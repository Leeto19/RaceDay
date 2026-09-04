USE RaceDay;
GO

-- ============================================
-- 1. DELETE OLD TABLES
-- ============================================

DROP TABLE IF EXISTS Result;
DROP TABLE IF EXISTS Enrolment;
DROP TABLE IF EXISTS EventCategory;
DROP TABLE IF EXISTS Event;
DROP TABLE IF EXISTS Category;
DROP TABLE IF EXISTS [User];
DROP TABLE IF EXISTS Role;
GO


-- ============================================
-- 2. CREATE ROLE
-- ============================================

CREATE TABLE Role (
    RoleID INT IDENTITY(1,1) PRIMARY KEY,
    RoleName VARCHAR(50) NOT NULL
);
GO


-- ============================================
-- 3. CREATE USER
-- ============================================

CREATE TABLE [User] (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    RoleID INT NOT NULL,

    CONSTRAINT FK_User_Role
        FOREIGN KEY (RoleID)
        REFERENCES Role(RoleID)
);
GO


-- ============================================
-- 4. CREATE EVENT
-- ============================================

CREATE TABLE Event (
    EventID INT IDENTITY(1,1) PRIMARY KEY,
    EventName VARCHAR(100) NOT NULL,
    EventDate DATE NOT NULL,
    Location VARCHAR(150) NOT NULL,
    Description VARCHAR(500),
    OrganiserID INT NOT NULL,

    CONSTRAINT FK_Event_Organiser
        FOREIGN KEY (OrganiserID)
        REFERENCES [User](UserID)
);
GO


-- ============================================
-- 5. CREATE CATEGORY
-- ============================================

CREATE TABLE Category (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL
);
GO


-- ============================================
-- 6. CREATE EVENTCATEGORY
-- ============================================

CREATE TABLE EventCategory (
    EventCategoryID INT IDENTITY(1,1) PRIMARY KEY,
    EventID INT NOT NULL,
    CategoryID INT NOT NULL,

    CONSTRAINT FK_EventCategory_Event
        FOREIGN KEY (EventID)
        REFERENCES Event(EventID),

    CONSTRAINT FK_EventCategory_Category
        FOREIGN KEY (CategoryID)
        REFERENCES Category(CategoryID),

    CONSTRAINT UQ_EventCategory
        UNIQUE (EventID, CategoryID)
);
GO


-- ============================================
-- 7. CREATE ENROLMENT
-- ============================================

CREATE TABLE Enrolment (
    EnrolmentID INT IDENTITY(1,1) PRIMARY KEY,
    EventCategoryID INT NOT NULL,
    ParticipantID INT NOT NULL,
    EnrolmentDate DATE NOT NULL,

    CONSTRAINT FK_Enrolment_EventCategory
        FOREIGN KEY (EventCategoryID)
        REFERENCES EventCategory(EventCategoryID),

    CONSTRAINT FK_Enrolment_Participant
        FOREIGN KEY (ParticipantID)
        REFERENCES [User](UserID)
);
GO


-- ============================================
-- 8. CREATE RESULT
-- ============================================

CREATE TABLE Result (
    ResultID INT IDENTITY(1,1) PRIMARY KEY,
    EnrolmentID INT NOT NULL,
    FinishTime TIME,
    Position INT,
    Status VARCHAR(50),

    CONSTRAINT FK_Result_Enrolment
        FOREIGN KEY (EnrolmentID)
        REFERENCES Enrolment(EnrolmentID),

    CONSTRAINT UQ_Result_Enrolment
        UNIQUE (EnrolmentID)
);
GO


-- ============================================
-- 9. INSERT ROLES
-- ============================================

INSERT INTO Role (RoleName)
VALUES
('Organiser'),
('Participant');
GO


-- ============================================
-- 10. INSERT 2 ORGANISERS + 2 PARTICIPANTS
-- ============================================

INSERT INTO [User]
    (FirstName, LastName, Email, PasswordHash, RoleID)
VALUES
('Thabo', 'Mokoena', 'thabo@example.com', 'hashed_password_1', 1),
('Lerato', 'Dlamini', 'lerato@example.com', 'hashed_password_2', 1),
('Neo', 'Molefe', 'neo@example.com', 'hashed_password_3', 2),
('Amahle', 'Ndlovu', 'amahle@example.com', 'hashed_password_4', 2);
GO


-- ============================================
-- 11. INSERT CATEGORIES
-- ============================================

INSERT INTO Category (CategoryName)
VALUES
('5 KM Run'),
('10 KM Run'),
('Half Marathon');
GO


-- ============================================
-- 12. INSERT EVENTS
-- ============================================

INSERT INTO Event
    (EventName, EventDate, Location, Description, OrganiserID)
VALUES
(
    'Pretoria Race Day',
    '2026-10-10',
    'Pretoria',
    'Annual community running event.',
    1
),
(
    'Johannesburg City Run',
    '2026-11-15',
    'Johannesburg',
    'City running event for participants.',
    2
);
GO


-- ============================================
-- 13. LINK EVENTS TO CATEGORIES
-- ============================================

INSERT INTO EventCategory
    (EventID, CategoryID)
VALUES
(1, 1),
(1, 2),
(2, 2),
(2, 3);
GO


-- ============================================
-- 14. INSERT ENROLMENTS
-- ============================================

INSERT INTO Enrolment
    (EventCategoryID, ParticipantID, EnrolmentDate)
VALUES
(1, 3, '2026-09-01'),
(2, 4, '2026-09-02'),
(3, 3, '2026-09-03');
GO


-- ============================================
-- 15. INSERT RESULTS
-- ============================================

INSERT INTO Result
    (EnrolmentID, FinishTime, Position, Status)
VALUES
(1, '00:28:35', 1, 'Finished'),
(2, '00:58:42', 2, 'Finished');
GO


-- ============================================
-- 16. CHECK TABLES
-- ============================================

SELECT * FROM Role;
SELECT * FROM [User];
SELECT * FROM Event;
SELECT * FROM Category;
SELECT * FROM EventCategory;
SELECT * FROM Enrolment;
SELECT * FROM Result;
Go
USE RaceDay;

SELECT * FROM Role;
SELECT * FROM [User];
SELECT * FROM Event;
SELECT * FROM Category;
SELECT * FROM EventCategory;
SELECT * FROM Enrolment;
SELECT * FROM Result;
