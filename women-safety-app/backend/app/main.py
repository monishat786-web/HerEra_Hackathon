from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.api.v1.endpoints import auth, evidence, users, alerts
from app.core.database import engine
from app.models.user import Base
# Note: Import all models here to ensure they are registered with Base.metadata
from app.models.alert import Alert
from app.models.evidence import EvidenceItem

# Create tables
Base.metadata.create_all(bind=engine)

app = FastAPI(title="herERA API", version="1.0.0")

# Set up CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include routers
app.include_router(auth.router, prefix="/api/v1/auth", tags=["auth"])
app.include_router(evidence.router, prefix="/api/v1/evidence", tags=["evidence"])
app.include_router(users.router, prefix="/api/v1/users", tags=["users"])
app.include_router(alerts.router, prefix="/api/v1/alerts", tags=["alerts"])

@app.get("/")
async def root():
    return {"message": "Welcome to herERA Safety API"}
