import itertools
import json
from concurrent.futures import ThreadPoolExecutor

import pytest

from driver_diary.application.add_trip import AddTrip, AddTripResult
from driver_diary.config import Settings
from driver_diary.infrastructure import json_store
from driver_diary.infrastructure.json_store import JsonTripStore, JsonUnitOfWork
from tests.fakes import EXAMPLE_TRIPS, TZ, make_command, make_trip


def add(store: JsonTripStore, **overrides) -> AddTripResult:
    return AddTrip(JsonUnitOfWork(store), TZ).execute(make_command(**overrides))


def stored_ids(store: JsonTripStore) -> set[str]:
    with JsonUnitOfWork(store) as uow:
        return {t.id for t in uow.trips.all()}


# --- Загрузка файла ----------------------------------------------------------


def test_seed_data_is_valid_and_has_no_overlaps(tmp_path):
    store = JsonTripStore(tmp_path / "trips.json", seed_path=Settings().seed_file)

    trips = sorted(store.snapshot().values(), key=lambda t: t.start)

    assert len(trips) > 50
    assert not [(a.id, b.id) for a, b in itertools.pairwise(trips) if a.overlaps(b)]


def test_seed_is_copied_when_data_file_is_missing(tmp_path, data_file):
    target = tmp_path / "runtime" / "trips.json"

    store = JsonTripStore(target, seed_path=data_file)

    assert target.read_bytes() == data_file.read_bytes()
    assert stored_ids(store) == {"t1", "t2"}


def test_missing_file_without_seed_means_no_trips(tmp_path):
    store = JsonTripStore(tmp_path / "trips.json")

    assert stored_ids(store) == set()


def test_file_with_duplicate_ids_is_rejected(tmp_path):
    path = tmp_path / "trips.json"
    path.write_text(json.dumps([EXAMPLE_TRIPS[0], EXAMPLE_TRIPS[0]]), encoding="utf-8")

    with pytest.raises(ValueError, match="duplicate trip id"):
        JsonTripStore(path)


@pytest.mark.parametrize(
    "broken",
    [
        pytest.param({"commission": 5000}, id="commission above amount"),
        pytest.param({"start": "2026-10-01T08:10:00"}, id="no timezone"),
        pytest.param({"payment": "crypto"}, id="unknown payment"),
        pytest.param({"tip": 100}, id="unknown field"),
    ],
)
def test_file_with_invalid_trip_is_rejected(tmp_path, broken):
    path = tmp_path / "trips.json"
    path.write_text(json.dumps([{**EXAMPLE_TRIPS[0], **broken}]), encoding="utf-8")

    with pytest.raises(ValueError, match="invalid trip #0"):
        JsonTripStore(path)


# --- Запись файла -------------------------------------------------------------


def test_file_is_saved_sorted_by_start_in_driver_timezone(store, data_file):
    add(store, id="утро", start="2026-10-01T02:00:00Z", end="2026-10-01T02:30:00Z")

    text = data_file.read_text(encoding="utf-8")
    records = json.loads(text)
    assert [r["id"] for r in records] == ["утро", "t1", "t2"]
    assert records[0] == {
        "id": "утро",
        "start": "2026-10-01T07:00:00+05:00",
        "end": "2026-10-01T07:30:00+05:00",
        "amount": 2000,
        "payment": "cash",
        "commission": 300,
    }
    assert text == json.dumps(records, ensure_ascii=False, indent=2) + "\n"


def test_duplicate_protection_survives_restart(data_file):
    add(JsonTripStore(data_file))

    reloaded = JsonTripStore(data_file)
    result = add(reloaded)

    assert result.created is False
    assert stored_ids(reloaded) == {"t1", "t2", "n1"}


def test_concurrent_resubmissions_create_single_trip(store, data_file):
    command = make_command()

    def submit(_: int) -> AddTripResult:
        return AddTrip(JsonUnitOfWork(store), TZ).execute(command)

    with ThreadPoolExecutor(max_workers=8) as pool:
        results = list(pool.map(submit, range(32)))

    assert sum(r.created for r in results) == 1
    assert {r.trip.id for r in results} == {"n1"}
    assert len(json.loads(data_file.read_text(encoding="utf-8"))) == 3


# --- Транзакции ----------------------------------------------------------------


def test_changes_without_commit_are_discarded(store, data_file):
    before = data_file.read_bytes()

    with JsonUnitOfWork(store) as uow:
        uow.trips.add(make_trip())

    assert stored_ids(store) == {"t1", "t2"}
    assert data_file.read_bytes() == before


def test_failed_write_changes_neither_file_nor_memory(store, data_file, monkeypatch):
    before = data_file.read_bytes()

    def broken_replace(src: str, dst: str) -> None:
        raise OSError("disk full")

    monkeypatch.setattr(json_store.os, "replace", broken_replace)

    with pytest.raises(OSError, match="disk full"):
        add(store)

    assert data_file.read_bytes() == before
    assert set(store.snapshot()) == {"t1", "t2"}
    assert stored_ids(store) == {"t1", "t2"}
    assert [p.name for p in data_file.parent.iterdir()] == ["trips.json"], "temporary file must be removed"

    # Блокировка отпущена, а после починки диска та же поездка сохраняется.
    monkeypatch.undo()
    assert add(store).created is True
