from enum import StrEnum

from driver_diary.domain.errors import DomainError
from driver_diary.domain.trip import Trip


class ConflictKind(StrEnum):
    ID_CONFLICT = "id_conflict"
    TRIP_OVERLAP = "trip_overlap"


class TripConflictError(DomainError):
    """Поездку нельзя сохранить: она противоречит уже сохранённой `existing`."""

    def __init__(self, kind: ConflictKind, existing: Trip) -> None:
        self.kind = kind
        self.existing = existing
        if kind is ConflictKind.ID_CONFLICT:
            self.message = f"Trip {existing.id!r} already exists with different data"
        else:
            self.message = f"Trip overlaps with trip {existing.id!r}"
        super().__init__(self.message)
