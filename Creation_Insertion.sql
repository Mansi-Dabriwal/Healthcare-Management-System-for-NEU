                                                     --DATABASE CREATION FOR OUR PROJECT--

IF NOT EXISTS (SELECT *
FROM sys.databases
WHERE name = 'GROUP_16')
BEGIN
    CREATE DATABASE GROUP_16;
END;

USE GROUP_16;


DROP TABLE IF EXISTS dbo.Test_Center_Inventory;
DROP TABLE IF EXISTS dbo.Test_Center;
DROP TABLE IF EXISTS dbo.Vaccine_Inventory;
DROP TABLE IF EXISTS dbo.Vaccine_Center;
DROP TABLE IF EXISTS dbo.Pharmacy_Medicine_Stock;
DROP TABLE IF EXISTS dbo.Pharmacy;
DROP TABLE IF EXISTS dbo.Address_Lookup;
DROP TABLE IF EXISTS dbo.Prescription_Tests;
DROP TABLE IF EXISTS dbo.Prescription_Medicine;
DROP TABLE IF EXISTS dbo.Prescription_Vaccine;
DROP TABLE IF EXISTS dbo.Test;
DROP TABLE IF EXISTS dbo.Vaccine;
DROP TABLE IF EXISTS dbo.Medicine;
DROP TABLE IF EXISTS dbo.Insurance_Claims;
DROP TABLE IF EXISTS dbo.Employee_Availibilty;
DROP TABLE IF EXISTS dbo.Appointment;
DROP TABLE IF EXISTS dbo.Prescription;
DROP TABLE IF EXISTS dbo.Employees;
DROP TABLE IF EXISTS dbo.Employee_Type_Lookup;
DROP TABLE IF EXISTS dbo.[User];
                                                      --TABLE CREATION--

--User Table--
CREATE TABLE [User] (
 User_ID INT PRIMARY KEY NOT NULL,
 First_Name VARCHAR (30) NOT NULL,
 Last_Name VARCHAR (30) NOT NULL,
 Date_of_Birth DATE NOT NULL,
 Phone_Number VARCHAR (30) NOT NULL,
 Gender VARCHAR (30) NOT NULL,
 Blood_Group VARCHAR (5) NOT NULL,
 Insurance_ID VARCHAR (30) NOT NULL,
 Age AS DATEDIFF(hour,Date_of_Birth,GETDATE())/8766);




--Employee Type Lookup Table--
CREATE TABLE Employee_Type_Lookup(
Employee_Type_ID INT PRIMARY KEY NOT NULL,
Designation VARCHAR (30) NOT NULL);

--Employee Table--
CREATE TABLE Employees(
Employee_ID INT PRIMARY KEY NOT NULL,
Husky_ID VARCHAR (30) NOT NULL,
First_Name VARCHAR (30) NOT NULL,
Last_Name VARCHAR (30) NOT NULL,
Gender VARCHAR (30) NOT NULL,
Phone_Number VARCHAR (30) NOT NULL,
Employee_Type_ID INT NOT NULL
FOREIGN KEY (Employee_Type_ID) REFERENCES Employee_Type_Lookup(Employee_Type_ID),
);


--Prescription Table --
CREATE TABLE Prescription (
  Prescription_ID INT PRIMARY KEY NOT NULL,
  Feedback VARCHAR(200) NOT NULL,
);

--Appointment Table--
CREATE TABLE Appointment(
 Appointment_ID INT PRIMARY KEY NOT NULL,
 User_ID INT NOT NULL,
 Employee_ID INT NOT NULL,
 Prescription_ID INT NOT NULL,
 [Date] DATE NOT NULL,
 [Time] TIME NOT NULL
  FOREIGN KEY ([User_ID]) REFERENCES [User]([User_ID]),
  FOREIGN KEY (Employee_ID) REFERENCES Employees(Employee_ID),
  FOREIGN KEY (Prescription_ID) REFERENCES Prescription(Prescription_ID),
);

--Employee Availability--
CREATE TABLE Employee_Availibilty(
Employee_Availaibity_ID INT PRIMARY KEY NOT NULL,
Employee_ID INT NOT NULL,
[Day] VARCHAR (30) NOT NULL,
Start_Time TIME NOT NULL,
End_Time TIME NOT NULL
FOREIGN KEY (Employee_ID) REFERENCES Employees(Employee_ID)
);


