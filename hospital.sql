
-- HOSPITAL MANAGEMENT SYSTEM  (MySQL 8.0+)
-- Based on the ER diagram: Department, Doctor, Patient,
-- Appointment, Treatment, Medicine, Prescription, Room,
-- Admission, Bill
-- ==========================================================
 
-- ----------------------------------------------------------
-- 1. DDL : CREATE DATABASE AND TABLES
-- ----------------------------------------------------------
DROP DATABASE IF EXISTS Hospital_Management_System;
CREATE DATABASE Hospital_Management_System;
USE Hospital_Management_System;
 
CREATE TABLE Department (
    Department_ID   INT PRIMARY KEY AUTO_INCREMENT,
    Department_Name VARCHAR(100) NOT NULL,
    Location        VARCHAR(100),
    Contact_Number  VARCHAR(15)
);
 
CREATE TABLE Doctor (
    Doctor_ID      INT PRIMARY KEY AUTO_INCREMENT,
    Doctor_Name    VARCHAR(100) NOT NULL,
    Specialization VARCHAR(50),
    Phone          VARCHAR(15),
    Email          VARCHAR(100),
    Department_ID  INT,
    CONSTRAINT FK_Doctor_Department
        FOREIGN KEY (Department_ID)
        REFERENCES Department(Department_ID)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);
 
CREATE TABLE Patient (
    Patient_ID   INT PRIMARY KEY AUTO_INCREMENT,
    Patient_Name VARCHAR(100) NOT NULL,
    Age          INT,
    Gender       VARCHAR(10),
    Phone        VARCHAR(15),
    Address      VARCHAR(150),
    Blood_Group  VARCHAR(5)
);
 
