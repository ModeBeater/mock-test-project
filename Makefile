.PHONY: setup backend client test reset-data

setup:
	cd backend && python3 -m venv .venv && .venv/bin/pip install -r requirements-dev.txt
	cd client && flutter pub get

backend:
	cd backend && .venv/bin/python -m app

client:
	cd client && flutter run -d chrome

test:
	cd backend && .venv/bin/pytest -q
	cd client && flutter test

reset-data:
	rm -f backend/data/trips.json
