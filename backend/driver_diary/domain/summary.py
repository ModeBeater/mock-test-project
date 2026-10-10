from collections.abc import Iterable, Mapping
from dataclasses import dataclass

from .trip import PaymentMethod, Trip


@dataclass(frozen=True, slots=True)
class PaymentBreakdown:
    count: int = 0
    amount: int = 0
    commission: int = 0


@dataclass(frozen=True, slots=True)
class DaySummary:
    trips_count: int
    revenue: int
    commission: int
    net: int
    by_payment: Mapping[PaymentMethod, PaymentBreakdown]


def summarize(trips: Iterable[Trip]) -> DaySummary:
    """Сводка по набору поездок. Отбор поездок по дню — забота вызывающего кода.

    В `by_payment` всегда есть оба способа оплаты, даже нулевые: клиенту не нужно угадывать ключи.
    """
    trip_list = list(trips)
    by_payment: dict[PaymentMethod, PaymentBreakdown] = {}
    for method in PaymentMethod:
        group = [t for t in trip_list if t.payment is method]
        by_payment[method] = PaymentBreakdown(
            count=len(group),
            amount=sum(t.amount for t in group),
            commission=sum(t.commission for t in group),
        )

    revenue = sum(b.amount for b in by_payment.values())
    commission = sum(b.commission for b in by_payment.values())
    return DaySummary(
        trips_count=len(trip_list),
        revenue=revenue,
        commission=commission,
        net=revenue - commission,
        by_payment=by_payment,
    )
