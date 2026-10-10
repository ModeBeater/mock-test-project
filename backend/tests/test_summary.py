from datetime import date

from app.config import Settings
from app.models import Trip
from app.storage import TripRepository
from app.summary import summarize

from .conftest import EXAMPLE_TRIPS, TZ, new_trip


def trips(*raw: dict) -> list[Trip]:
    return [Trip.model_validate(t) for t in raw]


def test_summary_for_example_day():
    summary = summarize(trips(*EXAMPLE_TRIPS))

    assert summary.trips_count == 2
    assert summary.revenue == 3900
    assert summary.commission == 585
    assert summary.net == 3315
    assert summary.by_payment["card"].model_dump() == {"count": 1, "amount": 2400, "commission": 360}
    assert summary.by_payment["cash"].model_dump() == {"count": 1, "amount": 1500, "commission": 225}


def test_summary_for_empty_day_has_zeros_and_both_payment_methods():
    summary = summarize([])

    assert (summary.trips_count, summary.revenue, summary.commission, summary.net) == (0, 0, 0, 0)
    assert set(summary.by_payment) == {"cash", "card"}
    assert all(b.count == 0 and b.amount == 0 for b in summary.by_payment.values())


def test_summary_with_single_payment_method():
    summary = summarize(trips(
        new_trip(id="a", amount=1000, commission=150, payment="card"),
        new_trip(id="b", amount=3000, commission=0, payment="card"),
    ))

    assert summary.revenue == 4000
    assert summary.net == 3850
    assert summary.by_payment["card"].count == 2
    assert summary.by_payment["cash"].count == 0


def test_day_report_endpoint(client):
    body = client.get("/api/days/2026-10-01").json()

    assert body["date"] == "2026-10-01"
    assert body["utc_offset"] == "+05:00"
    assert [t["id"] for t in body["trips"]] == ["t1", "t2"]
    assert body["summary"] == {
        "trips_count": 2,
        "revenue": 3900,
        "commission": 585,
        "net": 3315,
        "by_payment": {
            "cash": {"count": 1, "amount": 1500, "commission": 225},
            "card": {"count": 1, "amount": 2400, "commission": 360},
        },
    }


def test_other_day_is_empty(client):
    body = client.get("/api/days/2026-10-02").json()

    assert body["trips"] == []
    assert body["summary"]["trips_count"] == 0


def test_trip_after_midnight_counts_for_the_day_it_started(client, repo):
    # 23:50 1 октября → 00:20 2 октября: относится к 1 октября.
    client.post("/api/trips", json=new_trip(
        id="night", start="2026-10-01T23:50:00+05:00", end="2026-10-02T00:20:00+05:00"))

    assert [t.id for t in repo.for_day(date(2026, 10, 1))][-1] == "night"
    assert repo.for_day(date(2026, 10, 2)) == []


def test_day_is_determined_in_driver_timezone(client):
    # 19:30 UTC 1 октября — это уже 00:30 2 октября в UTC+5.
    created = client.post("/api/trips", json=new_trip(
        id="utc", start="2026-10-01T19:30:00Z", end="2026-10-01T19:50:00Z")).json()

    assert created["start"] == "2026-10-02T00:30:00+05:00"
    day2 = client.get("/api/days/2026-10-02").json()
    assert [t["id"] for t in day2["trips"]] == ["utc"]
    assert client.get("/api/days/2026-10-01").json()["summary"]["trips_count"] == 2


def test_days_list(client):
    client.post("/api/trips", json=new_trip(id="x", start="2026-10-03T10:00:00+05:00", end="2026-10-03T10:20:00+05:00"))

    assert client.get("/api/days").json() == [
        {"date": "2026-10-01", "trips_count": 2},
        {"date": "2026-10-03", "trips_count": 1},
    ]


def test_invalid_date_in_path(client):
    assert client.get("/api/days/2026-13-01").status_code == 422


def test_seed_data_is_valid_and_has_no_overlaps(tmp_path):
    repo = TripRepository(tmp_path / "trips.json", TZ, seed=Settings().seed_file)
    all_trips = [t for d in repo.days() for t in repo.for_day(d.date)]

    assert len(all_trips) > 50
    assert not [(a.id, b.id) for a, b in zip(all_trips, all_trips[1:]) if a.overlaps(b)]
