USE GROUP_16;
                                              --Table Level Check Based Function for USERS TABLE--
--Adding Function Based Column Check on USER--

ALTER TABLE [User]
DROP CONSTRAINT IF EXISTS CheckValidFirstNames;

ALTER TABLE [User]
DROP CONSTRAINT IF EXISTS CheckValidLastNames;

DROP FUNCTION IF EXISTS dbo.CheckValidFirstName;
DROP FUNCTION IF EXISTS dbo.CheckValidLastName;

GO


--Creating a function that performs a Column Check on First Name to check if it contians only Alphabets.
CREATE FUNCTION CheckValidFirstName(@FName varchar(30))
RETURNS smallint
AS
BEGIN
   DECLARE @Count smallint=0;
   SELECT @Count = COUNT(First_Name)
          FROM [User]
          WHERE First_Name = @FName
          AND First_Name LIKE '%[^a-zA-Z]%' OR First_Name = '';
   RETURN @Count;
END;

GO

--Creating a function that performs a Column Check on Last Name to check if it contians only Alphabets.
CREATE FUNCTION CheckValidLastName(@LName varchar(30))
RETURNS smallint
AS
BEGIN
   DECLARE @Count smallint=0;
   SELECT @Count = COUNT(Last_Name)
          FROM [User]
          WHERE Last_Name = @LName
          AND Last_Name LIKE '%[^a-zA-Z]%' OR Last_Name = '';
   RETURN @Count;
END;

GO

--Adding the constraints to the User table--
ALTER TABLE [User] ADD CONSTRAINT CheckValidFirstNames CHECK (dbo.CheckValidFirstName(First_Name) = 0);
ALTER TABLE [User] ADD CONSTRAINT CheckValidLastNames CHECK (dbo.CheckValidLastName(Last_Name) = 0);


--Testing the Function By Inserting Invalid First Names--
INSERT INTO [User](User_ID, First_Name, Last_Name, Date_of_Birth, Phone_Number, Gender, Blood_Group, Insurance_ID)
VALUES
(2008,'','Thiagarajan','04-12-1997','8248598448','Male','A+','A201');

INSERT INTO [User](User_ID, First_Name, Last_Name, Date_of_Birth, Phone_Number, Gender, Blood_Group, Insurance_ID)
VALUES
(2008,'Kiruba6a87','Thiagarajan','04-12-1997','8248598448','Male','A+','A201');

INSERT INTO [User](User_ID, First_Name, Last_Name, Date_of_Birth, Phone_Number, Gender, Blood_Group, Insurance_ID)
VALUES
(2008,'Kiruba%&*gar','Thiagarajan','04-12-1997','8248598448','Male','A+','A201');


--Testing the Function By Inserting Invalid Last Names--
INSERT INTO [User](User_ID, First_Name, Last_Name, Date_of_Birth, Phone_Number, Gender, Blood_Group, Insurance_ID)
VALUES
(2008,'Kirubagar','Thiagar6jan','04-12-1997','8248598448','Male','A+','A201');

INSERT INTO [User](User_ID, First_Name, Last_Name, Date_of_Birth, Phone_Number, Gender, Blood_Group, Insurance_ID)
VALUES
(2008,'Kirubagar','Thiaga#r%ajan','04-12-1997','8248598448','Male','A+','A201');

INSERT INTO [User](User_ID, First_Name, Last_Name, Date_of_Birth, Phone_Number, Gender, Blood_Group, Insurance_ID)
VALUES
(2008,'Kirubagar','','04-12-1997','8248598448','Male','A+','A201');


                                               --Table Level Check Based Function for EMPLOYEES TABLE--


ALTER TABLE Employees
DROP CONSTRAINT IF EXISTS CheckValidEmployeeFirstNames;

ALTER TABLE Employees
DROP CONSTRAINT IF EXISTS CheckValidEmployeeLastNames;

ALTER TABLE Employees
DROP CONSTRAINT IF EXISTS CheckValidHusky_ID;

DROP FUNCTION IF EXISTS dbo.CheckValidEmployeeFirstName;
DROP FUNCTION IF EXISTS dbo.CheckValidEmployeeLastName;
DROP FUNCTION IF EXISTS dbo.CountInvalidHuskyIDs;

