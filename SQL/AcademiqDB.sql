/*
use master
GO
drop database AcademiqDB
GO

*/

CREATE DATABASE AcademiqDB
COLLATE Hebrew_CI_AS  
GO

use AcademiqDB
Go

SET DATEFORMAT ymd;
CREATE TABLE Cities(
City_Code INT not null PRIMARY KEY ,
City_Name NVARCHAR(50) null 
)
GO

CREATE TABLE Departments (
	Department_Code INT PRIMARY KEY,
	Department_Name NVARCHAR(50),
	HOD_Id INT NULL --head of department	  
)
GO

CREATE TABLE Buildings (
	Building_Code INT PRIMARY KEY,
	Building_Name NVARCHAR(50) NULL 
)
GO

CREATE TABLE Classes (
    Class_Code INT NOT NULL PRIMARY KEY,
    Class_Name NVARCHAR(50) NULL,
    Building_Code INT NULL,
    FOREIGN KEY (Building_Code) REFERENCES Buildings(Building_Code)
)
GO

CREATE TABLE Lecturers (
    LecturerId INT NOT NULL PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Phone NVARCHAR(13) NOT NULL UNIQUE,
    Email NVARCHAR(50) NOT NULL UNIQUE,
	Academic_Degree NVARCHAR(20) NULL,
	Start_Date date NOT NULL,
	Address NVARCHAR(50) NULL ,
	City_Code INT NULL ,
	FOREIGN KEY (City_Code) REFERENCES Cities(City_Code),
	Password NVARCHAR(24) NULL, --NOT NULL
)
GO

CREATE TABLE Courses (
    CourseId INT NOT NULL PRIMARY KEY,
    CourseDescription NVARCHAR(50) NOT NULL
)
GO

CREATE TABLE Lecturers_In_Course (
    CourseId INT NOT NULL,
    LecturerId INT NOT NULL ,
	School_Year INT NOT NULL,
	Department_Code INT NOT NULL,
	FOREIGN KEY (LecturerId) REFERENCES Lecturers(LecturerId),
	FOREIGN KEY (CourseId) REFERENCES Courses(CourseId),
	FOREIGN KEY (Department_Code) REFERENCES Departments(Department_Code)
)
GO

CREATE TABLE Students (
    StudentId INT NOT NULL PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    School_Year smallint NOT NULL,
    Phone NVARCHAR(13) NOT NULL UNIQUE,
    Email NVARCHAR(50) NOT NULL UNIQUE,
	Picture_URL NVARCHAR(MAX) NULL ,
	Address NVARCHAR(50) NULL ,
	City_Code int NULL ,
	Enrollment date NULL,
	FOREIGN KEY (City_Code) REFERENCES Cities(City_Code),
	Password NVARCHAR(24)  NULL, --NOT NULL

)
GO

CREATE TABLE Assignments (
    AssignmentId INT NOT NULL PRIMARY KEY,
    CourseId INT NOT NULL,
    IsVisible BIT NOT NULL, --bool var- uploading all assing..change to show what is already uploaded
    Deadline DATETIME NOT NULL,
	File_URL NVARCHAR(MAX)  NULL,
	Description NVARCHAR(MAX) NULL, 
	FOREIGN KEY (CourseId) REFERENCES Courses(CourseId)

)
GO

CREATE TABLE Assignment_Of_Student (
    AssignmentId INT NOT NULL,
    CourseId INT NOT NULL,
	StudentId INT NOT NULL,
    Submitted BIT NOT NULL,
    SelfDeadline DATETIME NOT NULL, 
	Mark INT Null,
	FOREIGN KEY (AssignmentId) REFERENCES Assignments(AssignmentId),
	FOREIGN KEY (CourseId) REFERENCES Courses(CourseId),
	FOREIGN KEY (StudentId) REFERENCES Students(StudentId),
	PRIMARY KEY (AssignmentId,CourseId,StudentId)
)
GO

--test marks
CREATE TABLE Marks (
    StudentId INT NOT NULL,
    CourseId INT NOT NULL,
	Date INT NOT NULL,
    Mark INT NOT NULL,
    Semester Smallint NOT NULL,
	FOREIGN KEY (StudentId) REFERENCES Students(StudentId),
	FOREIGN KEY (CourseId) REFERENCES Courses(CourseId),
	PRIMARY KEY (StudentId,CourseId,Date)
)
GO


CREATE TABLE Courses_On_Air (
	Course_Code INT NOT Null PRIMARY KEY,
	Open_Date DATE NOT NULL,
	End_Date DATE NOT NULL,
	LecturerId INT NOT NULL,
	Building_Code INT NULL ,
	Class_Code INT NOT NULL, --where class is held
	FOREIGN KEY (LecturerId) REFERENCES Lecturers(LecturerId),
	FOREIGN KEY (Building_Code) REFERENCES Buildings(Building_Code),
	FOREIGN KEY (Class_Code) REFERENCES Classes(Class_Code)
)
GO


CREATE TABLE Course_Schedule (
    Course_Code INT NOT NULL,
    Week_Day NVARCHAR(1) NOT NULL,
    Start_Time TIME NOT NULL,
    End_Time TIME NOT NULL,
    Class_Code INT NOT NULL,
    PRIMARY KEY (Course_Code, Week_Day, Start_Time, End_Time),
    FOREIGN KEY (Course_Code) REFERENCES Courses_On_Air(Course_Code),
    FOREIGN KEY (Class_Code) REFERENCES Classes(Class_Code)
)
GO


CREATE TABLE Students_In_Course (
    StudentId INT NOT NULL,
    CourseId INT NOT NULL,
    School_Year INT NOT NULL,
    PRIMARY KEY (StudentId, CourseId, School_Year),
    FOREIGN KEY (StudentId) REFERENCES Students(StudentId),
    FOREIGN KEY (CourseId) REFERENCES Courses(CourseId)
)
GO

--new tables

Create Table Student_Notebook(
	StudentId INT NOT NULL,
	CourseId INT NOT NULL,
	Serial_Num INT Identity(1,1), --gives a serial number auotomatically and not changing if other file is deleted
	File_type Varchar(10) NOT NULL,
	Upload_date DATE NOT NULL, --auotomatic field
	File_URL Nvarchar(MAX) NOT NULL,
	Primary Key (StudentId, CourseId, Serial_Num),
	Foreign Key (StudentId) References Students(StudentId),
	FOREIGN KEY (CourseId) REFERENCES Courses(CourseId)
	
	)
