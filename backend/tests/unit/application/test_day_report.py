from datetime import date

from driver_diary.application.day_report import GetDayReport
from driver_diary.domain.summary import PaymentBreakdown
from driver_diary.domain.trip import PaymentMethod
from tests.fakes import TZ, FakeUnitOfWork, example_trips, make_trip


def test_report_for_example_day(uow):
    report = GetDayReport(uow, TZ).execute(date(2026, 10, 1))

    assert report.date == date(2026, 10, 1)
    assert report.tz == TZ
    assert [t.id for t in report.trips] == ["t1", "t2"]
    assert (report.summary.trips_count, report.summary.revenue) == (2, 3900)
    assert (report.summary.commission, report.summary.net) == (585, 3315)
    assert report.summary.by_payment[PaymentMethod.CASH] == PaymentBreakdown(count=1, amount=1500, commission=225)
    assert report.summary.by_payment[PaymentMethod.CARD] == PaymentBreakdown(count=1, amount=2400, commission=360)


def test_trips_are_sorted_by_start():
    uow = FakeUnitOfWork(reversed(example_trips()))

    report = GetDayReport(uow, TZ).execute(date(2026, 10, 1))

    assert [t.id for t in report.trips] == ["t1", "t2"]


def test_other_day_is_empty(uow):
    report = GetDayReport(uow, TZ).execute(date(2026, 10, 2))

    assert report.trips == []
    assert report.summary.trips_count == 0
    assert set(report.summary.by_payment) == {PaymentMethod.CASH, PaymentMethod.CARD}


def test_trip_after_midnight_counts_for_the_day_it_started():
    # 23:50 1 октября → 00:20 2 октября: относится к 1 октября.
    uow = FakeUnitOfWork([make_trip(id="night", start="2026-10-01T23:50:00+05:00", end="2026-10-02T00:20:00+05:00")])
    report = GetDayReport(uow, TZ)

    assert [t.id for t in report.execute(date(2026, 10, 1)).trips] == ["night"]
    assert report.execute(date(2026, 10, 2)).trips == []


def test_day_is_determined_in_driver_timezone():
    # 19:30 UTC 1 октября — это уже 00:30 2 октября в UTC+5.
    uow = FakeUnitOfWork([make_trip(id="utc", start="2026-10-01T19:30:00Z", end="2026-10-01T19:50:00Z")])
    report = GetDayReport(uow, TZ)

    day2 = report.execute(date(2026, 10, 2))

    assert [t.id for t in day2.trips] == ["utc"]
    assert day2.trips[0].start.isoformat() == "2026-10-02T00:30:00+05:00"
    assert report.execute(date(2026, 10, 1)).trips == []
