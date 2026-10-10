class DomainError(Exception):
    """Нарушено бизнес-правило."""


class InvalidTripError(DomainError):
    """Поездка с такими данными невозможна. `field` — имя поля, к которому относится ошибка."""

    def __init__(self, field: str, message: str) -> None:
        super().__init__(f"{field}: {message}")
        self.field = field
        self.message = message
