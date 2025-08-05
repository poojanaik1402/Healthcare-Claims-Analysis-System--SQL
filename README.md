# 🏥 Healthcare Claims Analysis System – SQL Project

This project simulates a **Healthcare Claims Management System**, built using SQL, designed to store and analyze data from patients, healthcare providers, diagnosis codes, claims, and payments.

---

## 📌 Objective

To create and analyze a realistic dataset that represents the **healthcare claims process**, providing insights into:
- Total claims per provider
- Approved vs Rejected claims
- Patient-wise claimed amounts
- Claims with no payments (unpaid/rejected)

---

## 🗂️ Database Schema

The project contains 5 main tables:

1. **Patients**
2. **Providers**
3. **Diagnosis Codes (ICD-10)**
4. **Claims**
5. **Payments**

---

## 🧱 Table Structures

```sql
-- Patients
CREATE TABLE patients (
  patient_id NUMBER PRIMARY KEY,
  full_name VARCHAR2(100),
  date_of_birth DATE,
  gender CHAR(1),
  contact_number VARCHAR2(15)
);

-- Providers
CREATE TABLE providers (
  provider_id NUMBER PRIMARY KEY,
  provider_name VARCHAR2(100),
  specialization VARCHAR2(100),
  location VARCHAR2(100)
);

-- Diagnosis Codes
CREATE TABLE diagnosis_code (
  code VARCHAR2(10) PRIMARY KEY,
  description VARCHAR2(300)
);

-- Claims
CREATE TABLE claims (
  claim_id NUMBER PRIMARY KEY,
  patient_id NUMBER REFERENCES patients(patient_id),
  provider_id NUMBER REFERENCES providers(provider_id),
  diagnosis_code VARCHAR2(10) REFERENCES diagnosis_code(code),
  claim_date DATE,
  amount_claimed NUMBER(10,2),
  status VARCHAR2(20) -- Submitted, Approved, Rejected, Pending
);

-- Payments
CREATE TABLE payments (
  payment_id NUMBER PRIMARY KEY,
  claim_id NUMBER REFERENCES claims(claim_id),
  payment_date DATE,
  amount_paid NUMBER(10,2)
);
```

---

## 🔢 Sample Data Inserted

Includes realistic entries for:
- 4 patients  
- 4 providers  
- 4 diagnosis codes  
- 4 claims (with varying statuses)  
- 2 payments  

---

## 📊 Key SQL Queries

```sql
-- 1. Total Claims Submitted per Provider
SELECT p.provider_name, COUNT(*) AS total_claims
FROM claims c
JOIN providers p ON c.provider_id = p.provider_id
GROUP BY p.provider_name;

-- 2. Approved vs Rejected Claims
SELECT status, COUNT(*) AS count
FROM claims
GROUP BY status;

-- 3. Patient-wise Total Amount Claimed
SELECT pt.full_name, SUM(c.amount_claimed) AS total_amt_claimed
FROM claims c
JOIN patients pt ON c.patient_id = pt.patient_id
GROUP BY pt.full_name;

-- 4. Claims Without Payments (Pending or Rejected)
SELECT c.claim_id, c.status, c.amount_claimed
FROM claims c
LEFT JOIN payments p ON c.claim_id = p.claim_id
WHERE p.payment_id IS NULL;
```

---

## 📌 Learnings & Skills Applied

- Data Modeling in Healthcare domain
- SQL Table creation & constraints
- Joins (INNER, LEFT), Grouping, Aggregations
- Realistic scenario-based data design
