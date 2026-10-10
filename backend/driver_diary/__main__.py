import os

import uvicorn


def main() -> None:
    uvicorn.run(
        "driver_diary.api.app:create_app",
        factory=True,
        host=os.environ.get("HOST", "127.0.0.1"),
        port=int(os.environ.get("PORT", "8000")),
        reload=os.environ.get("RELOAD", "1") == "1",
    )


if __name__ == "__main__":
    main()
