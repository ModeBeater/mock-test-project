from collections.abc import Iterable

from .models import DaySummary, Payment, PaymentBreakdown, Trip


def summarize(trips: Iterable[Trip]) -> DaySummary:
    """Сводка по набору поездок. Отбор поездок по дню — забота вызывающего кода."""
    by_payment = {method: PaymentBreakdown() for method in Payment}
    for trip in trips:
        bucket = by_payment[trip.payment]
        bucket.count += 1
        bucket.amount += trip.amount
        bucket.commission += trip.commission

    revenue = sum(b.amount for b in by_payment.values())
    commission = sum(b.commission for b in by_payment.values())
    return DaySummary(
        trips_count=sum(b.count for b in by_payment.values()),
        revenue=revenue,
        commission=commission,
        net=revenue - commission,
        by_payment=by_payment,
    )
