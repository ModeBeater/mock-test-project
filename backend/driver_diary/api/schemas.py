"""Модели запросов и ответов HTTP API и их сборка из доменных объектов.

Здесь только форма и типы данных; бизнес-правила (сумма > 0, конец позже начала и т.п.)
проверяет доменная модель Trip.
"""

import datetime as dt
from typing import Annotated, Self

from pydantic import AwareDatetime, BaseModel, ConfigDict, Field, StrictInt

from driver_diary.application.add_trip import AddTripCommand
from driver_diary.application.day_report import DayReport
from driver_diary.application.errors import ConflictKind, TripConflictError
from driver_diary.application.work_days import WorkDay
from driver_diary.config import format_utc_offset
from driver_diary.domain.summary import DaySummary, PaymentBreakdown
from driver_diary.domain.trip import PaymentMethod, Trip

TripId = Annotated[str, Field(min_length=1, max_length=64, pattern=r"^[A-Za-z0-9_-]+$")]


class TripIn(BaseModel):
    """Тело POST /api/trips.

    `id` необязателен, но клиенту стоит его передавать: это ключ идемпотентности,
    повторная отправка с тем же id вернёт уже сохранённую поездку.
    """

    model_config = ConfigDict(extra="forbid")

    id: TripId | None = None
    start: AwareDatetime
    end: AwareDatetime
    # Суммы — целые тенге. Strict: не принимаем "2400" (строку), 2400.0 и true.
    amount: StrictInt
    payment: PaymentMethod
    commission: StrictInt

    def to_command(self) -> AddTripCommand:
        return AddTripCommand(
            id=self.id,
            start=self.start,
            end=self.end,
            amount=self.amount,
            payment=self.payment,
            commission=self.commission,
        )


class TripOut(BaseModel):
    id: str
    start: dt.datetime
    end: dt.datetime
    amount: int
    payment: PaymentMethod
    commission: int

    @classmethod
    def from_domain(cls, trip: Trip, tz: dt.tzinfo) -> Self:
        """Время отдаём в часовом поясе водителя, как бы его ни прислали."""
        local = trip.with_timezone(tz)
        return cls(
            id=local.id,
            start=local.start,
            end=local.end,
            amount=local.amount,
            payment=local.payment,
            commission=local.commission,
        )


class PaymentBreakdownOut(BaseModel):
    count: int
    amount: int
    commission: int

    @classmethod
    def from_domain(cls, breakdown: PaymentBreakdown) -> Self:
        return cls(count=breakdown.count, amount=breakdown.amount, commission=breakdown.commission)


class DaySummaryOut(BaseModel):
    trips_count: int
    revenue: int
    commission: int
    net: int = Field(description="«На руки»: выручка минус комиссия")
    by_payment: dict[PaymentMethod, PaymentBreakdownOut]

    @classmethod
    def from_domain(cls, summary: DaySummary) -> Self:
        return cls(
            trips_count=summary.trips_count,
            revenue=summary.revenue,
            commission=summary.commission,
            net=summary.net,
            by_payment={method: PaymentBreakdownOut.from_domain(b) for method, b in summary.by_payment.items()},
        )


class DayReportOut(BaseModel):
    date: dt.date
    utc_offset: str = Field(description="Часовой пояс водителя; в нём же отданы start/end поездок")
    summary: DaySummaryOut
    trips: list[TripOut]

    @classmethod
    def from_domain(cls, report: DayReport, tz: dt.tzinfo) -> Self:
        return cls(
            date=report.date,
            utc_offset=format_utc_offset(report.tz),
            summary=DaySummaryOut.from_domain(report.summary),
            trips=[TripOut.from_domain(t, tz) for t in report.trips],
        )


class WorkDayOut(BaseModel):
    date: dt.date
    trips_count: int
    net: int = Field(description="«На руки» за день")

    @classmethod
    def from_domain(cls, day: WorkDay) -> Self:
        return cls(date=day.date, trips_count=day.trips_count, net=day.net)


class ConflictDetail(BaseModel):
    code: ConflictKind
    message: str
    existing: TripOut

    @classmethod
    def from_error(cls, error: TripConflictError, tz: dt.tzinfo) -> Self:
        return cls(code=error.kind, message=error.message, existing=TripOut.from_domain(error.existing, tz))


class ConflictResponse(BaseModel):
    detail: ConflictDetail