CREATE TABLE Appointment (
    Appointment_ID   INT PRIMARY KEY AUTO_INCREMENT,
    Patient_ID       INT NOT NULL,
    Doctor_ID        INT NOT NULL,
    Appointment_Date DATE,
    Appointment_Time TIME,
    Status           VARCHAR(20),
    CONSTRAINT FK_Appointment_Patient
        FOREIGN KEY (Patient_ID)
        REFERENCES Patient(Patient_ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT FK_Appointment_Doctor
        FOREIGN KEY (Doctor_ID)
        REFERENCES Doctor(Doctor_ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);
 
CREATE TABLE Treatment (
    Treatment_ID   INT PRIMARY KEY AUTO_INCREMENT,
    Patient_ID     INT NOT NULL,
    Doctor_ID      INT NOT NULL,
    Diagnosis      VARCHAR(150),
    Treatment_Date DATE,
    Description    VARCHAR(250),
    CONSTRAINT FK_Treatment_Patient
        FOREIGN KEY (Patient_ID)
        REFERENCES Patient(Patient_ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT FK_Treatment_Doctor
        FOREIGN KEY (Doctor_ID)
        REFERENCES Doctor(Doctor_ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);
 
CREATE TABLE Medicine (
    Medicine_ID   INT PRIMARY KEY AUTO_INCREMENT,
    Medicine_Name VARCHAR(100) NOT NULL,
    Category      VARCHAR(50),
    Quantity      INT DEFAULT 0,
    Price         DECIMAL(10,2),
    Expiry_Date   DATE
);
 
CREATE TABLE Prescription (
    Prescription_ID INT PRIMARY KEY AUTO_INCREMENT,
    Treatment_ID    INT NOT NULL,
    Medicine_ID     INT NOT NULL,
    Dosage          VARCHAR(50),
    Duration        VARCHAR(50),
    CONSTRAINT FK_Prescription_Treatment
        FOREIGN KEY (Treatment_ID)
        REFERENCES Treatment(Treatment_ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT FK_Prescription_Medicine
        FOREIGN KEY (Medicine_ID)
        REFERENCES Medicine(Medicine_ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);
 
CREATE TABLE Room (
    Room_ID     INT PRIMARY KEY AUTO_INCREMENT,
    Room_Number VARCHAR(20) NOT NULL UNIQUE,
    Room_Type   VARCHAR(50),
    Floor       INT,
    Status      VARCHAR(20)
);
 
CREATE TABLE Admission (
    Admission_ID   INT PRIMARY KEY AUTO_INCREMENT,
    Patient_ID     INT NOT NULL,
    Room_ID        INT NOT NULL,
    Admit_Date     DATE,
    Discharge_Date DATE,
    Status         VARCHAR(20),
    CONSTRAINT FK_Admission_Patient
        FOREIGN KEY (Patient_ID)
        REFERENCES Patient(Patient_ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT FK_Admission_Room
        FOREIGN KEY (Room_ID)
        REFERENCES Room(Room_ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);
 
CREATE TABLE Bill (
    Bill_ID        INT PRIMARY KEY AUTO_INCREMENT,
    Admission_ID   INT NOT NULL,
    Bill_Date      DATE,
    Total_Amount   DECIMAL(10,2),
    Payment_Method VARCHAR(30),
    Payment_Status VARCHAR(20),
    CONSTRAINT FK_Bill_Admission
        FOREIGN KEY (Admission_ID)
        REFERENCES Admission(Admission_ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);
 
-- DDL : ALTER TABLE (add a new column)
ALTER TABLE Patient ADD Email VARCHAR(100);
 
-- ----------------------------------------------------------
-- 2. DML : INSERT  (10-15 rows per table, parents first)
-- ----------------------------------------------------------
INSERT INTO Department(Department_Name, Location, Contact_Number) VALUES
('Cardiology',       'Block A', '9000000001'),
('Neurology',        'Block B', '9000000002'),
('Orthopedics',      'Block C', '9000000003'),
('Pediatrics',       'Block D', '9000000004'),
('General Medicine', 'Block E', '9000000005'),
('Dermatology',      'Block F', '9000000006'),
('ENT',              'Block G', '9000000007'),
('Gynecology',       'Block H', '9000000008'),
('Urology',          'Block I', '9000000009'),
('Oncology',         'Block J', '9000000010');
 
INSERT INTO Doctor(Doctor_Name, Specialization, Phone, Email, Department_ID) VALUES
('Dr. Ramesh Kumar',   'Cardiologist',       '9811111101', 'ramesh.kumar@hms.com',   1),
('Dr. Suresh Rao',     'Neurologist',        '9811111102', 'suresh.rao@hms.com',     2),
('Dr. Anil Sharma',    'Orthopedic Surgeon', '9811111103', 'anil.sharma@hms.com',    3),
('Dr. Lakshmi Devi',   'Pediatrician',       '9811111104', 'lakshmi.devi@hms.com',   4),
('Dr. Meena Reddy',    'General Physician',  '9811111105', 'meena.reddy@hms.com',    5),
('Dr. Deepa Menon',    'Dermatologist',      '9811111106', 'deepa.menon@hms.com',    6),
('Dr. Arun Pillai',    'ENT Specialist',     '9811111107', 'arun.pillai@hms.com',    7),
('Dr. Kavya Reddy',    'Gynecologist',       '9811111108', 'kavya.reddy@hms.com',    8),
('Dr. Manoj Verma',    'Urologist',          '9811111109', 'manoj.verma@hms.com',    9),
('Dr. Sindhu Rao',     'Oncologist',         '9811111110', 'sindhu.rao@hms.com',    10),
('Dr. Rajesh Chowdary','Cardiologist',       '9811111111', 'rajesh.chowdary@hms.com',1),
('Dr. Neha Kapoor',    'Orthopedic Surgeon', '9811111112', 'neha.kapoor@hms.com',    3);
 
INSERT INTO Patient(Patient_Name, Age, Gender, Phone, Address, Blood_Group) VALUES
('Rahul Sharma',   31, 'Male',   '9876543210', 'Hyderabad',     'O+'),
('Priya Reddy',    28, 'Female', '9876543211', 'Vijayawada',    'A+'),
('Arjun Kumar',    36, 'Male',   '9876543212', 'Guntur',        'B+'),
('Sneha Rao',      25, 'Female', '9876543213', 'Warangal',      'AB+'),
('Kiran Kumar',    41, 'Male',   '9876543214', 'Hyderabad',     'O-'),
('Anjali Singh',   29, 'Female', '9876543215', 'Visakhapatnam', 'A-'),
('Vijay Kumar',    52, 'Male',   '9876543216', 'Chennai',       'O+'),
('Pooja Iyer',     21, 'Female', '9876543217', 'Bangalore',     'A-'),
('Sanjay Patil',   38, 'Male',   '9876543218', 'Mumbai',        'B+'),
('Kavitha Naidu',  60, 'Female', '9876543219', 'Warangal',      'O+'),
('Ramesh Babu',    68, 'Male',   '9876543220', 'Rajahmundry',   'A+'),
('Swathi Reddy',   27, 'Female', '9876543221', 'Anantapur',     'B-'),
('Naveen Krishna', 34, 'Male',   '9876543222', 'Kadapa',        'AB+'),
('Anjali Menon',   33, 'Female', '9876543223', 'Kochi',         'AB-'),
('Mohammed Ali',   30, 'Male',   '9876543224', 'Kurnool',       'O-');
 
INSERT INTO Appointment(Patient_ID, Doctor_ID, Appointment_Date, Appointment_Time, Status) VALUES
(1,  1,  '2026-10-01', '10:00:00', 'Scheduled'),
(2,  4,  '2026-10-01', '11:30:00', 'Completed'),
(3,  3,  '2026-10-02', '09:00:00', 'Completed'),
(4,  2,  '2026-10-02', '14:00:00', 'Scheduled'),
(5,  5,  '2026-10-03', '10:30:00', 'Cancelled'),
(6,  1,  '2026-10-03', '16:00:00', 'Scheduled'),
(7,  11, '2026-10-04', '09:30:00', 'Completed'),
(8,  7,  '2026-10-04', '13:15:00', 'Scheduled'),
(9,  9,  '2026-10-05', '10:00:00', 'Completed'),
(10, 12, '2026-10-05', '12:00:00', 'Completed'),
(11, 10, '2026-10-06', '11:00:00', 'Scheduled'),
(12, 8,  '2026-10-06', '15:00:00', 'Scheduled'),
(13, 6,  '2026-10-07', '10:45:00', 'Cancelled'),
(14, 4,  '2026-10-07', '16:30:00', 'Scheduled'),
(15, 5,  '2026-10-08', '09:15:00', 'Scheduled');
 
INSERT INTO Treatment(Patient_ID, Doctor_ID, Diagnosis, Treatment_Date, Description) VALUES
(1,  1,  'Hypertension',     '2026-10-01', 'BP monitoring and medication'),
(2,  4,  'Viral Fever',      '2026-10-01', 'Rest and fever medication'),
(3,  3,  'Knee Fracture',    '2026-10-02', 'Cast and physiotherapy'),
(4,  2,  'Migraine',         '2026-10-02', 'Neurological check and medication'),
(5,  5,  'Seasonal Flu',     '2026-10-03', 'Symptomatic treatment'),
(7,  11, 'Chest Pain',       '2026-10-04', 'ECG and cardiac medication'),
(9,  9,  'Kidney Stone',     '2026-10-05', 'Scan and pain management'),
(10, 12, 'Hip Fracture',     '2026-10-05', 'Surgery and follow-up care'),
(11, 10, 'Cancer Screening', '2026-10-06', 'Screening tests and consultation'),
(12, 8,  'Prenatal Checkup', '2026-10-06', 'Routine checkup and supplements'),
(8,  7,  'Ear Infection',    '2026-10-04', 'Antibiotic course'),
(6,  6,  'Skin Allergy',     '2026-10-03', 'Antihistamine and skin care');
 
INSERT INTO Medicine(Medicine_Name, Category, Quantity, Price, Expiry_Date) VALUES
('Paracetamol',  'Analgesic',     200, 20.00, '2028-03-31'),
('Amlodipine',   'Cardiac',       150, 35.00, '2028-06-30'),
('Ibuprofen',    'Analgesic',     180, 25.00, '2027-12-31'),
('Sumatriptan',  'Neurological',   60, 90.00, '2027-09-30'),
('Cetirizine',   'Antihistamine',  80, 15.00, '2028-01-31'),
('Amoxicillin',  'Antibiotic',    300, 45.00, '2027-11-30'),
('Atorvastatin', 'Cardiac',       120, 60.00, '2028-08-31'),
('Omeprazole',   'Gastric',        90, 40.00, '2028-02-28'),
('Azithromycin', 'Antibiotic',     70, 55.00, '2027-10-31'),
('Vitamin D3',   'Supplement',    250, 30.00, '2028-05-31'),
('Metformin',    'Antidiabetic',  160, 35.00, '2028-04-30'),
('Diclofenac',   'Analgesic',     110, 28.00, '2027-12-15');
 
INSERT INTO Prescription(Treatment_ID, Medicine_ID, Dosage, Duration) VALUES
(1,  2,  '1 tablet daily',        '30 days'),
(1,  7,  '1 tablet after dinner', '30 days'),
(2,  1,  '1 tablet thrice a day', '3 days'),
(3,  3,  '1 tablet after food',   '10 days'),
(3,  1,  '1 tablet twice a day',  '5 days'),
(4,  4,  '1 tablet when needed',  '7 days'),
(5,  5,  '1 tablet at night',     '5 days'),
(6,  7,  '1 tablet after dinner', '30 days'),
(7,  12, '1 tablet twice a day',  '7 days'),
(8,  3,  '1 tablet after food',   '10 days'),
(8,  8,  '1 tablet before food',  '14 days'),
(9,  10, '1 tablet daily',        '60 days'),
(10, 10, '1 tablet daily',        '60 days'),
(11, 9,  '1 tablet daily',        '5 days'),
(12, 5,  '1 tablet at night',     '7 days');
 
INSERT INTO Room(Room_Number, Room_Type, Floor, Status) VALUES
('101',   'General',           1, 'Occupied'),
('102',   'Private',           1, 'Available'),
('ICU-1', 'ICU',               2, 'Occupied'),
('201',   'Private',           2, 'Available'),
('103',   'General',           1, 'Available'),
('104',   'General',           1, 'Occupied'),
('105',   'Private',           1, 'Occupied'),
('ICU-2', 'ICU',               2, 'Available'),
('OT-1',  'Operation Theatre', 3, 'Available'),
('202',   'Private',           2, 'Available'),
('203',   'General',           2, 'Occupied'),
('301',   'Private',           3, 'Available');
 
INSERT INTO Admission(Patient_ID, Room_ID, Admit_Date, Discharge_Date, Status) VALUES
(3,  1,  '2026-10-02', NULL,         'Admitted'),
(1,  3,  '2026-10-03', NULL,         'Admitted'),
(4,  2,  '2026-09-28', '2026-10-01', 'Discharged'),
(9,  6,  '2026-10-05', NULL,         'Admitted'),
(10, 7,  '2026-10-05', NULL,         'Admitted'),
(7,  11, '2026-10-04', NULL,         'Admitted'),
(11, 4,  '2026-09-30', '2026-10-03', 'Discharged'),
(2,  5,  '2026-09-25', '2026-09-29', 'Discharged'),
(12, 10, '2026-09-27', '2026-09-30', 'Discharged'),
(13, 8,  '2026-09-29', '2026-10-02', 'Discharged');
 
INSERT INTO Bill(Admission_ID, Bill_Date, Total_Amount, Payment_Method, Payment_Status) VALUES
(1,  '2026-10-04', 15000.00, 'Insurance', 'Pending'),
(2,  '2026-10-05', 48000.00, 'Card',      'Pending'),
(3,  '2026-10-01',  9000.00, 'Cash',      'Paid'),
(4,  '2026-10-06', 22000.00, 'UPI',       'Pending'),
(5,  '2026-10-06', 35000.00, 'Insurance', 'Pending'),
(6,  '2026-10-05', 18000.00, 'Card',      'Pending'),
(7,  '2026-10-03', 12000.00, 'Cash',      'Paid'),
(8,  '2026-09-29',  7500.00, 'UPI',       'Paid'),
(9,  '2026-09-30', 11000.00, 'Card',      'Paid'),
(10, '2026-10-02',  8500.00, 'Cash',      'Paid');
-- ----------------------------------------------------------
-- 3. DQL : SELECT QUERIES
-- ----------------------------------------------------------
SELECT * FROM Department;
SELECT * FROM Doctor;
SELECT * FROM Patient;
SELECT * FROM Appointment;
SELECT * FROM Treatment;
SELECT * FROM Prescription;
SELECT * FROM Medicine;
SELECT * FROM Bill;
SELECT * FROM Room;
SELECT * FROM Admission;
-- 1. Change appointment status
UPDATE Appointment
SET Status = 'Cancelled'
WHERE Appointment_ID = 4;

-- 2. Change patient phone number
UPDATE Patient
SET Phone = '8888888888'
WHERE Patient_ID = 5;

-- 3. Reduce medicine quantity by 10
UPDATE Medicine
SET Quantity = Quantity - 10
WHERE Medicine_ID = 3;

-- 4. Change billing payment status
UPDATE Bill
SET Payment_Status = 'Paid'
WHERE Bill_ID = 1;
-- 1. Delete an appointment
DELETE FROM Appointment
WHERE Appointment_ID = 6;

-- 2. Delete a medicine
DELETE FROM Medicine
WHERE Medicine_ID = 12;

-- 3. Delete a room
DELETE FROM Room
WHERE Room_ID = 12;
-- ==========================================================
-- INNER JOIN
-- ==========================================================

-- 1. PATIENT + APPOINTMENT + DOCTOR
SELECT 
    P.Patient_ID,
    P.Patient_Name,
    D.Doctor_Name,
    D.Specialization,
    A.Appointment_Date,
    A.Appointment_Time,
    A.Status
FROM Patient P
INNER JOIN Appointment A
    ON P.Patient_ID = A.Patient_ID
INNER JOIN Doctor D
    ON A.Doctor_ID = D.Doctor_ID;


-- 2. DOCTOR + DEPARTMENT
SELECT 
    D.Doctor_ID,
    D.Doctor_Name,
    D.Specialization,
    DP.Department_Name,
    DP.Location
FROM Doctor D
INNER JOIN Department DP
    ON D.Department_ID = DP.Department_ID;


-- 3. PATIENT + TREATMENT
SELECT 
    P.Patient_ID,
    P.Patient_Name,
    T.Treatment_ID,
    T.Diagnosis,
    T.Treatment_Date,
    T.Description
FROM Patient P
INNER JOIN Treatment T
    ON P.Patient_ID = T.Patient_ID;


-- 4. PATIENT + ADMISSION + BILL
SELECT 
    B.Bill_ID,
    P.Patient_ID,
    P.Patient_Name,
    A.Admission_ID,
    B.Total_Amount,
    B.Payment_Method,
    B.Payment_Status
FROM Bill B
INNER JOIN Admission A
    ON B.Admission_ID = A.Admission_ID
INNER JOIN Patient P
    ON A.Patient_ID = P.Patient_ID;


-- 5. PRESCRIPTION + MEDICINE + TREATMENT
SELECT 
    PR.Prescription_ID,
    T.Treatment_ID,
    T.Diagnosis,
    M.Medicine_ID,
    M.Medicine_Name,
    PR.Dosage,
    PR.Duration,
    M.Quantity,
    M.Price
FROM Prescription PR
INNER JOIN Treatment T
    ON PR.Treatment_ID = T.Treatment_ID
INNER JOIN Medicine M
    ON PR.Medicine_ID = M.Medicine_ID;


-- ==========================================================
-- LEFT JOIN
-- ==========================================================

-- 6. SHOW ALL DEPARTMENTS INCLUDING DEPARTMENTS
--    WITHOUT DOCTORS
SELECT 
    DP.Department_ID,
    DP.Department_Name,
    D.Doctor_Name,
    D.Specialization
FROM Department DP
LEFT JOIN Doctor D
    ON DP.Department_ID = D.Department_ID;


-- ==========================================================
-- RIGHT JOIN
-- ==========================================================

-- 7. SHOW ALL DEPARTMENTS AND THEIR DOCTORS
SELECT 
    DP.Department_Name,
    D.Doctor_Name,
    D.Specialization
FROM Doctor D
RIGHT JOIN Department DP
    ON D.Department_ID = DP.Department_ID;
-- 1. Patients who have appointments
SELECT Patient_Name
FROM Patient
WHERE Patient_ID IN (
    SELECT Patient_ID
    FROM Appointment
);


-- 2. Doctors working in Cardiology
SELECT Doctor_Name, Specialization
FROM Doctor
WHERE Department_ID = (
    SELECT Department_ID
    FROM Department
    WHERE Department_Name = 'Cardiology'
);


-- 3. Medicines with price greater than average medicine price
SELECT Medicine_Name, Price
FROM Medicine
WHERE Price > (
    SELECT AVG(Price)
    FROM Medicine
);


-- 4. Bills greater than average bill amount
SELECT Bill_ID, Total_Amount, Payment_Status
FROM Bill
WHERE Total_Amount > (
    SELECT AVG(Total_Amount)
    FROM Bill
);


-- 5. Patients who have been admitted
SELECT Patient_Name
FROM Patient
WHERE Patient_ID IN (
    SELECT Patient_ID
    FROM Admission
);


-- 6. Doctors who have appointments
SELECT Doctor_Name, Specialization
FROM Doctor
WHERE Doctor_ID IN (
    SELECT Doctor_ID
    FROM Appointment
);
-- Number of patients
SELECT COUNT(Patient_ID) AS Total_Patients
FROM Patient;

-- Number of doctors
SELECT COUNT(Doctor_ID) AS Total_Doctors
FROM Doctor;

-- Number of departments
SELECT COUNT(Department_ID) AS Total_Departments
FROM Department;

-- Number of appointments
SELECT COUNT(Appointment_ID) AS Total_Appointments
FROM Appointment;

-- Total medicine quantity
SELECT SUM(Quantity) AS Total_Medicine_Quantity
FROM Medicine;

-- Total billing amount
SELECT SUM(Total_Amount) AS Total_Billing
FROM Bill;

-- Average medicine price
SELECT AVG(Price) AS Average_Medicine_Price
FROM Medicine;

-- Maximum medicine price
SELECT MAX(Price) AS Maximum_Medicine_Price
FROM Medicine;

-- Minimum medicine price
SELECT MIN(Price) AS Minimum_Medicine_Price
FROM Medicine;
---- Sub Queries
-- Patients older than the average patient age
SELECT Patient_Name, Age
FROM Patient
WHERE Age > (
    SELECT AVG(Age)
    FROM Patient
);

-- Doctors who belong to departments located in Block A
SELECT Doctor_Name, Specialization
FROM Doctor
WHERE Department_ID IN (
    SELECT Department_ID
    FROM Department
    WHERE Location = 'Block A'
);

-- Medicines with price less than the average medicine price
SELECT Medicine_Name, Price
FROM Medicine
WHERE Price < (
    SELECT AVG(Price)
    FROM Medicine
);

-- Patients who have completed appointments
SELECT Patient_Name
FROM Patient
WHERE Patient_ID IN (
    SELECT Patient_ID
    FROM Appointment
    WHERE Status = 'Completed'
);

-- Patients who have pending bills
SELECT Patient_Name
FROM Patient
WHERE Patient_ID IN (
    SELECT Patient_ID
    FROM Admission
    WHERE Admission_ID IN (
        SELECT Admission_ID
        FROM Bill
        WHERE Payment_Status = 'Pending'
    )
);

-- Doctors who treated patients with appointments
SELECT Doctor_Name, Specialization
FROM Doctor
WHERE Doctor_ID IN (
    SELECT Doctor_ID
    FROM Treatment
);

-- Medicines with quantity greater than average quantity
SELECT Medicine_Name, Quantity
FROM Medicine
WHERE Quantity > (
    SELECT AVG(Quantity)
    FROM Medicine
);

-- Patients who are currently admitted
SELECT Patient_Name
FROM Patient
WHERE Patient_ID IN (
    SELECT Patient_ID
    FROM Admission
    WHERE Status = 'Admitted'
);
---- Views

-- View for patient details
CREATE VIEW Patient_View AS
SELECT Patient_ID, Patient_Name, Age, Gender, Phone
FROM Patient;

-- View for doctor details
CREATE VIEW Doctor_View AS
SELECT Doctor_ID, Doctor_Name, Specialization, Department_ID
FROM Doctor;

-- View for bill details
CREATE VIEW Bill_View AS
SELECT Bill_ID, Admission_ID, Total_Amount, Payment_Method, Payment_Status
FROM Bill;
SELECT * FROM Patient_View;

SELECT * FROM Doctor_View;

SELECT * FROM Bill_View;
---- Normalization

-- First Normal Form (1NF)
-- Atomic values, no repeating groups

CREATE TABLE Patient (
    Patient_ID INT PRIMARY KEY AUTO_INCREMENT,
    Patient_Name VARCHAR(100),
    Age INT,
    Gender VARCHAR(10),
    Phone VARCHAR(15),
    Address VARCHAR(150),
    Blood_Group VARCHAR(5)
);

-- Second Normal Form (2NF)
-- Separate appointment details from patient details

CREATE TABLE Appointment (
    Appointment_ID INT PRIMARY KEY AUTO_INCREMENT,
    Patient_ID INT,
    Doctor_ID INT,
    Appointment_Date DATE,
    Appointment_Time TIME,
    Status VARCHAR(20),
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID)
);

-- Third Normal Form (3NF)
-- Separate doctor and department information

CREATE TABLE Department (
    Department_ID INT PRIMARY KEY AUTO_INCREMENT,
    Department_Name VARCHAR(100),
    Location VARCHAR(100),
    Contact_Number VARCHAR(15)
);

CREATE TABLE Doctor (
    Doctor_ID INT PRIMARY KEY AUTO_INCREMENT,
    Doctor_Name VARCHAR(100),
    Specialization VARCHAR(50),
    Phone VARCHAR(15),
    Email VARCHAR(100),
    Department_ID INT,
    FOREIGN KEY (Department_ID)
    REFERENCES Department(Department_ID)
);