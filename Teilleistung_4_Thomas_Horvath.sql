--Teilleistung 4 - Thomas Horvath
--Dropping Everything
drop table staff;
drop table donors_medications;
drop table donations;
drop table medications;
drop table donors_medical_conditions;
drop table donors;
drop table blood_banks;
drop table medical_conditions;
drop table ref_staff_categories;
drop table religions;
drop table addresses;

drop view view_Donations_Count;
drop view  view_monthly;

--Creating Tables
CREATE TABLE addresses
(
address_id VARCHAR2(30) NOT NULL,
line_1_number_building VARCHAR2(50),
line_2_number_street VARCHAR2(50),
line_3_area_locality VARCHAR2(50),
city VARCHAR2(50) NOT NULL,
zip_postcode VARCHAR2(15) NOT NULL,
state_province_county VARCHAR2(50),
country VARCHAR2(50) NOT NULL,
other_address_details VARCHAR2(50)
);

CREATE TABLE ref_staff_categories
(
staff_category_code VARCHAR2(30) NOT NULL,
staff_category_description VARCHAR2(50)  NOT NULL
);

CREATE TABLE staff
(
staff_id VARCHAR2(30) NOT NULL,
address_id VARCHAR2(30) NOT NULL,
blood_bank_id VARCHAR2(30) NOT NULL,
staff_category_code VARCHAR2(30) NOT NULL,
gender_mfu VARCHAR2(10) NOT NULL,
staff_job_name VARCHAR2(50),
staff_first_name VARCHAR2(50) NOT NULL,
staff_middle_name VARCHAR2(50),
staff_last_name VARCHAR2(50) NOT NULL,
staff_qualifications VARCHAR2(50),
staff_birth_date DATE NOT NULL,
other_staff_details VARCHAR2(30)
);

CREATE TABLE blood_banks
(
blood_bank_id VARCHAR2(30) NOT NULL,
address_id VARCHAR2(30) NOT NULL,
blood_bank_details VARCHAR2(100)
);

CREATE TABLE donors_medications
(
donor_id VARCHAR2(30) NOT NULL,
medication_code VARCHAR2(30) NOT NULL,
comments VARCHAR2(150)
);

CREATE TABLE religions
(
religion_code VARCHAR2(30) NOT NULL,
religion_name VARCHAR2(50) NOT NULL,
religion_description VARCHAR2(100),
other_details VARCHAR2(30)
);

CREATE TABLE donors
(
donor_id VARCHAR2(30) NOT NULL,
address_id VARCHAR2(30) NOT NULL,
blood_bank_id VARCHAR2(30) NOT NULL,
religion_code VARCHAR2(30) NOT NULL,
national_medical_number VARCHAR2(30) NOT NULL,
gender_mfu VARCHAR2(10) NOT NULL,
date_of_birth DATE NOT NULL,
first_name VARCHAR2(50) NOT NULL,
middle_name VARCHAR2(50),
last_name VARCHAR2(50) NOT NULL,
home_phone VARCHAR2(30),
work_phone VARCHAR2(30),
cell_mobile_phone VARCHAR2(30),
medical_condition VARCHAR2(50),
other_details VARCHAR2(30)
);

CREATE TABLE donations
(
donation_id VARCHAR2(30) NOT NULL,
donor_id VARCHAR2(30) NOT NULL,
donation_date DATE NOT NULL,
other_details VARCHAR2(30),
comments VARCHAR2(250)
);

CREATE TABLE medications
(
medication_code VARCHAR2(30) NOT NULL,
medication_name VARCHAR2(50) NOT NULL,
medication_description VARCHAR2(150),
other_details VARCHAR2(100)
);

CREATE TABLE medical_conditions
(
condition_code VARCHAR2(30) NOT NULL,
condition_name VARCHAR2(50) NOT NULL,
condition_description VARCHAR2(150),
other_details VARCHAR2(100)
);

CREATE TABLE donors_medical_conditions
(
donor_id VARCHAR2(30) NOT NULL,
condition_code VARCHAR2(30) NOT NULL,
seriousness VARCHAR2(30)
);

