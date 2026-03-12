from sqlalchemy import Column, String, DateTime, UUID, ForeignKey, Float
from sqlalchemy.sql import func
import uuid
from .user import Base

class EvidenceItem(Base):
    __tablename__ = "evidence_items"

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    user_id = Column(UUID(as_uuid=True), ForeignKey("users.id", on_delete="CASCADE"), nullable=False)
    type = Column(String, nullable=False) # audio, video, photo, location
    file_url = Column(String, nullable=False)
    file_hash = Column(String, nullable=False) # SHA-256 for integrity
    location_lat = Column(Float)
    location_lng = Column(Float)
    timestamp = Column(DateTime(timezone=True), nullable=False)
    created_at = Column(DateTime(timezone=True), server_default=func.now())
