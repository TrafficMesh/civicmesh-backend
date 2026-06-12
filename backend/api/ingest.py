"""Evidence ingestion pipeline: 8-step process."""

from fastapi import APIRouter, UploadFile, File, Form

router = APIRouter(prefix="/incidents", tags=["incidents"])

@router.post("/submit")
async def submit_incident(metadata: str = Form(...), evidence: UploadFile = File(...)) -> dict:
    """Submit evidence from node.
    
    Steps:
    1. Verify HMAC-SHA256 signature
    2. Upload H.264 to MinIO
    3. Check duplicates (PostGIS)
    4. Classify violation
    5. Score confidence
    6. Route to queue
    7. Insert incident
    8. Append audit log
    """
    pass
