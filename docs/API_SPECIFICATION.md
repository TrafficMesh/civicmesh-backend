# Backend API Specification

## Evidence Submission
POST /incidents/submit - Upload evidence from node

## Officer Portal
- GET /portal/queue - Queue summary
- GET /portal/incidents/{id} - Incident details
- POST /portal/incidents/{id}/approve - Issue citation
- POST /portal/incidents/{id}/reject - Reject incident
- POST /portal/incidents/{id}/escalate - Escalate
