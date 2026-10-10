import json

import pytest

from tests.fakes import EXAMPLE_TRIPS, new_trip


def day_count(client, day: str = "2026-10-01") -> int:
    return client.get(f"/api/days/{day}").json()["summary"]["trips_count"]


# --- Защита от дублей -------------------------------------------------------


def test_resending_same_trip_does_not_create_duplicate(client):
    first = client.post("/api/trips", json=new_trip())
    second = client.post("/api/trips", json=new_trip())

    assert first.status_code == 201
    assert second.status_code == 200
    assert second.json() == first.json()
    assert first.headers["location"] == second.headers["location"] == "/api/trips/n1"
    assert day_count(client) == 3


def test_resending_trip_from_the_original_file_is_idempotent(client):
    response = client.post("/api/trips", json=EXAMPLE_TRIPS[0])

    assert response.status_code == 200
    assert response.json() == EXAMPLE_TRIPS[0]
    assert day_count(client) == 2


def test_same_trip_without_id_is_not_duplicated(client):
    first = client.post("/api/trips", json=new_trip(id=None))
    second = client.post("/api/trips", json=new_trip(id=None))

    assert (first.status_code, second.status_code) == (201, 200)
    assert second.json()["id"] == first.json()["id"]
    assert day_count(client) == 3


def test_same_id_with_different_data_is_conflict(client):
    client.post("/api/trips", json=new_trip())
    response = client.post("/api/trips", json=new_trip(amount=2500))

    assert response.status_code == 409
    assert response.json() == {
        "detail": {
            "code": "id_conflict",
            "message": "Trip 'n1' already exists with different data",
            "existing": {**new_trip(), "amount": 2000},
        }
    }
    assert day_count(client) == 3


def test_overlapping_trip_is_conflict(client):
    # Та же поездка t1, но с исправленной суммой и новым id — не должна стать второй записью.
    response = client.post("/api/trips", json={**EXAMPLE_TRIPS[0], "id": "t1-fixed", "amount": 2500})

    assert response.status_code == 409
    assert response.json()["detail"]["code"] == "trip_overlap"
    assert response.json()["detail"]["existing"] == EXAMPLE_TRIPS[0]
    assert day_count(client) == 2


# --- Сохранение -------------------------------------------------------------


def test_created_trip_is_persisted_in_driver_timezone(client, data_file):
    response = client.post("/api/trips", json=new_trip(start="2026-10-01T05:00:00Z", end="2026-10-01T05:20:00Z"))

    assert response.status_code == 201
    assert response.headers["location"] == "/api/trips/n1"
    saved = {t["id"]: t for t in json.loads(data_file.read_text(encoding="utf-8"))}
    assert saved["n1"]["start"] == "2026-10-01T10:00:00+05:00"
    assert client.get("/api/trips/n1").json() == response.json()


def test_server_generates_id_when_missing(client):
    response = client.post("/api/trips", json=new_trip(id=None))

    assert response.status_code == 201
    trip_id = response.json()["id"]
    assert trip_id
    assert response.headers["location"] == f"/api/trips/{trip_id}"


def test_unknown_trip_is_not_found(client):
    response = client.get("/api/trips/nope")

    assert response.status_code == 404
    assert response.json() == {"detail": "Trip not found"}


# --- Валидация --------------------------------------------------------------


@pytest.mark.parametrize(
    "overrides",
    [
        pytest.param({"amount": 0}, id="zero amount"),
        pytest.param({"amount": -100}, id="negative amount"),
        pytest.param({"amount": "2000"}, id="amount as string"),
        pytest.param({"amount": 2000.5}, id="fractional amount"),
        pytest.param({"end": "2026-10-01T10:00:00+05:00"}, id="end equals start"),
        pytest.param({"end": "2026-10-01T09:59:00+05:00"}, id="end before start"),
        pytest.param({"start": "2026-10-01T10:00:00", "end": "2026-10-01T10:25:00"}, id="no timezone"),
        pytest.param({"payment": "crypto"}, id="unknown payment"),
        pytest.param({"commission": -1}, id="negative commission"),
        pytest.param({"commission": 2001}, id="commission above amount"),
        pytest.param({"id": "has spaces"}, id="bad id"),
        pytest.param({"tip": 100}, id="unknown field"),
    ],
)
def test_invalid_trip_is_rejected(client, overrides):
    response = client.post("/api/trips", json=new_trip(**overrides))

    assert response.status_code == 422
    assert day_count(client) == 2


def test_missing_field_is_rejected(client):
    payload = new_trip()
    del payload["amount"]

    assert client.post("/api/trips", json=payload).status_code == 422


def test_business_rule_error_looks_like_validation_error(client):
    response = client.post("/api/trips", json=new_trip(commission=2001))

    assert response.status_code == 422
    assert response.json() == {
        "detail": [{"type": "value_error", "loc": ["body", "commission"], "msg": "commission cannot exceed amount"}]
    }


def test_end_after_start_across_offsets_is_valid(client):
    # 10:00+05:00 (05:00Z) → 05:30Z: окончание позже начала, хотя «на часах» 05:30 < 10:00.
    response = client.post("/api/trips", json=new_trip(end="2026-10-01T05:30:00Z"))

    assert response.status_code == 201
    assert response.json()["end"] == "2026-10-01T10:30:00+05:00"
