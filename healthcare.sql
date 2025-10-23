-- Create database
CREATE DATABASE healthdb;
USE healthdb;
-- Import healthdb.sql 

-- Retrieve All Table Information
select * from patients;
select * from appointments;
select * from billing;
select * from doctors;
select * from prescriptions;

-- Get All Appointments for a Specific Patient
SELECT * FROM Appointments
WHERE patient_id = 1;

-- Retrieve All Prescriptions for a Specific Appointment
SELECT * FROM Prescriptions
WHERE appointment_id = 1;

-- Get Billing Information for a Specific Appointment
SELECT * FROM Billing
WHERE appointment_id = 2;

-- List All Appointments with Billing Status
SELECT a.appointment_id, p.first_name AS patient_first_name, p.last_name AS patient_last_name,       
d.first_name AS doctor_first_name, d.last_name AS doctor_last_name,       
b.amount, b.payment_date, b.status
FROM Appointments a
JOIN Patients p ON a.patient_id = p.patient_id
JOIN Doctors d ON a.doctor_id = d.doctor_id
JOIN Billing b ON a.appointment_id = b.appointment_id;

-- Find all paid billing
SELECT * FROM Billing
WHERE status = 'Paid';

-- Calculate Total Amount Billed and Total Paid Amount
SELECT     
(SELECT SUM(amount) FROM Billing) AS total_billed,    
(SELECT SUM(amount) FROM Billing WHERE status = 'Paid') AS total_paid;

-- Get the Number of Appointments by Specialty
SELECT d.specialty, COUNT(a.appointment_id) AS number_of_appointments
FROM Appointments a
JOIN Doctors d ON a.doctor_id = d.doctor_id
GROUP BY d.specialty;

-- Find the Most Common Reason for Appointments
SELECT reason, 
COUNT(*) AS count
FROM Appointments
GROUP BY reason
ORDER BY count DESC;

-- List Patients with Their Latest Appointment Date
SELECT p.patient_id, p.first_name, p.last_name, MAX(a.appointment_date) AS latest_appointment
FROM Patients p
JOIN Appointments a ON p.patient_id = a.patient_id
GROUP BY p.patient_id, p.first_name, p.last_name;

-- List All Doctors and the Number of Appointments They Had
SELECT d.doctor_id, d.first_name, d.last_name, COUNT(a.appointment_id) AS number_of_appointments
FROM Doctors d
LEFT JOIN Appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.first_name, d.last_name;

-- Retrieve Patients Who Had Appointments in the Last 90 Days
SELECT DISTINCT p.*
FROM Patients p
JOIN Appointments a ON p.patient_id = a.patient_id
WHERE STR_TO_DATE(a.appointment_date, '%d-%m-%Y') >= CURDATE() - INTERVAL 30 DAY;

-- Find Prescriptions Associated with Appointments that are Pending Payment
SELECT pr.prescription_id, pr.medication, pr.dosage, pr.instructions
FROM Prescriptions pr
JOIN Appointments a ON pr.appointment_id = a.appointment_id
JOIN Billing b ON a.appointment_id = b.appointment_id
WHERE b.status = 'Pending';

-- Analyse patient demographics
SELECT gender, COUNT(*) AS count
FROM Patients
GROUP BY gender;

-- Identify the most frequently prescribed medications and their total dosage
SELECT medication, COUNT(*) AS frequency, SUM(CAST(SUBSTRING_INDEX(dosage, ' ', 1) AS UNSIGNED)) AS total_dosage
FROM Prescriptions
GROUP BY medication
ORDER BY frequency DESC;

-- Average Billing Amount by Number of Appointments
SELECT p.patient_id, COUNT(a.appointment_id) AS appointment_count, AVG(b.amount) AS avg_billing_amount
FROM Patients p
LEFT JOIN Appointments a ON p.patient_id = a.patient_id
LEFT JOIN Billing b ON a.appointment_id = b.appointment_id
GROUP BY p.patient_id;

