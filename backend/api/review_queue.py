"""Officer portal endpoints."""

from fastapi import APIRouter

router = APIRouter(prefix="/portal", tags=["portal"])

@router.get("/queue")
async def get_queue() -> dict:
    """Get queue summary by type."""
    pass

@router.get("/incidents/{incident_id}")
async def get_incident(incident_id: str) -> dict:
    """Get incident details with video URL."""
    pass

@router.post("/incidents/{incident_id}/approve")
async def approve_incident(incident_id: str) -> dict:
    """Approve and issue citation."""
    pass

@router.post("/incidents/{incident_id}/reject")
async def reject_incident(incident_id: str, reason: str) -> dict:
    """Reject false positive."""
    pass

@router.post("/incidents/{incident_id}/escalate")
async def escalate_incident(incident_id: str) -> dict:
    """Escalate to supervisor."""
    pass
