import pytest

from driver_diary.application.add_trip import AddTrip, AddTripResult
from driver_diary.application.errors import ConflictKind, TripConflictError
from driver_diary.domain.errors import InvalidTripError
from tests.fakes import EXAMPLE_TRIPS, TZ, FakeUnitOfWork, make_command


def add(uow: FakeUnitOfWork, **overrides) -> AddTripResult:
    return AddTrip(uow, TZ).execute(make_command(**overrides))


def test_new_trip_is_saved_and_committed(uow):
    result = add(uow)

    assert result.created is True
    assert uow.committed["n1"] == result.trip
    assert uow.commits == 1


def test_new_trip_is_stored_in_driver_timezone(uow):
    result = add(uow, start="2026-10-01T05:00:00Z", end="2026-10-01T05:20:00Z")

    assert uow.committed["n1"].start.isoformat() == "2026-10-01T10:00:00+05:00"
    assert result.trip.end.isoformat() == "2026-10-01T10:20:00+05:00"


def test_server_generates_id_when_missing(uow):
    use_case = AddTrip(uow, TZ, id_factory=lambda: "generated")

    result = use_case.execute(make_command(id=None))

    assert result.trip.id == "generated"
    assert "generated" in uow.committed


# --- Защита от дублей -------------------------------------------------------


def test_resending_same_trip_does_not_create_duplicate(uow):
    first = add(uow)
    second = add(uow)

    assert (first.created, second.created) == (True, False)
    assert second.trip == first.trip
    assert len(uow.committed) == 3
    assert uow.commits == 1


def test_resending_trip_from_the_original_data_is_idempotent(uow):
    result = add(uow, **EXAMPLE_TRIPS[0])

    assert result.created is False
    assert result.trip.id == "t1"
    assert len(uow.committed) == 2


def test_same_trip_without_id_is_not_duplicated(uow):
    first = add(uow, id=None)
    second = add(uow, id=None)

    assert (first.created, second.created) == (True, False)
    assert second.trip.id == first.trip.id
    assert len(uow.committed) == 3


def test_same_trip_under_another_id_is_not_duplicated(uow):
    add(uow, id="a")
    result = add(uow, id="b")

    assert result.created is False
    assert result.trip.id == "a"
    assert "b" not in uow.committed


def test_same_moment_in_another_timezone_is_recognized_as_duplicate(uow):
    # 08:10+05:00 == 03:10Z
    result = add(
        uow, **{**EXAMPLE_TRIPS[0], "id": None, "start": "2026-10-01T03:10:00Z", "end": "2026-10-01T03:32:00Z"}
    )

    assert result.created is False
    assert result.trip.id == "t1"
    assert len(uow.committed) == 2


def test_same_id_with_different_data_is_conflict(uow):
    add(uow)

    with pytest.raises(TripConflictError) as exc:
        add(uow, amount=2500)

    assert exc.value.kind is ConflictKind.ID_CONFLICT
    assert exc.value.existing.amount == 2000
    assert uow.committed["n1"].amount == 2000


def test_overlapping_trip_is_conflict(uow):
    # Та же поездка t1, но с исправленной суммой и новым id — не должна стать второй записью.
    with pytest.raises(TripConflictError) as exc:
        add(uow, **{**EXAMPLE_TRIPS[0], "id": "t1-fixed", "amount": 2500})

    assert exc.value.kind is ConflictKind.TRIP_OVERLAP
    assert exc.value.existing.id == "t1"
    assert set(uow.committed) == {"t1", "t2"}
    assert uow.commits == 0


def test_back_to_back_trips_are_allowed(uow):
    # t1 закончилась в 08:32 — следующая может начаться в 08:32.
    result = add(uow, start="2026-10-01T08:32:00+05:00", end="2026-10-01T08:50:00+05:00")

    assert result.created is True


def test_invalid_trip_is_rejected_before_looking_for_duplicates(uow):
    # id совпадает с t1, но данные некорректны: это ошибка валидации, а не конфликт.
    with pytest.raises(InvalidTripError) as exc:
        add(uow, **{**EXAMPLE_TRIPS[0], "commission": 5000})

    assert exc.value.field == "commission"
    assert uow.commits == 0
