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
);

CREATE TABLE Courses (
    CourseId INT NOT NULL PRIMARY KEY,
    CourseDescription NVARCHAR(50) NOT NULL
);

CREATE TABLE Lecturers_In_Course (
    CourseId INT NOT NULL,
    LecturerId INT NOT NULL ,
	School_Year INT NOT NULL,
	Department_Code INT NOT NULL,
	FOREIGN KEY (LecturerId) REFERENCES Lecturers(LecturerId),
	FOREIGN KEY (CourseId) REFERENCES Courses(CourseId),
	FOREIGN KEY (Department_Code) REFERENCES Departments(Department_Code)
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
	Enrollment date NULL,
	FOREIGN KEY (City_Code) REFERENCES Cities(City_Code),
	Password NVARCHAR(24)  NULL, --NOT NULL

);

CREATE TABLE Assignments (
    AssignmentId INT NOT NULL PRIMARY KEY,
    CourseId INT NOT NULL,
    IsVisible BIT NOT NULL, --bool var- uploading all assing..change to show what is already uploaded
    Deadline DATETIME NOT NULL,
	File_URL NVARCHAR(MAX)  NULL,
	Description NVARCHAR(MAX) NULL, 
	FOREIGN KEY (CourseId) REFERENCES Courses(CourseId)

);

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
);

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
);


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
    PRIMARY KEY (Course_Code, Week_Day, Begin_Hour, End_Hour),
    FOREIGN KEY (Course_Code) REFERENCES Courses_On_Air(Course_Code),
    FOREIGN KEY (Class_Code) REFERENCES Classes(Class_Code)
);


CREATE TABLE Students_In_Course (
    StudentId INT NOT NULL,
    CourseId INT NOT NULL,
    School_Year INT NOT NULL,
    PRIMARY KEY (StudentId, CourseId, School_Year),
    FOREIGN KEY (StudentId) REFERENCES Students(StudentId),
    FOREIGN KEY (CourseId) REFERENCES Courses(CourseId)
);



-- Cities
INSERT INTO Cities (City_Code, City_Name) VALUES
(1, '???????'),
(2, '?? ????'),
(3, '????'),
(4, '??? ???'),
(5, '?????'),
(6, '????? ?????'),
(7, '??? ?????'),
(8, '?????'),
(9, '??? ??'),
(10, '?????');

-- Departments
INSERT INTO Departments (Department_Code, Department_Name, HOD_Id) VALUES --HOD - head of department
(1, '???? ?????', 1),
(2, '???????', 2),
(3, '??????', 3),
(4, '?????', 4),
(5, '????????', 5),
(6, '?????', 6),
(7, '?????', 7),
(8, '?????', 8),
(9, '?????', 9),
(10, '??????????', 10);

-- Buildings
INSERT INTO Buildings (Building_Code, Building_Name) VALUES
(1, '????? ?'),
(2, '????? ?'),
(3, '????? ?'),
(4, '????? ?'),
(5, '????? ?'),
(6, '????? ?'),
(7, '????? ?'),
(8, '????? ?'),
(9, '????? ?'),
(10, '????? ?');

INSERT INTO Classes (Class_Code, Class_Name, Building_Code) VALUES
(1, '?????????? 1', 1),
(2, '????? 2', 2),
(3, '??? ???', 3),
(4, '???? ????', 4),
(5, '??? ?????', 5),
(6, '???? ???????', 6),
(7, '??? ??????', 7),
(8, '?????????? 2', 8),
(9, '????? 3', 9),
(10, '??? 10', 10);

-- Lecturers
INSERT INTO Lecturers (LecturerId, FirstName, LastName, Phone, Email, Academic_Degree, Start_Date, Address, City_Code, Password) VALUES
(1, '???', '???', '0541234567', 'avi@example.com', '???????', '2010-01-01', '???? ???, ?? ????', 2, 'password1'),
(2, '???', '???', '0521234567', 'ruth@example.com', '??????', '2015-01-01', '???? ?????, ???????', 1, 'password2'),
(3, '???', '????', '0501234567', 'dani@example.com', '?????', '2018-01-01', '???? ?????, ????', 3, 'password3'),
(4, '????', '??', '0531234567', 'michal@example.com', '???????', '2012-01-01', '???? ????, ??? ???', 4, 'password4'),
(5, '????', '????', '0581234567', 'yoav@example.com', '??????', '2017-01-01', '???? ???, ?????', 5, 'password5'),
(6, '???', '????', '0571234567', 'adi@example.com', '?????', '2019-01-01', '???? ??, ????? ?????', 6, 'password6'),
(7, '?????', '???', '0591234567', 'lior@example.com', '???????', '2014-01-01', '???? ???, ??? ?????', 7, 'password7'),
(8, '?????', '????', '0561234567', 'liron@example.com', '??????', '2016-01-01', '???? ?????, ?????', 8, 'password8'),
(9, '????', '??', '0551234567', 'eyal@example.com', '?????', '2020-01-01', '???? ???, ??? ??', 9, 'password9'),
(10, '?????', '????', '0511234567', 'itamar@example.com', '???????', '2013-01-01', '???? ???, ?????', 10, 'password10');

-- Courses
INSERT INTO Courses (CourseId, CourseDescription) VALUES
(1, '???? ????? ?????'),
(2, '?????? ???????'),
(3, '?????? 1'),
(4, '????? ???????'),
(5, '???????? ????'),
(6, '????? ?????'),
(7, '?????'),
(8, '????? ?????'),
(9, '????'),
(10, '?????????? ?? ?????');

-- Lecturers_In_Course
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

