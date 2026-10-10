"""Правило зависимостей чистой архитектуры: внутренние слои не знают о внешних."""

import ast
from pathlib import Path

import pytest

PACKAGE = Path(__file__).resolve().parents[2] / "driver_diary"

# Слой → чего ему импортировать нельзя.
FORBIDDEN = {
    "domain": (
        "driver_diary.application",
        "driver_diary.infrastructure",
        "driver_diary.api",
        "driver_diary.config",
        "fastapi",
        "pydantic",
        "uvicorn",
        "json",
    ),
    "application": (
        "driver_diary.infrastructure",
        "driver_diary.api",
        "driver_diary.config",
        "fastapi",
        "pydantic",
        "uvicorn",
        "json",
    ),
    "infrastructure": ("driver_diary.api", "fastapi", "pydantic"),
}


def imported_modules(path: Path) -> set[str]:
    tree = ast.parse(path.read_text(encoding="utf-8"))
    modules: set[str] = set()
    for node in ast.walk(tree):
        if isinstance(node, ast.Import):
            modules.update(alias.name for alias in node.names)
        elif isinstance(node, ast.ImportFrom) and node.module and node.level == 0:
            modules.add(node.module)
    return modules


@pytest.mark.parametrize("layer", FORBIDDEN)
def test_layer_does_not_depend_on_outer_layers(layer):
    violations = [
        f"{path.relative_to(PACKAGE)} imports {module}"
        for path in (PACKAGE / layer).rglob("*.py")
        for module in imported_modules(path)
        if any(module == f or module.startswith(f + ".") for f in FORBIDDEN[layer])
    ]

    assert violations == []
