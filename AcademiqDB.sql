/*
use master
drop database AcademiqDB
*/

CREATE DATABASE AcademiqDB
COLLATE Hebrew_CI_AS  
GO

use AcademiqDB
Go

CREATE TABLE Cities(
City_Code INT not null PRIMARY KEY ,
City_Name NVARCHAR(50) null 
);

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
);

CREATE TABLE Courses (
    CourseId INT NOT NULL PRIMARY KEY,
    CourseDescription NVARCHAR(50) NOT NULL,
);

CREATE TABLE Lecturers_In_Course (
    CourseId INT NOT NULL,
    LecturerId INT NOT NULL ,
	School_Year INT NOT NULL,
	FOREIGN KEY (LecturerId) REFERENCES Lecturers(LecturerId),
	FOREIGN KEY (CourseId) REFERENCES Courses(CourseId)
);

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
	Registration date NULL,
	FOREIGN KEY (City_Code) REFERENCES Cities(City_Code),
	Password NVARCHAR(24)  NULL, --NOT NULL

);

CREATE TABLE Assignments (
    AssignmentId INT NOT NULL PRIMARY KEY,
    CourseId INT NOT NULL,
    IsVisible BIT NOT NULL,
    Deadline DATETIME NOT NULL,
	File_URL NVARCHAR(MAX)  NULL,
	Description NVARCHAR(MAX) NULL, 
	FOREIGN KEY (CourseId) REFERENCES Courses(CourseId),

);

CREATE TABLE Assignment_Of_Student (
    AssignmentId INT NOT NULL,
    CourseId INT NOT NULL,
	StudentId INT NOT NULL,
    IsDone BIT NOT NULL,
    SelfDeadline DATETIME NOT NULL,
	FOREIGN KEY (AssignmentId) REFERENCES Assignments(AssignmentId),
	FOREIGN KEY (CourseId) REFERENCES Courses(CourseId),
	FOREIGN KEY (StudentId) REFERENCES Students(StudentId),
	PRIMARY KEY (AssignmentId,CourseId,StudentId)
);


CREATE TABLE Marks (
    StudentId INT NOT NULL,
    CourseId INT NOT NULL,
	Date INT NOT NULL,
    Mark INT NOT NULL,
    Semester Smallint NOT NULL,
	FOREIGN KEY (StudentId) REFERENCES Students(StudentId),
	FOREIGN KEY (CourseId) REFERENCES Courses(CourseId),
	PRIMARY KEY (StudentId,CourseId,Date)
);

CREATE TABLE [Departments] (
	[Department_Code] [Us_Code] ,
	[Department_Name] [Us_Desc_Names_Heb] ,
	[Manager] [Us_Names_Heb] NULL 	  
)
GO

CREATE TABLE [dbo].[Buildings] (
	[Building_Code] [Us_Code] ,
	[Building_Name] [Us_Desc_Names_Heb] NULL 
)
GO

CREATE TABLE [Courses_On_Air] (
	[Course_Code] [int] Not Null,
	[Open_Date] [date] NOT NULL ,
	[End_Date] [date] NOT NULL ,
	[Teacher_Id] [Us_Id] ,
	[Building_Code] [Us_Code] NULL ,
	[Class_Code] [Us_Code] NULL ,
	[Week_Day] [char] (1) NULL ,
	[Begin_Hour] [time] NULL ,
	[End_Hour] [time] NULL
)
GO


-- Cities
INSERT INTO Cities (City_Code, City_Name) VALUES
(1, 'London'),
(2, 'Paris'),
(3, 'New York'),
(4, 'Tokyo'),
(5, 'Sydney');

-- Lecturers
INSERT INTO Lecturers (LecturerId, FirstName, LastName, Phone, Email, Start_Date, Academic_Degree, Address, City_Code) VALUES
(1, 'John', 'Doe', '+1234567890', 'john.doe@example.com', '2023-01-01', 1, '123 Main Street', 1),
(2, 'Jane', 'Smith', '+1987654321', 'jane.smith@example.com', '2022-05-15', 2, '456 Oak Avenue', 2),
(3, 'David', 'Brown', '+1555123456', 'david.brown@example.com', '2023-03-08', 3, '789 Pine Lane', 3),
(4, 'Emily', 'Wilson', '+1111222333', 'emily.wilson@example.com', '2022-10-20', 2, '1011 Elm Street', 4),
(5, 'Michael', 'Jones', '+1999888777', 'michael.jones@example.com', '2023-02-12', 1, '1213 Maple Drive', 5);

-- Courses
INSERT INTO Courses (CourseId, CourseDescription) VALUES
(1, 'Introduction to Programming'),
(2, 'Data Structures and Algorithms'),
(3, 'Calculus I'),
(4, 'Linear Algebra'),
(5, 'Web Development');

-- Lecturers_In_Course
INSERT INTO Lecturers_In_Course (CourseId, LecturerId, School_Year) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(4, 4, 1),
(5, 5, 1);

-- Assignments
INSERT INTO Assignments (AssignmentId, CourseId, IsVisible, Deadline) VALUES
(1, 1, 1, CONVERT(datetime, '15/12/2023 23:59:59', 103)),  -- 103 is the format code for 'dd/mm/yyyy'
(2, 2, 1, CONVERT(datetime, '22/12/2023 23:59:59', 103)),
(3, 3, 1, CONVERT(datetime, '29/12/2023 23:59:59', 103)),
(4, 4, 1, CONVERT(datetime, '05/01/2024 23:59:59', 103)),
(5, 5, 1, CONVERT(datetime, '12/01/2024 23:59:59', 103)); 

-- Students
INSERT INTO Students (StudentId, FirstName, LastName, School_Year, Phone, Email, Address, City_Code, Registration) VALUES
(1, 'Alice', 'Johnson', 2023, '+1111111111', 'alice.johnson@example.com',  '201 Park Avenue', 1, '2023-09-01'),
(2, 'Bob', 'Williams', 2022, '+1222222222', 'bob.williams@example.com',  '301 Oak Street', 2, '2022-09-01'),
(3, 'Charlie', 'Brown', 2021, '+1333333333', 'charlie.brown@example.com','401 Pine Lane', 3, '2021-09-01'),
(4, 'Diana', 'Davis', 2024, '+1444444444', 'diana.davis@example.com',  '501 Elm Street', 4, '2024-09-01'),
(5, 'Eric', 'Miller', 2023, '+1555555555', 'eric.miller@example.com', '601 Maple Drive', 5, '2023-09-01');

-- Marks
INSERT INTO Marks (StudentId, CourseId, Mark, Date, Semester) VALUES
(1, 1, 85, 20231210, 1),
(1, 2, 90, 20231210, 1),
(2, 2, 90, 20231217, 1),
(3, 3, 78, 20231224, 1),
(4, 4, 88, 20240101, 1),
(5, 5, 92, 20240108, 1);

select * from Marks inner join Students on Students.StudentId = Marks.StudentId
go