CREATE TABLE Faculties
(
Id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
Name NVARCHAR(100) NOT NULL CHECK(Name != '') UNIQUE,
);

CREATE TABLE Subjects
(
Id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
Name NVARCHAR(100) NOT NULL CHECK(Name != '') UNIQUE
);

CREATE TABLE Teachers
(
Id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
Name NVARCHAR(MAX) NOT NULL CHECK(Name != ''),
Salary MONEY NOT NULL CHECK(Salary > 0),
Surname NVARCHAR(MAX) NOT NULL CHECK(Surname != '')
);

CREATE TABLE Departments
(
Id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
Financing MONEY NOT NULL CHECK(Financing >= 0) DEFAULT(0),
Name NVARCHAR(100) NOT NULL CHECK(Name != '') UNIQUE,
FacultyId INT NOT NULL,
FOREIGN KEY (FacultyId) REFERENCES Faculties(Id)
);

CREATE TABLE Groups
(
Id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
Name NVARCHAR(10) NOT NULL CHECK(Name != '') UNIQUE,
Year INT NOT NULL CHECK(Year BETWEEN 1 AND 5),
DepartmentId INT NOT NULL,
FOREIGN KEY (DepartmentId) REFERENCES Departments(Id)
);

CREATE TABLE Lectures
(
Id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
DayOfWeek INT NOT NULL CHECK(DayOfWeek BETWEEN 1 AND 7),
LectureRoom NVARCHAR(MAX) NOT NULL CHECK(LectureRoom != ''),
SubjectId INT NOT NULL,
FOREIGN KEY (SubjectId) REFERENCES Subjects(Id),
TeacherId INT NOT NULL,
FOREIGN KEY (TeacherId) REFERENCES Teachers(Id)
);

CREATE TABLE GroupsLectures
(
Id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
GroupId INT NOT NULL,
FOREIGN KEY (GroupId) REFERENCES Groups(Id),
LectureId INT NOT NULL,
FOREIGN KEY (LectureId) REFERENCES Lectures(Id)
);

/*GPT*/
INSERT INTO Faculties (Name) VALUES
('Computer Science'),
('Mathematics'),
('Physics');

INSERT INTO Subjects (Name) VALUES
('Algorithms'),
('Databases'),
('Linear Algebra'),
('OOP'),
('Networks');

INSERT INTO Teachers (Name, Surname, Salary) VALUES
('Dave', 'McQueen', 3000),
('Jack', 'Underhill', 3500),
('Alice', 'Brown', 2800),
('Bob', 'Smith', 3200);

INSERT INTO Departments (Name, Financing, FacultyId) VALUES
('Software Development', 10000, 1),
('Data Science', 8000, 1),
('Applied Math', 7000, 2),
('Quantum Physics', 6000, 3);

INSERT INTO Groups (Name, Year, DepartmentId) VALUES
('CS-11', 1, 1),
('CS-12', 2, 1),
('DS-11', 1, 2),
('AM-11', 3, 3),
('QP-11', 4, 4);

INSERT INTO Lectures (DayOfWeek, LectureRoom, SubjectId, TeacherId) VALUES
(1, 'D201', 1, 1),
(2, 'D201', 2, 2),
(3, 'A101', 3, 3),
(4, 'B305', 4, 1),
(5, 'D201', 5, 2),
(1, 'A101', 1, 2),
(2, 'B305', 2, 4),
(3, 'D201', 3, 1),
(6, 'A101', 4, 3),
(7, 'B305', 5, 4);

INSERT INTO GroupsLectures (GroupId, LectureId) VALUES
(1, 1), (1, 2), (1, 4),
(2, 1), (2, 3), (2, 5),
(3, 2), (3, 6), (3, 7),
(4, 3), (4, 8), (4, 9),
(5, 5), (5, 7), (5, 10);

-- 1
SELECT COUNT(DISTINCT T.Id)
FROM Teachers AS T
JOIN Lectures AS L ON T.Id = L.TeacherId
JOIN GroupsLectures AS GL ON GL.LectureId = L.Id
JOIN Groups AS G ON G.Id = GL.GroupId
JOIN Departments AS D ON G.DepartmentId = D.Id
WHERE D.Name = 'Software Development';

-- 2
SELECT COUNT(L.Id) AS CountOfLecture
FROM Lectures AS L
JOIN Teachers AS T ON L.TeacherId = T.Id
WHERE T.Name + ' ' + T.Surname = 'Dave McQueen';

-- 3
SELECT COUNT(L.Id) AS CountOfLectures
FROM Lectures AS L
WHERE L.LectureRoom = 'D201';

-- 4
SELECT L.LectureRoom, COUNT(L.Id) AS CountOfLectures
FROM Lectures AS L
GROUP BY L.LectureRoom;

-- 5

-- 6
SELECT AVG(DISTINCT T.Salary) AS AverageSalary
FROM Teachers AS T
JOIN Lectures AS L ON L.TeacherId = T.Id
JOIN GroupsLectures AS GL ON GL.LectureId = L.Id
JOIN Groups AS G ON GL.GroupId = G.Id
JOIN Departments AS D ON G.DepartmentId = D.Id
JOIN Faculties AS F ON D.FacultyId = F.Id
WHERE F.Name = 'Computer Science';

-- 7

-- 8
SELECT AVG(D.Financing) AS AverageFinancing
FROM Departments AS D;

-- 9
SELECT T.Name + ' ' + T.Surname AS FullName, COUNT(DISTINCT S.Id)
FROM Teachers AS T
JOIN Lectures AS L ON T.Id = L.TeacherId
JOIN Subjects AS S ON L.SubjectId = S.Id
GROUP BY T.Name + ' ' + T.Surname;

-- 10
SELECT L.DayOfWeek, COUNT(L.Id)
FROM Lectures AS L
GROUP BY L.DayOfWeek;

-- 11
SELECT L.LectureRoom, COUNT(DISTINCT D.Id) AS CountDepartments
FROM Lectures AS L
JOIN GroupsLectures AS GL ON GL.LectureId = L.Id
JOIN Groups AS G ON GL.GroupId = G.Id
JOIN Departments AS D ON G.DepartmentId = D.Id
GROUP BY L.LectureRoom;

-- 12
SELECT F.Name, COUNT(DISTINCT S.Id) CountSubject
FROM Faculties AS F
JOIN Departments AS D ON D.FacultyId = F.Id
JOIN Groups AS G ON G.DepartmentId = D.Id
JOIN GroupsLectures AS GL ON GL.GroupId = G.Id
JOIN Lectures AS L ON GL.LectureId = L.Id
JOIN Subjects AS S ON L.SubjectId = S.Id
GROUP BY F.Name;

-- 13
SELECT L.LectureRoom, T.Name + ' ' + T.Surname AS TeachersFullName, COUNT(L.Id) AS CountOfLectures
FROM Lectures AS L
JOIN Teachers AS T ON L.TeacherId = T.Id 
GROUP BY L.LectureRoom, T.Name, T.Surname;