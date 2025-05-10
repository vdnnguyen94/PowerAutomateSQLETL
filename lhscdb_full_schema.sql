
-- Create database if it doesn't exist
IF DB_ID('LHSCDB') IS NULL
BEGIN
    CREATE DATABASE LHSCDB;
END;
GO

USE LHSCDB;
GO

-- Create Patients table (holds PHI)
CREATE TABLE Patients (
    patient_id INT IDENTITY(1,1) PRIMARY KEY,
    patient_uid UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),  -- Internal ID for de-identification
    ohip_number CHAR(10) NOT NULL,
    first_name NVARCHAR(100),
    last_name NVARCHAR(100),
    dob DATE,
    gender VARCHAR(10),
    address NVARCHAR(255),
    phone_number VARCHAR(20),
    created_at DATETIME DEFAULT GETDATE()
);
GO

-- Create Visits table (linked to Patients)
CREATE TABLE Visits (
    visit_id INT IDENTITY(1,1) PRIMARY KEY,
    patient_id INT NOT NULL,
    visit_date DATETIME NOT NULL,
    clinic VARCHAR(100),
    reason_for_visit NVARCHAR(255),
    status VARCHAR(50) DEFAULT 'Admitted',  -- Admitted, Discharged, etc.
    discharge_date DATETIME NULL,
    is_processed BIT DEFAULT 0,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);
GO

-- Create Staging_Valid table (de-identified)
CREATE TABLE Staging_Valid (
    staging_id INT IDENTITY(1,1) PRIMARY KEY,
    patient_uid UNIQUEIDENTIFIER NOT NULL,
    visit_id INT NOT NULL,
    clinic VARCHAR(100),
    visit_date DATETIME,
    status VARCHAR(50),
    discharge_date DATETIME,
    created_at DATETIME DEFAULT GETDATE()
);
GO

-- Create Staging_Error table (contains validation issues and possibly PHI)
CREATE TABLE Staging_Error (
    error_id INT IDENTITY(1,1) PRIMARY KEY,
    visit_id INT,
    patient_id INT,
    ohip_number CHAR(10),
    error_reason NVARCHAR(255),
    raw_data NVARCHAR(MAX),
    logged_at DATETIME DEFAULT GETDATE()
);
GO
