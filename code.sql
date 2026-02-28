CREATE TABLE Faculties
(
Id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
Financing MONEY NOT NULL CHECK(Financing >= 0) DEFAULT(0),
Name NVARCHAR(100) NOT NULL CHECK(Name != '') UNIQUE
);

CREATE TABLE Curators
(
Id INT IDENTITY(1, 1) NOt NULL PRIMARY KEY,
Name NVARCHAR(MAX) NOT NULL CHECK(Name != ''),
Surname NVARCHAR(MAX) NOT NULL CHECK(Surname != '')
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
Id INT IDENTITY(1, 1) NOt NULL PRIMARY KEY,
Financing MONEY NOT NULL CHECK(Financing >= 0) DEFAULT(0),
Name NVARCHAR(100) NOT NULL CHECK(Name != '') UNIQUE,
FacultyId INT NOT NULL,
FOREIGN KEY (FacultyId) REFERENCES Faculties(Id)
);

CREATE TABLE Groups
(
Id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
Name NVARCHAR(10) NOT NULL CHECK(Name != '') UNIQUE,
Year INT NOT NULL CHECK(Year BETWEEN 1 AND 5 ),
DepartmentId INT NOT NULL,
FOREIGN KEY (DepartmentId) REFERENCES Departments(Id)
);

CREATE TABLE Lectures
(
Id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
LectureRoom NVARCHAR(MAX) NOT NULL CHECK(LectureRoom != ''),
SubjectId INT NOT NULL,
FOREIGN KEY (SubjectId) REFERENCES Subjects(Id),
TeacherId INT NOT NULL,
FOREIGN KEY (TeacherId) REFERENCES Teachers(Id)
);

CREATE TABLE GroupsCurators
(
Id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
CuratorId INT NOT NULL,
FOREIGN KEY (CuratorId) REFERENCES Curators(Id),
GroupId INT NOT NULL,
FOREIGN KEY (GroupId) REFERENCES Groups(Id)
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
INSERT INTO Faculties (Financing, Name) VALUES
(10000, 'Faculty of Computer Science'),
(20000, 'Faculty of Mathematics'),
(15000, 'Faculty of Physics');

INSERT INTO Curators (Name, Surname) VALUES
('John', 'Smith'),
('Jane', 'Doe'),
('Michael', 'Johnson');

INSERT INTO Subjects (Name) VALUES
('Mathematics'),
('Physics'),
('Programming'),
('Databases'),
('Algorithms');

INSERT INTO Teachers (Name, Salary, Surname) VALUES
('Alice', 5000, 'Brown'),
('Bob', 6000, 'White'),
('Charlie', 7000, 'Black');

INSERT INTO Departments (Financing, Name, FacultyId) VALUES
(5000, 'Department of AI', 1),
(22398, 'Department of Algebra', 2),
(6000, 'Department of Quantum Physics', 3);

INSERT INTO Groups (Name, Year, DepartmentId) VALUES
('CS-101', 1, 1),
('CS-202', 2, 1),
('MA-101', 3, 2),
('PH-101', 4, 3);

INSERT INTO Lectures (LectureRoom, SubjectId, TeacherId) VALUES
('Room 101', 1, 1),
('Room 202', 2, 2),
('Room 303', 3, 3),
('Room 404', 4, 1),
('Room 505', 5, 2);

INSERT INTO GroupsCurators (CuratorId, GroupId) VALUES
(1, 1),
(2, 2),
(3, 3),
(1, 4);

INSERT INTO GroupsLectures (GroupId, LectureId) VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 4),
(4, 5);

-- 1
SELECT *
FROM Teachers
CROSS JOIN Groups;

-- 2
SELECT F.Name
FROM Faculties AS F
JOIN Departments AS D ON D.FacultyId = F.Id
WHERE D.Financing > F.Financing;

-- 3
SELECT C.Surname, G.Name
FROM Curators AS C
JOIN GroupsCurators AS GC ON C.Id = GC.CuratorId
JOIN Groups AS G ON G.Id = GC.GroupId;

-- 4
SELECT T.Surname
FROM Teachers AS T
JOIN Lectures AS L ON L.TeacherId = T.Id
JOIN GroupsLectures AS GL ON GL.LectureId = L.Id
JOIN Groups AS G ON GL.GroupId = G.Id
WHERE G.Name = 'P107';

-- 5
SELECT T.Surname, F.Name
FROM Teachers AS T
JOIN Lectures AS L ON L.TeacherId = T.Id
JOIN GroupsLectures AS GL ON GL.LectureId = L.Id
JOIN Groups AS G ON GL.GroupId = G.Id
JOIN Departments AS D ON G.DepartmentId = D.Id
JOIN Faculties AS F ON D.FacultyId = F.Id;

-- 6
SELECT D.Name, G.Name
FROM Departments AS D
JOIN Groups AS G ON D.Id = G.DepartmentId;

-- 7
SELECT S.Name
FROM Subjects AS S
JOIN Lectures AS L ON L.SubjectId = S.Id
JOIN Teachers AS T ON L.TeacherId = T.Id
WHERE T.Name + ' ' + T.Surname = 'Samantha Adams';

-- 8
SELECT D.Name
FROM Subjects AS S
JOIN Lectures AS L ON S.Id = L.SubjectId
JOIN GroupsLectures AS GL ON L.Id = GL.LectureId
JOIN Groups AS G ON GL.GroupId = G.Id
JOIN Departments AS D ON G.DepartmentId = D.Id
WHERE S.Name = 'Databases';

-- 9
SELECT G.Name
FROM Groups AS G
JOIN Departments AS D ON G.DepartmentId = D.Id
JOIN Faculties AS F ON D.FacultyId = F.Id
WHERE F.Name = 'Faculty of Computer Science';

-- 10
SELECT G.Name AS GroupName, F.Name AS FacultieName
FROM Groups AS G 
JOIN Departments AS D ON G.DepartmentId = D.Id
JOIN Faculties AS F ON D.FacultyId = F.Id
WHERE G.Year = 1;

-- 11
SELECT T.Surname, L.LectureRoom, S.Name, G.Name
FROM Teachers AS T
JOIN Lectures AS L ON L.TeacherId = T.Id
JOIN Subjects AS S ON L.SubjectId = S.Id
JOIN GroupsLectures AS GL ON GL.LectureId = L.Id
JOIN Groups AS G ON GL.GroupId = G.Id
WHERE L.LectureRoom = 'B103';