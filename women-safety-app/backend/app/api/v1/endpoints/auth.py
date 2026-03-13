from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from app.api.v1.dependencies import get_db
from app.core.security import get_password_hash, verify_password, create_access_token
from app.models.user import User
from pydantic import BaseModel, EmailStr
from typing import Any

router = APIRouter()

class SignupRequest(BaseModel):
    email: EmailStr
    password: str
    secret_password: str
    full_name: str = None

class LoginRequest(BaseModel):
    email: EmailStr
    password: str

class Token(BaseModel):
    access_token: str
    token_type: str

@router.post("/signup", response_model=Any)
async def signup(request: SignupRequest, db: Session = Depends(get_db)):
    # Check if user already exists
    user = db.query(User).filter(User.email == request.email).first()
    if user:
        raise HTTPException(
            status_code=400,
            detail="User with this email already exists"
        )
    
    # Create new user
    new_user = User(
        email=request.email,
        password_hash=get_password_hash(request.password),
        secret_password_hash=get_password_hash(request.secret_password),
        full_name=request.full_name
    )
    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    
    return {"message": "User created successfully", "id": str(new_user.id)}

@router.post("/login", response_model=Token)
async def login(request: LoginRequest, db: Session = Depends(get_db)):
    user = db.query(User).filter(User.email == request.email).first()
    if not user or not verify_password(request.password, user.password_hash):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect email or password"
        )
    
    access_token = create_access_token(subject=str(user.id))
    return {
        "access_token": access_token,
        "token_type": "bearer"
    }
