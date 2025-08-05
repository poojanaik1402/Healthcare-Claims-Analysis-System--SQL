-----Healthcare Claims Analysis System -------

---This project simulates a mini healthcare claims management system designed to capture and analyze key information such as 
--------Patient details,Healthcare provider records,Diagnosis codes (e.g., ICD-10),Insurance claims (submitted, approved, rejected, or pending),Payments made for approved claims


--Patient table---
create table patients(
    patient_id NUMBER PRIMARY KEY,
    full_name VARCHAR2(100),
    date_of_birth DATE,
    gender CHAR(1),
    contact_number VARCHAR2(15)
);
---Provider table----
create table providers(
    provider_id NUMBER PRIMARY KEY,
    provider_name VARCHAR2(100),
    specialization VARCHAR2(100),
    location VARCHAR2(100)
);

---Diagnosis Codes---
Create table diagnosis_code(
    code VARCHAR2(10) PRIMARY KEY,
    description VARCHAR2(300)
);  

---Claims Table----
create table claims(
    claim_id NUMBER PRIMARY KEY,
    patient_id NUMBER REFERENCES patients(patient_id),
    provider_id NUMBER REFERENCES providers(provider_id),
    diagnosis_code VARCHAR2(10) REFERENCES diagnosis_code(code),
    claim_date DATE,
    amount_claimed NUMBER(10,2),
    status VARCHAR2(20)---Submitted,Approved,Rejected,Pending
    );
    
---Payments table----
create table payments(
    payment_id NUMBER PRIMARY KEY,
    claim_id NUMBER REFERENCES claims(claim_id),
    payment_date DATE,
    amount_paid NUMBER(10,2)
    );

 -----sample Patients----   
insert into patients values(1,'Jacky husan',to_date('1992-08-15','yyyy-mm-dd'),'F','9876543212');
insert into patients values(2,'Hiroshi Tanaka',to_date('1985-07-22','yyyy-mm-dd'),'M','9988776655');
insert into patients values(3,'Anastasia Volkova',to_date('1990-11-30','yyyy-mm-dd'),'F','8887654123');
insert into patients values(4,'Carlos Mendoza',to_date('1988-05-09','yyyy-mm-dd'),'M','7485961425');

-----sample providers-----
insert into providers values(101,'Apollo hospital','cardiology','Bangalore');
insert into providers values(102,'Fortis Healthcare','orthopedics','Hyderabad');
insert into providers values(103,'Apollo Diagnostics','Pathology and Laboratory services','Chennai');
insert into providers values(104,'Manipal Hospitals','Multi-specialty tertiary care','Pune');

-----sample diagnosis codes----
insert into diagnosis_code values('I10','Essential(primary)hypertension');
insert into  diagnosis_code values('M54.5','Low back pain');
insert into  diagnosis_code values ('E11.9', 'Type 2 diabetes mellitus without complications');
insert into  diagnosis_code values ('J45.909', 'Unspecified asthma, uncomplicated');

----sample claims---
insert into claims values(1001,1,101,'I10',to_date('2024-01-10','yyyy-mm-dd'),10000,'Approved');
insert into claims values(1002,2,102,'M54.5',to_date('2024-01-15','yyyy-mm-dd'),8000,'Rejected');
insert into claims values (1003, 3, 103, 'E11.9',to_date('2024-02-12', 'yyyy-mm-dd'),6000, 'Approved');
insert into claims values(1004, 4, 104, 'J45.909',to_date('2024-02-18', 'yyyy-mm-dd'),7500, 'Pending');

-----Sample Payments-----
insert into payments values(501,1001,to_date('2024-01-20','yyyy-mm-dd'),9500);
insert into payments values (503, 1003,to_date('2024-02-20','yyyy-mm-dd'), 5800);

----fetching all tables----
select * from patients;
select * from providers;
select * from diagnosis_code;
select * from claims;
select * from payments;

-----Total claims Submitted per provider---
select p.provider_name,count(*)As total_claims
from claims c
join providers p
on c.provider_id = p.provider_id
group by p.provider_name;

-----Approved Vs Rejected claims---
select status, count(*) As count
from claims
group by status;

------Patient-wise total amount claimed---
select pt.full_name, SUM(c.amount_claimed) As total_amt_claimed
from claims c
join patients pt 
on c.patient_id = pt.patient_id 
group by pt.full_name;

-------Claims without payment(pending or rejected)
select c.claim_id,c.status,c.amount_claimed
from claims c
left join payments p 
on c.claim_id = p.claim_id
where p.payment_id is null;



