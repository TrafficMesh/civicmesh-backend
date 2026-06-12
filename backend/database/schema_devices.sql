CREATE TABLE devices (
    node_id VARCHAR(64) PRIMARY KEY,
    vehicle_vin VARCHAR(17),
    vehicle_plate VARCHAR(16),
    status VARCHAR(32) DEFAULT 'active',
    last_heartbeat TIMESTAMPTZ,
    firmware_version VARCHAR(32),
    enrolled_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_devices_status ON devices(status);