--Insurance Claim Table--
CREATE TABLE Insurance_Claims (
  Insurance_Claim_ID INT PRIMARY KEY NOT NULL,
  User_ID INT NOT NULL,
  Incident_Date DATE NOT NULL,
  Claimed_Date DATE NOT NULL,
  Claimed_Amount DECIMAL(10, 2) NOT NULL,
  Claimed_Status VARCHAR(50) NOT NULL,
  FOREIGN KEY (User_ID) REFERENCES [User](User_ID)
);

--Medicine Table--
CREATE TABLE Medicine(
    Medicine_ID INT PRIMARY KEY NOT NULL,
    Medicine_Name VARCHAR(50) NOT NULL,
    Medicine_Manufacturer VARCHAR(50) NOT NULL,
    Medicine_Manufacturing_Date DATE NOT NULL,
    Medicine_Product_Number INT NOT NULL,
    Medicine_Expiry_Date DATE NOT NULL,
    Price DECIMAL(10,2) NOT NULL
);


--Vaccine Table--
CREATE TABLE Vaccine (
    Vaccine_ID INT PRIMARY KEY NOT NULL,
    Vaccine_Name VARCHAR(50) NOT NULL,
    Vaccine_Manufacturer VARCHAR(50) NOT NULL,
    Vaccine_Manufacturing_Date DATE NOT NULL,
    Vacine_Production_Number INT NOT NULL,
    Vaccine_Expiry_Date DATE NOT NULL,
    Price DECIMAL(10,2) NOT NULL
);


--Tests Table--
CREATE TABLE Test (
	Test_ID INT PRIMARY KEY NOT NULL,
	Test_Name VARCHAR(100) NOT NULL,
	Price INT NOT NULL
);

--Prescription Vaccine Table--
 CREATE TABLE Prescription_Vaccine (
  Prescription_ID INT NOT NULL,
  Vaccine_ID INT NOT NULL,
  PRIMARY KEY (Prescription_ID, Vaccine_ID),
  FOREIGN KEY (Prescription_ID) REFERENCES Prescription(Prescription_ID),
  FOREIGN KEY (Vaccine_ID) REFERENCES Vaccine(Vaccine_ID)
);


--Prescription Medicine Table --
CREATE TABLE Prescription_Medicine (
  Prescription_ID INT NOT NULL,
  Medicine_ID INT NOT NULL,
  PRIMARY KEY (Prescription_ID, Medicine_ID),
  FOREIGN KEY (Prescription_ID) REFERENCES Prescription(Prescription_ID),
  FOREIGN KEY (Medicine_ID) REFERENCES Medicine(Medicine_ID)
);


--Prescription Test Table --
CREATE TABLE Prescription_Tests (
  Prescription_ID INT NOT NULL,
  Test_ID INT NOT NULL,
  PRIMARY KEY (Prescription_ID, Test_ID),
  FOREIGN KEY (Prescription_ID) REFERENCES Prescription(Prescription_ID),
  FOREIGN KEY (Test_ID) REFERENCES Test(Test_ID)
);

--Address Lookup Table--
CREATE TABLE Address_Lookup (
  Address_ID INT PRIMARY KEY NOT NULL,
  AddressLine_1 VARCHAR(100) NOT NULL,
  AddressLine_2 VARCHAR(100),
  City VARCHAR(50) NOT NULL,
  State VARCHAR(50) NOT NULL,
  Country VARCHAR(50) NOT NULL,
  ZipCode INT NOT NULL
);

--Pharmacy Table--
CREATE TABLE Pharmacy(
    Pharmacy_ID INT PRIMARY KEY NOT NULL,
    Name VARCHAR(50) NOT NULL,
    Address_ID INT NOT NULL,
  FOREIGN KEY (Address_ID) REFERENCES Address_Lookup(Address_ID));

--Pharmacy Medicine Stock Table--
CREATE TABLE Pharmacy_Medicine_Stock(
Pharmacy_ID INT NOT NULL,
Medicine_ID INT NOT NULL,
  PRIMARY KEY (Pharmacy_ID, Medicine_ID),
  FOREIGN KEY (Pharmacy_ID) REFERENCES Pharmacy(Pharmacy_ID),
  FOREIGN KEY (Medicine_ID ) REFERENCES Medicine(Medicine_ID)
);

