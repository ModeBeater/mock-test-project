import json
from pathlib import Path

import pytest
from fastapi.testclient import TestClient

from driver_diary.api.app import create_app
from driver_diary.config import Settings
from driver_diary.infrastructure.json_store import JsonTripStore
from tests.fakes import EXAMPLE_TRIPS, TZ, FakeUnitOfWork, example_trips


@pytest.fixture
def data_file(tmp_path: Path) -> Path:
    path = tmp_path / "trips.json"
    path.write_text(json.dumps(EXAMPLE_TRIPS), encoding="utf-8")
    return path


@pytest.fixture
def store(data_file: Path) -> JsonTripStore:
    return JsonTripStore(data_file)


@pytest.fixture
def uow() -> FakeUnitOfWork:
    return FakeUnitOfWork(example_trips())


@pytest.fixture
def client(data_file: Path) -> TestClient:
    # Настоящая сборка приложения: JSON-хранилище во временном файле.
    settings = Settings(data_file=data_file, seed_file=data_file, tz=TZ)
    return TestClient(create_app(settings))