--Creating Primary Keys
CREATE UNIQUE INDEX address_PK ON addresses (address_id);
CREATE UNIQUE INDEX ref_staff_categories_PK ON ref_staff_categories (staff_category_code);
CREATE UNIQUE INDEX blood_banks_PK ON blood_banks (blood_bank_id);
CREATE UNIQUE INDEX staff_PK ON staff (staff_id);
CREATE UNIQUE INDEX religions_PK ON religions (religion_code);
CREATE UNIQUE INDEX donors_PK ON donors (donor_id);
CREATE UNIQUE INDEX donors_medications_PK ON donors_medications (donor_id, medication_code);
CREATE UNIQUE INDEX medications_PK ON medications (medication_code);
CREATE UNIQUE INDEX donors_medical_conditions_PK ON donors_medical_conditions (donor_id, condition_code);
CREATE UNIQUE INDEX donations_PK ON donations (donation_id);
CREATE UNIQUE INDEX medical_conditions_PK ON medical_conditions (condition_code);

--Enabling Primary Keys
ALTER TABLE addresses ADD CONSTRAINT address_PK PRIMARY KEY (address_id) ENABLE;
ALTER TABLE ref_staff_categories ADD CONSTRAINT ref_staff_categories_PK PRIMARY KEY(staff_category_code) ENABLE;
ALTER TABLE blood_banks ADD CONSTRAINT blood_banks_PK PRIMARY KEY (blood_bank_id)ENABLE;
ALTER TABLE staff ADD CONSTRAINT staff_PK PRIMARY KEY (staff_id) ENABLE;
ALTER TABLE religions ADD CONSTRAINT religions_PK PRIMARY KEY (religion_code) ENABLE;
ALTER TABLE donors ADD CONSTRAINT donors_PK PRIMARY KEY (donor_id) ENABLE;
ALTER TABLE donors_medications ADD CONSTRAINT donors_medications_PK PRIMARY KEY (donor_id, medication_code) ENABLE;
ALTER TABLE medications ADD CONSTRAINT medications_PK PRIMARY KEY (medication_code) ENABLE;
ALTER TABLE donors_medical_conditions ADD CONSTRAINT donors_medical_conditions_PK PRIMARY KEY (donor_id, condition_code) ENABLE;
ALTER TABLE donations ADD CONSTRAINT donations_PK PRIMARY KEY (donation_id) ENABLE;
ALTER TABLE medical_conditions ADD CONSTRAINT medical_conditions_PK PRIMARY KEY (condition_code) ENABLE;

--FOREIGN KEYS
ALTER TABLE staff ADD CONSTRAINT address_id_FK1 FOREIGN KEY (address_id) REFERENCES addresses (address_id) ENABLE;
ALTER TABLE staff ADD CONSTRAINT blood_bank_id_FK FOREIGN KEY (blood_bank_id) REFERENCES blood_banks (blood_bank_id) ENABLE;
ALTER TABLE staff ADD CONSTRAINT staff_category_code_FK FOREIGN KEY (staff_category_code) REFERENCES ref_staff_categories (staff_category_code) ENABLE;

ALTER TABLE blood_banks ADD CONSTRAINT address_id_FK2 FOREIGN KEY (address_id) REFERENCES addresses (address_id) ENABLE;

ALTER TABLE donors ADD CONSTRAINT address_id_FK3 FOREIGN KEY (address_id) REFERENCES addresses(address_id) ENABLE;
ALTER TABLE donors ADD CONSTRAINT blood_bank_id_FK2 FOREIGN KEY (blood_bank_id) REFERENCES blood_banks (blood_bank_id) ENABLE;
ALTER TABLE donors ADD CONSTRAINT religion_code_FK FOREIGN KEY (religion_code) REFERENCES religions (religion_code) ENABLE;

ALTER TABLE donations ADD CONSTRAINT donor_id_FK FOREIGN KEY (donor_id) REFERENCES donors (donor_id) ENABLE;

ALTER TABLE donors_medications ADD CONSTRAINT medication_code_FK FOREIGN KEY(medication_code) REFERENCES medications(medication_code) ENABLE;
ALTER TABLE donors_medications ADD CONSTRAINT donor_id_FK3 FOREIGN KEY (donor_id) REFERENCES donors(donor_id) ENABLE;