---Vaccine Center Table--
CREATE TABLE Vaccine_Center (
  Vaccine_Center_ID INT PRIMARY KEY NOT NULL,
  Name VARCHAR(255) NOT NULL,
  Address_ID INT NOT NULL,
  FOREIGN KEY (Address_ID) REFERENCES Address_Lookup(Address_ID)
);


--Vaccine Inventory Table--
CREATE TABLE Vaccine_Inventory (
  Vaccine_Center_ID INT NOT NULL,
  Vaccine_ID INT NOT NULL,
  PRIMARY KEY (Vaccine_Center_ID, Vaccine_ID),
  FOREIGN KEY (Vaccine_Center_ID) REFERENCES Vaccine_Center(Vaccine_Center_ID),
  FOREIGN KEY (Vaccine_ID) REFERENCES Vaccine(Vaccine_ID)
);


--Test Center Table--
CREATE TABLE Test_Center (
	Testing_Center_ID INT PRIMARY KEY NOT NULL,
	Testing_Center_Name VARCHAR(100) NOT NULL,
	Address_ID INT NOT NULL,
	FOREIGN KEY (Address_ID) REFERENCES Address_Lookup(Address_ID)
);

--Test Center Inventory Table--
CREATE TABLE Test_Center_Inventory (
  Test_ID INT NOT NULL,
  Testing_Center_ID INT NOT NULL,
  PRIMARY KEY (Test_ID, Testing_Center_ID),
  FOREIGN KEY (Test_ID) REFERENCES Test(Test_ID),
  FOREIGN KEY (Testing_Center_ID) REFERENCES Test_Center(Testing_Center_ID)
);


                                                      --DATA INSERTION INTO THE TABLES--
--User Table Insertion--
DROP PROCEDURE IF EXISTS dbo.User_Table_Insertion;
GO
CREATE PROCEDURE User_Table_Insertion
    @User_ID INT,
    @First_Name VARCHAR (30),
    @Last_Name VARCHAR (30),
    @Date_of_Birth DATE,
    @Phone_Number VARCHAR (30),
    @Gender VARCHAR (30),
    @Blood_Group VARCHAR (5),
    @Insurance_ID VARCHAR (30)
AS
BEGIN

    INSERT INTO [User](User_ID, First_Name, Last_Name, Date_of_Birth, Phone_Number, Gender, Blood_Group, Insurance_ID)
    VALUES (@User_ID, @First_Name, @Last_Name, @Date_of_Birth, @Phone_Number, @Gender, @Blood_Group, @Insurance_ID);
END;
GO

EXEC User_Table_Insertion 1001,'Mansi','Dabriwal','04-07-1998','8573708868','Female','B+','A101';
EXEC User_Table_Insertion 1002,'Urvashi','Gupta','04-06-1999','8573468868','Female','B-','A102';
EXEC User_Table_Insertion 1003,'Atharva','Dhatingan','01-05-1997','9876543210','Male','A+','A103';
EXEC User_Table_Insertion 1004,'Urmika','Koul','05-01-1996','7776543210','Female','A-','A104';
EXEC User_Table_Insertion 1005,'Stuti','Ajmera','03-12-1995','7676543210','Female','AB+','A104';
EXEC User_Table_Insertion 1006,'Shrey','Sinha','12-12-1997','7876543210','Male','AB-','A104';
EXEC User_Table_Insertion 1007,'Ronak','Chougule','09-08-2000','7654321890','Male','O+','A104';
EXEC User_Table_Insertion 1008,'Mahima','Pawar','01-04-2001','8765432190','Female','A+','A104';
EXEC User_Table_Insertion 1009,'Shatabdi','Bhise','02-01-2005','9087654321','Female','O-','A104';
EXEC User_Table_Insertion 1010,'Animesh','Jain','05-01-1994','8907654321','Male','A+','A104';


--Employee Type Lookup Table Insertion--
DROP PROCEDURE IF EXISTS dbo.Employee_LookUp_Table_Insertion;
GO
CREATE PROCEDURE Employee_LookUp_Table_Insertion
    @Employee_Type_ID INT,
    @Designation VARCHAR (30)
        
