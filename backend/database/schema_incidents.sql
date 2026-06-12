CREATE EXTENSION IF NOT EXISTS postgis;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE incidents (
    incident_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    node_id VARCHAR(64) NOT NULL,
    violation_type VARCHAR(64) NOT NULL,
    plate VARCHAR(16),
    location GEOMETRY(Point, 4326) NOT NULL,
    timestamp TIMESTAMPTZ NOT NULL,
    evidence_s3_url TEXT,
    confidence FLOAT NOT NULL,
    status VARCHAR(32) NOT NULL DEFAULT 'queued',
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_incidents_plate_time ON incidents(plate, timestamp);
CREATE INDEX idx_incidents_location ON incidents USING GIST(location);
CREATE INDEX idx_incidents_status ON incidents(status);

CREATE TABLE review_queues (
    queue_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    queue_type VARCHAR(32) NOT NULL,
    incident_id UUID REFERENCES incidents(incident_id),
    assigned_officer_id VARCHAR(64),
    locked_until TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE citations (
    citation_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    incident_id UUID REFERENCES incidents(incident_id),
    officer_id VARCHAR(64) NOT NULL,
    badge_number VARCHAR(32),
    digital_signature TEXT,
    signed_at TIMESTAMPTZ,
    noc_document_hash TEXT,
    mto_ticket_number VARCHAR(64),
    status VARCHAR(32) DEFAULT 'issued'
);

CREATE TABLE audit_log (
    log_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    incident_id UUID REFERENCES incidents(incident_id),
    event_type VARCHAR(64) NOT NULL,
    actor VARCHAR(64) NOT NULL,
    timestamp TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    metadata JSONB,
    hmac_hash TEXT NOT NULL
);
