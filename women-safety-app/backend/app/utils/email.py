import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from app.core.config import settings
import logging
from datetime import datetime

logger = logging.getLogger(__name__)

async def send_sos_email(recipient_emails: list, user_data: dict, location: dict):
    """
    Sends SOS alert emails to emergency contacts.
    This function should be called within a BackgroundTask to avoid blocking.
    """
    if not settings.SMTP_USER or not settings.SMTP_PASS:
        logger.warning("SMTP credentials not configured. Skipping email send.")
        return

    subject = "🚨 herERA SOS Alert – Immediate Attention Required"
    
    # Format Google Maps link
    map_link = f"https://www.google.com/maps?q={location['lat']},{location['lng']}" if location.get('lat') and location.get('lng') else "Location Not Available"
    
    html_content = f"""
    <html>
    <body style="font-family: Arial, sans-serif; line-height: 1.6; color: #333;">
        <div style="max-width: 600px; margin: 0 auto; border: 2px solid #e53e3e; border-radius: 8px; overflow: hidden;">
            <div style="background-color: #e53e3e; color: white; padding: 20px; text-align: center;">
                <h1 style="margin: 0;">herERA EMERGENCY ALERT</h1>
            </div>
            <div style="padding: 20px;">
                <p>Hello,</p>
                <p>This is an automated alert from <strong>herERA</strong>. A user has triggered an emergency SOS.</p>
                
                <div style="background-color: #f7fafc; padding: 15px; border-radius: 4px; margin-bottom: 20px;">
                    <p style="margin: 5px 0;"><strong>User:</strong> {user_data.get('name', 'Unknown User')}</p>
                    <p style="margin: 5px 0;"><strong>Email:</strong> {user_data.get('email', 'N/A')}</p>
                    <p style="margin: 5px 0;"><strong>Time:</strong> {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}</p>
                    <p style="margin: 5px 0;"><strong>Location:</strong> <a href="{map_link}" style="color: #3182ce;">View on Google Maps</a></p>
                </div>
                
                <p style="color: #c53030; font-weight: bold;">Please take immediate action to ensure the safety of the user.</p>
                
                <hr style="border: 0; border-top: 1px solid #eee; margin: 20px 0;">
                <p style="font-size: 12px; color: #718096;">This is an automated message sent by the herERA Safety Platform. Please do not reply to this email.</p>
            </div>
        </div>
    </body>
    </html>
    """

    try:
        msg = MIMEMultipart()
        msg['From'] = settings.SMTP_FROM
        msg['To'] = ", ".join(recipient_emails)
        msg['Subject'] = subject
        msg.attach(MIMEText(html_content, 'html'))

        # Standard smtplib usage
        with smtplib.SMTP(settings.SMTP_HOST, settings.SMTP_PORT) as server:
            if not settings.SMTP_SECURE:
                server.starttls()
            server.login(settings.SMTP_USER, settings.SMTP_PASS)
            server.send_message(msg)
            
        logger.info(f"SOS Email sent successfully to: {recipient_emails}")
        return True
    except Exception as e:
        logger.error(f"Failed to send SOS email: {str(e)}")
        return False