ALTER TABLE donors_medical_conditions ADD CONSTRAINT donor_id_FK2 FOREIGN KEY(donor_id) REFERENCES donors(donor_id) ENABLE;
ALTER TABLE donors_medical_conditions ADD CONSTRAINT condition_code_FK FOREIGN KEY(condition_code) REFERENCES medical_conditions(condition_code) ENABLE;

--Insert into addresses
INSERT INTO addresses VALUES ('A-3000', '200','Hauptstrasse','Area One', 'Forchtenstein', '7212', 'Burgenland', 'Austria', 'Europe');
INSERT INTO addresses VALUES ('A-3001', '19','Böcklinstrasse','Area Two', 'Wien', '1020', 'Wien', 'Austria', 'Europe');
INSERT INTO addresses VALUES ('A-3002', '23','Hochstrasse','Area Three', 'Mattersburg', '7210', 'Mattersburg', 'Austria', 'Europe');
INSERT INTO addresses VALUES ('A-3003', '14','Vivariumstrasse','Area Four', 'Wien', '1030', 'Wien', 'Austria', 'Europe');
INSERT INTO addresses VALUES ('A-3004', '25','Vivariumstrasse','Area Four', 'Wien', '1030', 'Wien', 'Austria', 'Europe');

--Insert into blood_banks
INSERT INTO blood_banks (blood_bank_id, address_id) VALUES ('B-1000','A-3000');
INSERT INTO blood_banks (blood_bank_id, address_id) VALUES ('B-1001','A-3001');
INSERT INTO blood_banks (blood_bank_id, address_id) VALUES ('B-1002','A-3002');
INSERT INTO blood_banks (blood_bank_id, address_id) VALUES ('B-1003','A-3003');
INSERT INTO blood_banks VALUES ('B-1004','A-3004', 'great infrastructure');

--Insert into ref_staff_categories
INSERT INTO ref_staff_categories VALUES ('S-400', 'Nurse');
INSERT INTO ref_staff_categories VALUES ('S-401', 'Doctor');
INSERT INTO ref_staff_categories VALUES ('S-402', 'Paramedic');
INSERT INTO ref_staff_categories VALUES ('S-403', 'Senior Nurse');
INSERT INTO ref_staff_categories VALUES ('S-404', 'Assistent');

--INSERT into religions
INSERT INTO religions VALUES('R-500','Christianity', 'An Abrahamic monotheistic religion' , 'Roman Catholic');
INSERT INTO religions VALUES('R-501','Judaism', 'An Abrahamic monotheistic religion' , 'Unknown');
INSERT INTO religions VALUES('R-502','Christianity', 'An Abrahamic monotheistic religion' , 'Evangelical');
INSERT INTO religions VALUES('R-503','Christianity', 'An Abrahamic monotheistic religion' , 'Orthodox');
INSERT INTO religions VALUES('R-504','Christianity', 'An Abrahamic monotheistic religion' , 'Eastern Catholic');

--INSERT into staff
INSERT INTO staff VALUES('W-1000','A-3000','B-1000','S-400','Male','Head Nurse','Thomas','Johann','Horvath','Bachelor of Art',to_date('1994-09-23','YYYY-MM-DD'),'Great Nurse');
INSERT INTO staff (staff_id, address_id, blood_bank_id, staff_category_code, gender_mfu, staff_first_name, staff_last_name, staff_birth_date) VALUES ('W-1001','A-3001','B-1001','S-400','Female','Catarina','Power',to_date('1994-02-14','YYYY-MM-DD'));
INSERT INTO staff (staff_id, address_id, blood_bank_id, staff_category_code, gender_mfu, staff_first_name, staff_last_name, staff_birth_date) VALUES ('W-1002','A-3001','B-1001','S-401','Male','Hannes','Zettel',to_date('1984-03-20','YYYY-MM-DD'));
INSERT INTO staff (staff_id, address_id, blood_bank_id, staff_category_code, gender_mfu, staff_first_name, staff_last_name, staff_birth_date) VALUES ('W-1003','A-3003','B-1003','S-402','Male','Martin','Schüssel',to_date('1974-01-21','YYYY-MM-DD'));
INSERT INTO staff (staff_id, address_id, blood_bank_id, staff_category_code, gender_mfu, staff_first_name, staff_last_name, staff_birth_date) VALUES ('W-1004','A-3002','B-1002','S-403','Male','Markus','Hofer',to_date('1991-10-10','YYYY-MM-DD'));

