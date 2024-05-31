                                                              --VIEWS--
USE GROUP_16;
DROP VIEW IF EXISTS dbo.MA_Centers;
GO

--Creating View to display All vaccine centers, Pharmacies, and Testing Centers located in the State 'MA'--
CREATE VIEW MA_Centers AS
SELECT Vaccine_Center.Vaccine_Center_ID, Vaccine_Center.Name AS Center_Name, Address_Lookup.AddressLine_1, Address_Lookup.AddressLine_2, Address_Lookup.City, Address_Lookup.ZipCode, 'Vaccine Center' AS Center_Type
FROM Vaccine_Center
INNER JOIN Address_Lookup ON Vaccine_Center.Address_ID = Address_Lookup.Address_ID
WHERE Address_Lookup.State = 'MA'

UNION

SELECT Pharmacy.Pharmacy_ID, Pharmacy.Name AS Center_Name, Address_Lookup.AddressLine_1, Address_Lookup.AddressLine_2, Address_Lookup.City, Address_Lookup.ZipCode, 'Pharmacy' AS Center_Type
FROM Pharmacy
INNER JOIN Address_Lookup ON Pharmacy.Address_ID = Address_Lookup.Address_ID
WHERE Address_Lookup.State = 'MA'

UNION

SELECT Test_Center.Testing_Center_ID, Test_Center.Testing_Center_Name AS Center_Name, Address_Lookup.AddressLine_1, Address_Lookup.AddressLine_2, Address_Lookup.City, Address_Lookup.ZipCode, 'Test Center' AS Center_Type
FROM Test_Center
INNER JOIN Address_Lookup ON Test_Center.Address_ID = Address_Lookup.Address_ID
WHERE Address_Lookup.State = 'MA';
GO

SELECT * FROM MA_Centers; 

DROP VIEW IF EXISTS dbo.Moderna_Vaccinated;
GO
CREATE VIEW Moderna_Vaccinated AS
SELECT u.First_name, u.Last_name, u.Date_of_Birth, u.Phone_Number
FROM [USER] u
INNER JOIN Appointment a ON u.User_ID = a.User_ID
INNER JOIN Prescription_Vaccine pv ON a.Prescription_ID = pv.Prescription_ID
INNER JOIN Vaccine v ON pv.Vaccine_ID = v.Vaccine_ID
WHERE v.Vaccine_Name = 'Moderna';
GO

SELECT * from Moderna_Vaccinated







