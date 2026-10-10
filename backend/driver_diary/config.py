import os
import re
from dataclasses import dataclass, field
from datetime import timedelta, timezone
from pathlib import Path

BACKEND_DIR = Path(__file__).resolve().parent.parent


def parse_utc_offset(value: str) -> timezone:
    match = re.fullmatch(r"([+-])(\d{2}):(\d{2})", value.strip())
    if not match or int(match[2]) > 14 or int(match[3]) >= 60:
        raise ValueError(f"Invalid UTC offset {value!r}, expected ±HH:MM")
    sign = 1 if match[1] == "+" else -1
    return timezone(sign * timedelta(hours=int(match[2]), minutes=int(match[3])))


def format_utc_offset(tz: timezone) -> str:
    minutes = int(tz.utcoffset(None).total_seconds() // 60)
    sign = "+" if minutes >= 0 else "-"
    hours, minutes = divmod(abs(minutes), 60)
    return f"{sign}{hours:02d}:{minutes:02d}"


@dataclass(frozen=True)
class Settings:
    data_file: Path = BACKEND_DIR / "data" / "trips.json"
    seed_file: Path = BACKEND_DIR / "data" / "seed_trips.json"
    # Часовой пояс водителя: по нему поездка относится к дню. В Казахстане UTC+5 круглый год.
    tz: timezone = timezone(timedelta(hours=5))
    cors_origins: list[str] = field(default_factory=lambda: ["*"])

    @classmethod
    def from_env(cls) -> "Settings":
        defaults = cls()
        return cls(
            data_file=Path(os.environ.get("DATA_FILE", defaults.data_file)),
            seed_file=Path(os.environ.get("SEED_FILE", defaults.seed_file)),
            tz=parse_utc_offset(os.environ["DRIVER_UTC_OFFSET"]) if "DRIVER_UTC_OFFSET" in os.environ else defaults.tz,
            cors_origins=os.environ.get("CORS_ORIGINS", "*").split(","),
        )