AS
BEGIN

    INSERT INTO Employee_Type_Lookup(Employee_Type_ID,Designation)
    VALUES (@Employee_Type_ID,@Designation);
END;
GO

EXEC Employee_LookUp_Table_Insertion 001,'Doctor';
EXEC Employee_LookUp_Table_Insertion 002,'Nurse';
EXEC Employee_LookUp_Table_Insertion 003,'RSO Officer';
EXEC Employee_LookUp_Table_Insertion 004,'Technical Support';
EXEC Employee_LookUp_Table_Insertion 005,'Cleaning Staff';
EXEC Employee_LookUp_Table_Insertion 006,'Front Desk Manager';
EXEC Employee_LookUp_Table_Insertion 007,'Pharmacist';
EXEC Employee_LookUp_Table_Insertion 008,'Health Councillor';
EXEC Employee_LookUp_Table_Insertion 009,'Security Officer';
EXEC Employee_LookUp_Table_Insertion 010,'Psychiatrist';


--Employee Table Insertion--
DROP PROCEDURE IF EXISTS dbo.Employee_Table_Insertion;
GO
CREATE PROCEDURE Employee_Table_Insertion
    @Employee_ID INT,
    @Husky_ID VARCHAR (30),
    @First_Name VARCHAR (30),
    @Last_Name VARCHAR (30),
    @Gender VARCHAR (30),
    @Phone_Number VARCHAR (30),
    @Employee_Type_ID INT
    
AS
BEGIN

    INSERT INTO Employees(Employee_ID,Husky_ID,First_Name,Last_Name,Gender,Phone_Number,Employee_Type_ID)
    VALUES (@Employee_ID, @Husky_ID, @First_Name, @Last_Name, @Gender, @Phone_Number, @Employee_Type_ID);
END;
GO

EXEC Employee_Table_Insertion 1111,'002774233','Abhinav','Mishra','Male','9876543210',001; 
EXEC Employee_Table_Insertion 1112,'002774234','Mayank','Bansal','Male','8765432190',002; 
EXEC Employee_Table_Insertion 1113,'002774235','Diya','Garg','Non-Binary','7654321890',003; 
EXEC Employee_Table_Insertion 1114,'002774236','Aisha','Saraf','Female','9876543211',004; 
EXEC Employee_Table_Insertion 1115,'002774237','Hardik','Saraf','Male','8907654321',005; 
EXEC Employee_Table_Insertion 1116,'002774238','Naveen','Aggarwal','Non-Binary','7654321888',008; 
EXEC Employee_Table_Insertion 1117,'002774239','Anish','More','Male','9812345670',009; 
EXEC Employee_Table_Insertion 1118,'002774240','Deepasha','Aggarwal','Female','986754321',001; 
EXEC Employee_Table_Insertion 1119,'002774241','Harshit','Aggarwal','Non-Binary','8907654311',002; 
EXEC Employee_Table_Insertion 1110,'002774242','Tanu','More','Male','9432156777',002; 



--Prescription Table Insertion--
INSERT INTO Prescription (Prescription_ID, Feedback) 
VALUES (1111, 'Prescription verified and processed. Medication delivery scheduled for tomorrow.'), 
       (1121, 'Patient needs to take proper test for correct diagnosis.'), 
       (1131, '101 Degree Celsius Fever. Need to take proper rest and visit again after a week'), 
       (1141, 'Prescription filled and medication given to patient.'), 
       (1151, 'Patient needs to rest and complete medication cycle'), 
       (1161, 'X-ray scheduled for patient.'), 
       (1171, 'Patient is all well. Needs to take rest and visit after a week.'), 
       (1181, 'High fever and throat infection. Prescribed medication'), 
       (1191, 'Migraine Problem. Patient needs to sleep and take rest'), 
       (1110, 'Breathing problem because of pollution. Prescribed inhaler');


--Appointment Table Insertion--
DROP PROCEDURE IF EXISTS dbo.Appointment_Table_Insertion;
GO
CREATE PROCEDURE Appointment_Table_Insertion
    @Appointment_ID INT,
    @User_ID INT,
    @Employee_ID INT,
    @Prescription_ID INT,
    @Date DATE,
    @Time TIME
    