GO

Create Table Lecturer_Msg(
	MessageId INT Identity(1,1) Primary Key,
	LecturerId int NOT NULL,
	StudentId int not null,
	MessageTitle Nvarchar(20),
	MessageContent Nvarchar(400) not null,
	SentDate DateTime Not Null,
	ReadStatus bit Not Null,
	)
GO

Create Table Role_codes(
	Role_code smallint Not null PRIMARY KEY,
	Role_desc Nvarchar(25),
	)
GO

Create Table Roles (
	Id int Not Null Primary Key, 
	Name Nvarchar(20) Not null,
	Role_code smallint Not Null,
	Password Nvarchar(255) Not null, --keeps encrypted passwords, the encryption will be done in the code
	Email Nvarchar(50) Not null UNIQUE,
	Phone Nvarchar(13) UNIQUE,
	Foreign Key (Role_code) References Role_codes(Role_code)
	)
GO



Create Table UI_Essentials(
	StudentId int not null Primary Key,
	--TODO - each column will represent a button on home page, the buttons will display in different sizes according to its usage by the specific student
	--the field will calculate the ratio of size of the buttuns i.e - if in 50 percent of the time a specific button is pressed its size will be XL;
	--s - 25%
	--m - and so forth
	)
GO
	


-- ערים
INSERT INTO Cities (City_Code, City_Name) VALUES
(1, 'תל אביב'),
(2, 'ירושלים'),
(3, 'חיפה'),
(4, 'באר שבע'),
(5, 'ראשון לציון'),
(6, 'פתח תקווה'),
(7, 'אשדוד'),
(8, 'נתניה'),
(9, 'חולון'),
(10, 'בת ים');

-- מגמות
INSERT INTO Departments (Department_Code, Department_Name, HOD_Id) VALUES
(1, 'מדעי המחשב', 1),
(2, 'מתמטיקה', 2),
(3, 'פיזיקה', 3),
(4, 'כימיה', 4),
(5, 'ביולוגיה', 5),
(6, 'היסטוריה', 6),
(7, 'ספרות', 7),
(8, 'כלכלה', 8),
(9, 'פסיכולוגיה', 9),
(10, 'סוציולוגיה', 10);

-- בניינים
INSERT INTO Buildings (Building_Code, Building_Name) VALUES
(1, 'בניין א'),
(2, 'בניין ב'),
(3, 'בניין ג'),
(4, 'בניין ד'),
(5, 'בניין ה'),
(6, 'בניין ו'),
(7, 'בניין ז'),
(8, 'בניין ח'),
(9, 'בניין ט'),
(10, 'בניין י');

-- כיתות
INSERT INTO Classes (Class_Code, Class_Name, Building_Code) VALUES
(1, 'כיתה 1', 1),
(2, 'כיתה 2', 2),
(3, 'כיתה 3', 3),
(4, 'כיתה 4', 4),
(5, 'כיתה 5', 5),
(6, 'כיתה 6', 6),
(7, 'כיתה 7', 7),
(8, 'כיתה 8', 8),
(9, 'כיתה 9', 9),
(10, 'כיתה 10', 10);

-- מרצים
INSERT INTO Lecturers (LecturerId, FirstName, LastName, Phone, Email, Academic_Degree, Start_Date, Address, City_Code, Password) VALUES
(1, 'יוחנן', 'כהן', '054-1234567', 'john.doe@example.com', 'דוקטור', '2020-01-01', 'רחוב הראשי 123', 1, 'password123'),
(2, 'שרה', 'לוי', '052-9876543', 'jane.smith@example.com', 'מגיסטר', '2021-02-15', 'שדרות האלונים 456', 2, 'password456'),
(3, 'דוד', 'שרון', '050-7890123', 'david.brown@example.com', 'דוקטור', '2019-08-22', 'דרך האורנים 789', 3, 'password789'),
(4, 'אביגיל', 'בן דוד', '058-1111111', 'alice.wilson@example.com', 'מגיסטר', '2022-03-10', 'סמטת המייפל 101', 4, 'password111'),
(5, 'אברהם', 'כהן', '054-2222222', 'bob.anderson@example.com', 'דוקטור', '2020-05-05', 'רחוב התמר 202', 5, 'password222'),
(6, 'עמליה', 'לוי', '052-3333333', 'emily.davis@example.com', 'מגיסטר', '2021-06-20', 'שדרות הברוש 303', 6, 'password333'),
(7, 'יוסף', 'שרון', '050-4444444', 'charlie.miller@example.com', 'דוקטור', '2019-09-10', 'דרך האלון 404', 7, 'password444'),
(8, 'רבקה', 'בן דוד', '058-5555555', 'michelle.johnson@example.com', 'מגיסטר', '2022-04-05', 'סמטת הדקל 505', 8, 'password555'),
(9, 'יעקב', 'כהן', '054-6666666', 'james.brown@example.com', 'דוקטור', '2020-06-15', 'רחוב הברוש 606', 9, 'password666'),
(10, 'שמואל', 'לוי', '052-7777777', 'sarah.wilson@example.com', 'מגיסטר', '2021-07-20', 'שדרות האלון 707', 10, 'password777');

-- קורסים
INSERT INTO Courses (CourseId, CourseDescription) VALUES
(1, 'מבוא למדעי המחשב'),
(2, 'אלגברה לינארית'),
(3, 'פיזיקה 1'),
(4, 'כימיה אורגנית'),
(5, 'ביולוגיה תאית'),
(6, 'היסטוריה של ישראל'),
(7, 'ספרות עברית'),
(8, 'מיקרו כלכלה'),
(9, 'פסיכולוגיה חברתית'),
(10, 'סוציולוגיה של התרבות');

-- מרצים בקורס
INSERT INTO Lecturers_In_Course (CourseId, LecturerId, School_Year, Department_Code) VALUES
(1, 1, 2023, 1),
(2, 2, 2023, 2),
(3, 3, 2023, 3),
(4, 4, 2023, 4),
(5, 5, 2023, 5),
(6, 6, 2023, 6),
(7, 7, 2023, 7),
(8, 8, 2023, 8),
(9, 9, 2023, 9),
(10, 10, 2023, 10);

