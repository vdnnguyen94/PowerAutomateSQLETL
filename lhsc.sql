--De-identified Query from Visits + Patients
SELECT 
    p.patient_uid,                             -- Use internal UUID instead of name
    v.visit_id,
    v.clinic,
    v.visit_date,
    v.status,
    v.discharge_date,
    v.report_code,
    v.document_type,
    v.encounter_notes
FROM Visits v
JOIN Patients p ON v.patient_id = p.patient_id
WHERE v.clinic = 'Cardiac' AND v.is_processed = 0;
-- Get all patients with PHI and internal tracking info
SELECT 
    patient_id,
    patient_uid,
    ohip_number,
    first_name,
    last_name,
    dob,
    gender,
    address,
    phone_number,
    created_at
FROM Patients;

-- Get visit data along with the patient’s full name
SELECT 
    v.visit_id,
    p.first_name + ' ' + p.last_name AS full_name,
    v.clinic,
    v.visit_date,
    v.status,
    v.report_code,
    v.encounter_notes
FROM Visits v
JOIN Patients p ON v.patient_id = p.patient_id;

-- Get documents linked to visits, and show related patient and clinic info
SELECT 
    d.document_id,
    d.document_type,
    d.report_code,
    d.file_path,
    v.clinic,
    v.visit_date,
    p.first_name + ' ' + p.last_name AS patient_name
FROM VisitDocuments d
JOIN Visits v ON d.visit_id = v.visit_id
JOIN Patients p ON v.patient_id = p.patient_id;

--De-identified Query from Visits + Patients
SELECT 
    p.patient_uid,                             -- Use internal UUID instead of name
    v.visit_id,
    v.clinic,
    v.visit_date,
    v.status,
    v.discharge_date,
    v.report_code,
    v.document_type,
    v.encounter_notes
FROM Visits v
JOIN Patients p ON v.patient_id = p.patient_id
WHERE v.clinic = 'Cardiac' AND v.is_processed = 0;
