CREATE TABLE officer_sessions (
    session_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    officer_id VARCHAR(64) NOT NULL,
    badge_number VARCHAR(32),
    login_at TIMESTAMPTZ DEFAULT NOW(),
    logout_at TIMESTAMPTZ
);

CREATE TABLE compliance_audit (
    audit_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    event_type VARCHAR(64) NOT NULL,
    actor VARCHAR(64),
    timestamp TIMESTAMPTZ DEFAULT NOW(),
    metadata JSONB
);