--INSERT into donors
INSERT INTO donors VALUES ('D-100','A-3000','B-1000','R-500','129538','Male',to_date('1991-10-10','YYYY-MM-DD'),'Erich','Johann','Schuber','069917019098','069915916905','06991701519','Lung Cancer','Stage 3 Cancer');
INSERT INTO donors (donor_id, address_id, blood_bank_id, religion_code, national_medical_number, gender_mfu, date_of_birth, first_name, last_name, cell_mobile_phone) VALUES ('D-101', 'A-3000','B-1000', 'R-501', '129500','Male', to_date('1990-11-11','YYYY-MM-DD'), 'Thomas', 'Schuber', '+4369917019050');
INSERT INTO donors (donor_id, address_id, blood_bank_id, religion_code, national_medical_number, gender_mfu, date_of_birth, first_name, last_name, cell_mobile_phone) VALUES ('D-102', 'A-3001','B-1001', 'R-502', '139503','Male', to_date('1985-12-12','YYYY-MM-DD'), 'Thomas', 'Klawatsch', '+4369912212052');
INSERT INTO donors (donor_id, address_id, blood_bank_id, religion_code, national_medical_number, gender_mfu, date_of_birth, first_name, last_name, cell_mobile_phone) VALUES ('D-103', 'A-3003','B-1003', 'R-503', '111513','Female', to_date('1980-12-12','YYYY-MM-DD'), 'Maria', 'Himmel', '+4365015012051');
INSERT INTO donors (donor_id, address_id, blood_bank_id, religion_code, national_medical_number, gender_mfu, date_of_birth, first_name, last_name, cell_mobile_phone) VALUES ('D-104', 'A-3003','B-1003', 'R-501', '132567','Female', to_date('1992-11-12','YYYY-MM-DD'), 'Kate', 'Pellerin', '069912012031');
INSERT INTO donors (donor_id, address_id, blood_bank_id, religion_code, national_medical_number, gender_mfu, date_of_birth, first_name, last_name, cell_mobile_phone) VALUES ('D-105', 'A-3003','B-1002', 'R-501', '112561','Female', to_date('1990-01-15','YYYY-MM-DD'), 'Jenny', 'Rose', '069916016069');
INSERT INTO donors (donor_id, address_id, blood_bank_id, religion_code, national_medical_number, gender_mfu, date_of_birth, first_name, last_name, cell_mobile_phone) VALUES ('D-106', 'A-3003','B-1002', 'R-501', '162581','Male', to_date('1990-05-12','YYYY-MM-DD'), 'Sean', 'Mendez', '069915015162');

