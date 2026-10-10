import json
import os
import shutil
import tempfile
import threading
import uuid
from datetime import date, timezone
from pathlib import Path

from pydantic import TypeAdapter

from .models import DayInfo, Trip, TripIn

_trips_adapter = TypeAdapter(list[Trip])


class TripConflict(Exception):
    """Поездку нельзя сохранить: она противоречит уже сохранённой."""

    def __init__(self, code: str, message: str, existing: Trip):
        super().__init__(message)
        self.code = code
        self.message = message
        self.existing = existing


class TripRepository:
    """Поездки водителя в JSON-файле.

    Все данные держим в памяти и после каждого добавления целиком перезаписываем файл
    (атомарно, через временный файл). Для дневника одного водителя этого достаточно.
    Проверка на дубль и вставка выполняются под одной блокировкой, поэтому два
    одновременных запроса с одной и той же поездкой не создадут две записи.
    """

    def __init__(self, path: Path, tz: timezone, seed: Path | None = None):
        self._path = path
        self._tz = tz
        self._lock = threading.Lock()
        if not path.exists() and seed is not None:
            path.parent.mkdir(parents=True, exist_ok=True)
            shutil.copyfile(seed, path)

        self._trips: dict[str, Trip] = {}
        if path.exists():
            for trip in _trips_adapter.validate_json(path.read_bytes()):
                if trip.id in self._trips:
                    raise ValueError(f"{path}: duplicate trip id {trip.id!r}")
                self._trips[trip.id] = self._normalize(trip)

    def local_date(self, trip: TripIn) -> date:
        """День поездки — дата её начала по часовому поясу водителя."""
        return trip.start.astimezone(self._tz).date()

    def get(self, trip_id: str) -> Trip | None:
        with self._lock:
            return self._trips.get(trip_id)

    def for_day(self, day: date) -> list[Trip]:
        with self._lock:
            trips = [t for t in self._trips.values() if self.local_date(t) == day]
        return sorted(trips, key=lambda t: t.start)

    def days(self) -> list[DayInfo]:
        counts: dict[date, int] = {}
        with self._lock:
            for trip in self._trips.values():
                day = self.local_date(trip)
                counts[day] = counts.get(day, 0) + 1
        return [DayInfo(date=d, trips_count=n) for d, n in sorted(counts.items())]

    def add(self, data: TripIn) -> tuple[Trip, bool]:
        """Сохраняет поездку. Возвращает (поездка, создана ли новая запись).

        - тот же id и те же данные → повтор запроса, отдаём сохранённую поездку;
        - тот же id, но другие данные → TripConflict("id_conflict");
        - те же данные под другим id (или без id) → тоже повтор, дубль не создаём;
        - пересечение по времени с другой поездкой → TripConflict("trip_overlap"):
          водитель не может везти два заказа одновременно, а «почти дубль»
          (та же поездка с исправленной суммой) иначе прошёл бы как новая.
        """
        with self._lock:
            if data.id is not None and (existing := self._trips.get(data.id)) is not None:
                if existing.same_trip_as(data):
                    return existing, False
                raise TripConflict("id_conflict", f"Trip {data.id!r} already exists with different data", existing)

            for existing in self._trips.values():
                if existing.same_trip_as(data):
                    return existing, False

            for existing in self._trips.values():
                if existing.overlaps(data):
                    raise TripConflict("trip_overlap", f"Trip overlaps with trip {existing.id!r}", existing)

            trip = self._normalize(Trip(**data.model_dump(exclude={"id"}), id=data.id or uuid.uuid4().hex))
            self._trips[trip.id] = trip
            try:
                self._save()
            except Exception:
                del self._trips[trip.id]
                raise
            return trip, True

    def _normalize(self, trip: Trip) -> Trip:
        """Храним и отдаём время в часовом поясе водителя, как бы его ни прислали."""
        return trip.model_copy(update={"start": trip.start.astimezone(self._tz), "end": trip.end.astimezone(self._tz)})

    def _save(self) -> None:
        trips = sorted(self._trips.values(), key=lambda t: t.start)
        payload = json.dumps([t.model_dump(mode="json") for t in trips], ensure_ascii=False, indent=2)
        fd, tmp = tempfile.mkstemp(dir=self._path.parent, prefix=f".{self._path.name}.", suffix=".tmp")
        try:
            with os.fdopen(fd, "w", encoding="utf-8") as f:
                f.write(payload + "\n")
                f.flush()
                os.fsync(f.fileno())
            os.replace(tmp, self._path)
        except BaseException:
            Path(tmp).unlink(missing_ok=True)
            raise
