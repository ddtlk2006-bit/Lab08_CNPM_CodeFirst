-- =========================================================================================
-- Lab 08: ASP.NET Core with Razor / MVC - Code First
-- Database Creation Script for SchoolDB
-- FIT - TDTU - Software Engineering
-- =========================================================================================

IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'SchoolDB')
BEGIN
    CREATE DATABASE [SchoolDB];
END
GO

USE [SchoolDB];
GO

-- 1. Create __EFMigrationsHistory table for Entity Framework Core tracking
IF OBJECT_ID(N'[dbo].[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [dbo].[__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END
GO

-- 2. Drop existing foreign keys and tables if recreating (safe idempotent setup)
IF OBJECT_ID(N'[dbo].[FK_Enrollments_Students_StudentID]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Enrollments] DROP CONSTRAINT [FK_Enrollments_Students_StudentID];
GO
IF OBJECT_ID(N'[dbo].[FK_Enrollments_Courses_CourseID]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Enrollments] DROP CONSTRAINT [FK_Enrollments_Courses_CourseID];
GO
IF OBJECT_ID(N'[dbo].[FK_Courses_Departments_DepartmentID]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Courses] DROP CONSTRAINT [FK_Courses_Departments_DepartmentID];
GO

IF OBJECT_ID(N'[dbo].[Enrollments]', 'U') IS NOT NULL DROP TABLE [dbo].[Enrollments];
IF OBJECT_ID(N'[dbo].[Students]', 'U') IS NOT NULL DROP TABLE [dbo].[Students];
IF OBJECT_ID(N'[dbo].[Courses]', 'U') IS NOT NULL DROP TABLE [dbo].[Courses];
IF OBJECT_ID(N'[dbo].[Instructors]', 'U') IS NOT NULL DROP TABLE [dbo].[Instructors];
IF OBJECT_ID(N'[dbo].[Departments]', 'U') IS NOT NULL DROP TABLE [dbo].[Departments];
GO

-- 3. Create Departments Table
CREATE TABLE [dbo].[Departments] (
    [DepartmentID] INT IDENTITY(1,1) NOT NULL,
    [DepartmentName] NVARCHAR(MAX) NOT NULL,
    [Budget] DECIMAL(18, 2) NOT NULL,
    [StartDate] DATETIME2(7) NOT NULL,
    CONSTRAINT [PK_Departments] PRIMARY KEY CLUSTERED ([DepartmentID] ASC)
);
GO

-- 4. Create Instructors Table
CREATE TABLE [dbo].[Instructors] (
    [InstructorID] INT IDENTITY(1,1) NOT NULL,
    [LastName] NVARCHAR(MAX) NOT NULL,
    [FirstName] NVARCHAR(MAX) NOT NULL,
    [HireDate] DATETIME2(7) NOT NULL,
    CONSTRAINT [PK_Instructors] PRIMARY KEY CLUSTERED ([InstructorID] ASC)
);
GO

-- 5. Create Courses Table
CREATE TABLE [dbo].[Courses] (
    [CourseID] INT IDENTITY(1,1) NOT NULL,
    [Title] NVARCHAR(MAX) NOT NULL,
    [Credits] INT NOT NULL,
    [DepartmentID] INT NOT NULL,
    CONSTRAINT [PK_Courses] PRIMARY KEY CLUSTERED ([CourseID] ASC),
    CONSTRAINT [FK_Courses_Departments_DepartmentID] FOREIGN KEY ([DepartmentID]) 
        REFERENCES [dbo].[Departments] ([DepartmentID]) ON DELETE CASCADE
);
GO
CREATE NONCLUSTERED INDEX [IX_Courses_DepartmentID] ON [dbo].[Courses]([DepartmentID] ASC);
GO

-- 6. Create Students Table
CREATE TABLE [dbo].[Students] (
    [StudentID] INT IDENTITY(1,1) NOT NULL,
    [LastName] NVARCHAR(MAX) NOT NULL,
    [FirstName] NVARCHAR(MAX) NOT NULL,
    [EnrollmentDate] DATETIME2(7) NOT NULL,
    CONSTRAINT [PK_Students] PRIMARY KEY CLUSTERED ([StudentID] ASC)
);
GO

-- 7. Create Enrollments Table
CREATE TABLE [dbo].[Enrollments] (
    [EnrollmentID] INT IDENTITY(1,1) NOT NULL,
    [CourseID] INT NOT NULL,
    [StudentID] INT NOT NULL,
    [Grade] DECIMAL(18, 2) NOT NULL,
    CONSTRAINT [PK_Enrollments] PRIMARY KEY CLUSTERED ([EnrollmentID] ASC),
    CONSTRAINT [FK_Enrollments_Courses_CourseID] FOREIGN KEY ([CourseID]) 
        REFERENCES [dbo].[Courses] ([CourseID]) ON DELETE CASCADE,
    CONSTRAINT [FK_Enrollments_Students_StudentID] FOREIGN KEY ([StudentID]) 
        REFERENCES [dbo].[Students] ([StudentID]) ON DELETE CASCADE
);
GO
CREATE NONCLUSTERED INDEX [IX_Enrollments_CourseID] ON [dbo].[Enrollments]([CourseID] ASC);
CREATE NONCLUSTERED INDEX [IX_Enrollments_StudentID] ON [dbo].[Enrollments]([StudentID] ASC);
GO

-- 8. Seed EF Migrations Record
IF NOT EXISTS (SELECT * FROM [dbo].[__EFMigrationsHistory] WHERE [MigrationId] = N'20250429100129_InitialCreate')
BEGIN
    INSERT INTO [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250429100129_InitialCreate', N'8.0.11');
END
IF NOT EXISTS (SELECT * FROM [dbo].[__EFMigrationsHistory] WHERE [MigrationId] = N'20250430021132_InitialCreate')
BEGIN
    INSERT INTO [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250430021132_InitialCreate', N'8.0.11');
END
GO

-- 9. Seed Initial Sample Data matching Lab manual screenshots
SET IDENTITY_INSERT [dbo].[Departments] ON;
INSERT INTO [dbo].[Departments] ([DepartmentID], [DepartmentName], [Budget], [StartDate])
VALUES 
    (1, N'Computer Science', 100000.00, '2025-01-04 07:02:00'),
    (2, N'Information Systems', 200000.00, '2025-01-04 07:07:00'),
    (3, N'Mathematics', 150000.00, '2025-01-04 08:00:00'),
    (4, N'Economics', 120000.00, '2025-01-04 08:30:00');
SET IDENTITY_INSERT [dbo].[Departments] OFF;
GO

SET IDENTITY_INSERT [dbo].[Instructors] ON;
INSERT INTO [dbo].[Instructors] ([InstructorID], [LastName], [FirstName], [HireDate])
VALUES 
    (1, N'Abercrombie', N'Kim', '2015-03-11'),
    (2, N'Fakhouri', N'Fadi', '2017-07-06'),
    (3, N'Harui', N'Roger', '2018-07-01'),
    (4, N'Kapoor', N'Candace', '2019-01-15'),
    (5, N'Zheng', N'Roger', '2020-02-12');
SET IDENTITY_INSERT [dbo].[Instructors] OFF;
GO

SET IDENTITY_INSERT [dbo].[Courses] ON;
INSERT INTO [dbo].[Courses] ([CourseID], [Title], [Credits], [DepartmentID])
VALUES 
    (1050, N'Chemistry', 3, 1),
    (4022, N'Microeconomics', 3, 4),
    (4041, N'Macroeconomics', 3, 4),
    (1045, N'Calculus', 4, 3),
    (3141, N'Trigonometry', 4, 3),
    (2021, N'Composition', 3, 2),
    (2042, N'Literature', 4, 2);
SET IDENTITY_INSERT [dbo].[Courses] OFF;
GO

SET IDENTITY_INSERT [dbo].[Students] ON;
INSERT INTO [dbo].[Students] ([StudentID], [LastName], [FirstName], [EnrollmentDate])
VALUES 
    (1, N'Carson', N'Alexander', '2022-09-01'),
    (2, N'Meredith', N'Alonso', '2023-09-01'),
    (3, N'Arturo', N'Anand', '2023-09-01'),
    (4, N'Barzdukas', N'Gytis', '2024-01-15'),
    (5, N'Li', N'Yan', '2024-01-15'),
    (6, N'Justice', N'Peggy', '2024-09-01'),
    (7, N'Olivetto', N'Nino', '2024-09-01');
SET IDENTITY_INSERT [dbo].[Students] OFF;
GO

SET IDENTITY_INSERT [dbo].[Enrollments] ON;
INSERT INTO [dbo].[Enrollments] ([EnrollmentID], [CourseID], [StudentID], [Grade])
VALUES 
    (1, 1050, 1, 3.50),
    (2, 4022, 1, 4.00),
    (3, 4041, 1, 3.00),
    (4, 1045, 2, 2.50),
    (5, 3141, 2, 3.75),
    (6, 2021, 2, 4.00),
    (7, 1050, 3, 3.00),
    (8, 1050, 4, 3.50),
    (9, 4022, 5, 2.75),
    (10, 4041, 6, 3.25);
SET IDENTITY_INSERT [dbo].[Enrollments] OFF;
GO

PRINT 'SchoolDB database script executed successfully.';
GO