AS
BEGIN
    INSERT INTO Appointment(Appointment_ID, User_ID, Employee_ID, Prescription_ID, [Date],[Time])
    VALUES (@Appointment_ID, @User_ID, @Employee_ID, @Prescription_ID, @Date,@Time);
END;
GO

EXEC Appointment_Table_Insertion 1,1001,1111,1111,'01-02-2023','4:00PM';
EXEC Appointment_Table_Insertion 2,1002,1111,1121,'02-03-2023','5:00PM';
EXEC Appointment_Table_Insertion 3,1003,1111,1131,'03-04-2023','6:00PM';
EXEC Appointment_Table_Insertion 4,1004,1118,1141,'04-05-2023','7:00PM';
EXEC Appointment_Table_Insertion 5,1005,1118,1151,'05-06-2023','8:00AM';
EXEC Appointment_Table_Insertion 6,1006,1118,1161,'06-07-2023','9:00AM';
EXEC Appointment_Table_Insertion 7,1007,1112,1171,'07-08-2023','10:00AM';
EXEC Appointment_Table_Insertion 8,1008,1112,1181,'08-09-2023','1:00PM';
EXEC Appointment_Table_Insertion 9,1009,1119,1191,'09-10-2023','2:00PM';
EXEC Appointment_Table_Insertion 10,1010,1119,1110,'10-01-2023','3:00PM';



--Employee Availability Table--
INSERT INTO Employee_Availibilty(Employee_Availaibity_ID,Employee_ID,[Day],Start_Time,End_Time)
VALUES
(1,1111,'Monday','9:00AM','9:00PM'),
(2,1111,'Tuesday','9:00AM','9:00PM'),
(3,1118,'Wednesday','9:00AM','9:00PM'),
(4,1118,'Thursday','9:00AM','9:00PM'),
(5,1112,'Monday','9:00AM','9:00PM'),
(6,1112,'Tuesday','9:00AM','9:00PM'),
(7,1119,'Wednesday','9:00AM','9:00PM'),
(8,1119,'Thursday','9:00AM','9:00PM'),
(9,1111,'Friday','9:00AM','3:00PM'),
(10,1118,'Friday','3:00PM','9:00PM'),
(11,1119,'Friday','9:00AM','3:00PM'),
(12,1112,'Friday','3:00PM','9:00PM');


--Insurance Claims Table Insertion--
INSERT INTO Insurance_Claims (Insurance_Claim_ID, User_ID, Incident_Date, Claimed_Date, Claimed_Amount, Claimed_Status) 
VALUES 
(41, 1001, '2022-02-15', '2022-02-18', 1500.00, 'Pending'),
(42, 1002, '2022-01-05', '2022-01-07', 500.50, 'Approved'),
(43, 1001, '2022-04-01', '2022-04-03', 750.25, 'Rejected'),
(44, 1004, '2022-05-10', '2022-05-12', 250.00, 'Pending'),
(45, 1001, '2022-02-14', '2022-02-18', 1250.75, 'Approved'),
(46, 1006, '2022-06-22', '2022-06-25', 800.00, 'Pending'),
(47, 1001, '2022-07-19', '2022-07-22', 1500.00, 'Rejected'),
(48, 1008, '2022-09-05', '2022-09-08', 600.50, 'Pending'),
(49, 1009, '2022-11-14', '2022-11-17', 300.25, 'Approved'),
(50, 1010, '2022-12-31', '2023-01-02', 400.00, 'Pending'),
(51, 1007, '2022-12-31', '2023-03-04', 400.00, 'Approved'),
(52, 1008, '2022-12-31', '2023-05-06', 400.00, 'Rejected'),
(53, 1007, '2022-12-31', '2023-07-08', 400.00, 'Pending'),
(54, 1005, '2022-12-31', '2023-09-10', 400.00, 'Approved'),
(55, 1006, '2022-12-31', '2023-11-12', 400.00, 'Rejected');

