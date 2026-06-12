"""Shared dependencies: DB, MinIO, Redis."""

from typing import AsyncGenerator
from sqlalchemy.ext.asyncio import AsyncSession

async def get_db() -> AsyncGenerator[AsyncSession, None]:
    """Get async database session."""
    pass

async def get_minio_client():
    """Get MinIO S3 client."""
    pass

async def get_redis_client():
    """Get Redis cache client."""
    pass
