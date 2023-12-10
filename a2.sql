
-- Question 1
CREATE TABLE medical_record (
rec_no SMALLINT UNSIGNED,
patient CHAR(9),
doctor CHAR(9),
entered_on DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
diagnosis MEDIUMTEXT NOT NULL,
treatment TEXT(1000),
CONSTRAINT fk_patient
	FOREIGN KEY (patient) REFERENCES patient(ni_number)
	ON DELETE CASCADE  ON UPDATE RESTRICT,
CONSTRAINT fk_doctor
	FOREIGN KEY (doctor) REFERENCES doctor(ni_number)
	ON DELETE SET NULL  ON UPDATE RESTRICT,
PRIMARY KEY (rec_no,patient)	);



 
-- Question 2
ALTER TABLE medical_record
	ADD COLUMN duration TIME;


-- Question 3
UPDATE doctor
SET salary = salary * 0.9
WHERE expertise = 'ear'; 


-- Question 4
SELECT fname,lname,YEAR(date_of_birth) AS born FROM patient
WHERE city LIKE '%right%'
ORDER BY lname ASC, fname ASC;

-- Question 5
SELECT ni_number,fname,lname,ROUND(weight/POWER(height/100,2),3) AS BMI FROM patient 
WHERE TIMESTAMPDIFF(YEAR,date_of_birth,CURDATE()) < 30;


-- Question 6
SELECT COUNT(ni_number) AS number FROM doctor;


-- Quesiton 7
SELECT d.ni_number,d.lname,
(SELECT COUNT(*) FROM carries_out AS c WHERE c.doctor = d.ni_number) AS operations
FROM doctor AS d
ORDER BY operations DESC;


-- Question 8
SELECT m.ni_number,UPPER(LEFT(m.fname,1)) AS init,m.lname
FROM doctor AS m, doctor AS mb
WHERE m.mentored_by IS NULL AND m.ni_number = mb.mentored_by; 


-- Question 9
SELECT one.theatre_no AS theatre,one.start_date_time AS start_time1,TIME(two.start_date_time) AS start_time2
FROM operation AS one
INNER JOIN operation AS two 
ON two.start_date_time > one.start_date_time AND
ADDTIME(one.start_date_time,one.duration) > two.start_date_time AND 
one.theatre_no = two.theatre_no;



-- Question 10
SELECT theatre_no,DAY(start_date_time) AS dom,MONTHNAME(start_date_time) AS month,YEAR(start_date_time) AS year, 
tot AS num_ops 
FROM(SELECT theatre_no, DATE(start_date_time) AS start_date_time,COUNT(*) AS tot FROM operation GROUP BY DATE(start_date_time),theatre_no ORDER BY theatre_no) AS t
WHERE tot = (SELECT MAX(tot) FROM (SELECT theatre_no, DATE(start_date_time) AS start_date_time,COUNT(*) AS tot FROM operation GROUP BY DATE(start_date_time),theatre_no ORDER BY theatre_no) AS d);


-- Question 11
delimiter $$