--Insert into donations
INSERT INTO donations VALUES ('T-100','D-100',to_date('2020-11-12','YYYY-MM-DD'),'100 ml','Spende ohne Probleme');
INSERT INTO donations (donation_id, donor_id, donation_date) VALUES ('T-101','D-101',to_date('2020-11-13','YYYY-MM-DD'));
INSERT INTO donations (donation_id, donor_id, donation_date, other_details) VALUES ('T-102','D-102',to_date('2020-11-14','YYYY-MM-DD'),'100 ml');
INSERT INTO donations (donation_id, donor_id, donation_date) VALUES ('T-103','D-103',to_date('2020-11-15','YYYY-MM-DD'));
INSERT INTO donations (donation_id, donor_id, donation_date) VALUES ('T-104','D-101',to_date('2020-11-16','YYYY-MM-DD'));
INSERT INTO donations (donation_id, donor_id, donation_date) VALUES ('T-105','D-101',to_date('2018-01-16','YYYY-MM-DD'));
INSERT INTO donations (donation_id, donor_id, donation_date) VALUES ('T-106','D-101',to_date('2019-11-16','YYYY-MM-DD'));
INSERT INTO donations (donation_id, donor_id, donation_date) VALUES ('T-107','D-101',to_date('2015-02-16','YYYY-MM-DD'));
INSERT INTO donations (donation_id, donor_id, donation_date) VALUES ('T-108','D-101',to_date('2011-01-16','YYYY-MM-DD'));
INSERT INTO donations (donation_id, donor_id, donation_date) VALUES ('T-109','D-101',to_date('2011-12-16','YYYY-MM-DD'));
INSERT INTO donations (donation_id, donor_id, donation_date) VALUES ('T-110','D-101',to_date('2012-02-16','YYYY-MM-DD'));
INSERT INTO donations (donation_id, donor_id, donation_date) VALUES ('T-111','D-101',to_date('2012-03-16','YYYY-MM-DD'));
INSERT INTO donations (donation_id, donor_id, donation_date) VALUES ('T-112','D-101',to_date('2013-01-16','YYYY-MM-DD'));
INSERT INTO donations (donation_id, donor_id, donation_date) VALUES ('T-113','D-101',to_date('2014-06-16','YYYY-MM-DD'));
INSERT INTO donations (donation_id, donor_id, donation_date) VALUES ('T-114','D-101',to_date('2015-04-16','YYYY-MM-DD'));
INSERT INTO donations (donation_id, donor_id, donation_date) VALUES ('T-115','D-100',to_date('2017-01-16','YYYY-MM-DD'));
INSERT INTO donations (donation_id, donor_id, donation_date) VALUES ('T-116','D-104',to_date('2016-10-16','YYYY-MM-DD'));
INSERT INTO donations (donation_id, donor_id, donation_date) VALUES ('T-117','D-104',to_date('2016-05-16','YYYY-MM-DD'));
INSERT INTO donations (donation_id, donor_id, donation_date) VALUES ('T-118','D-105',to_date('2016-04-12','YYYY-MM-DD'));

--Insert into medical_conditions
INSERT INTO medical_conditions VALUES ('MC-100','Lung Cancer', 'Shortness of Breath, Chronic Cough, Pain in Chest','Life Threatening');
INSERT INTO medical_conditions VALUES ('MC-101','Acute Pancreatitis', 'Severe dull pain at stomach','Life Threatening');
INSERT INTO medical_conditions VALUES ('MC-102','Anxiety', 'Restlessness, Sense of dread','Life Threatening');
INSERT INTO medical_conditions VALUES ('MC-103','Asthma', 'Shortness of Breath, coughing, tightness in chest','Life Threatening');
INSERT INTO medical_conditions VALUES ('MC-104','Diabetes', 'Feeling very thirsty, feeling very tired','Life Threatening');

--INSERT into donors_medical_conditions
INSERT INTO donors_medical_conditions VALUES ('D-100','MC-100','Very Serious');
INSERT INTO donors_medical_conditions VALUES ('D-100','MC-101','Serious');
INSERT INTO donors_medical_conditions VALUES ('D-100','MC-102','Not Serious');
INSERT INTO donors_medical_conditions VALUES ('D-101','MC-102','Not Serious');
Insert Into donors_medical_conditions VALUES ('D-102','MC-101','Serious');

--INSERT INTO medications
INSERT INTO medications (medication_code, medication_name, medication_description) VALUES ('M-200','Adderall','Treats ADHD and narcolepsy.');
INSERT INTO medications (medication_code, medication_name, medication_description) VALUES ('M-201','Amitriptyline', 'Treats symptoms of depression.');
INSERT INTO medications (medication_code, medication_name, medication_description) VALUES ('M-202','Lexapro', 'Treats symptoms of anxiety.');
INSERT INTO medications (medication_code, medication_name, medication_description) VALUES ('M-203', 'Bleomycin', 'Treats symptoms of cancer.');
INSERT INTO medications (medication_code, medication_name, medication_description) VALUES ('M-204','Antibiotics', 'Treats symptoms of pancreatitis.');

--INSERT INTO DONORS_Medications
INSERT INTO donors_medications VALUES ('D-100','M-203','2x per day');
INSERT INTO donors_medications VALUES ('D-100','M-201','1x per day');
INSERT INTO donors_medications VALUES ('D-100','M-202','3x per day');
INSERT INTO donors_medications VALUES ('D-101','M-202','3x per day');
INSERT INTO donors_medications VALUES ('D-102','M-201','1x per day');

--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------

--Aufgabe_4_A
--1. "Namensliste aller Spender mit Diabetes" (view_Donors_Diabetes)
--Wichtig bei möglichen Nebenwirkungen während dem Blutspenden.

