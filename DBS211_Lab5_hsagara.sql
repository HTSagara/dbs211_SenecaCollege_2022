-- ***********************
-- Name: Henrique Toshio Sagara
-- ID: 170954218
-- Date: 2022/10/16
-- Purpose: Lab 05 DBS211
-- ***********************

/*Q1.	Create a query that shows employee number, first name, last name, city, phone number and postal code for all employees 
in France.
a.	Answer this question using an ANSI-89 Join
b.	Answer this question using an ANSI-92 Join
*/

--ANSI-89
SELECT 
    employeenumber,
    firstname,
    lastname,
    city,
    phone,
    postalcode
FROM
    dbs211_employees,
    dbs211_offices;
    
--ANSI-92
SELECT 
    dbs211_employees.employeenumber,
    dbs211_employees.firstname,
    dbs211_employees.lastname,
    dbs211_offices.city,
    dbs211_offices.phone,
    dbs211_offices.postalcode
FROM
    dbs211_employees 
CROSS JOIN
    dbs211_offices;
    
/*Q2.	Create a query that displays all payments made by customers from Canada.  
a.	Sort the output by Customer Number.  
b.	Only display the Customer Number, Customer Name, Payment Date and Amount.  
c.	Make sure the date is displayed clearly to know what date it is.
(i.e. what date is 02-04-19??? – Feb 4, 2019, April 2, 2019, April 19, 2002, ….)
*/
SELECT 
    dbs211_payments.customernumber,
    dbs211_customers.customername,
    TO_CHAR(dbs211_payments.paymentdate, 'DD MON YYYY'),
    dbs211_payments.amount
FROM
    dbs211_payments
LEFT JOIN
    dbs211_customers
ON
    dbs211_payments.customernumber = dbs211_customers.customernumber
WHERE
    dbs211_customers.country = 'Canada'
ORDER BY 
   dbs211_customers.customernumber;
   
/*Q3.	Create a query that shows all USA customers who have not made a payment.  
Display only the customer number and customer name sorted by customer number.*/
SELECT
    dbs211_customers.customernumber,
    dbs211_customers.customername,
    dbs211_payments.amount
FROM
    dbs211_customers
LEFT JOIN
    dbs211_payments
ON
    dbs211_customers.customernumber = dbs211_payments.customernumber
WHERE
    UPPER(dbs211_customers.country) = 'USA'
AND
    dbs211_payments.amount IS NULL;

/*Q4.
a) Create a view (vwCustomerOrder) to list all orders with the following data for all customers:  
Customer Number, Order number, order date, product name, quantity ordered, and price for each product in every order. 
b) Write a statement to view the results of the view just created.
*/
CREATE VIEW vwCustomerOrder
AS SELECT 
    o.customernumber,
    od.ordernumber,
    o.orderdate,
    p.productname,
    count(o.ordernumber) quantity_ordered,
    p.msrp
FROM
    dbs211_orders o
LEFT JOIN
    dbs211_orderdetails od
ON
    o.ordernumber = od.ordernumber
LEFT JOIN
    dbs211_products p
ON
    od.productcode = p.productcode
GROUP BY
    o.customernumber, 
    od.ordernumber, 
    o.orderdate, 
    p.productname, 
    p.msrp;

SELECT * FROM vwcustomerorder;

/*Q5.	Using the vwCustomerOrder  view, display the order information for customer number 124. 
Sort the output based on order number and then order line number. (Yes, I know orderLineNumber is not in the view)*/
SELECT
    *
FROM
    vwcustomerorder
WHERE
    customernumber = 124;

/*Q6.	Create a query that displays the customer number, first name, last name, phone, and credit limits for all 
customers who do not have any orders.*/
SELECT
    c.customernumber,
    c.contactfirstname,
    c.contactlastname,
    c.phone,
    c.creditlimit,
    COUNT(o.ordernumber) AS numoforders
FROM
    dbs211_customers c
LEFT JOIN
    dbs211_orders o
ON
    c.customernumber = o.customernumber
    
GROUP BY
     c.customernumber,
    c.contactfirstname,
    c.contactlastname,
    c.phone,
    c.creditlimit
HAVING COUNT(o.ordernumber) = 0
;

/*Q7.	Create a view (vwEmployeeManager) to display all information of all employees and the name and the last name
of their managers if there is any manager that the employee reports to.  Include all employees, including those who do 
not report to anyone.*/
CREATE VIEW vwEmployeeManager
AS SELECT 
    emp1.*,
    emp2.firstname AS mgrname,
    emp2.lastname AS msglastname
FROM
    dbs211_employees emp1
LEFT JOIN
    dbs211_employees emp2
ON
    emp1.reportsto = emp2.employeenumber
GROUP BY
    emp1.employeenumber,
    emp1.lastname,
    emp1.firstname,
    emp1.extension,
    emp1.email,
    emp1.officecode,
    emp1.reportsto,
    emp1.jobtitle,
    emp2.firstname,
    emp2.lastname
ORDER BY
    emp1.employeenumber;

SELECT * FROM vwEmployeeManager;
/*Q8.	Modify the employee_manager view so the view returns only employee information for employees who have a manager. 
Do not DROP and recreate the view – modify it. (Google is your friend).*/
CREATE OR REPLACE VIEW vwEmployeeManager
AS SELECT 
    emp1.*,
    emp2.firstname AS mgrname,
    emp2.lastname AS msglastname
FROM
    dbs211_employees emp1
LEFT JOIN
    dbs211_employees emp2
ON
    emp1.reportsto = emp2.employeenumber
GROUP BY
    emp1.employeenumber,
    emp1.lastname,
    emp1.firstname,
    emp1.extension,
    emp1.email,
    emp1.officecode,
    emp1.reportsto,
    emp1.jobtitle,
    emp2.firstname,
    emp2.lastname
HAVING
    emp2.firstname IS NOT NULL
ORDER BY
    emp1.employeenumber;
SELECT * FROM vwEmployeeManager;
/*Q9.	Drop both customer_order and employee_manager views. */
DROP VIEW   vwcustomerorder;
DROP VIEW   vwemployeemanager;