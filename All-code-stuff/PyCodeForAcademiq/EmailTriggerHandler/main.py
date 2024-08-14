import pyodbc
import smtplib
import time
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from dotenv import load_dotenv
import os
load_dotenv()

# Configuration
server = os.getenv("SQL_SERVER")
database = os.getenv("SQL_DATABASE")
username = os.getenv("SQL_USERNAME")
password = os.getenv("SQL_PASSWORD")

# Email Settings
sender_email = os.getenv("SENDER_EMAIL")
sender_password = os.getenv("SENDER_PASSWORD")


def send_email(subject, body, recipient_email):
    # recipient_email = 'mishakolomyza@gmail.com' # Email address for test
    msg = MIMEMultipart()
    msg['From'] = sender_email
    msg['To'] = recipient_email
    msg['Subject'] = subject
    msg.attach(MIMEText(body, 'plain'))

    server = smtplib.SMTP_SSL('smtp.gmail.com', 465)
    server.login(sender_email, sender_password)
    server.sendmail(sender_email, recipient_email, msg.as_string())
    server.quit()


def handle_trigger_event(event):
    trigger_name = event[1]
    action = event[2]
    object_name = event[3]
    user_email = event[4]

    match(trigger_name):
        case 'UserRegistrationTrigger':
            subject = f"Object '{object_name}' created by user '{user_email}'."
            body = f"Trigger '{trigger_name}' fired for object '{object_name}'. Action: '{action}'.\nUser Email: {user_email}"
            print(subject + "\n" + body)
        case default:
            subject = f"Object '{object_name}' created by user '{user_email}'."
            body = f"Trigger '{trigger_name}' fired for object '{object_name}'. Action: '{action}'.\nUser Email: {user_email}"
            print(f"Object '{object_name}' updated by user '{user_email}'.")

    send_email(subject, body, user_email)


def main():
    try:
        # Connect to SQL Server
        conn = pyodbc.connect(
            f'DRIVER={{SQL Server}};SERVER={server};DATABASE={database};UID={username};PWD={password};TrustServerCertificate=True')
        cursor = conn.cursor()

        # Process TriggerLog
        while True:
            cursor.execute("SELECT * FROM TriggerLog ORDER BY LogID DESC")
            events = cursor.fetchall()

            # Process events
            for event in events:
                handle_trigger_event(event)

                # After processing, delete the event from TriggerLog
                cursor.execute(
                    f"DELETE FROM TriggerLog WHERE LogID = {event[0]}")
                conn.commit()
                print(
                    f"Event with LogID {event[0]} processed and deleted.")

            # Sleep briefly to avoid excessive polling
            # Adjust based on how frequent you expect trigger events
            time.sleep(1800)

    except Exception as e:
        print(f"Error: {e}")
    finally:
        cursor.close()
        conn.close()
        pass


if __name__ == "__main__":
    main()


'''CREATE TABLE TriggerLog (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    TriggerName VARCHAR(255),
    Action VARCHAR(255),
    ObjectName VARCHAR(255),
	UserEmail NVARCHAR(50) NULL,
	MessageToUser NVARCHAR(500) NULL,
    Timestamp DATETIME2
);

CREATE TABLE TriggerLogArchive (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    TriggerName VARCHAR(255),
    Action VARCHAR(255),
    ObjectName VARCHAR(255),
	UserEmail NVARCHAR(50) NULL,
	MessageToUser NVARCHAR(500) NULL,
    Timestamp DATETIME2
);

CREATE or ALTER TRIGGER UserRegistrationTrigger
ON Users
AFTER INSERT
AS
BEGIN
    DECLARE @Email NVARCHAR(50);
    SELECT @Email = i.Email
    FROM inserted i;

    INSERT INTO TriggerLog (TriggerName, Action, ObjectName, UserEmail , Timestamp)
    VALUES ('UserRegistrationTrigger', 'INSERT', 'Users', @Email , GETDATE());

	INSERT INTO TriggerLogArchive (TriggerName, Action, ObjectName, UserEmail , Timestamp)
    VALUES ('UserRegistrationTrigger', 'INSERT', 'Users', @Email , GETDATE());

END
GO
'''