--2. "Blood Bank B-1000: Spendenanzahl geordnet nach Monat" (view_Monthly_Donations) 
--Um zu erkennen, an welchen Monaten am meisten gespendet wird bei B-1000.

--3. "Namensliste aller Spender die Antibiotics-Medikamente nehmen" (view_Donors_Antibiotics)
--Wichtig bei möglichen Nebenwirkungen während dem Blutspenden.

--4. "Spendenanzahl geordnet nach Orte" (view_donations_count) 
--Gibt an, an welchen Orten (der Bloodbanks) am meisten gespendet wird.

--5. "Alle BloodBanks anzeigen, die unter dem Durschnitts-Spendenwert liegen" (view_bloodbanks_below_donation_average)
--Kann zeigen, welche Blood-Banks wenig im Vergleich besucht werden.


------------------------Aufgabe_B----------------------
--"Spendenanzahl geordnet nach Ort"
CREATE VIEW view_Donations_Count
AS
SELECT  city, count(*) as Spendenanzahl FROM Blood_banks a
INNER JOIN addresses b ON a.address_id = b.address_id
INNER JOIN donors c ON a.blood_bank_id = c.blood_bank_id
INNER JOIN donations d ON d.donor_id = c.donor_id
group by city
order by spendenanzahl desc;
-- SELECT * FROM view_donations_count;

--2. "Blood Bank B-1000: Spendenanzahl geordnet nach Monat"
CREATE VIEW view_Monthly_Donations
AS
SELECT to_char(donation_date,'mm') as Month, count(*) as Donations FROM DONATIONS a
INNER JOIN DONORS b ON a.donor_id = b.donor_id
WHERE b.blood_bank_id = 'B-1000'
group by to_char(donation_date,'mm')
order by count(*) desc;
-- SELECT * FROM view_monthly_Donations;

----------------------------------Aufgabe C ---------------------------------------------------------
SET SERVEROUTPUT ON;

-- Kompilierfehler beim normalen durchlaufen möglicherweise?
-- Händisches auswählen sollts aber richitg kompilieren.

--Religion von Donor_ID als varchar2 zurückbekommen
--zB Christianity - Roman Catholic
--Könnte aus religiösen Fragen auch zur Frage kommen, ob diese Person noch immer bereit zum Spenden ist.
CREATE OR REPLACE FUNCTION religion_of_donor(donor_id varchar2) 
RETURN varchar2
IS
  religion varchar2(200);
BEGIN
   SELECT b.religion_name || ' - ' || b.other_details into religion FROM donors a
    INNER JOIN religions b ON a.religion_code = b.religion_code
    WHERE donor_Id = donor_ID
    FETCH FIRST 1 ROW ONLY;
return religion;
END;
--SELECT religion_of_donor('D-100') from dual;

-------------------------------------Aufgabe D---------------------------------------
-- Namensliste von Donors mit Telefonnummer und Medical Condition.
-- Man müsste da vielleicht beim Blutabnehmen zuerst nachfragen - oder regelmäßig - ob sich da etwas verändert hat.

CREATE OR REPLACE Procedure Conditions_Donors
IS
    cursor c_zeile is SELECT * FROM donors;
BEGIN
    dbms_output.put_line('Donors and their Medical Conditions:');
    FOR zeile in c_zeile loop
            dbms_output.put_line('');
            dbms_output.put_line(zeile.donor_id);
            
            if zeile.medical_condition is null then 
                dbms_output.put_line(zeile.first_name || ' ' || zeile.last_name || ', ' || zeile.gender_mfu || ': No condition.');
            else
                dbms_output.put_line(zeile.first_name || ' ' || zeile.last_name || ': ' || zeile.medical_condition);
            end if;
                dbms_output.put_line(zeile.cell_mobile_phone);
                dbms_output.put_line('Birthdate: ' || zeile.date_of_birth);
            if zeile.other_details is not null then 
                dbms_output.put_line('Other Details: ' || zeile.other_details);
            end if;
    end loop;
END;
-- EXECUTE conditions_donors;
-- 2. Idee wäre gewesen, eine Liste der Medikamenten für bestimmte Donors (Parameter donor_id varchar2) als Stored Procedure zu machen.