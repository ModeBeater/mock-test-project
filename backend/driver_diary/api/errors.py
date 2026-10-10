from datetime import tzinfo

from fastapi import FastAPI, Request, status
from fastapi.responses import JSONResponse

from driver_diary.application.errors import TripConflictError
from driver_diary.domain.errors import InvalidTripError

from .schemas import ConflictDetail, ConflictResponse


def register_exception_handlers(app: FastAPI, tz: tzinfo) -> None:
    @app.exception_handler(InvalidTripError)
    async def invalid_trip(_: Request, exc: InvalidTripError) -> JSONResponse:
        # Та же форма, что у ошибок валидации FastAPI: клиенту не нужно различать, кто именно отклонил данные.
        return JSONResponse(
            status_code=status.HTTP_422_UNPROCESSABLE_CONTENT,
            content={"detail": [{"type": "value_error", "loc": ["body", exc.field], "msg": exc.message}]},
        )

    @app.exception_handler(TripConflictError)
    async def trip_conflict(_: Request, exc: TripConflictError) -> JSONResponse:
        body = ConflictResponse(detail=ConflictDetail.from_error(exc, tz))
        return JSONResponse(status_code=status.HTTP_409_CONFLICT, content=body.model_dump(mode="json"))
