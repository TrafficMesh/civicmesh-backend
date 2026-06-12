"""Test deduplication logic."""

def test_unique_incident():
    """Different plate -> UNIQUE"""
    pass

def test_duplicate_same_time():
    """Same plate/location within 5min -> DUPLICATE"""
    pass

def test_duplicate_outside_time_window():
    """Same plate/location, 10min apart -> UNIQUE"""
    pass

def test_duplicate_outside_geofence():
    """Same plate/time, >50m -> UNIQUE"""
    pass

def test_duplicate_higher_confidence():
    """Duplicate with higher confidence -> update"""
    pass

def test_duplicate_lower_confidence():
    """Duplicate with lower confidence -> discard"""
    pass