-- סטודנטים
INSERT INTO Students (StudentId, FirstName, LastName, School_Year, Phone, Email, Picture_URL, Address, City_Code, Enrollment, Password) VALUES
(1, 'איתן', 'כהן', 2, '054-8888888', 'ethan.cohen@example.com', 'https://www.example.com/profile_picture.jpg', 'רחוב הראשי 123', 1, '2022-09-01', 'password123'),
(2, 'נועה', 'לוי', 3, '052-7777777', 'noa.levi@example.com', 'https://www.example.com/profile_picture.jpg', 'שדרות האלונים 456', 2, '2021-09-01', 'password456'),
(3, 'דניאל', 'שרון', 1, '050-6666666', 'daniel.sharon@example.com', 'https://www.example.com/profile_picture.jpg', 'דרך האורנים 789', 3, '2023-09-01', 'password789'),
(4, 'עדי', 'בן דוד', 4, '058-5555555', 'adi.bendavid@example.com', 'https://www.example.com/profile_picture.jpg', 'סמטת המייפל 101', 4, '2020-09-01', 'password111'),
(5, 'ליאור', 'כהן', 2, '054-4444444', 'lior.cohen@example.com', 'https://www.example.com/profile_picture.jpg', 'רחוב התמר 202', 5, '2022-09-01', 'password222'),
(6, 'אפרת', 'לוי', 3, '052-3333333', 'efrat.levi@example.com', 'https://www.example.com/profile_picture.jpg', 'שדרות הברוש 303', 6, '2021-09-01', 'password333'),
(7, 'איתמר', 'שרון', 1, '050-2222222', 'itamar.sharon@example.com', 'https://www.example.com/profile_picture.jpg', 'דרך האלון 404', 7, '2023-09-01', 'password444'),
(8, 'מיה', 'בן דוד', 4, '058-1111111', 'mia.bendavid@example.com', 'https://www.example.com/profile_picture.jpg', 'סמטת הדקל 505', 8, '2020-09-01', 'password555'),
(9, 'עומר', 'כהן', 2, '054-0000000', 'omer.cohen@example.com', 'https://www.example.com/profile_picture.jpg', 'רחוב הברוש 606', 9, '2022-09-01', 'password666'),
(10, 'תמר', 'לוי', 3, '052-9999999', 'tamar.levi@example.com', 'https://www.example.com/profile_picture.jpg', 'שדרות האלון 707', 10, '2021-09-01', 'password777');

-- מטלות
INSERT INTO Assignments (AssignmentId, CourseId, IsVisible, Deadline, File_URL, Description) VALUES
(1, 1, 1, '2023-12-15 23:59:59', 'https://www.example.com/assignment1.pdf', 'מטלת תכנות'),
(2, 2, 1, '2023-12-22 23:59:59', 'https://www.example.com/assignment2.pdf', 'מטלת אלגברה לינארית'),
(3, 3, 1, '2023-12-29 23:59:59', 'https://www.example.com/assignment3.pdf', 'מטלת פיזיקה'),
(4, 4, 1, '2024-01-05 23:59:59', 'https://www.example.com/assignment4.pdf', 'מטלת כימיה'),
(5, 5, 1, '2024-01-12 23:59:59', 'https://www.example.com/assignment5.pdf', 'מטלת ביולוגיה'),
(6, 6, 1, '2024-01-19 23:59:59', 'https://www.example.com/assignment6.pdf', 'מטלת היסטוריה'),
(7, 7, 1, '2024-01-26 23:59:59', 'https://www.example.com/assignment7.pdf', 'מטלת ספרות'),
(8, 8, 1, '2024-02-02 23:59:59', 'https://www.example.com/assignment8.pdf', 'מטלת כלכלה'),
(9, 9, 1, '2024-02-09 23:59:59', 'https://www.example.com/assignment9.pdf', 'מטלת פסיכולוגיה'),
(10, 10, 1, '2024-02-16 23:59:59', 'https://www.example.com/assignment10.pdf', 'מטלת סוציולוגיה');

-- מטלות של סטודנטים
INSERT INTO Assignment_Of_Student (AssignmentId, CourseId, StudentId, Submitted, SelfDeadline, Mark) VALUES
(1, 1, 1, 1, '2023-12-14 23:59:59', 85),
(2, 2, 2, 1, '2023-12-21 23:59:59', 90),
(3, 3, 3, 0, '2023-12-28 23:59:59', NULL),
(4, 4, 4, 1, '2024-01-04 23:59:59', 75), -- Changed to 2024 for valid date
(5, 5, 5, 1, '2024-01-11 23:59:59', 80), -- Changed to 2024 for valid date
(6, 6, 6, 0, '2024-01-18 23:59:59', NULL), -- Changed to 2024 for valid date
(7, 7, 7, 1, '2024-01-25 23:59:59', 95), -- Changed to 2024 for valid date
(8, 8, 8, 1, '2024-02-01 23:59:59', 88),
(9, 9, 9, 0, '2024-02-08 23:59:59', NULL),
(10, 10, 10, 1, '2024-02-15 23:59:59', 78);

-- ציונים
INSERT INTO Marks (StudentId, CourseId, Date, Mark, Semester) VALUES
(1, 1, 20230101, 85, 1),
(2, 2, 20230101, 90, 1),
(3, 3, 20230101, 75, 1),
(4, 4, 20230101, 80, 1),
(5, 5, 20230101, 95, 1),
(6, 6, 20230101, 88, 1),
(7, 7, 20230101, 78, 1),
(8, 8, 20230101, 82, 1),
(9, 9, 20230101, 87, 1),
(10, 10, 20230101, 92, 1);

-- קורסים בשידור
INSERT INTO Courses_On_Air (Course_Code, Open_Date, End_Date, LecturerId, Building_Code, Class_Code) VALUES
(1, '2023-09-01', '2024-05-31', 1, 1, 1),
(2, '2023-09-01', '2024-05-31', 2, 2, 2),
(3, '2023-09-01', '2024-05-31', 3, 3, 3),
(4, '2023-09-01', '2024-05-31', 4, 4, 4),
(5, '2023-09-01', '2024-05-31', 5, 5, 5),
(6, '2023-09-01', '2024-05-31', 6, 6, 6),
(7, '2023-09-01', '2024-05-31', 7, 7, 7),
(8, '2023-09-01', '2024-05-31', 8, 8, 8),
(9, '2023-09-01', '2024-05-31', 9, 9, 9),
(10, '2023-09-01', '2024-05-31', 10, 10, 10);

