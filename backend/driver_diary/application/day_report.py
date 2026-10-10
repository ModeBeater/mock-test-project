import datetime as dt
from dataclasses import dataclass

from driver_diary.domain.summary import DaySummary, summarize
from driver_diary.domain.trip import Trip

from .ports import UnitOfWork


def trip_day(trip: Trip, tz: dt.tzinfo) -> dt.date:
    """День поездки — дата её начала по часовому поясу водителя.

    Поездка 23:50–00:20 относится к дню, в который началась: так водитель и считает смену.
    """
    return trip.start.astimezone(tz).date()


@dataclass(frozen=True, slots=True)
class DayReport:
    date: dt.date
    tz: dt.timezone
    summary: DaySummary
    trips: list[Trip]


class GetDayReport:
    """Сводка и поездки за один день; время поездок — в часовом поясе водителя."""

    def __init__(self, uow: UnitOfWork, tz: dt.timezone) -> None:
        self._uow = uow
        self._tz = tz

    def execute(self, day: dt.date) -> DayReport:
        with self._uow as uow:
            stored = uow.trips.all()

        trips = sorted(
            (t.with_timezone(self._tz) for t in stored if trip_day(t, self._tz) == day),
            key=lambda t: t.start,
        )
        return DayReport(date=day, tz=self._tz, summary=summarize(trips), trips=trips)
