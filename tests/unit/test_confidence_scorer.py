"""Test confidence scoring."""

def test_bus_lane_high_confidence():
    """Bus lane @ 0.97 -> fast_track"""
    pass

def test_bus_lane_medium_confidence():
    """Bus lane @ 0.87 -> manual_review"""
    pass

def test_low_confidence_discard():
    """Any violation < 0.80 -> discard"""
    pass

def test_threshold_boundary():
    """Test exact threshold (0.95)"""
    pass

def test_multiple_violation_types():
    """Test different thresholds per type"""
    pass

def test_confidence_normalization():
    """Test confidence clamping (0.0-1.0)"""
    pass

def test_red_light_high():
    """Red light @ 0.96 -> fast_track"""
    pass

def test_red_light_low():
    """Red light @ 0.79 -> discard"""
    pass