-- לוח זמנים של קורסים
INSERT INTO Course_Schedule (Course_Code, Week_Day, Start_Time, End_Time, Class_Code) VALUES
(1, 'א', '08:00:00', '09:00:00', 1),
(2, 'ב', '10:00:00', '11:00:00', 2),
(3, 'ג', '12:00:00', '13:00:00', 3),
(4, 'ד', '14:00:00', '15:00:00', 4),
(5, 'ה', '16:00:00', '17:00:00', 5),
(6, 'א', '10:00:00', '11:00:00', 6),
(7, 'ב', '12:00:00', '13:00:00', 7),
(8, 'ג', '14:00:00', '15:00:00', 8),
(9, 'ד', '16:00:00', '17:00:00', 9),
(10, 'ה', '08:00:00', '09:00:00', 10);

-- סטודנטים בקורס
INSERT INTO Students_In_Course (StudentId, CourseId, School_Year) VALUES
(1, 1, 2023),
(2, 2, 2023),
(3, 3, 2023),
(4, 4, 2023),
(5, 5, 2023),
(6, 6, 2023),
(7, 7, 2023),
(8, 8, 2023),
(9, 9, 2023),
(10, 10, 2023)
GO

-- מחברת סטודנטים
INSERT INTO Student_Notebook (StudentId, CourseId, File_type, Upload_date, File_URL) VALUES
(1, 1, 'pdf', '2023-10-26', 'https://www.example.com/student_notebook_1.pdf'),
(2, 2, 'docx', '2023-10-27', 'https://www.example.com/student_notebook_2.docx'),
(3, 3, 'jpg', '2023-10-28', 'https://www.example.com/student_notebook_3.jpg'),
(4, 4, 'txt', '2023-10-29', 'https://www.example.com/student_notebook_4.txt'),
(5, 5, 'pdf', '2023-10-30', 'https://www.example.com/student_notebook_5.pdf'),
(6, 6, 'docx', '2023-10-31', 'https://www.example.com/student_notebook_6.docx'),
(7, 7, 'jpg', '2023-11-01', 'https://www.example.com/student_notebook_7.jpg'),
(8, 8, 'txt', '2023-11-02', 'https://www.example.com/student_notebook_8.txt'),
(9, 9, 'pdf', '2023-11-03', 'https://www.example.com/student_notebook_9.pdf'),
(10, 10, 'docx', '2023-11-04', 'https://www.example.com/student_notebook_10.docx')
GO

-- הודעות מרצים
INSERT INTO Lecturer_Msg (LecturerId, StudentId, MessageTitle, MessageContent, SentDate, ReadStatus) VALUES
(1, 1, 'הודעה לגבי מטלה 1', 'המטלה צריכה להיות מוגשת עד יום שישי', '2023-10-25 10:00:00', 1),
(2, 2, 'עדכון חשוב', 'שינוי במועד המבחן', '2023-10-26 14:30:00', 0),
(3, 3, 'מידע נוסף', 'הרצאה נוספת תתקיים ביום שלישי', '2023-10-27 09:15:00', 1),
(4, 4, 'שאלה לגבי מטלה 2', 'האם יש לכם שאלות לגבי המטלה?', '2023-10-28 16:45:00', 0),
(5, 5, 'הודעה חשובה', 'הרצאה נוספת תתקיים ביום חמישי', '2023-10-29 12:00:00', 1),
(6, 6, 'עדכון', 'שינוי במיקום השיעור', '2023-10-30 10:30:00', 0),
(7, 7, 'שאלה לגבי מטלה 3', 'האם יש לכם שאלות לגבי המטלה?', '2023-10-31 17:15:00', 1),
(8, 8, 'הודעה לגבי מטלה 4', 'המטלה צריכה להיות מוגשת עד יום שני', '2023-11-01 09:00:00', 0),
(9, 9, 'מידע נוסף', 'שיעור נוסף תתקיים ביום רביעי', '2023-11-02 14:00:00', 1),
(10, 10, 'עדכון חשוב', 'שינוי במועד המבחן', '2023-11-03 10:45:00', 0);

-- תפקידים
INSERT INTO Roles (Id, Name, Role_code, Password, Email, Phone) VALUES
(1, 'מנהל', 1, 'admin123', 'admin@example.com', '054-1234567'),
(2, 'מזכירה', 2, 'secretary123', 'secretary@example.com', '058-1111111')
GO

-- קודי תפקידים
INSERT INTO Role_codes (Role_code, Role_desc) VALUES
(1, 'מנהל'),
(2, 'מזכירה')
GO

	








	------------------------------------
-- Cities
CREATE OR ALTER PROCEDURE sp_InsertCity
    @City_Code INT,
    @City_Name NVARCHAR(50)
AS
BEGIN
    BEGIN TRANSACTION
    BEGIN TRY
        INSERT INTO Cities (City_Code, City_Name)
        VALUES (@City_Code, @City_Name)
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION
        THROW;
    END CATCH
END
GO

-- Departments
CREATE OR ALTER PROCEDURE sp_InsertDepartment
    @Department_Code INT,
    @Department_Name NVARCHAR(50),
    @HOD_Id INT = NULL
AS
BEGIN
    BEGIN TRANSACTION
    BEGIN TRY
        INSERT INTO Departments (Department_Code, Department_Name, HOD_Id)
        VALUES (@Department_Code, @Department_Name, @HOD_Id)
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION
        THROW;
    END CATCH
END
GO

-- Buildings
CREATE OR ALTER PROCEDURE sp_InsertBuilding
    @Building_Code INT,
    @Building_Name NVARCHAR(50)
AS
BEGIN
    BEGIN TRANSACTION
    BEGIN TRY
        INSERT INTO Buildings (Building_Code, Building_Name)
        VALUES (@Building_Code, @Building_Name)
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION
        THROW;
    END CATCH
END
GO

-- Classes
CREATE OR ALTER PROCEDURE sp_InsertClass
    @Class_Code INT,
    @Class_Name NVARCHAR(50),
    @Building_Code INT = NULL
