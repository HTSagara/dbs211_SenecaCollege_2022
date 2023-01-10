-- ***********************
-- Name: Henrique Toshio Sagara
-- ID: 170954218
-- Date: 2022/10/07
-- Purpose: Lab 04 DBS211
-- ***********************
/* Q1.	Create a new empty table employee2 the same as table employees.  
Use a single statement to create the table and insert the data at the same time.*/
CREATE TABLE employee2
AS SELECT * 
FROM dbs211_employees;

ALTER TABLE employee2 ADD PRIMARY KEY (employeenumber);
ALTER TABLE employee2 ADD CONSTRAINT emp2_office_fk FOREIGN KEY (officecode) REFERENCES dbs211_offices;
ALTER TABLE employee2 ADD CONSTRAINT emp2_rtemp_FK FOREIGN KEY (reportsto) REFERENCES employee2;

/*Q2.	Modify table employee2 and add a new column username to this table. The 
value of this column is not required and does not have to be unique.*/
ALTER TABLE employee2
ADD username VARCHAR(20);

/*Q3.	Delete all the data in the employee2 table*/
DELETE FROM employee2;

/*Q4.	Re-insert all data from the employees table into your new table employee2 
using a single statement.*/
INSERT INTO
   employee2 (employeenumber, lastname, firstname, extension, email, officecode, reportsto, jobtitle) 
   SELECT
      employeenumber,
      lastname,
      firstname,
      extension,
      email,
      officecode,
      reportsto,
      jobtitle 
   FROM
      dbs211_employees;

--Q5.	Create a statement that will insert yourself as an employee into employee2.  

/*a.	Use a unique employee number of your choice (Hint: Find the highest value of 
the employee number in the dbs211_employees table, increase the value by one and
use it as your employee number.)
To find the highest value of the employee number you can sort the rows in the 
descending order. The first row will then contain the highest value.
Or, you can run the following statement (Do not include this statement in your 
submission.)

SELECT max(employeenumber)
FROM	dbs211_employees;

This statement returns the maximum value of the employee number in table 
dbs211_employees.

b.	Use your school email address
c.	Your extension is ‘x2222’
d.	Your job title will be “Cashier”
e.	Office code will be 4
f.	You will report to employee 1088
g.	You do not have any username
*/
INSERT INTO
   employee2 
VALUES
   (1703, 'Sagara', 'Henrique', 'x2222', 'hsagara@myseneca.ca', 4, 1088, 'Cashier', null);

/*Q6.	Create a query that displays your, and only your, employee data.*/
SELECT
   * 
FROM
   employee2 
WHERE
   employee2.firstname = 'Henrique';
   
/*Q7.	Create a statement to update your job title to “Head Cashier”.
Hint: Be careful. You may update other rows or all rows in the employee table. 
You only need to update one row which belongs to you and update your job title. 
Make sure that your query updates only one employee using a WHERE clause.*/
UPDATE  employee2
SET jobtitle = 'Head Cashier'
WHERE employee2.firstname = 'Henrique';

/*Q8.	Create a statement to insert another fictional employee into employee2. 
This employee will be a “Cashier” and will report to you.  Make up fake data for
the other fields. The fake employee does not have any username.*/
INSERT INTO
   employee2 
VALUES
   (1704, 'Sagara', 'Gustavo', 'x2222', 'gsagara@myseneca.ca', 4, 1703, 'Cashier', null);

/*Q9.	Create a statement to delete yourself from employee2.  Did it work?  
If not, why?*/
DELETE
FROM
   employee2 
WHERE
   employee2.firstname = 'Henrique' 
   and employee2.lastname = 'Sagara';

/*Q10.	Create a statement to delete the fake employee from employee2 and then 
rerun the statement to delete yourself.  Did it work? Explain why?*/
DELETE
FROM
   employee2 
WHERE
   employee2.firstname = 'Gustavo' 
   and employee2.lastname = 'Sagara';
   
/*Q11.	Create a single statement that will insert both yourself and the fake 
employee at the same time.  This time you and the fake employee will report to 1088.*/
INSERT ALL 
INTO employee2
(employeenumber, lastname, firstname, extension, email, officecode, reportsto, jobtitle, username) 
VALUES (1703, 'Sagara', 'Henrique', 'x2222', 'hsagara@myseneca.ca', 4, 1088, 'Cashier', null)
INTO employee2
(employeenumber, lastname, firstname, extension, email, officecode, reportsto, jobtitle, username)
VALUES (1704, 'Fake', 'Fake', 'x2222', 'fake@myseneca.ca', 4, 1088, 'Cashier', null)
SELECT * FROM dual;

SELECT * FROM employee2;
/*Q12.	Create a single statement to delete both yourself and the fake employee from employee2.*/
DELETE
FROM
   employee2 
WHERE
   employeenumber = 1703 OR employeenumber = 1704;
   
/*Q13.	In table employee2, generate the email address for column username for each student
by concatenating the first character of employee’s first name and the employee’s last name. 
For instance, the username of employee Peter Stone will be pstone. NOTE: the username is in 
all lower case letters. */
UPDATE employee2
   SET username = LOWER(SUBSTR(firstname,1,1) || lastname);
   
/*Q14.	In table employee2, remove all employees with office code 4. */
DELETE
FROM
   employee2 
WHERE
   officecode = 4;

/*Q15.	Drop table employee2. */
DROP TABLE employee2;