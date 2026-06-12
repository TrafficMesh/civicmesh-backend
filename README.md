# CivicMesh Backend

FastAPI backend for evidence ingestion and officer review portal.

## Directory Structure

```
civicmesh-backend/
├── backend/
│   ├── api/
│   │   ├── main.py              # FastAPI app entry point, routes, startup
│   │   ├── ingest.py            # POST /incidents/submit - 8-step pipeline
│   │   ├── review_queue.py      # Officer portal endpoints (queue, detail, approve, reject, escalate)
│   │   └── deps.py              # Shared dependencies (DB, MinIO, Redis)
│   ├── models/
│   │   ├── violation_classifier.py   # Map violation type → queue routing decision
│   │   ├── confidence_scorer.py      # Validate confidence per violation type
│   │   ├── deduplication_logic.py    # Geospatial dedup (50m/5min window)
│   │   └── citation_generator.py     # Generate NOC from incident
│   └── database/
│       ├── schema_incidents.sql      # incidents, review_queues, citations, audit_log
│       ├── schema_devices.sql        # Node registry and heartbeat tracking
│       ├── schema_twin.sql           # Digital twin observations
│       └── schema_compliance.sql     # Officer sessions, compliance audit
├── tests/
│   └── unit/
│       ├── test_confidence_scorer.py    # 8 test cases: thresholds, normalization
│       ├── test_violation_classifier.py # 9 test cases: type normalization, routing
│       └── test_dedup_logic.py          # 5 scenarios: unique, duplicate, geofence
├── config/
│   └── docker/
│       ├── docker-compose.yml       # PostgreSQL, MinIO, Redis, RabbitMQ, FastAPI
│       └── Dockerfile.api           # Multi-stage build for backend service
├── docs/
│   ├── API_SPECIFICATION.md         # Endpoint reference (POST /incidents, GET/POST /portal/*)
│   ├── DEPLOYMENT_GUIDE.md          # Local dev, production, scaling
│   └── DEVELOPER_GUIDE.md           # Setup, testing, code style (Black, flake8, mypy)
├── .github/workflows/
│   ├── ci.yml                       # Run tests on PR (pytest, black, flake8, mypy, coverage)
│   └── docker-build.yml             # Build & push Docker image on main branch
├── requirements.txt                 # FastAPI 0.111, asyncpg, SQLAlchemy 2.0, etc.
├── .gitignore                       # Python standard excludes
├── CODEOWNERS                       # @TrafficMesh/backend-team for code review
└── README.md                        # This file
```

## Quick Start

### Local Development with Docker Compose

```bash
docker compose -f config/docker/docker-compose.yml up
```

**Services will be available at:**
- Backend API: http://localhost:8000
- PostgreSQL: localhost:5432
- MinIO Console: http://localhost:9001 (admin/minioadmin)
- RabbitMQ Console: http://localhost:15672 (guest/guest)
- Redis: localhost:6379

### Health Check

```bash
curl http://localhost:8000/health
```

## Development Workflow

### Setup

```bash
python -m venv venv
source venv/bin/activate  # or `venv\Scripts\activate` on Windows
pip install -r requirements.txt
```

### Running Tests

```bash
pytest tests/unit/ -v --cov=backend --cov-report=html
```

### Code Style

```bash
black backend/ tests/           # Format code
flake8 backend/ tests/          # Lint
mypy backend/ --ignore-missing-imports  # Type check
```

## Architecture

### Evidence Ingestion Pipeline (8 Steps)

1. **HMAC Verification** - Validate node secret on upload
2. **MinIO Upload** - Store H.264 evidence clip
3. **PostGIS Deduplication** - Check for duplicates (same plate/50m/5min)
4. **Classification** - Normalize violation type
5. **Confidence Scoring** - Determine per-violation thresholds
6. **Queue Routing** - Route to fast_track/manual_review/discard
7. **Database Insertion** - Create incident record
8. **Audit Logging** - Append immutable blake3-signed log

### Officer Portal Endpoints

- `GET /portal/queue` - Queue summary by type
- `GET /portal/incidents/{id}` - Incident details with presigned S3 URL
- `POST /portal/incidents/{id}/approve` - Issue citation
- `POST /portal/incidents/{id}/reject` - Reject false positive
- `POST /portal/incidents/{id}/escalate` - Escalate to supervisor

See `docs/API_SPECIFICATION.md` for full API reference.

## Technology Stack

- **Web Framework:** FastAPI 0.111.0 (async)
- **Database:** PostgreSQL 16 + PostGIS 3.4 (geospatial queries)
- **ORM:** SQLAlchemy 2.0 with asyncpg (non-blocking)
- **Storage:** MinIO (S3-compatible)
- **Caching:** Redis 7
- **Queuing:** RabbitMQ 3.13 (Phase 1+)
- **Cryptography:** blake3 (immutable audit logs)
- **Testing:** pytest, pytest-asyncio, pytest-cov
- **Linting:** black, flake8, mypy

## Phase 0 Success Criteria

- [x] Repository structure
- [ ] Evidence ingestion pipeline (HMAC → MinIO → PostGIS → Queue)
- [ ] Officer portal endpoints (5 endpoints)
- [ ] Unit tests (>80% coverage)
- [ ] Docker Compose local dev
- [ ] Integration testing
- [ ] Field deployment (5-10 buses)

## Documentation

- [API Specification](docs/API_SPECIFICATION.md) - Full endpoint reference
- [Deployment Guide](docs/DEPLOYMENT_GUIDE.md) - Local, production, scaling
- [Developer Guide](docs/DEVELOPER_GUIDE.md) - Setup, testing, code standards
- [Central Docs Hub](https://github.com/TrafficMesh/civicmesh-docs) - Architecture, compliance, roadmap

## Contributing

See [CONTRIBUTING.md](https://github.com/TrafficMesh/civicmesh-docs/blob/main/community/CONTRIBUTING.md) in the docs repository.

## Team

- **Owner:** @TrafficMesh/backend-team
- **Code Review:** CODEOWNERS

## License

Dual license: AGPL (open source) + BSL (commercial)