AS
BEGIN
    BEGIN TRANSACTION
    BEGIN TRY
        INSERT INTO Classes (Class_Code, Class_Name, Building_Code)
        VALUES (@Class_Code, @Class_Name, @Building_Code)
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION
        THROW;
    END CATCH
END
GO

-- Lecturers
CREATE OR ALTER PROCEDURE sp_InsertLecturer
    @LecturerId INT,
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @Phone NVARCHAR(13),
    @Email NVARCHAR(50),
    @Academic_Degree NVARCHAR(20) = NULL,
    @Start_Date DATE,
    @Address NVARCHAR(50) = NULL,
    @City_Code INT = NULL,
    @Password NVARCHAR(24) = NULL
AS
BEGIN
    BEGIN TRANSACTION
    BEGIN TRY
        INSERT INTO Lecturers (LecturerId, FirstName, LastName, Phone, Email, Academic_Degree, Start_Date, Address, City_Code, Password)
        VALUES (@LecturerId, @FirstName, @LastName, @Phone, @Email, @Academic_Degree, @Start_Date, @Address, @City_Code, @Password)
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION
        THROW;
    END CATCH
END
GO

-- Courses
CREATE OR ALTER PROCEDURE sp_InsertCourse
    @CourseId INT,
    @CourseDescription NVARCHAR(50)
AS
BEGIN
    BEGIN TRANSACTION
    BEGIN TRY
        INSERT INTO Courses (CourseId, CourseDescription)
        VALUES (@CourseId, @CourseDescription)
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION
        THROW;
    END CATCH
END
GO

-- Lecturers_In_Course
CREATE OR ALTER PROCEDURE sp_InsertLecturerInCourse
    @CourseId INT,
    @LecturerId INT,
    @School_Year INT,
    @Department_Code INT
AS
BEGIN
    BEGIN TRANSACTION
    BEGIN TRY
        INSERT INTO Lecturers_In_Course (CourseId, LecturerId, School_Year, Department_Code)
        VALUES (@CourseId, @LecturerId, @School_Year, @Department_Code)
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION
        THROW;
    END CATCH
END
GO

-- Students
CREATE OR ALTER PROCEDURE sp_InsertStudent
    @StudentId INT,
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @School_Year SMALLINT,
    @Phone NVARCHAR(13),
    @Email NVARCHAR(50),
    @Picture_URL NVARCHAR(MAX) = NULL,
    @Address NVARCHAR(50) = NULL,
    @City_Code INT = NULL,
    @Enrollment DATE = NULL,
    @Password NVARCHAR(24) = NULL
AS
BEGIN
    BEGIN TRANSACTION
    BEGIN TRY
        INSERT INTO Students (StudentId, FirstName, LastName, School_Year, Phone, Email, Picture_URL, Address, City_Code, Enrollment, Password)
        VALUES (@StudentId, @FirstName, @LastName, @School_Year, @Phone, @Email, @Picture_URL, @Address, @City_Code, @Enrollment, @Password)
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION
        THROW;
    END CATCH
END
GO

-- Assignments
CREATE OR ALTER PROCEDURE sp_InsertAssignment
    @AssignmentId INT,
    @CourseId INT,
    @IsVisible BIT,
    @Deadline DATETIME,
    @File_URL NVARCHAR(MAX) = NULL,
    @Description NVARCHAR(MAX) = NULL
AS
BEGIN
    BEGIN TRANSACTION
    BEGIN TRY
        INSERT INTO Assignments (AssignmentId, CourseId, IsVisible, Deadline, File_URL, Description)
        VALUES (@AssignmentId, @CourseId, @IsVisible, @Deadline, @File_URL, @Description)
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION
        THROW;
    END CATCH
END
GO

-- Assignment_Of_Student
CREATE OR ALTER PROCEDURE sp_InsertAssignmentOfStudent
    @AssignmentId INT,
    @CourseId INT,
    @StudentId INT,
    @Submitted BIT,
    @SelfDeadline DATETIME,
    @Mark INT = NULL
AS
BEGIN
    BEGIN TRANSACTION
    BEGIN TRY
        INSERT INTO Assignment_Of_Student (AssignmentId, CourseId, StudentId, Submitted, SelfDeadline, Mark)
        VALUES (@AssignmentId, @CourseId, @StudentId, @Submitted, @SelfDeadline, @Mark)
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION
        THROW;
    END CATCH
END
GO

-- Marks
CREATE OR ALTER PROCEDURE sp_InsertMark
    @StudentId INT,
    @CourseId INT,
    @Date INT,
    @Mark INT,
    @Semester SMALLINT
AS
BEGIN
    BEGIN TRANSACTION
    BEGIN TRY
        INSERT INTO Marks (StudentId, CourseId, Date, Mark, Semester)
        VALUES (@StudentId, @CourseId, @Date, @Mark, @Semester)
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION
        THROW;
    END CATCH
END
GO

-- Courses_On_Air
CREATE OR ALTER PROCEDURE sp_InsertCourseOnAir
    @Course_Code INT,
    @Open_Date DATE,
    @End_Date DATE,
    @LecturerId INT,
    @Building_Code INT = NULL,
    @Class_Code INT
AS
BEGIN
    BEGIN TRANSACTION
    BEGIN TRY
        INSERT INTO Courses_On_Air (Course_Code, Open_Date, End_Date, LecturerId, Building_Code, Class_Code)
        VALUES (@Course_Code, @Open_Date, @End_Date, @LecturerId, @Building_Code, @Class_Code)
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION
        THROW;
    END CATCH
END
GO

-- Course_Schedule
CREATE OR ALTER PROCEDURE sp_InsertCourseSchedule
    @Course_Code INT,
    @Week_Day NVARCHAR(1),
    @Start_Time TIME,
    @End_Time TIME,
    @Class_Code INT
AS
BEGIN
    BEGIN TRANSACTION
    BEGIN TRY
        INSERT INTO Course_Schedule (Course_Code, Week_Day, Start_Time, End_Time, Class_Code)
        VALUES (@Course_Code, @Week_Day, @Start_Time, @End_Time, @Class_Code)
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION
        THROW;
    END CATCH
END
GO

-- Students_In_Course
CREATE OR ALTER PROCEDURE sp_InsertStudentInCourse
    @StudentId INT,
    @CourseId INT,
    @School_Year INT
