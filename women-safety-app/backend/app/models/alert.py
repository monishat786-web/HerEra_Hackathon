from sqlalchemy import Column, String, DateTime, UUID, ForeignKey, Float
from sqlalchemy.sql import func
import uuid
from .user import Base

class Alert(Base):
    __tablename__ = "alerts"

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    user_id = Column(UUID(as_uuid=True), ForeignKey("users.id", on_delete="CASCADE"), nullable=False)
    type = Column(String, nullable=False) # manual, shake, scream, voice
    location_lat = Column(Float)
    location_lng = Column(Float)
    status = Column(String, default="active") # active, resolved, cancelled
    timestamp = Column(DateTime(timezone=True), server_default=func.now())
    created_at = Column(DateTime(timezone=True), server_default=func.now())
