USE GROUP_16;
DROP FUNCTION IF EXISTS dbo.GetPrescriptionTotalPrice;
GO

-- Creating a function to calculate total estimated price of a prescription, which includes prices of vaccines, medicines and tests--
--attached with each prescirption--
CREATE FUNCTION dbo.GetPrescriptionTotalPrice
(
    @PrescriptionId INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        SUM(COALESCE(V.Price, 0)) + SUM(COALESCE(T.Price, 0)) + SUM(COALESCE(M.Price, 0)) AS TotalPrice
    FROM
        Prescription_Vaccine PV
    FULL OUTER JOIN
        Prescription_Tests PT ON PV.Prescription_ID = PT.Prescription_ID
    FULL OUTER JOIN
        Prescription_Medicine PM ON PV.Prescription_ID = PM.Prescription_ID
    LEFT JOIN
        Vaccine V ON PV.Vaccine_ID = V.Vaccine_ID
    LEFT JOIN
        Test T ON PT.Test_ID = T.Test_ID
    LEFT JOIN
        Medicine M ON PM.Medicine_ID = M.Medicine_ID
    WHERE
        PV.Prescription_ID = @PrescriptionId
);
GO



--Creating a new column called EstimatedTotalPrice, and populating the value by passing the prescription ID to the function.
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Prescription' AND COLUMN_NAME = 'EstimatedTotalPrice')
BEGIN
    ALTER TABLE Prescription
    ADD EstimatedTotalPrice DECIMAL(10, 2);
END
GO
UPDATE Prescription
SET EstimatedTotalPrice = (SELECT TotalPrice FROM dbo.GetPrescriptionTotalPrice(Prescription_ID));
GO
--Displaying the updated columns with the populated values.
SELECT * FROM Prescription; 