AS
BEGIN
    BEGIN TRANSACTION
    BEGIN TRY
        INSERT INTO Students_In_Course (StudentId, CourseId, School_Year)
        VALUES (@StudentId, @CourseId, @School_Year)
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION
        THROW;
    END CATCH
END
GO

-- Student_Notebook
CREATE OR ALTER PROCEDURE sp_InsertStudentNotebook
    @StudentId INT,
    @CourseId INT,
    @File_type VARCHAR(10),
    @File_URL NVARCHAR(MAX)
AS
BEGIN
    BEGIN TRANSACTION
    BEGIN TRY
        INSERT INTO Student_Notebook (StudentId, CourseId, File_type, Upload_date, File_URL)
        VALUES (@StudentId, @CourseId, @File_type, GETDATE(), @File_URL)
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION
        THROW;
    END CATCH
END
GO

-- Lecturer_Msg
CREATE OR ALTER PROCEDURE sp_InsertLecturerMsg
    @LecturerId INT,
    @StudentId INT,
    @MessageTitle NVARCHAR(20),
    @MessageContent NVARCHAR(400)
AS
BEGIN
    BEGIN TRANSACTION
    BEGIN TRY
        INSERT INTO Lecturer_Msg (LecturerId, StudentId, MessageTitle, MessageContent, SentDate, ReadStatus)
        VALUES (@LecturerId, @StudentId, @MessageTitle, @MessageContent, GETDATE(), 0)
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION
        THROW;
    END CATCH
END
GO

-- Roles
CREATE OR ALTER PROCEDURE sp_InsertRole
    @Id INT,
    @Name NVARCHAR(20),
    @Role_code SMALLINT,
    @Password NVARCHAR(255),
    @Email NVARCHAR(50),
    @Phone NVARCHAR(13) = NULL
AS
BEGIN
    BEGIN TRANSACTION
    BEGIN TRY
        INSERT INTO Roles (Id, Name, Role_code, Password, Email, Phone)
        VALUES (@Id, @Name, @Role_code, @Password, @Email, @Phone)
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION
        THROW;
    END CATCH
END
GO

-- Role_codes
CREATE OR ALTER PROCEDURE sp_InsertRoleCode
    @Role_code SMALLINT,
    @Role_desc NVARCHAR(25)
AS
BEGIN
    BEGIN TRANSACTION
    BEGIN TRY
        INSERT INTO Role_codes (Role_code, Role_desc)
        VALUES (@Role_code, @Role_desc)
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION
        THROW;
    END CATCH
END
GO





-- סטודנטים עם קורסים
CREATE OR ALTER VIEW vw_StudentsWithCourses AS
SELECT 
    s.StudentId,
    s.FirstName AS 'Student First Name',
    s.LastName AS 'Student Last Name',
    --c.CourseId,
    c.CourseDescription
FROM 
    Students s
JOIN 
    Students_In_Course sic ON s.StudentId = sic.StudentId
JOIN 
    Courses c ON sic.CourseId = c.CourseId
GO

SELECT * FROM vw_StudentsWithCourses
GO

-- מרצים עם קורסים
CREATE OR ALTER VIEW vw_LecturersWithCourses AS
SELECT
    l.LecturerId,
    l.FirstName AS 'Lecturer First Name',
    l.LastName AS 'Lecturer Last Name',
    --c.CourseId,
    c.CourseDescription
FROM 
    Lecturers l
JOIN
    Lecturers_In_Course lic ON l.LecturerId = lic.LecturerId
JOIN
    Courses c ON lic.CourseId = c.CourseId
GO

SELECT * FROM vw_LecturersWithCourses
GO

-- ציונים עם פרטי סטודנטים וקורסים
CREATE OR ALTER VIEW vw_MarksWithStudentDetails AS
	SELECT
    m.StudentId,
    s.FirstName AS 'Student First Name',
    s.LastName AS 'Student Last Name',
    --m.CourseId,
    c.CourseDescription,
    m.Mark
	FROM 
    Marks m inner JOIN Students s 
	ON m.StudentId = s.StudentId inner JOIN Courses c ON
	m.CourseId = c.CourseId
GO
-- פקודה להצגת ה-VIEW:
SELECT * FROM vw_MarksWithStudentDetails
GO

--רשימת הסטודנטים בקודס על פי הID של הקרוס
CREATE  OR ALTER FUNCTION GetStudentsByCourse (@CourseId INT)
RETURNS TABLE
AS
RETURN
(
    SELECT
        Students.StudentId,
        Students.FirstName,
        Students.LastName
    FROM
        Students
    JOIN
        Students_In_Course sic ON Students.StudentId = sic.StudentId
    WHERE
        sic.CourseId = @CourseId
);
GO

-- שימוש בפונקציה
SELECT * FROM dbo.GetStudentsByCourse(2)
GO


--פונקציה לחישוב ממוצע ציונים של סטודנט בקורס
CREATE OR ALTER FUNCTION GetAverageMarkByCourse (@studentId INT, @courseId INT)
RETURNS DECIMAL(4,2)
AS
BEGIN
    DECLARE @averageMark DECIMAL(4,2);

    SELECT @averageMark = AVG(Mark) 
    FROM Marks 
    WHERE StudentId = @studentId AND CourseId = @courseId;

    RETURN @averageMark;
END
GO

-- שימוש בפונקציה
SELECT StudentId, CourseId, dbo.GetAverageMarkByCourse(StudentId, CourseId) AS AverageMark FROM Marks
GO


--פונקציה לקבלת רשימת קורסים של מרצה מסוים
CREATE OR ALTER FUNCTION GetLecturerCourses (@LecturerId INT)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        c.CourseId,
        c.CourseDescription
    FROM 
        Courses c
    JOIN
        Lecturers_In_Course lic ON c.CourseId = lic.CourseId
    WHERE 
        lic.LecturerId = @LecturerId
)
GO

-- שימוש בפונקציה
SELECT * FROM dbo.GetLecturerCourses(1)
GO


--פונקציה לקבלת רשימת קורסים של סטודנט מסוים
CREATE OR ALTER FUNCTION GetStudentCourses (@StudentId INT)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        Courses.CourseId,
		Courses.CourseDescription
    FROM 
        Courses
    JOIN
        Students_In_Course sic ON Courses.CourseId = sic.CourseId
    WHERE 
        sic.StudentId = @StudentId
)
GO

