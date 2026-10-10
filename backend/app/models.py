from datetime import date
from enum import Enum
from typing import Annotated

from pydantic import AwareDatetime, BaseModel, ConfigDict, Field, model_validator

# Суммы — целые тенге. strict=True: не принимаем "2400" (строку), 2400.0 и true.
Money = Annotated[int, Field(strict=True)]
TripId = Annotated[str, Field(min_length=1, max_length=64, pattern=r"^[A-Za-z0-9_-]+$")]


class Payment(str, Enum):
    CASH = "cash"
    CARD = "card"


class TripIn(BaseModel):
    """Тело POST /api/trips.

    `id` необязателен, но клиенту стоит его передавать: это ключ идемпотентности,
    повторная отправка с тем же id вернёт уже сохранённую поездку.
    """

    model_config = ConfigDict(extra="forbid")

    id: TripId | None = None
    start: AwareDatetime
    end: AwareDatetime
    amount: Money = Field(gt=0)
    payment: Payment
    commission: Money = Field(ge=0)

    @model_validator(mode="after")
    def _check_consistency(self):
        if self.end <= self.start:
            raise ValueError("end must be later than start")
        if self.commission > self.amount:
            raise ValueError("commission cannot exceed amount")
        return self

    def same_trip_as(self, other: "TripIn") -> bool:
        """Совпадают ли поездки по содержимому (id не учитывается).

        Время сравнивается как момент времени, поэтому 08:10+05:00 и 03:10Z — одно и то же.
        """
        return (
            self.start == other.start
            and self.end == other.end
            and self.amount == other.amount
            and self.payment == other.payment
            and self.commission == other.commission
        )

    def overlaps(self, other: "TripIn") -> bool:
        # Полуоткрытые интервалы: поездка, начавшаяся ровно в момент окончания предыдущей, — не пересечение.
        return self.start < other.end and other.start < self.end


class Trip(TripIn):
    id: TripId


class PaymentBreakdown(BaseModel):
    count: int = 0
    amount: int = 0
    commission: int = 0


class DaySummary(BaseModel):
    trips_count: int
    revenue: int
    commission: int
    net: int = Field(description="«На руки»: выручка минус комиссия")
    by_payment: dict[Payment, PaymentBreakdown]


class DayReport(BaseModel):
    date: date
    utc_offset: str = Field(description="Часовой пояс водителя; в нём же отданы start/end поездок")
    summary: DaySummary
    trips: list[Trip]


class DayInfo(BaseModel):
    date: date
    trips_count: int
