from fastapi import APIRouter, Depends, HTTPException, status, UploadFile, File, Form
from sqlalchemy.orm import Session
from app.models.evidence import EvidenceItem
from app.models.user import User
from app.core.security import verify_password
from app.api.v1.dependencies import get_db, get_current_user
from pydantic import BaseModel
import uuid
import os
from datetime import datetime
import hashlib

router = APIRouter()

UPLOAD_DIR = "uploads"
if not os.path.exists(UPLOAD_DIR):
    os.makedirs(UPLOAD_DIR)

class DeletionRequest(BaseModel):
    evidence_id: uuid.UUID
    secret_password: str

@router.post("/upload")
async def upload_evidence(
    file: UploadFile = File(...),
    evidence_type: str = Form(...),
    lat: float = Form(None),
    lng: float = Form(None),
    timestamp: str = Form(None),
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    # 1. Generate unique filename
    file_id = str(uuid.uuid4())
    extension = os.path.splitext(file.filename)[1]
    filename = f"{file_id}{extension}"
    file_path = os.path.join(UPLOAD_DIR, filename)

    # 2. Save file and calculate hash
    sha256_hash = hashlib.sha256()
    with open(file_path, "wb") as buffer:
        while True:
            chunk = await file.read(1024 * 1024)
            if not chunk:
                break
            buffer.write(chunk)
            sha256_hash.update(chunk)
    
    file_hash = sha256_hash.hexdigest()

    # 3. Save metadata to DB
    new_evidence = EvidenceItem(
        id=uuid.UUID(file_id),
        user_id=current_user.id,
        type=evidence_type,
        file_url=file_path,
        file_hash=file_hash,
        location_lat=lat,
        location_lng=lng,
        timestamp=datetime.fromisoformat(timestamp) if timestamp else datetime.now()
    )
    
    db.add(new_evidence)
    db.commit()
    db.refresh(new_evidence)

    return {
        "id": new_evidence.id,
        "message": "Evidence uploaded and secured",
        "hash": file_hash
    }

@router.get("/list")
async def list_evidence(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    items = db.query(EvidenceItem).filter(EvidenceItem.user_id == current_user.id).all()
    return items

@router.post("/delete")
async def delete_evidence(
    request: DeletionRequest,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    # 1. Fetch evidence
    evidence = db.query(EvidenceItem).filter(
        EvidenceItem.id == request.evidence_id,
        EvidenceItem.user_id == current_user.id
    ).first()
    
    if not evidence:
        raise HTTPException(status_code=404, detail="Evidence not found")

    # 2. Verify SECRET password hash
    if not verify_password(request.secret_password, current_user.secret_password_hash):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid secret password"
        )
    
    # 3. Delete file and DB record
    if os.path.exists(evidence.file_url):
        os.remove(evidence.file_url)
        
    db.delete(evidence)
    db.commit()

    return {"message": "Evidence permanently deleted"}