-- שימוש בפונקציה
SELECT * FROM dbo.GetStudentCourses(2)
GO


--פונקציה לבדיקת האם סטודנט רשום לקורס מסוים
CREATE OR ALTER FUNCTION IsStudentInCourse (@studentId INT, @courseId INT)
RETURNS BIT
AS
BEGIN
    DECLARE @isInCourse BIT

    IF EXISTS (SELECT 1 FROM Students_In_Course WHERE StudentId = @studentId AND CourseId = @courseId)
    BEGIN
        SET @isInCourse = 1;
    END
    ELSE
    BEGIN
        SET @isInCourse = 0;
    END;

    RETURN @isInCourse
END
GO

-- שימוש בפונקציה
SELECT StudentId, CourseId, dbo.IsStudentInCourse(StudentId, CourseId) AS InCourse FROM Students_In_Course
GO



CREATE OR ALTER FUNCTION GetStudentMarksWithDetails (@studentId INT)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        s.FirstName,
        s.LastName,
        c.CourseDescription,
        m.Mark
    FROM
        Students s
    JOIN
        Marks m ON s.StudentId = m.StudentId
    JOIN
        Courses c ON m.CourseId = c.CourseId
    WHERE
        s.StudentId = @studentId
)
GO

-- שימוש בפונקציה
SELECT * FROM dbo.GetStudentMarksWithDetails(1)
GO


--בדיקת תאריך הגשה של מטלה 
CREATE OR ALTER FUNCTION IsAssignmentSubmittedOnTime (@studentId INT, @assignmentId INT)
RETURNS BIT
AS
BEGIN
    DECLARE @submissionDate DATETIME
    DECLARE @deadline DATETIME

    -- קבלת תאריך הגשת המטלה
    SELECT @submissionDate = SelfDeadline
    FROM Assignment_Of_Student
    WHERE StudentId = @studentId AND AssignmentId = @assignmentId

    -- קבלת תאריך אחרון להגשה
    SELECT @deadline = Deadline 
    FROM Assignments
    WHERE AssignmentId = @assignmentId

    -- השוואת התאריכים
    IF @submissionDate <= @deadline
        RETURN 1
    
    RETURN 0

END
GO

CREATE OR ALTER VIEW vw_StudentAssignmentsWithStatus
AS
SELECT 
    s.FirstName,
    s.LastName,
    a.Description AS AssignmentDescription,
    dbo.IsAssignmentSubmittedOnTime(s.StudentId, a.AssignmentId) AS SubmittedOnTime
FROM
    Students s
JOIN
    Assignment_Of_Student aos ON s.StudentId = aos.StudentId
JOIN
    Assignments a ON aos.AssignmentId = a.AssignmentId;
GO

-- שימוש ב-VIEW
SELECT * FROM vw_StudentAssignmentsWithStatus
GO


--טריגר להגדרת ערך ברירת מחדל לשדה ReadStatus
CREATE OR ALTER TRIGGER tr_SetReadStatusDefault
ON Lecturer_Msg
AFTER INSERT
AS
BEGIN
    -- עדכון שדה ReadStatus ל-0 (לא נקרא) עבור כל רשומה חדשה
    UPDATE Lecturer_Msg
    SET ReadStatus = 0
    WHERE MessageId IN (SELECT MessageId FROM inserted);
END;
GO

CREATE OR ALTER TRIGGER tr_UpdateStudentEnrollmentDate
ON Students
AFTER INSERT
AS
BEGIN
    -- קבלת ה-StudentId מהרשומה שהוכנסה
    DECLARE @studentId INT = (SELECT StudentId FROM inserted)

    -- עדכון שדה Enrollment בטבלת Students
    UPDATE Students
    SET Enrollment = GETDATE()
    WHERE StudentId = @studentId
END
GO

-- שם הפרוצדורה
CREATE OR ALTER PROCEDURE sp_FullBackup
    @backupPath VARCHAR(256)
AS
BEGIN
	DECLARE @databaseName VARCHAR(128)
	SET @databaseName = 'AcademiqDB'
    -- ודא שהנתיב לגיבוי קיים
    IF NOT EXISTS (SELECT 1 FROM sys.databases WHERE name = @databaseName)
    BEGIN
        RAISERROR('בסיס הנתונים לא קיים.', 16, 1);
        RETURN;
    END;

    -- יצירת גיבוי מלא
	SET @backupPath = @backupPath + '\' + @databaseName + '_FullBackup.bak'


    BACKUP DATABASE @databaseName
    TO DISK = @backupPath
    WITH FORMAT;

    -- הודעה על גיבוי מוצלח
    PRINT 'גיבוי מלא של בסיס הנתונים ' + @databaseName + ' בוצע בהצלחה.';
END;
GO

-- שימוש בפרוצדורה
EXEC sp_FullBackup @backupPath = 'C:\SQLBackups'
GO


-- שם הפרוצדורה
CREATE OR ALTER PROCEDURE sp_FullRestore
    @backupPath VARCHAR(256)
AS
BEGIN
    -- התחלת טרנזקציה
    BEGIN TRANSACTION
    BEGIN TRY

		DECLARE @databaseName VARCHAR(128)
		SET @databaseName = 'AcademiqDB'
		SET @backupPath = @backupPath + '\' + @databaseName + '_FullBackup.bak'

        -- שחזור מלא
        RESTORE DATABASE @databaseName
        FROM DISK = @backupPath
        WITH REPLACE;

        -- אישור הטרנזקציה
        COMMIT TRANSACTION
        -- הודעה על שחזור מוצלח
        PRINT 'שחזור מלא של בסיס הנתונים ' + @databaseName + ' בוצע בהצלחה.';
    END TRY
    BEGIN CATCH
        -- הצגת הודעת שגיאה למשתמש
        RAISERROR('שגיאה במהלך שחזור בסיס הנתונים.', 16, 1);
        -- ביטול הטרנזקציה במקרה של שגיאה
		--IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION
    END CATCH
END;
GO

-- שימוש בפרוצדורה
use master
GO
EXEC AcademiqDB.dbo.sp_FullRestore @backupPath = 'C:\SQLBackups'
GO
use AcademiqDB
GO




