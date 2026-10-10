"""Тестовые данные и подделки для тестов всех слоёв."""

from collections.abc import Iterable
from datetime import datetime, timedelta, timezone
from typing import Any, Self

from driver_diary.application.add_trip import AddTripCommand
from driver_diary.domain.trip import PaymentMethod, Trip
from driver_diary.infrastructure.memory import InMemoryTripRepository

TZ = timezone(timedelta(hours=5))

# Пример из задания.
EXAMPLE_TRIPS: list[dict[str, Any]] = [
    {
        "id": "t1",
        "start": "2026-10-01T08:10:00+05:00",
        "end": "2026-10-01T08:32:00+05:00",
        "amount": 2400,
        "payment": "card",
        "commission": 360,
    },
    {
        "id": "t2",
        "start": "2026-10-01T09:05:00+05:00",
        "end": "2026-10-01T09:20:00+05:00",
        "amount": 1500,
        "payment": "cash",
        "commission": 225,
    },
]


def new_trip(**overrides: Any) -> dict[str, Any]:
    """Тело POST /api/trips. Поле со значением None выбрасывается."""
    trip = {
        "id": "n1",
        "start": "2026-10-01T10:00:00+05:00",
        "end": "2026-10-01T10:25:00+05:00",
        "amount": 2000,
        "payment": "cash",
        "commission": 300,
    }
    trip.update(overrides)
    return {k: v for k, v in trip.items() if v is not None}


def to_trip(raw: dict[str, Any]) -> Trip:
    return Trip(
        id=raw["id"],
        start=datetime.fromisoformat(raw["start"]),
        end=datetime.fromisoformat(raw["end"]),
        amount=raw["amount"],
        payment=PaymentMethod(raw["payment"]),
        commission=raw["commission"],
    )


def make_trip(**overrides: Any) -> Trip:
    return to_trip(new_trip(**overrides))


def example_trips() -> list[Trip]:
    return [to_trip(t) for t in EXAMPLE_TRIPS]


def make_command(**overrides: Any) -> AddTripCommand:
    raw = new_trip(**overrides)
    return AddTripCommand(
        id=raw.get("id"),
        start=datetime.fromisoformat(raw["start"]),
        end=datetime.fromisoformat(raw["end"]),
        amount=raw["amount"],
        payment=PaymentMethod(raw["payment"]),
        commission=raw["commission"],
    )


class FakeUnitOfWork:
    """UoW без файлов и блокировок, но с настоящей семантикой транзакции.

    Изменения видны только после commit(): так тесты сценариев поймают забытый commit.
    """

    def __init__(self, trips: Iterable[Trip] = ()) -> None:
        self.committed: dict[str, Trip] = {t.id: t for t in trips}
        self.commits = 0
        self._pending: dict[str, Trip] | None = None

    @property
    def trips(self) -> InMemoryTripRepository:
        assert self._pending is not None, "repository is used outside of `with uow:`"
        return InMemoryTripRepository(self._pending)

    def __enter__(self) -> Self:
        self._pending = dict(self.committed)
        return self

    def __exit__(self, *exc_info: object) -> None:
        self._pending = None

    def commit(self) -> None:
        assert self._pending is not None, "commit outside of `with uow:`"
        self.committed = dict(self._pending)
        self.commits += 1
