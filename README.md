                                                                  Task-8
                                                          Hospital Database SQL Script
 Description
This SQL script sets up a simple Hospital database to manage patient billing, especially for senior citizens who receive a discount on their bills.

 Database and Table
Database

CREATE DATABASE hospital;

USE hospital;

Creates and uses a database named hospital.

Table: Patients

CREATE TABLE Patients (

    PatientID INT PRIMARY KEY,
    
    Name VARCHAR(100),
    
    Age INT,
    
    BillAmount DECIMAL(10,2)
);

Stores basic patient information:

PatientID: Unique ID for each patient.

Name: Patient's name.

Age: Patient's age.

BillAmount: Total bill amount before or after discount.

Sample Data

INSERT INTO Patients VALUES
(1, 'karun Kumar', 70, 5000),

(2, 'lakshman', 30, 3000),

(3, 'Sita Rao', 68, 8000);

Inserts example patients with different ages and bills.

 Function: GetSeniorDiscount

CREATE FUNCTION GetSeniorDiscount(age INT, bill DECIMAL(10,2))

RETURNS DECIMAL(10,2)

Purpose

Calculates a 20% discount on the bill if the patient is a senior citizen (age ≥ 60).

Otherwise, no discount is applied.

Logic

IF age >= 60 THEN discount = bill * 0.20; ELSE discount = 0; END IF;

 Procedure: ApplyDiscount
 
CREATE PROCEDURE ApplyDiscount(IN pID INT)

Purpose

Applies the senior discount to a specific patient (by PatientID).

Updates the BillAmount field in the Patients table.

Returns a message showing:

Discount amount.

New bill after discount.

Steps

Gets patient's age and original bill.

Calculates discount using the GetSeniorDiscount() function.

Computes new bill amount.

Updates the patient's BillAmount.

Displays a success message with discount details.

 Usage Examples
 
Check discount amounts

SELECT Name, Age, BillAmount, GetSeniorDiscount(Age, BillAmount) AS Discount

FROM Patients;

Shows each patient's discount (without actually updating the bill).

Apply discount to a patient

CALL ApplyDiscount(1);

Applies discount to patient with PatientID = 1.

Updates their BillAmount.
