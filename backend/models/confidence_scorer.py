"""Score confidence per violation type."""

class ConfidenceScorer:
    THRESHOLDS = {'bus_lane': 0.95, 'red_light': 0.95}
    
    def score(self, violation_type: str, raw_confidence: float) -> float:
        """Return normalized confidence."""
        pass
