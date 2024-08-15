import smtplib
import time
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from dotenv import load_dotenv
import os
from database_connection import DatabaseConnection


class TriggerMonitor:
    def __init__(self):
        load_dotenv()
        self.sender_email = os.getenv("SENDER_EMAIL")
        self.sender_password = os.getenv("SENDER_PASSWORD")

        self.db_conn = DatabaseConnection()
        self.db_conn.connect()

    def send_email(self, subject, body, recipient_email):
        try:
            msg = MIMEMultipart()
            msg["From"] = self.sender_email
            msg["To"] = recipient_email
            msg["Subject"] = subject
            msg.attach(MIMEText(body, "plain"))

            server = smtplib.SMTP_SSL("smtp.gmail.com", 465)
            server.login(self.sender_email, self.sender_password)
            server.sendmail(self.sender_email,
                            recipient_email, msg.as_string())
            server.quit()
        except Exception as e:
            print(f"Error sending email: {e}")

    def handle_trigger_event(self, event):
        trigger_name = event[1]
        action = event[2]
        object_name = event[3]
        user_email = event[4]

        match trigger_name:
            case "UserRegistrationTrigger":
                subject = f"Object '{object_name}' created by user '{user_email}'."
                body = f"Trigger '{trigger_name}' fired for object '{object_name}'. Action: '{action}'.\nUser Email: {user_email}"
                print(subject + "\n" + body)
            case _:
                subject = f"Object '{object_name}' updated by user '{user_email}'."
                body = f"Trigger '{trigger_name}' fired for object '{object_name}'. Action: '{action}'.\nUser Email: {user_email}"
                print(
                    f"Object '{object_name}' updated by user '{user_email}'.")

        self.send_email(subject, body, user_email)

    def monitor_triggers(self):
        try:
            while True:
                print('Monitoring triggers...')
                self.db_conn.cursor.execute(
                    "SELECT * FROM TriggerLog ORDER BY LogID DESC")
                events = self.db_conn.cursor.fetchall()

                for event in events:
                    self.handle_trigger_event(event)

                    self.db_conn.cursor.execute(
                        f"DELETE FROM TriggerLog WHERE LogID = {event[0]}"
                    )
                    self.db_conn.connection.commit()
                    print(
                        f"Event with LogID {event[0]} processed and deleted.")

                # תדירות הבדיקות
                time.sleep(1800)

        except Exception as e:
            print(f"Error: {e}")
        finally:
            self.db_conn.close()

    def run(self):
        self.monitor_triggers()
