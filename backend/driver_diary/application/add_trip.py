import uuid
from collections.abc import Callable
from dataclasses import dataclass
from datetime import datetime, tzinfo

from driver_diary.domain.trip import PaymentMethod, Trip

from .errors import ConflictKind, TripConflictError
from .ports import UnitOfWork


@dataclass(frozen=True, slots=True, kw_only=True)
class AddTripCommand:
    """`id` необязателен, но клиенту стоит его передавать: это ключ идемпотентности."""

    id: str | None = None
    start: datetime
    end: datetime
    amount: int
    payment: PaymentMethod
    commission: int


@dataclass(frozen=True, slots=True)
class AddTripResult:
    trip: Trip
    created: bool


def _new_trip_id() -> str:
    return uuid.uuid4().hex


class AddTrip:
    """Сохраняет поездку, не допуская дублей.

    - тот же id и те же данные → повтор запроса, отдаём сохранённую поездку;
    - тот же id, но другие данные → TripConflictError(ID_CONFLICT);
    - те же данные под другим id (или без id) → тоже повтор, дубль не создаём;
    - пересечение по времени с другой поездкой → TripConflictError(TRIP_OVERLAP):
      водитель не может везти два заказа одновременно, а «почти дубль»
      (та же поездка с исправленной суммой) иначе прошёл бы как новая.
    """

    def __init__(self, uow: UnitOfWork, tz: tzinfo, id_factory: Callable[[], str] = _new_trip_id) -> None:
        self._uow = uow
        self._tz = tz
        self._id_factory = id_factory

    def execute(self, cmd: AddTripCommand) -> AddTripResult:
        # Сначала инварианты: некорректные данные отклоняем, не заглядывая в хранилище и не беря блокировку.
        trip = Trip(
            id=cmd.id if cmd.id is not None else self._id_factory(),
            start=cmd.start,
            end=cmd.end,
            amount=cmd.amount,
            payment=cmd.payment,
            commission=cmd.commission,
        ).with_timezone(self._tz)

        # Проверка и вставка в одной транзакции: два одновременных запроса с одной поездкой не создадут две записи.
        with self._uow as uow:
            if cmd.id is not None and (existing := uow.trips.get(cmd.id)) is not None:
                if existing.same_ride_as(trip):
                    return AddTripResult(existing, created=False)
                raise TripConflictError(ConflictKind.ID_CONFLICT, existing)

            stored = uow.trips.all()
            for existing in stored:
                if existing.same_ride_as(trip):
                    return AddTripResult(existing, created=False)
            for existing in stored:
                if existing.overlaps(trip):
                    raise TripConflictError(ConflictKind.TRIP_OVERLAP, existing)

            uow.trips.add(trip)
            uow.commit()
            return AddTripResult(trip, created=True)
