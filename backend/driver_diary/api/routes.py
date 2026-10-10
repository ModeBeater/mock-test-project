import datetime as dt
from typing import Annotated

from fastapi import APIRouter, Depends, HTTPException, Query, Request, Response, status

from driver_diary.application.add_trip import AddTrip
from driver_diary.application.day_report import GetDayReport
from driver_diary.application.get_trip import GetTrip
from driver_diary.application.ports import UnitOfWork, UnitOfWorkFactory
from driver_diary.application.work_days import ListWorkDays
from driver_diary.config import Settings

from .schemas import ConflictResponse, DayReportOut, TripIn, TripOut, WorkDayOut

# Зависимости собирают сценарии из того, что create_app положил в app.state.
# Unit of Work создаётся заново на каждый запрос.


def get_settings(request: Request) -> Settings:
    settings: Settings = request.app.state.settings
    return settings


def get_uow(request: Request) -> UnitOfWork:
    factory: UnitOfWorkFactory = request.app.state.uow_factory
    return factory()


SettingsDep = Annotated[Settings, Depends(get_settings)]
UnitOfWorkDep = Annotated[UnitOfWork, Depends(get_uow)]


def make_get_day_report(uow: UnitOfWorkDep, settings: SettingsDep) -> GetDayReport:
    return GetDayReport(uow, settings.tz)


def make_list_work_days(uow: UnitOfWorkDep, settings: SettingsDep) -> ListWorkDays:
    return ListWorkDays(uow, settings.tz)


def make_get_trip(uow: UnitOfWorkDep) -> GetTrip:
    return GetTrip(uow)


def make_add_trip(uow: UnitOfWorkDep, settings: SettingsDep) -> AddTrip:
    return AddTrip(uow, settings.tz)


GetDayReportDep = Annotated[GetDayReport, Depends(make_get_day_report)]
ListWorkDaysDep = Annotated[ListWorkDays, Depends(make_list_work_days)]
GetTripDep = Annotated[GetTrip, Depends(make_get_trip)]
AddTripDep = Annotated[AddTrip, Depends(make_add_trip)]


router = APIRouter(prefix="/api")


@router.get("/health")
def health() -> dict[str, str]:
    return {"status": "ok"}


@router.get("/days", summary="Дни, в которые были поездки")
def list_days(
    use_case: ListWorkDaysDep,
    date_from: Annotated[dt.date | None, Query(alias="from", description="Первый день, включительно")] = None,
    date_to: Annotated[dt.date | None, Query(alias="to", description="Последний день, включительно")] = None,
) -> list[WorkDayOut]:
    return [WorkDayOut.from_domain(day) for day in use_case.execute(date_from, date_to)]


@router.get("/days/{day}", summary="Сводка и поездки за день")
def get_day(
    day: dt.date,
    use_case: GetDayReportDep,
    settings: SettingsDep,
) -> DayReportOut:
    return DayReportOut.from_domain(use_case.execute(day), settings.tz)


@router.get("/trips/{trip_id}", responses={status.HTTP_404_NOT_FOUND: {}})
def read_trip(
    trip_id: str,
    use_case: GetTripDep,
    settings: SettingsDep,
) -> TripOut:
    trip = use_case.execute(trip_id)
    if trip is None:
        raise HTTPException(status.HTTP_404_NOT_FOUND, "Trip not found")
    return TripOut.from_domain(trip, settings.tz)


@router.post(
    "/trips",
    status_code=status.HTTP_201_CREATED,
    summary="Добавить поездку",
    responses={
        status.HTTP_200_OK: {
            "model": TripOut,
            "description": "Такая поездка уже сохранена — возвращаем её, дубль не создан",
        },
        status.HTTP_409_CONFLICT: {
            "model": ConflictResponse,
            "description": "Конфликт по id или пересечение по времени",
        },
    },
)
def create_trip(
    payload: TripIn,
    response: Response,
    use_case: AddTripDep,
    settings: SettingsDep,
) -> TripOut:
    result = use_case.execute(payload.to_command())
    response.status_code = status.HTTP_201_CREATED if result.created else status.HTTP_200_OK
    response.headers["Location"] = f"/api/trips/{result.trip.id}"
    return TripOut.from_domain(result.trip, settings.tz)
