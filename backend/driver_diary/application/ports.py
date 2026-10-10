from collections.abc import Callable
from types import TracebackType
from typing import Protocol, Self

from driver_diary.domain.trip import Trip


class TripRepository(Protocol):
    def get(self, trip_id: str) -> Trip | None: ...

    def all(self) -> list[Trip]: ...

    def add(self, trip: Trip) -> None: ...


class UnitOfWork(Protocol):
    """Граница транзакции: всё, что сделано внутри `with uow:`, видно другим только после `commit()`.

    Выход из блока без `commit()` — откат.
    """

    @property
    def trips(self) -> TripRepository: ...

    def __enter__(self) -> Self: ...

    def __exit__(
        self,
        exc_type: type[BaseException] | None,
        exc: BaseException | None,
        tb: TracebackType | None,
    ) -> None: ...

    def commit(self) -> None: ...


UnitOfWorkFactory = Callable[[], UnitOfWork]
