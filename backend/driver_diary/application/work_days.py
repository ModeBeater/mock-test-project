import datetime as dt
from collections import defaultdict
from dataclasses import dataclass

from driver_diary.domain.trip import Trip

from .day_report import trip_day
from .ports import UnitOfWork


@dataclass(frozen=True, slots=True)
class WorkDay:
    date: dt.date
    trips_count: int
    net: int


class ListWorkDays:
    """Дни, в которые были поездки, по возрастанию даты. Границы `date_from`/`date_to` включительные."""

    def __init__(self, uow: UnitOfWork, tz: dt.tzinfo) -> None:
        self._uow = uow
        self._tz = tz

    def execute(self, date_from: dt.date | None = None, date_to: dt.date | None = None) -> list[WorkDay]:
        with self._uow as uow:
            stored = uow.trips.all()

        by_day: defaultdict[dt.date, list[Trip]] = defaultdict(list)
        for trip in stored:
            day = trip_day(trip, self._tz)
            if (date_from is None or day >= date_from) and (date_to is None or day <= date_to):
                by_day[day].append(trip)

        return [
            WorkDay(date=day, trips_count=len(trips), net=sum(t.net for t in trips))
            for day, trips in sorted(by_day.items())
        ]
