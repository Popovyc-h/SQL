CREATE TABLE Departments
(
Id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
Financing MONEY NOT NULL CHECK(Financing >= 0) DEFAULT(0),
Name NVARCHAR(100) NOT NULL CHECK(Name != '') UNIQUE
);

CREATE TABLE Faculties
(
Id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
Dean NVARCHAR(MAX) NOT NULL CHECK(Dean != ''),
Name NVARCHAR(100) NOT NULL CHECK(Name != '') UNIQUE
);

CREATE TABLE Groups
(
Id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
Name NVARCHAR(10) NOT NULL CHECK(Name != '') UNIQUE,
Rating INT NOT NULL CHECK (Rating BETWEEN 0 AND 5),
Year INT NOT NULL CHECK (Year BETWEEN 1 AND 5)
);

CREATE TABLE Teachers
(
Id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
EmploymentDate DATE NOT NULL CHECK (EmploymentDate >= '1990.01.01'),
IsAssistant BIT NOT NULL DEFAULT(0),
IsProfessor BIT NOT NULL DEFAULT(0),
Name NVARCHAR(MAX) NOT NULL CHECK(Name != ''),
Position NVARCHAR(MAX) NOT NULL CHECK(Position != ''),
Premium MONEY NOT NULL CHECK(Premium >= 0) DEFAULT(0),
Salary MONEY NOT NULL CHECK(Salary > 0),
Surname NVARCHAR(MAX) NOT NULL CHECK(Surname != '')
);

-- 1
SELECT Name, Financing, Id 
FROM Departments;

-- 2
SELECT Name AS 'Group Name', Rating AS 'Group Rating' 
FROM Groups;

-- 3
SELECT Surname, (Salary / Premium) * 100 AS 'Salary Premium Percent', 
      (Salary / (Salary + Premium)) * 100 AS 'Salary Percentage	'
FROM Teachers;

-- 4
SELECT 'The dean of faculty ' + Name + ' is ' + Dean
FROM Faculties;

-- 5
SELECT Surname
FROM Teachers
WHERE IsProfessor = 1 AND Salary > 1050;

-- 6
SELECT Name
FROM Departments
WHERE Financing < 11000 OR Financing > 25000;

-- 7
SELECT Name
FROM Faculties
WHERE Name != 'Computer Science';

-- 8
SELECT Surname, Position
FROM Teachers
WHERE IsProfessor = 0;

-- 9
SELECT Surname, Position, Salary, Premium
FROM Teachers
WHERE IsAssistant = 1 AND Premium BETWEEN 160 AND 550;

-- 10
SELECT Surname, Salary
FROM Teachers
WHERE IsAssistant = 1;

-- 11
SELECT Surname, Position
FROM Teachers
WHERE EmploymentDate < '2000.01.01';

-- 12
SELECT Name AS 'Name of Department'
FROM Departments
WHERE Name < 'Software Development';

-- 13
SELECT Surname
FROM Teachers
WHERE IsAssistant = 1 AND Salary + Premium <= 1200;

-- 14
SELECT Name
FROM Groups
WHERE Rating BETWEEN 2 AND 4 AND Year = 5;

-- 15
SELECT Surname
FROM Teachers
WHERE IsAssistant = 1 AND (Salary < 550 OR Premium < 200);

INSERT INTO Departments (Financing, Name)
VALUES (1239, 'IT');

INSERT INTO Faculties (Dean, Name)
VALUES ('John Smith', 'Computer Science'), 
       ('Cristiano Ronaldo', 'Barbi');

INSERT INTO Groups (Name, Rating, Year)
VALUES ('P41', 5, 2)
       ('P777', 3, 4);

INSERT INTO Teachers (EmploymentDate, IsAssistant, IsProfessor, Name, Position, Premium, Salary, Surname)
VALUES ('1999-02-04', 1, 0, 'Oleg', 'Director', 170, 2390, 'Olegovich'),
       ('2020-12-01', 0, 1, 'Viktor', 'Zauch', 1000, 2390, 'Petrovich');