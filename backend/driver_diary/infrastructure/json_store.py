import json
import os
import shutil
import tempfile
import threading
from collections.abc import Iterable, Mapping
from datetime import datetime
from pathlib import Path
from types import TracebackType
from typing import Any, Self

from driver_diary.domain.errors import InvalidTripError
from driver_diary.domain.trip import PaymentMethod, Trip

from .memory import InMemoryTripRepository

_FIELDS = ("id", "start", "end", "amount", "payment", "commission")


class JsonTripStore:
    """Поездки водителя в JSON-файле.

    Все данные держим в памяти и при каждом изменении целиком перезаписываем файл
    (атомарно, через временный файл). Для дневника одного водителя этого достаточно.
    Работать с хранилищем нужно через JsonUnitOfWork: он берёт блокировку.
    """

    def __init__(self, path: Path, seed_path: Path | None = None) -> None:
        self._path = path
        self._lock = threading.Lock()
        if not path.exists() and seed_path is not None:
            path.parent.mkdir(parents=True, exist_ok=True)
            shutil.copyfile(seed_path, path)
        self._trips = self._load() if path.exists() else {}

    @property
    def path(self) -> Path:
        return self._path

    @property
    def lock(self) -> threading.Lock:
        return self._lock

    def snapshot(self) -> dict[str, Trip]:
        """Копия текущих данных. Вызывать под `lock`."""
        return dict(self._trips)

    def save(self, trips: Mapping[str, Trip]) -> None:
        """Записывает файл и только после успешной записи подменяет данные в памяти. Вызывать под `lock`."""
        new_state = dict(trips)
        _write_atomically(self._path, _dump(new_state.values()))
        self._trips = new_state

    def _load(self) -> dict[str, Trip]:
        records = json.loads(self._path.read_text(encoding="utf-8"))
        if not isinstance(records, list):
            raise ValueError(f"{self._path}: expected a JSON array of trips")

        trips: dict[str, Trip] = {}
        for index, record in enumerate(records):
            try:
                trip = _trip_from_record(record)
            except (InvalidTripError, ValueError, TypeError) as e:
                raise ValueError(f"{self._path}: invalid trip #{index}: {e}") from e
            if trip.id in trips:
                raise ValueError(f"{self._path}: duplicate trip id {trip.id!r}")
            trips[trip.id] = trip
        return trips


class JsonUnitOfWork:
    """Транзакция над JsonTripStore.

    На время `with` держит блокировку хранилища и работает с копией данных:
    без `commit()` изменения просто выбрасываются, а при ошибке записи файла
    не меняются ни файл, ни данные в памяти.
    """

    def __init__(self, store: JsonTripStore) -> None:
        self._store = store
        self._data: dict[str, Trip] | None = None
        self._trips: InMemoryTripRepository | None = None

    @property
    def trips(self) -> InMemoryTripRepository:
        if self._trips is None:
            raise RuntimeError("JsonUnitOfWork is not active, use it as `with uow: ...`")
        return self._trips

    def __enter__(self) -> Self:
        self._store.lock.acquire()
        self._data = self._store.snapshot()
        self._trips = InMemoryTripRepository(self._data)
        return self

    def __exit__(
        self,
        exc_type: type[BaseException] | None,
        exc: BaseException | None,
        tb: TracebackType | None,
    ) -> None:
        self._data = None
        self._trips = None
        self._store.lock.release()

    def commit(self) -> None:
        if self._data is None:
            raise RuntimeError("JsonUnitOfWork is not active, use it as `with uow: ...`")
        self._store.save(self._data)


def _trip_from_record(record: Any) -> Trip:
    if not isinstance(record, dict) or sorted(record) != sorted(_FIELDS):
        raise ValueError(f"expected an object with exactly these fields: {', '.join(_FIELDS)}")
    return Trip(
        id=record["id"],
        start=_parse_datetime(record["start"]),
        end=_parse_datetime(record["end"]),
        amount=record["amount"],
        payment=PaymentMethod(record["payment"]),
        commission=record["commission"],
    )


def _parse_datetime(value: Any) -> datetime:
    if not isinstance(value, str):
        raise ValueError(f"expected an ISO 8601 string, got {value!r}")
    return datetime.fromisoformat(value)


def _dump(trips: Iterable[Trip]) -> str:
    records = [
        {
            "id": t.id,
            "start": t.start.isoformat(),
            "end": t.end.isoformat(),
            "amount": t.amount,
            "payment": t.payment.value,
            "commission": t.commission,
        }
        for t in sorted(trips, key=lambda t: t.start)
    ]
    return json.dumps(records, ensure_ascii=False, indent=2) + "\n"


def _write_atomically(path: Path, content: str) -> None:
    # Пишем во временный файл рядом и подменяем им основной: при сбое на диске остаётся либо старая, либо новая версия.
    path.parent.mkdir(parents=True, exist_ok=True)
    fd, tmp = tempfile.mkstemp(dir=path.parent, prefix=f".{path.name}.", suffix=".tmp")
    try:
        with os.fdopen(fd, "w", encoding="utf-8") as f:
            f.write(content)
            f.flush()
            os.fsync(f.fileno())
        os.replace(tmp, path)
    except BaseException:
        Path(tmp).unlink(missing_ok=True)
        raise
