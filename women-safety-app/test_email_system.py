import asyncio
import os
import sys

# Add backend directory to path
sys.path.append(os.path.abspath(os.path.join(os.getcwd(), "backend")))

from app.utils.email import send_sos_email
from app.core.config import settings

async def test_email():
    print(f"Using SMTP Host: {settings.SMTP_HOST}")
    print(f"Using SMTP User: {settings.SMTP_USER}")
    print(f"Recipients: {settings.EMERGENCY_EMAILS}")
    
    recipients = settings.EMERGENCY_EMAILS.split(",")
    user_data = {"name": "Test User", "email": "test@herera.com"}
    location = {"lat": 13.0827, "lng": 80.2707}
    
    print("\nAttempting to send test email...")
    success = await send_sos_email(recipients, user_data, location)
    
    if success:
        print("\n✅ SUCCESS: Email logic executed correctly.")
    else:
        print("\n❌ FAILED: Email could not be sent. Check logs above (likely due to placeholder credentials).")

if __name__ == "__main__":
    asyncio.run(test_email())
