from trigger_monitor import TriggerMonitor

if __name__ == "__main__":
    monitor = TriggerMonitor()
    monitor.run()
'''
CREATE TABLE TriggerLog (
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