-- הגדרת תפקיד למרצה
CREATE ROLE LecturerRole;
-- מתן הרשאות לתפקיד מרצה
GRANT CONNECT TO LecturerRole;
GRANT SELECT ON dbo.Students TO LecturerRole;
GRANT SELECT ON dbo.Courses TO LecturerRole;
GRANT SELECT ON dbo.Marks TO LecturerRole;
GRANT UPDATE ON dbo.Marks TO LecturerRole; -- עדכון טבלת ציונים
GRANT INSERT ON dbo.Lecturer_Msg TO LecturerRole; -- שליחת הודעות
GRANT SELECT ON dbo.Lecturer_Msg TO LecturerRole; -- קריאה של הודעות


-- הגדרת תפקיד לסטודנט
CREATE ROLE StudentRole;
-- מתן הרשאות לתפקיד סטודנט
GRANT CONNECT TO StudentRole;
GRANT SELECT ON dbo.Students TO StudentRole;
GRANT SELECT ON dbo.Courses TO StudentRole;
GRANT SELECT ON dbo.Assignments TO StudentRole;
GRANT SELECT ON dbo.Assignment_Of_Student TO StudentRole;
GRANT UPDATE ON dbo.Assignment_Of_Student TO StudentRole; -- עדכון סטטוס הגשת מטלה
GRANT INSERT ON dbo.Student_Notebook TO StudentRole; -- הוספת תוכן למחברת הסטודנט
GRANT SELECT ON dbo.Student_Notebook TO StudentRole; -- קריאה מהמחברת
GRANT SELECT ON dbo.Lecturer_Msg TO StudentRole; -- קריאה של הודעות
GRANT UPDATE ON dbo.Lecturer_Msg TO StudentRole; -- עדכון סטטוס קריאה של הודעות


-- הגדרת תפקיד למזכירה
CREATE ROLE SecretaryRole;
-- מתן הרשאות לתפקיד מזכירה
GRANT CONNECT TO SecretaryRole;
GRANT SELECT ON dbo.Courses_On_Air TO SecretaryRole;
GRANT SELECT ON dbo.Course_Schedule TO SecretaryRole;
GRANT UPDATE ON dbo.Courses_On_Air TO SecretaryRole; -- שינוי לוח שנה
GRANT UPDATE ON dbo.Course_Schedule TO SecretaryRole; -- שינוי מערכת שבועית
GRANT SELECT ON dbo.Students TO SecretaryRole;
GRANT SELECT ON dbo.Lecturers TO SecretaryRole;


-- הגדרת תפקיד למנהל
CREATE ROLE AdminRole;
-- מתן הרשאות לתפקיד מנהל
GRANT CONNECT TO AdminRole;
GRANT VIEW DEFINITION TO AdminRole;
GRANT ALTER ANY USER TO AdminRole;
GRANT CREATE USER TO AdminRole;
GRANT SELECT, INSERT, UPDATE, REFERENCES, EXECUTE ON SCHEMA::dbo TO AdminRole;
--DENY DELETE TO AdminRole; -- מניעת מחיקת נתונים


-- יצירת משתמש
CREATE LOGIN LecturerUser WITH PASSWORD = 'Password123';
CREATE LOGIN StudentUser WITH PASSWORD = 'Password456';
CREATE LOGIN SecretaryUser WITH PASSWORD = 'Password789';
CREATE LOGIN AdminUser WITH PASSWORD = 'Password000';

CREATE USER LecturerUser FOR LOGIN LecturerUser;
CREATE USER StudentUser FOR LOGIN StudentUser;
CREATE USER SecretaryUser FOR LOGIN SecretaryUser;
CREATE USER AdminUser FOR LOGIN AdminUser;

-- חיבור המשתמש לתפקיד
ALTER ROLE LecturerRole ADD MEMBER LecturerUser;
ALTER ROLE StudentRole ADD MEMBER StudentUser;
ALTER ROLE SecretaryRole ADD MEMBER SecretaryUser;
ALTER ROLE AdminRole ADD MEMBER AdminUser;


-- sql to csv and vice verca

Exec sp_configure 'Show advanced options',1
 Reconfigure
go

sp_configure 'xp_cmdshell', '1'
reconfigure with override
Go

use AcademiqDB
go

 CREATE OR ALTER PROCEDURE sp_Export_Csv
    @table_name NVARCHAR(50)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        DECLARE @file_name VARCHAR(50);
        DECLARE @command VARCHAR(200);
        
		SET @file_name = 'C:\School\SQLBackups\' + @table_name + '.csv'; 
		SET @command = 'bcp ' + QUOTENAME(DB_NAME()) + '.dbo.'
             + QUOTENAME(@table_name) + ' out ' + @file_name + ' -c -t, -T -S '
 
        
        PRINT @command; 
         EXEC master..xp_cmdshell @command; --  execute the command.
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        RAISERROR('Error occurred during the database operation.', 16, 1);
    END CATCH;
    
    IF @@TRANCOUNT > 0
        COMMIT TRANSACTION;
END;
GO

Exec sp_Export_Csv @table_name = 'Classes'
go


declare @table_name varchar(50)
declare @fileName varchar(50)
declare @command varchar(200)
set @table_name = 'Students'
set @fileName = 'E:\' + @table_name + '.csv'
set @command = 'bcp ' + db_name() +'.dbo.'+@table_name + ' out '
+ @fileName +' -c -t, -T -S ' 
Print @command
EXEC master..xp_cmdshell @command;
go

select @@SERVERNAME
go


CREATE OR ALTER PROCEDURE BulkInsertData
    @FileName VARCHAR(255),
    @TableName VARCHAR(128)
AS
BEGIN
    DECLARE @BulkInsertCommand NVARCHAR(MAX);
    SET @BulkInsertCommand = 'BULK INSERT ' + @TableName + '  
        FROM ''' + @FileName + '''
        WITH (
            CODEPAGE = ''ACP'', 
            FIRSTROW = 2, 
            MAXERRORS = 0,
            FIELDTERMINATOR = '','', 
            ROWTERMINATOR = ''\n'' 
        );'; 
    EXEC sp_executesql @BulkInsertCommand;
END;
GO


EXEC BulkInsertData @FileName = 'C:\Users\misha\OneDrive\Desktop\HTML\academiq-final-project\Marks.csv', @TableName = 'Marks';

select * from Marks

	
	

   ​