--Medicine Table Insertion--
INSERT INTO Medicine(Medicine_ID,
Medicine_Name,
Medicine_Manufacturer,
Medicine_Manufacturing_Date,
Medicine_Product_Number,
Medicine_Expiry_Date,
Price
)
VALUES
(30,'Vicodin','Pfizer','2019-01-01', 1111, '2024-12-11',49.00),
(31,'Humira','AbbVie','2019-02-02', 2222, '2024-11-11',211.00),
(32,'Spikevax','Moderna','2018-03-04', 3333, '2025-09-10',110.23),
(33, 'Keytruda','Merck & Co.','2020-05-06', 4444, '2025-12-12',99.99),
(34, 'Eliquis','Bristol Myers Squibb','2020-03-03', 5555, '2024-01-02',49.99),
(35, 'Revlimid','Bristol Myers Squibb','2022-01-05', 6666, '2024-06-08',149.99),
(36, 'Imbruvica','Johnson & Johnson','2022-12-12', 7777, '2025-11-12',35.49),
(37, 'Stelara','Johnson & Johnson','2021-11-11', 8888, '2023-12-31',79.99),
(38, 'Eylea','Bayer','2020-08-09', 9999, '2023-11-21',15.99),
(39, 'Biktarvy','Gilead Sciences','2019-02-04', 0000, '2023-12-31',22.49);

--Vaccine Table Insertion--
INSERT INTO Vaccine (Vaccine_ID, Vaccine_Name, Vaccine_Manufacturer, Vaccine_Manufacturing_Date, Vacine_Production_Number, Vaccine_Expiry_Date, Price)
VALUES 
    (1, 'Moderna', 'Moderna Inc.', '2022-01-01', 12345, '2023-12-31', 100.00),
    (2, 'Pfizer', 'Pfizer Inc.', '2022-02-01', 23456, '2023-11-30', 90.00),
    (3, 'AstraZeneca', 'AstraZeneca plc', '2022-03-01', 34567, '2023-10-31', 50.00),
    (4, 'Johnson & Johnson', 'Johnson & Johnson', '2022-04-01', 45678, '2023-09-30', 70.00),
    (5, 'Sinovac', 'Sinovac Biotech', '2022-05-01', 56789, '2023-08-31', 30.00),
    (6, 'Sputnik V', 'Gamaleya Research Institute', '2022-06-01', 67890, '2023-07-31', 40.00),
    (7, 'Novavax', 'Novavax Inc.', '2022-07-01', 78901, '2023-06-30', 80.00),
    (8, 'Covovax', 'Serum Institute of India', '2022-08-01', 89012, '2023-05-31', 60.00),
    (9, 'Covishield', 'Serum Institute of India', '2022-09-01', 90123, '2023-04-30', 40.00),
    (10, 'EpiVacCorona', 'Vector Institute', '2022-10-01', 12345, '2023-03-31', 20.00);

--Test Table Insertion--
INSERT INTO Test (Test_ID, Test_Name, Price) 
VALUES (1, 'Blood Glucose Test', 129),
(2, 'Complete Blood Count (CBC)', 250),
(3, 'Cholesterol Test', 60),
(4, 'Thyroid Function Test', 200),
(5, 'HIV Test', 100),
(6, 'MRI Scan', 2000),
(7, 'X-Ray', 1000),
(8, 'Ultrasound', 1250),
(9, 'Electrocardiogram (ECG)', 2500),
(10, 'Pap Smear', 1250);


--Prescription Vaccine--
INSERT INTO Prescription_Vaccine  (Prescription_ID, Vaccine_ID)
VALUES 
    (1111, 1),
	(1111, 3),
    (1121, 2),
    (1131, 1),
    (1141, 4),
    (1151, 3),
	(1151, 2),
    (1161, 1),
    (1171, 7),
    (1181, 2),
	(1181, 4),
    (1191, 2),
    (1110, 1);

--Prescription Medicine--
INSERT INTO Prescription_Medicine (Prescription_ID, Medicine_ID)
VALUES 
    (1111, 30),
    (1121, 30),
    (1131, 31),
    (1141, 32),
    (1151, 33),
    (1161, 34),
    (1171, 36),
    (1181, 38),
    (1191, 39),
    (1110, 33);

--Prescription Test--
INSERT INTO Prescription_Tests (Prescription_ID, Test_ID)
VALUES 
    (1111, 1),
    (1121, 2),
    (1131, 3),
    (1141, 4),
    (1151, 5),
	(1151, 9),
    (1161, 6),
	(1161, 2),
    (1171, 7),
    (1181, 8),
	(1181, 1),
    (1191, 9),
    (1110, 10),
	(1110, 6);

