create database hospital;
use hospital;
-- Table
CREATE TABLE Patients (
    PatientID INT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT,
    BillAmount DECIMAL(10,2)
);

INSERT INTO Patients VALUES
(1, 'karun Kumar', 70, 5000),
(2, 'lakshman', 30, 3000),
(3, 'Sita Rao', 68, 8000);

-- Function
DELIMITER //

CREATE FUNCTION GetSeniorDiscount(age INT, bill DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE discount DECIMAL(10,2);
    
    IF age >= 60 THEN
        SET discount = bill * 0.20;
    ELSE
        SET discount = 0;
    END IF;
    
    RETURN discount;
END //

-- Procedure
CREATE PROCEDURE ApplyDiscount(IN pID INT)
BEGIN
    DECLARE patientAge INT;
    DECLARE originalBill DECIMAL(10,2);
    DECLARE discount DECIMAL(10,2);
    DECLARE newBill DECIMAL(10,2);
    
    SELECT Age, BillAmount INTO patientAge, originalBill
    FROM Patients WHERE PatientID = pID;
    
    SET discount = GetSeniorDiscount(patientAge, originalBill);
    SET newBill = originalBill - discount;
    
    UPDATE Patients SET BillAmount = newBill WHERE PatientID = pID;
    
    SELECT CONCAT('Discount applied: ₹', discount, ', New bill: ₹', newBill) AS Message;
END //

DELIMITER ;

-- Example usage
SELECT Name, Age, BillAmount, GetSeniorDiscount(Age, BillAmount) AS Discount FROM Patients;

CALL ApplyDiscount(1);
