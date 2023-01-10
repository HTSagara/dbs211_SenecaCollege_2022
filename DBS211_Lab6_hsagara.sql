-- ***********************
-- Name: Henrique Toshio Sagara
-- ID: 170954218
-- Date: Oct 22 2022
-- Purpose: Lab 06 DBS211
-- ***********************


--Question 1
--1.Create a blank sheet connecting to the server.
--2.BEGIN statement .
--3.COMMIT statement saves the current transaction and starts a new one.
--4.Executing data definition language (DDL) statements which triggers the auto commit.

--Question 2
CREATE TABLE newEmployees (
    employeenumber PRIMARY KEY, 
    lastname, 
    firstname, 
    extension, 
    email, 
    officecode, 
    reportsto, 
    jobtitle) 
AS SELECT
   * 
FROM
   dbs211_employees 
WHERE
   1 = 2;

--Question 3
SET AUTCOMMIT OFF; --I copied exactly from the word document, but it didn't work.
SET TRANSACTION READ WRITE;

--Question 4
INSERT ALL INTO newEmployees 
VALUES
   (
      100, 'Patel', 'Ralph', '22333', 'rpatel@mail.com', '1', NULL, 'Sales Rep'
   )
   INTO newEmployees 
   VALUES
      (
         101, 'Denis', 'Betty', '33444', 'bdenis@mail.com', '4', NULL, 'Sales Rep'
      )
      INTO newEmployees 
      VALUES
         (
            102, 'Biri', 'Ben', '44555', 'bbirir@mail.com', '2', NULL, 'Sales Rep'
         )
         INTO newEmployees 
         VALUES
            (
               103, 'Newman', 'Chad', '66777', 'cnewman@mail.com', '3', NULL, 'Sales Rep'
            )
            INTO newEmployees 
            VALUES
               (
                  104, 'Ropebur', 'Audrey', '77888', 'arepebur@mail.com', '1', NULL, 'Sales Rep'
               )
               SELECT
                  * 
               FROM
                  DUAL;

--Question 5
SELECT 
    * 
FROM
    newEmployees;
--5

--Question 6
ROLLBACK;


--Question 7
INSERT ALL INTO newEmployees 
VALUES
   (
      100, 'Patel', 'Ralph', '22333', 'rpatel@mail.com', '1', NULL, 'Sales Rep'
   )
   INTO newEmployees 
   VALUES
      (
         101, 'Denis', 'Betty', '33444', 'bdenis@mail.com', '4', NULL, 'Sales Rep'
      )
      INTO newEmployees 
      VALUES
         (
            102, 'Biri', 'Ben', '44555', 'bbirir@mail.com', '2', NULL, 'Sales Rep'
         )
         INTO newEmployees 
         VALUES
            (
               103, 'Newman', 'Chad', '66777', 'cnewman@mail.com', '3', NULL, 'Sales Rep'
            )
            INTO newEmployees 
            VALUES
               (
                  104, 'Ropebur', 'Audrey', '77888', 'arepebur@mail.com', '1', NULL, 'Sales Rep'
               )
               SELECT
                  * 
               from
                  DUAL;
COMMIT;
SELECT
   * 
from
   newEmployees;

--Question 8
UPDATE
   newEmployees 
SET
   jobtitle = 'unknown';

--Question 9
COMMIT;

--Question 10
ROLLBACK;


--Question 11
COMMIT;
DELETE FROM newEmployees;

--Question 12
CREATE VIEW vwNewEmps AS 
SELECT
   * 
FROM
   newEmployees 
ORDER BY
   lastname,
   firstname;

--Question 13
ROLLBACK;
SELECT 
    * 
FROM 
    newEmployees;


--Question 14
COMMIT;
INSERT ALL INTO newEmployees 
VALUES
   (
      100, 'Patel', 'Ralph', '22333', 'rpatel@mail.com', '1', NULL, 'Sales Rep'
   )
   INTO newEmployees 
   VALUES
      (
         101, 'Denis', 'Betty', '33444', 'bdenis@mail.com', '4', NULL, 'Sales Rep'
      )
      INTO newEmployees 
      VALUES
         (
            102, 'Biri', 'Ben', '44555', 'bbirir@mail.com', '2', NULL, 'Sales Rep'
         )
         INTO newEmployees 
         VALUES
            (
               103, 'Newman', 'Chad', '66777', 'cnewman@mail.com', '3', NULL, 'Sales Rep'
            )
            INTO newEmployees 
            VALUES
               (
                  104, 'Ropebur', 'Audrey', '77888', 'arepebur@mail.com', '1', NULL, 'Sales Rep'
               )
               SELECT
                  * 
               FROM
                  DUAL;

--Question 15
SAVEPOINT insertion;

--Question 16
UPDATE
   newEmployees 
SET
   jobtitle = 'unknown';
SELECT
   * 
FROM
   newEmployees;


--Question 17
ROLLBACK to SAVEPOINT insertion;
SELECT
   * 
FROM
   newEmployees;


--Question 18
ROLLBACK;
SELECT
   * 
FROM
   newEmployees;

--Question 19
REVOKE ALL 
ON newEmployees 
FROM
   PUBLIC;

--Question 22
GRANT 
SELECT
   on newEmployees TO dbs211_223zbb24;

--Question 21
GRANT INSERT, 
UPDATE
, 
   DELETE
      ON newEmployees TO dbs211_223zbb24;

--Question 22
REVOKE ALL 
ON newEmployees 
FROM
   dbs211_223zbb24;

--Question 23
DROP TABLE newEmployees;
DROP VIEW vwNewEmps;
COMMIT;