-- Analyze the correlation between appointment frequency and billing status
SELECT p.patient_id, p.first_name, p.last_name, SUM(b.amount) AS total_billed
FROM Patients p
JOIN Appointments a ON p.patient_id = a.patient_id
JOIN Billing b ON a.appointment_id = b.appointment_id
GROUP BY p.patient_id, p.first_name, p.last_name
ORDER BY total_billed DESC
LIMIT 10;

-- Payment Status Over Time
SELECT DATE_FORMAT(payment_date, '%Y-%m') AS month, status, COUNT(*) AS count
FROM Billing
GROUP BY month, status
ORDER BY month, status;

-- Unpaid Bills Analysis
SELECT p.patient_id, p.first_name, p.last_name, SUM(b.amount) AS total_unpaid
FROM Patients p
JOIN Appointments a ON p.patient_id = a.patient_id
JOIN Billing b ON a.appointment_id = b.appointment_id
WHERE b.status = 'Pending'
GROUP BY p.patient_id, p.first_name, p.last_name
ORDER BY total_unpaid DESC;

-- Doctor Performance Metrics
SELECT d.doctor_id, d.first_name, d.last_name, COUNT(a.appointment_id) AS number_of_appointments
FROM Doctors d
LEFT JOIN Appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.first_name, d.last_name;

-- Day wise Appointment counts
SELECT appointment_date, COUNT(*) AS appointment_count
FROM Appointments
GROUP BY appointment_date;

-- Find patients with missing appointments
SELECT p.patient_id, p.first_name, p.last_name
FROM Patients p
LEFT JOIN Appointments a ON p.patient_id = a.patient_id
WHERE a.appointment_id IS NULL;

-- Find appointments without billing records
SELECT a.appointment_id, a.patient_id, a.doctor_id, a.appointment_date
FROM Appointments a
LEFT JOIN Billing b ON a.appointment_id = b.appointment_id
WHERE b.billing_id IS NULL;

-- Find All Appointments for doctor with id 1
SELECT a.appointment_id, p.first_name AS patient_first_name, p.last_name AS patient_last_name, a.appointment_date, a.reason
FROM Appointments a
JOIN Patients p ON a.patient_id = p.patient_id
WHERE a.doctor_id = 1; 

-- All Prescriptions with Payment Status as Pending
SELECT p.medication, p.dosage, p.instructions, b.amount, b.payment_date, b.status
FROM Prescriptions p
JOIN Appointments a ON p.appointment_id = a.appointment_id
JOIN Billing b ON a.appointment_id = b.appointment_id
WHERE b.status = 'Pending';

-- CHANGE APPOINTMENT_DATE FROM TEXT TO DATE
-- disable safe mode
SET SQL_SAFE_UPDATES=0;

UPDATE appointments
SET appointment_date=STR_TO_DATE(appointment_date,'%d-%m-%Y');

ALTER TABLE appointments
MODIFY COLUMN appointment_date DATE;

-- List All Patients Who Had Appointments in August
SELECT DISTINCT p.first_name, p.last_name, p.dob, p.gender, a.appointment_date
FROM Patients p
JOIN Appointments a ON p.patient_id = a.patient_id
WHERE DATE_FORMAT(a.appointment_date, '%Y-%m') = '2024-08';

-- List All Doctors and Their Appointments in august till today
SELECT d.first_name, d.last_name, a.appointment_date, p.first_name AS patient_first_name, p.last_name AS patient_last_name
FROM Doctors d
JOIN Appointments a ON d.doctor_id = a.doctor_id
JOIN Patients p ON a.patient_id = p.patient_id
WHERE a.appointment_date BETWEEN '2025-08-01' AND '2025-08-10'; 

-- Get Total Amount Billed Per Doctor
SELECT d.first_name, d.last_name, d.specialty, SUM(b.amount) AS total_billed
FROM Doctors d
JOIN Appointments a ON d.doctor_id = a.doctor_id
JOIN Billing b ON a.appointment_id = b.appointment_id
GROUP BY d.first_name, d.last_name, d.specialty
ORDER BY total_billed desc;
