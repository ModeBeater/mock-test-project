from __future__ import annotations

from dataclasses import dataclass, replace
from datetime import datetime, timedelta, tzinfo
from enum import StrEnum

from .errors import InvalidTripError


class PaymentMethod(StrEnum):
    CASH = "cash"
    CARD = "card"


@dataclass(frozen=True, slots=True)
class Trip:
    """Поездка водителя. Суммы — целые тенге.

    Объект нельзя создать с нарушенными инвариантами, поэтому остальной код
    может на них полагаться без повторных проверок.
    """

    id: str
    start: datetime
    end: datetime
    amount: int
    payment: PaymentMethod
    commission: int

    def __post_init__(self) -> None:
        if not isinstance(self.id, str) or not self.id:
            raise InvalidTripError("id", "id must be a non-empty string")
        # Без часового пояса нельзя понять ни момент поездки, ни к какому дню она относится.
        for name, value in (("start", self.start), ("end", self.end)):
            if not isinstance(value, datetime) or value.utcoffset() is None:
                raise InvalidTripError(name, f"{name} must be a timezone-aware datetime")
        if self.end <= self.start:
            raise InvalidTripError("end", "end must be later than start")
        if not _is_int(self.amount) or self.amount <= 0:
            raise InvalidTripError("amount", "amount must be a positive integer")
        if not isinstance(self.payment, PaymentMethod):
            raise InvalidTripError("payment", f"payment must be one of: {', '.join(PaymentMethod)}")
        if not _is_int(self.commission) or self.commission < 0:
            raise InvalidTripError("commission", "commission must be a non-negative integer")
        if self.commission > self.amount:
            raise InvalidTripError("commission", "commission cannot exceed amount")

    @property
    def duration(self) -> timedelta:
        return self.end - self.start

    @property
    def net(self) -> int:
        """«На руки»: сумма минус комиссия."""
        return self.amount - self.commission

    def same_ride_as(self, other: Trip) -> bool:
        """Совпадают ли поездки по содержимому (id не учитывается).

        Время сравнивается как момент времени, поэтому 08:10+05:00 и 03:10Z — одно и то же.
        """
        return (self.start, self.end, self.amount, self.payment, self.commission) == (
            other.start,
            other.end,
            other.amount,
            other.payment,
            other.commission,
        )

    def overlaps(self, other: Trip) -> bool:
        # Полуоткрытые интервалы: поездка, начавшаяся ровно в момент окончания предыдущей, — не пересечение.
        return self.start < other.end and other.start < self.end

    def with_timezone(self, tz: tzinfo) -> Trip:
        return replace(self, start=self.start.astimezone(tz), end=self.end.astimezone(tz))


def _is_int(value: object) -> bool:
    # bool — подкласс int, но True вместо суммы — явная ошибка.
    return isinstance(value, int) and not isinstance(value, bool)
