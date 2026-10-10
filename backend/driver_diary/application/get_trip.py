from driver_diary.domain.trip import Trip

from .ports import UnitOfWork


class GetTrip:
    def __init__(self, uow: UnitOfWork) -> None:
        self._uow = uow

    def execute(self, trip_id: str) -> Trip | None:
        with self._uow as uow:
            return uow.trips.get(trip_id)
