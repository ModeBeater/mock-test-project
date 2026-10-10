from driver_diary.domain.trip import Trip


class InMemoryTripRepository:
    """Репозиторий поверх словаря id → поездка. Словарь не копируется: им владеет вызывающий код."""

    def __init__(self, trips: dict[str, Trip] | None = None) -> None:
        self._trips = trips if trips is not None else {}

    def get(self, trip_id: str) -> Trip | None:
        return self._trips.get(trip_id)

    def all(self) -> list[Trip]:
        return list(self._trips.values())

    def add(self, trip: Trip) -> None:
        if trip.id in self._trips:
            raise ValueError(f"duplicate trip id {trip.id!r}")
        self._trips[trip.id] = trip
