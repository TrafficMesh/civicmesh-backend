# Backend Developer Guide

## Setup
1. Clone repository
2. Create venv: `python -m venv venv`
3. Activate: `source venv/bin/activate`
4. Install: `pip install -r requirements.txt`

## Tests
```bash
pytest tests/unit/ -v
```

## Code Style
- Format: `black backend/ tests/`
- Lint: `flake8 backend/ tests/`
- Type: `mypy backend/`