--Address Lookup Table--
INSERT INTO Address_Lookup(Address_ID, AddressLine_1, AddressLine_2, City, State, Country, ZipCode)
VALUES
(101, '456 Elm St', 'Apt 3C', 'Los Angeles', 'CA', 'USA', '90001'),
(102, '789 Oak Ave', NULL, 'San Francisco', 'CA', 'USA', '94102'),
(103, '321 Maple Blvd', 'Suite 100', 'Lowell', 'MA', 'USA', '02953'),
(104, '555 Pine St', 'Suite 245', 'Cambridge', 'MA', 'USA', '027854'),
(105, '999 Cedar Rd', 'Unit B', 'Boston', 'MA', 'USA', '02108'),
(106, '777 Walnut St', 'Apt 5A', 'Newton', 'MA', 'USA', '02456'),
(107, '111 Oak St', NULL, 'Austin', 'TX', 'USA', '78701'),
(108, '222 Maple Ave', 'Unit 200', 'Atlanta', 'GA', 'USA', '30303'),
(109, '444 Elm St', NULL, 'Denver', 'CO', 'USA', '80202'),
(110, '888 Pine Rd', 'Apt 1B', 'Portland', 'OR', 'USA', '97201');


--Pharmacy Table--
INSERT INTO Pharmacy(Pharmacy_ID, Name, Address_ID)
VALUES
(201,'Walgreens', 101),
(202,'CVS',102),
(203,'Cigna',103),
(204,'UnitedHealth Group',104),
(205,'Kroger Company',101),
(206,'Humana',106),
(207,'Publix',102),
(208,'Costco Wholesale Corporation',108),
(209,'Albertsons Companies',109),
(210,'Centene',107);

--Pharmacy Medicine Stock--
INSERT INTO Pharmacy_Medicine_Stock(Pharmacy_ID,Medicine_ID)
VALUES
(201,30),
(201,31),
(201,32),
(202,34),
(202,35),
(202,30),
(203,36),
(203,37),
(203,38),
(204,30),
(204,31),
(204,32),
(205,39),
(205,34),
(205,35);

--Vacine Center Tables--
INSERT INTO Vaccine_Center (Vaccine_Center_ID, Name, Address_ID)
VALUES 
    (21, 'Community Health Center', 101),
    (22, 'City Hospital', 102),
    (23, 'Rhode Vaccination Center', 105),
    (24, 'Regional Health Center', 101),
    (25, 'General Hospital', 101),
    (26, 'Boston Urgent Care Center', 104),
    (27, 'Family Health Center', 107),
    (28, 'Rhode Pediatric Clinic', 105),
    (29, 'CBS Medical Group', 109),
    (30, 'Specialty Hospital', 110);

--Vaccine Inventory--
INSERT INTO Vaccine_Inventory (Vaccine_Center_ID, Vaccine_ID)
VALUES 
    (21, 1),
    (22, 2),
    (23, 3),
    (24, 4),
    (25, 5),
    (26, 6),
    (27, 7),
    (28, 8),
    (29, 9),
    (30, 10);

--Test Center Insertion--
INSERT INTO Test_Center (Testing_Center_ID, Testing_Center_Name, Address_ID) VALUES
(51, 'New Medical Lab', 101),
(52, 'ABC Diagnostics', 102),
(53, 'Sunshine Medical Imaging', 102),
(54, 'Heart Health Services', 106),
(55, 'Top Clinical Labs', 105),
(56, 'Healthline Diagnostics', 108),
(57, 'Sunrise Medical Lab', 107),
(58, 'Global Imaging Center', 108),
(59, 'City Clinical Lab', 109),
(50, 'Metropolis Diagnostic Center', 110);

--Test Center Inventory--
INSERT INTO Test_Center_Inventory (Test_ID, Testing_Center_ID)
VALUES 
    (1, 51),
    (2, 52),
    (3, 53),
    (4, 51),
    (5, 52),
    (6, 54),
    (7, 55),
    (8, 56),
    (9, 56),
    (10, 57),
	(1, 58),
	(2, 59),
    (3, 50);