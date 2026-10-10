import pytest

from tests.fakes import new_trip


def test_health(client):
    assert client.get("/api/health").json() == {"status": "ok"}


def test_day_report_endpoint(client):
    body = client.get("/api/days/2026-10-01").json()

    assert body["date"] == "2026-10-01"
    assert body["utc_offset"] == "+05:00"
    assert [t["id"] for t in body["trips"]] == ["t1", "t2"]
    assert body["trips"][0] == {
        "id": "t1",
        "start": "2026-10-01T08:10:00+05:00",
        "end": "2026-10-01T08:32:00+05:00",
        "amount": 2400,
        "payment": "card",
        "commission": 360,
    }
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
    assert body["summary"]["by_payment"]["cash"] == {"count": 0, "amount": 0, "commission": 0}


def test_day_is_determined_in_driver_timezone(client):
    # 19:30 UTC 1 октября — это уже 00:30 2 октября в UTC+5.
    created = client.post(
        "/api/trips", json=new_trip(id="utc", start="2026-10-01T19:30:00Z", end="2026-10-01T19:50:00Z")
    )

    assert created.json()["start"] == "2026-10-02T00:30:00+05:00"
    day2 = client.get("/api/days/2026-10-02").json()
    assert [t["id"] for t in day2["trips"]] == ["utc"]
    assert client.get("/api/days/2026-10-01").json()["summary"]["trips_count"] == 2


def test_invalid_date_in_path(client):
    assert client.get("/api/days/2026-13-01").status_code == 422


# --- Список дней --------------------------------------------------------------


@pytest.fixture
def client_with_three_days(client):
    client.post("/api/trips", json=new_trip(id="x", start="2026-10-02T10:00:00+05:00", end="2026-10-02T10:20:00+05:00"))
    client.post("/api/trips", json=new_trip(id="y", start="2026-10-03T10:00:00+05:00", end="2026-10-03T10:20:00+05:00"))
    return client


def test_days_list(client_with_three_days):
    assert client_with_three_days.get("/api/days").json() == [
        {"date": "2026-10-01", "trips_count": 2, "net": 3315},
        {"date": "2026-10-02", "trips_count": 1, "net": 1700},
        {"date": "2026-10-03", "trips_count": 1, "net": 1700},
    ]


@pytest.mark.parametrize(
    ("query", "expected"),
    [
        pytest.param("?from=2026-10-02", ["2026-10-02", "2026-10-03"], id="from only"),
        pytest.param("?to=2026-10-02", ["2026-10-01", "2026-10-02"], id="to only"),
        pytest.param("?from=2026-10-02&to=2026-10-02", ["2026-10-02"], id="bounds inclusive"),
        pytest.param("?from=2026-10-04", [], id="nothing in range"),
    ],
)
def test_days_list_filtered_by_range(client_with_three_days, query, expected):
    body = client_with_three_days.get(f"/api/days{query}").json()

    assert [d["date"] for d in body] == expected


@pytest.mark.parametrize("query", ["?from=2026-13-01", "?to=yesterday"])
def test_invalid_date_in_days_filter(client, query):
    assert client.get(f"/api/days{query}").status_code == 422
