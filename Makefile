.PHONY: setup backend client test lint codegen reset-data

setup:
	cd backend && python3 -m venv .venv && .venv/bin/pip install -e ".[dev]"
	cd client && flutter pub get

backend:
	cd backend && .venv/bin/python -m driver_diary

client:
	cd client && flutter run -d chrome

test:
	cd backend && .venv/bin/pytest -q
	cd client && flutter test

lint:
	cd backend && .venv/bin/ruff check . && .venv/bin/ruff format --check . && .venv/bin/mypy driver_diary
	cd client && flutter analyze

codegen:
	cd client && dart run build_runner build

reset-data:
	rm -f backend/data/trips.json
