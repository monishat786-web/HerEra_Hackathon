from fastapi import APIRouter, Depends, BackgroundTasks, status
from sqlalchemy.orm import Session
from app.api.v1.dependencies import get_db, get_current_user
from app.models.user import User
from app.models.alert import Alert
from app.schemas.alert import AlertCreate, AlertResponse
from app.utils.email import send_sos_email
from app.core.config import settings
import logging

router = APIRouter()
logger = logging.getLogger(__name__)

@router.post("/trigger", response_model=AlertResponse, status_code=status.HTTP_201_CREATED)
async def trigger_sos(
    alert_in: AlertCreate,
    background_tasks: BackgroundTasks,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    # 1. Save SOS alert to database
    new_alert = Alert(
        user_id=current_user.id,
        type=alert_in.type,
        location_lat=alert_in.location_lat,
        location_lng=alert_in.location_lng,
        status="active"
    )
    db.add(new_alert)
    db.commit()
    db.refresh(new_alert)

    # 2. Prepare email recipients
    # In a real app, we'd fetch these from a user_emergency_contacts table.
    # For now, we use the default emails from settings and any specifically provided by the user.
    recipient_emails = settings.EMERGENCY_EMAILS.split(",")
    recipient_emails = [email.strip() for email in recipient_emails if "@" in email]

    # 3. Trigger email sends in background (non-blocking)
    if recipient_emails:
        user_data = {
            "name": current_user.full_name or "herERA User",
            "email": current_user.email
        }
        location_data = {
            "lat": alert_in.location_lat,
            "lng": alert_in.location_lng
        }
        background_tasks.add_task(
            send_sos_email, 
            recipient_emails, 
            user_data, 
            location_data
        )
        logger.info(f"Scheduled SOS emails for user {current_user.id}")

    return new_alert

@router.get("/my-alerts", response_model=list[AlertResponse])
async def get_my_alerts(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    alerts = db.query(Alert).filter(Alert.user_id == current_user.id).all()
    return alerts
