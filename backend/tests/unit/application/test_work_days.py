from datetime import date

import pytest

from driver_diary.application.work_days import ListWorkDays, WorkDay
from tests.fakes import TZ, FakeUnitOfWork, example_trips, make_trip

OCT_1, OCT_2, OCT_3 = date(2026, 10, 1), date(2026, 10, 2), date(2026, 10, 3)


@pytest.fixture
def three_days() -> FakeUnitOfWork:
    return FakeUnitOfWork(
        [
            *example_trips(),
            # 19:30 UTC 1 октября — уже 2 октября у водителя.
            make_trip(id="night", start="2026-10-01T19:30:00Z", end="2026-10-01T19:50:00Z", amount=1000, commission=0),
            make_trip(id="x", start="2026-10-03T10:00:00+05:00", end="2026-10-03T10:20:00+05:00"),
        ]
    )


def test_days_list_has_trip_count_and_net(three_days):
    days = ListWorkDays(three_days, TZ).execute()

    assert days == [
        WorkDay(date=OCT_1, trips_count=2, net=3315),
        WorkDay(date=OCT_2, trips_count=1, net=1000),
        WorkDay(date=OCT_3, trips_count=1, net=1700),
    ]


@pytest.mark.parametrize(
    ("date_from", "date_to", "expected"),
    [
        pytest.param(OCT_2, None, [OCT_2, OCT_3], id="from only"),
        pytest.param(None, OCT_2, [OCT_1, OCT_2], id="to only"),
        pytest.param(OCT_2, OCT_2, [OCT_2], id="single day, bounds inclusive"),
        pytest.param(OCT_1, OCT_3, [OCT_1, OCT_2, OCT_3], id="whole range"),
        pytest.param(date(2026, 10, 4), None, [], id="after the last day"),
        pytest.param(OCT_3, OCT_1, [], id="from after to"),
    ],
)
def test_days_list_filtered_by_range(three_days, date_from, date_to, expected):
    days = ListWorkDays(three_days, TZ).execute(date_from, date_to)

    assert [d.date for d in days] == expected


def test_no_trips_means_no_days():
    assert ListWorkDays(FakeUnitOfWork(), TZ).execute() == []
