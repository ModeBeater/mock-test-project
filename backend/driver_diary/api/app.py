from functools import partial

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from driver_diary.application.ports import UnitOfWorkFactory
from driver_diary.config import Settings
from driver_diary.infrastructure.json_store import JsonTripStore, JsonUnitOfWork

from .errors import register_exception_handlers
from .routes import router


def create_app(settings: Settings | None = None, *, uow_factory: UnitOfWorkFactory | None = None) -> FastAPI:
    """Точка сборки приложения: здесь выбираются реализации портов."""
    settings = settings or Settings.from_env()
    if uow_factory is None:
        store = JsonTripStore(settings.data_file, seed_path=settings.seed_file)
        uow_factory = partial(JsonUnitOfWork, store)

    app = FastAPI(title="Дневник смен водителя", version="1.0.0")
    app.state.settings = settings
    app.state.uow_factory = uow_factory
    app.add_middleware(
        CORSMiddleware,
        allow_origins=settings.cors_origins,
        allow_methods=["GET", "POST"],
        allow_headers=["*"],
    )
    register_exception_handlers(app, settings.tz)
    app.include_router(router)
    return app