GO

--Creating a function that performs a Column Check on First Name to check if it contians only Alphabets.
CREATE FUNCTION CheckValidEmployeeFirstName(@FName varchar(30))
RETURNS smallint
AS
BEGIN
   DECLARE @Count smallint=0;
   SELECT @Count = COUNT(First_Name)
          FROM Employees
          WHERE First_Name = @FName
          AND First_Name LIKE '%[^a-zA-Z]%' OR First_Name = '';
   RETURN @Count;
END;


GO

--Creating a function that performs a Column Check on Last Name to check if it contians only Alphabets.
CREATE FUNCTION CheckValidEmployeeLastName(@LName varchar(30))
RETURNS smallint
AS
BEGIN
   DECLARE @Count smallint=0;
   SELECT @Count = COUNT(Last_Name)
          FROM Employees
          WHERE Last_Name = @LName
          AND Last_Name LIKE '%[^a-zA-Z]%' OR Last_Name = '';
   RETURN @Count;
END;

GO

--Adding the constraints to the Employee table--
ALTER TABLE Employees ADD CONSTRAINT CheckValidEmployeeFirstNames CHECK (dbo.CheckValidEmployeeFirstName(First_Name) = 0);
ALTER TABLE Employees ADD CONSTRAINT CheckValidEmployeeLastNames CHECK (dbo.CheckValidEmployeeLastName(Last_Name) = 0);

GO

--Testing the Function By Inserting Invalid First Names--
INSERT INTO Employees(Employee_ID,Husky_ID,First_Name,Last_Name,Gender,Phone_Number,Employee_Type_ID)
VALUES
(2222,'002774233','Dan1e1','Craig','Male','9876543210',001);

INSERT INTO Employees(Employee_ID,Husky_ID,First_Name,Last_Name,Gender,Phone_Number,Employee_Type_ID)
VALUES
(2222,'002774233','Dan$ie*l%','Mishra','Male','9876543210',001);

INSERT INTO Employees(Employee_ID,Husky_ID,First_Name,Last_Name,Gender,Phone_Number,Employee_Type_ID)
VALUES
(2222,'002774233','','Craig','Male','9876543210',001);


--Testing the Function By Inserting Invalid Last Names--
INSERT INTO Employees(Employee_ID,Husky_ID,First_Name,Last_Name,Gender,Phone_Number,Employee_Type_ID)
VALUES
(2222,'002774233','Daniel','Cra19','Male','9876543210',001);

INSERT INTO Employees(Employee_ID,Husky_ID,First_Name,Last_Name,Gender,Phone_Number,Employee_Type_ID)
VALUES
(2222,'002774233','Daniel','Cr@!ag','Male','9876543210',001);

INSERT INTO Employees(Employee_ID,Husky_ID,First_Name,Last_Name,Gender,Phone_Number,Employee_Type_ID)
VALUES
(2222,'002774233','Daniel','','Male','9876543210',001);



--Creating a function that checks if the husky ID is valid (9 digit number starting with 2 0's)--
GO
CREATE FUNCTION CountInvalidHuskyIDs()
RETURNS smallint
AS
BEGIN
   DECLARE @Count smallint=0;
   SELECT @Count = COUNT(Husky_ID)
          FROM Employees
          WHERE LEN(Husky_ID) != 9
          OR Husky_ID NOT LIKE '%00[0-9][0-9][0-9][0-9][0-9][0-9][0-9]%'
   RETURN @Count;
END;

GO

--Testing by inserting invalid values--
ALTER TABLE Employees ADD CONSTRAINT CheckValidHusky_ID CHECK (dbo.CountInvalidHuskyIDs()=0);

INSERT INTO Employees(Employee_ID,Husky_ID,First_Name,Last_Name,Gender,Phone_Number,Employee_Type_ID)
VALUES
(2228,'qwertyujik','Daniel','Craig','Male','9876543210',001);

select * from Employees;

INSERT INTO Employees(Employee_ID,Husky_ID,First_Name,Last_Name,Gender,Phone_Number,Employee_Type_ID)
VALUES
(2221,'!@#456789','Daniel','Craig','Male','9876543210',001);


