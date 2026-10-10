from datetime import date

from fastapi import FastAPI, HTTPException, Response
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel

from .config import Settings, format_utc_offset
from .models import DayInfo, DayReport, Trip, TripIn
from .storage import TripConflict, TripRepository
from .summary import summarize


class ConflictDetail(BaseModel):
    code: str
    message: str
    existing: Trip


class ConflictResponse(BaseModel):
    detail: ConflictDetail


def create_app(settings: Settings | None = None, repo: TripRepository | None = None) -> FastAPI:
    settings = settings or Settings.from_env()
    repo = repo or TripRepository(settings.data_file, settings.tz, seed=settings.seed_file)
    utc_offset = format_utc_offset(settings.tz)

    app = FastAPI(title="Дневник смен водителя", version="1.0.0")
    app.add_middleware(
        CORSMiddleware,
        allow_origins=settings.cors_origins,
        allow_methods=["GET", "POST"],
        allow_headers=["*"],
    )

    @app.get("/api/health")
    def health() -> dict[str, str]:
        return {"status": "ok"}

    @app.get("/api/days", response_model=list[DayInfo], summary="Дни, в которые были поездки")
    def list_days() -> list[DayInfo]:
        return repo.days()

    @app.get("/api/days/{day}", response_model=DayReport, summary="Сводка и поездки за день")
    def get_day(day: date) -> DayReport:
        trips = repo.for_day(day)
        return DayReport(date=day, utc_offset=utc_offset, summary=summarize(trips), trips=trips)

    @app.get("/api/trips/{trip_id}", response_model=Trip, responses={404: {}})
    def get_trip(trip_id: str) -> Trip:
        trip = repo.get(trip_id)
        if trip is None:
            raise HTTPException(404, "Trip not found")
        return trip

    @app.post(
        "/api/trips",
        response_model=Trip,
        status_code=201,
        summary="Добавить поездку",
        responses={
            200: {"model": Trip, "description": "Такая поездка уже сохранена — возвращаем её, дубль не создан"},
            409: {"model": ConflictResponse, "description": "Конфликт по id или пересечение по времени"},
        },
    )
    def create_trip(payload: TripIn, response: Response) -> Trip:
        try:
            trip, created = repo.add(payload)
        except TripConflict as e:
            raise HTTPException(409, ConflictDetail(code=e.code, message=e.message, existing=e.existing).model_dump(mode="json"))
        response.status_code = 201 if created else 200
        response.headers["Location"] = f"/api/trips/{trip.id}"
        return trip

    return app
