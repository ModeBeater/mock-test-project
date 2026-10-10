import json
from datetime import timedelta, timezone
from pathlib import Path

import pytest
from fastapi.testclient import TestClient

from app.config import Settings
from app.main import create_app
from app.storage import TripRepository

TZ = timezone(timedelta(hours=5))

# Пример из задания.
EXAMPLE_TRIPS = [
    {"id": "t1", "start": "2026-10-01T08:10:00+05:00", "end": "2026-10-01T08:32:00+05:00",
     "amount": 2400, "payment": "card", "commission": 360},
    {"id": "t2", "start": "2026-10-01T09:05:00+05:00", "end": "2026-10-01T09:20:00+05:00",
     "amount": 1500, "payment": "cash", "commission": 225},
]


@pytest.fixture
def data_file(tmp_path: Path) -> Path:
    path = tmp_path / "trips.json"
    path.write_text(json.dumps(EXAMPLE_TRIPS), encoding="utf-8")
    return path


@pytest.fixture
def repo(data_file: Path) -> TripRepository:
    return TripRepository(data_file, TZ)


@pytest.fixture
def client(repo: TripRepository, data_file: Path) -> TestClient:
    settings = Settings(data_file=data_file, seed_file=data_file, tz=TZ)
    return TestClient(create_app(settings, repo))


def new_trip(**overrides) -> dict:
    trip = {"id": "n1", "start": "2026-10-01T10:00:00+05:00", "end": "2026-10-01T10:25:00+05:00",
            "amount": 2000, "payment": "cash", "commission": 300}
    trip.update(overrides)
    return {k: v for k, v in trip.items() if v is not None}
