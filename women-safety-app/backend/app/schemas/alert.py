from pydantic import BaseModel
from typing import Optional
from datetime import datetime
import uuid

class AlertBase(BaseModel):
    type: str # manual, shake, scream, voice
    location_lat: Optional[float] = None
    location_lng: Optional[float] = None

class AlertCreate(AlertBase):
    pass

class AlertResponse(AlertBase):
    id: uuid.UUID
    user_id: uuid.UUID
    status: str
    timestamp: datetime

    class Config:
        from_attributes = True
