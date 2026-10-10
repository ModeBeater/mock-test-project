from dataclasses import FrozenInstanceError, replace
from datetime import datetime, timedelta

import pytest

from driver_diary.domain.errors import InvalidTripError
from driver_diary.domain.trip import PaymentMethod
from tests.fakes import TZ, make_trip


def at(time: str) -> datetime:
    return datetime.fromisoformat(f"2026-10-01T{time}")


# --- Инварианты --------------------------------------------------------------


@pytest.mark.parametrize(
    ("overrides", "field"),
    [
        pytest.param({"id": ""}, "id", id="empty id"),
        pytest.param({"start": at("10:00")}, "start", id="naive start"),
        pytest.param({"end": at("10:25")}, "end", id="naive end"),
        pytest.param({"end": at("10:00+05:00")}, "end", id="end equals start"),
        pytest.param({"end": at("09:59+05:00")}, "end", id="end before start"),
        pytest.param({"amount": 0}, "amount", id="zero amount"),
        pytest.param({"amount": -100}, "amount", id="negative amount"),
        pytest.param({"amount": 2000.0}, "amount", id="float amount"),
        pytest.param({"amount": True}, "amount", id="bool amount"),
        pytest.param({"payment": "cash"}, "payment", id="payment as plain string"),
        pytest.param({"commission": -1}, "commission", id="negative commission"),
        pytest.param({"commission": False}, "commission", id="bool commission"),
        pytest.param({"commission": 2001}, "commission", id="commission above amount"),
    ],
)
def test_trip_with_broken_invariant_is_rejected(overrides, field):
    valid = make_trip()

    with pytest.raises(InvalidTripError) as exc:
        replace(valid, **overrides)

    assert exc.value.field == field


def test_error_messages_for_business_rules():
    valid = make_trip()

    with pytest.raises(InvalidTripError, match="end must be later than start"):
        replace(valid, end=valid.start)
    with pytest.raises(InvalidTripError, match="commission cannot exceed amount"):
        replace(valid, commission=valid.amount + 1)


@pytest.mark.parametrize("commission", [0, 2000])
def test_commission_may_be_zero_or_the_whole_amount(commission):
    trip = make_trip(amount=2000, commission=commission)

    assert trip.net == 2000 - commission


def test_end_after_start_across_offsets_is_valid():
    # 10:00+05:00 (05:00Z) → 05:30Z: окончание позже начала, хотя «на часах» 05:30 < 10:00.
    trip = make_trip(start="2026-10-01T10:00:00+05:00", end="2026-10-01T05:30:00+00:00")

    assert trip.duration == timedelta(minutes=30)


def test_trip_is_immutable():
    trip = make_trip()

    with pytest.raises(FrozenInstanceError):
        trip.amount = 1  # type: ignore[misc]


# --- Сравнение поездок ---------------------------------------------------------


def test_same_ride_ignores_id():
    assert make_trip(id="a").same_ride_as(make_trip(id="b"))


def test_same_ride_compares_moments_not_wall_clock():
    # 08:10+05:00 == 03:10Z
    local = make_trip(start="2026-10-01T08:10:00+05:00", end="2026-10-01T08:32:00+05:00")
    utc = make_trip(start="2026-10-01T03:10:00Z", end="2026-10-01T03:32:00Z")

    assert local.same_ride_as(utc)


@pytest.mark.parametrize(
    "overrides",
    [
        pytest.param({"start": "2026-10-01T10:01:00+05:00"}, id="start"),
        pytest.param({"end": "2026-10-01T10:26:00+05:00"}, id="end"),
        pytest.param({"amount": 2100}, id="amount"),
        pytest.param({"payment": "card"}, id="payment"),
        pytest.param({"commission": 301}, id="commission"),
    ],
)
def test_ride_differs_when_any_field_except_id_differs(overrides):
    assert not make_trip().same_ride_as(make_trip(**overrides))


@pytest.mark.parametrize(
    ("start", "end", "expected"),
    [
        pytest.param("09:50", "10:05", True, id="overlaps the beginning"),
        pytest.param("10:20", "10:40", True, id="overlaps the end"),
        pytest.param("10:05", "10:10", True, id="inside"),
        pytest.param("09:00", "11:00", True, id="covers"),
        pytest.param("09:30", "10:00", False, id="ends exactly at start"),
        pytest.param("10:25", "10:40", False, id="starts exactly at end"),
        pytest.param("12:00", "12:30", False, id="later"),
    ],
)
def test_overlaps_uses_half_open_intervals(start, end, expected):
    trip = make_trip(start="2026-10-01T10:00:00+05:00", end="2026-10-01T10:25:00+05:00")
    other = make_trip(id="other", start=f"2026-10-01T{start}:00+05:00", end=f"2026-10-01T{end}:00+05:00")

    assert trip.overlaps(other) is expected
    assert other.overlaps(trip) is expected


def test_duration_and_net():
    trip = make_trip(amount=2000, commission=300)

    assert trip.duration == timedelta(minutes=25)
    assert trip.net == 1700


def test_with_timezone_keeps_the_moment_and_changes_the_offset():
    trip = make_trip(start="2026-10-01T05:00:00Z", end="2026-10-01T05:20:00Z", payment="card")

    local = trip.with_timezone(TZ)

    assert local.start.isoformat() == "2026-10-01T10:00:00+05:00"
    assert local.end.isoformat() == "2026-10-01T10:20:00+05:00"
    assert local == trip
    assert local.payment is PaymentMethod.CARD
