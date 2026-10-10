from driver_diary.domain.summary import PaymentBreakdown, summarize
from driver_diary.domain.trip import PaymentMethod
from tests.fakes import example_trips, make_trip


def test_summary_for_example_day():
    summary = summarize(example_trips())

    assert summary.trips_count == 2
    assert summary.revenue == 3900
    assert summary.commission == 585
    assert summary.net == 3315
    assert summary.by_payment[PaymentMethod.CARD] == PaymentBreakdown(count=1, amount=2400, commission=360)
    assert summary.by_payment[PaymentMethod.CASH] == PaymentBreakdown(count=1, amount=1500, commission=225)


def test_summary_for_empty_day_has_zeros_and_both_payment_methods():
    summary = summarize([])

    assert (summary.trips_count, summary.revenue, summary.commission, summary.net) == (0, 0, 0, 0)
    assert set(summary.by_payment) == {PaymentMethod.CASH, PaymentMethod.CARD}
    assert all(b == PaymentBreakdown() for b in summary.by_payment.values())


def test_summary_with_single_payment_method():
    summary = summarize(
        [
            make_trip(id="a", amount=1000, commission=150, payment="card"),
            make_trip(id="b", amount=3000, commission=0, payment="card"),
        ]
    )

    assert summary.revenue == 4000
    assert summary.net == 3850
    assert summary.by_payment[PaymentMethod.CARD].count == 2
    assert summary.by_payment[PaymentMethod.CASH].count == 0