-- Students
INSERT INTO Students (StudentId, FirstName, LastName, School_Year, Phone, Email, Picture_URL, Address, City_Code, Registration, Password) VALUES
(1, '?????', '?????', 1, '0541234567', 'daniel@example.com', 'https://www.example.com/image.jpg', '???? ???, ?? ????', 2, '2023-01-01', 'student1'),
(2, '???', '???', 2, '0521234567', 'sarah@example.com', 'https://www.example.com/image.jpg', '???? ?????, ???????', 1, '2022-01-01', 'student2'),
(3, '?????', '????', 3, '0501234567', 'jonathan@example.com', 'https://www.example.com/image.jpg', '???? ?????, ????', 3, '2021-01-01', 'student3'),
(4, '????', '??', 4, '0531234567', 'liat@example.com', 'https://www.example.com/image.jpg', '???? ????, ??? ???', 4, '2020-01-01', 'student4'),
(5, '???', '????', 1, '0581234567', 'ron@example.com', 'https://www.example.com/image.jpg', '???? ???, ?????', 5, '2023-01-01', 'student5'),
(6, '?????', '???', 2, '0571234567', 'aylet@example.com', 'https://www.example.com/image.jpg', '???? ??, ????? ?????', 6, '2022-01-01', 'student6'),
(7, '????', '????', 3, '0591234567', 'idan@example.com', 'https://www.example.com/image.jpg', '???? ???, ??? ?????', 7, '2021-01-01', 'student7'),
(8, '????', '???', 4, '0561234567', 'tomer@example.com', 'https://www.example.com/image.jpg', '???? ?????, ?????', 8, '2020-01-01', 'student8'),
(9, '??????', '??', 1, '0551234567', 'avigail@example.com', 'https://www.example.com/image.jpg', '???? ???, ??? ??', 9, '2023-01-01', 'student9'),
(10, '?????', '????', 2, '0511234567', 'lior@example.com', 'https://www.example.com/image.jpg', '???? ???, ?????', 10, '2022-01-01', 'student10');

-- Assignments
INSERT INTO Assignments (AssignmentId, CourseId, IsVisible, Deadline, File_URL, Description) VALUES
(1, 1, 1, '2023-04-01 23:59:59', 'https://www.example.com/assignment1.pdf', '????? ??? 1 ????? ????? ?????'),
(2, 2, 1, '2023-05-01 23:59:59', 'https://www.example.com/assignment2.pdf', '????? ??? 2 ??????? ???????'),
(3, 3, 1, '2023-06-01 23:59:59', 'https://www.example.com/assignment3.pdf', '????? ??? 3 ??????? 1'),
(4, 4, 1, '2023-07-01 23:59:59', 'https://www.example.com/assignment4.pdf', '????? ??? 4 ?????? ???????'),
(5, 5, 1, '2023-08-01 23:59:59', 'https://www.example.com/assignment5.pdf', '????? ??? 5 ????????? ????'),
(6, 6, 1, '2023-09-01 23:59:59', 'https://www.example.com/assignment6.pdf', '????? ??? 6 ?????? ?????'),
(7, 7, 1, '2023-10-01 23:59:59', 'https://www.example.com/assignment7.pdf', '????? ??? 7 ??????'),
(8, 8, 1, '2023-11-01 23:59:59', 'https://www.example.com/assignment8.pdf', '????? ??? 8 ?????? ?????'),
(9, 9, 1, '2023-12-01 23:59:59', 'https://www.example.com/assignment9.pdf', '????? ??? 9 ?????'),
(10, 10, 1, '2024-01-01 23:59:59', 'https://www.example.com/assignment10.pdf', '????? ??? 10 ??????????? ?? ?????');

-- Assignment_Of_Student
INSERT INTO Assignment_Of_Student (AssignmentId, CourseId, StudentId, IsDone, SelfDeadline) VALUES
(1, 1, 1, 0, '2023-04-05 23:59:59'),
(2, 2, 2, 0, '2023-05-05 23:59:59'),
(3, 3, 3, 0, '2023-06-05 23:59:59'),
(4, 4, 4, 0, '2023-07-05 23:59:59'),
(5, 5, 5, 0, '2023-08-05 23:59:59'),
(6, 6, 6, 0, '2023-09-05 23:59:59'),
(7, 7, 7, 0, '2023-10-05 23:59:59'),
(8, 8, 8, 0, '2023-11-05 23:59:59'),
(9, 9, 9, 0, '2023-12-05 23:59:59'),
(10, 10, 10, 0, '2024-01-05 23:59:59');

-- Marks
INSERT INTO Marks (StudentId, CourseId, Date, Mark, Semester) VALUES
(1, 1, 20230101, 85, 1),
(2, 2, 20230101, 90, 1),
(3, 3, 20230101, 78, 1),
(4, 4, 20230101, 88, 1),
(5, 5, 20230101, 92, 1),
(6, 6, 20230101, 80, 1),
(7, 7, 20230101, 85, 1),
(8, 8, 20230101, 90, 1),
(9, 9, 20230101, 78, 1),
(10, 10, 20230101, 88, 1);

-- Courses_On_Air
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

-- Course_Schedule
INSERT INTO Course_Schedule (Course_Code, Week_Day, Begin_Hour, End_Hour, Class_Code) VALUES
(1, '?', '08:00', '09:00', 1),
(2, '?', '10:00', '11:00', 2),
(3, '?', '12:00', '13:00', 3),
(4, '?', '14:00', '15:00', 4),
(5, '?', '16:00', '17:00', 5),
(6, '?', '18:00', '19:00', 6),
(7, '?', '08:00', '09:00', 7),
(8, '?', '10:00', '11:00', 8),
(9, '?', '12:00', '13:00', 9),
(10, '?', '14:00', '15:00', 10);

-- Students_In_Course
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
(10, 10, 2023);
select * from Marks inner join Students on Students.StudentId = Marks.StudentId
go
