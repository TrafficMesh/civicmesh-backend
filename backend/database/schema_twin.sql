CREATE TABLE segment_observations (
    obs_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    segment_id VARCHAR(64),
    location GEOMETRY(LineString, 4326),
    observation JSONB,
    observed_at TIMESTAMPTZ DEFAULT NOW()
);
