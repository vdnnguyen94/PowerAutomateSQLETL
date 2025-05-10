"""
================================================================================
README - Power Automate ETL with SQL Validation Using Azure VMs
================================================================================

PROJECT OVERVIEW:
-----------------
This project demonstrates an ETL pipeline using Power Automate between two
SQL Server instances hosted on Azure Virtual Machines. The source database 
simulates the LHSC clinical environment, and the destination (staging) 
database represents Alimentiv.

Data flow:
- Extract new visit records from LHSC SQL
- Validate and clean data
- Route valid/invalid data to respective staging tables in Alimentiv SQL
- Optionally trigger Power BI refresh after staging is updated

================================================================================
PROJECT SETUP PLAN
================================================================================

WEEK 1 – Environment Setup:
---------------------------
✅ 1.1 Create Two Azure VMs:
    - Name: LHSC-VM, Alimentiv-VM
    - Image: Windows Server 2019 or 2022
    - Enable RDP + open SQL Server port 1433
    - Configure inbound NSG rules and VM firewall

✅ 1.2 Install SQL Server on both VMs:
    - Use SQL Server Express or Developer edition
    - Enable mixed authentication (SQL + Windows)
    - Allow TCP/IP connections in SQL Server Configuration Manager

✅ 1.3 Install On-Premises Data Gateway:
    - Download and install from Microsoft
    - Sign in with same Microsoft account used for Power Automate
    - Register both LHSC and Alimentiv servers as data sources

================================================================================

WEEK 2 – Database Design:
--------------------------
✅ 2.1 LHSC SQL Server - Create table `ClinicalVisits`:
    - Columns: visit_id, patient_id, clinic, visit_date, status, is_processed

✅ 2.2 Alimentiv SQL Server - Create tables:
    - Staging_Valid: holds cleaned & accepted data
    - Staging_Error: holds rejected or invalid records
    - (Optional) Audit tables: ETLLog, ValidationAudit

✅ 2.3 Insert sample test data in `ClinicalVisits`:
    - 5–10 dummy rows including edge cases (nulls, bad formats)

================================================================================

WEEK 3 – Power Automate Flow:
-----------------------------
✅ 3.1 Create a Scheduled Cloud Flow:
    - Trigger: Recurrence (e.g., every 5 min)
    - Action 1: Get rows from `ClinicalVisits` where 
                clinic = 'Cardiac' AND is_processed = false
    - Action 2: Apply to Each:
        - Add validation conditions (e.g., not null, valid format)
        - If valid → insert into Staging_Valid
        - Else → insert into Staging_Error
        - Update `is_processed = true` in LHSC source table

✅ 3.2 Test & Debug:
    - Confirm correct routing
    - Monitor run history
    - Validate inserts in Alimentiv tables

================================================================================

WEEK 4 – Power BI + Documentation:
----------------------------------
✅ 4.1 Connect Power BI:
    - Link Alimentiv SQL Server to Power BI Desktop
    - Visualize volume, error rates, visit trends

✅ 4.2 (Optional) Automate Power BI Refresh:
    - Use Power BI connector in Power Automate to refresh dataset

✅ 4.3 Final Documentation:
    - Draw architecture diagram
    - Save SQL scripts and flow steps
    - Document validation logic
    - Push everything to GitHub

================================================================================

DELIVERABLES:
-------------
✅ Azure VM x2 (LHSC, Alimentiv)
✅ SQL Databases and Tables (source/staging)
✅ Working Power Automate ETL Flow
✅ Sample Data Validated & Routed
✅ Optional Power BI Dashboard
✅ README + GitHub repo (optional)

================================================================================
ESTIMATED TIME COMMITMENT:
================================================================================

Assuming 1–3 hours of work per day, this project can be completed within
approximately 2–3 weeks.

| Phase                            | Time Estimate      | Notes |
|----------------------------------|--------------------|----------------------------------------------------------|
| Week 1: Azure VM + Gateway Setup | 6–8 hours total    | VM creation, SQL install, gateway, firewall              |
| Week 2: DB Schema + Sample Data  | 4–6 hours total    | Design schema, add dummy rows                           |
| Week 3: Power Automate ETL Flow  | 6–10 hours total   | Build flow, validation logic, test, debug                |
| Week 4: Power BI + Documentation | 4–6 hours total    | BI connection, refresh logic, architecture doc, GitHub   |

🔹 **Fast Track**: 10 days at 2–3 hrs/day  
🔹 **Comfortable Pace**: 2–3 weeks at 1–1.5 hrs/day

================================================================================
"""
