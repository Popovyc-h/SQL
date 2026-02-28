CREATE TABLE Students (
    Id INT PRIMARY KEY IDENTITY(1, 1),
    LastName NVARCHAR(50) NOT NULL,
    FirstName NVARCHAR(50) NOT NULL,
    BirthDate DATE NOT NULL,
    Grants DECIMAL(10, 2) NULL,
    Email NVARCHAR(100) NULL
);

INSERT INTO Students (LastName, FirstName, BirthDate, Grants, Email)
VALUES
    ('Petrenko', 'Іван', '1998-03-15', 1200.00, 'ivan.petrenko@example.com'),
    ('Коваленко', 'Марія', '1997-07-22', 1500.00, 'maria.kovalenko@example.com'),
    ('Шевченко', 'Олександр', '1999-11-08', NULL, 'oleksandr.shevchenko@example.com'),
    ('Мельник', 'Анна', '1998-05-30', 1200.00, NULL),
    ('Бойко', 'Дмитро', '1997-12-10', 1800.00, 'dmytro.boyko@example.com'),
    ('Ткаченко', 'Олена', '1999-02-18', NULL, 'olena.tkachenko@example.com'),
    ('Мороз', 'Андрій', '1998-09-25', 1350.00, 'andriy.moroz@example.com'),
    ('Сидоренко', 'Катерина', '1997-04-12', 1650.00, NULL),
    ('Коваль', 'Сергій', '1999-06-07', NULL, 'serhiy.koval@example.com'),
    ('Литвиненко', 'Юлія', '1998-10-29', 1450.00, 'yulia.lytvynenko@example.com'),
    ('Павленко', 'Максим', '1997-08-14', 1750.00, 'maxym.pavlenko@example.com'),
    ('Савченко', 'Вікторія', '1999-01-21', 1550.00, 'victoria.savchenko@example.com');

SELECT FirstName, LastName, ISNULL(Email, 'Email відсутній') AS Email 
FROM Students;

SELECT FirstName, LastName, BirthDate 
FROM Students
WHERE MONTH(BirthDate) = 2 
ORDER BY LastName;

SELECT TOP (3) FirstName, LastName
FROM Students
ORDER BY Grants;

SELECT FirstName, LastName, BirthDate 
FROM Students
WHERE Year(BirthDate) > 1997 AND Email IS NOT NULL AND Grants > 1400
ORDER BY Grants DESC;

SELECT SUBSTRING('Petrenko', 4, 3);