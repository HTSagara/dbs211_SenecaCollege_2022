/*Q1.Display the data for all offices. Display office code, city, state, country, and phone for all offices.*/
select
   * 
from
   dbs211_offices;
   
/*Q2.	Display employee number, first name, last name, and extension for all employees whose office code is 1. Sort the result 
based on the employee number.*/
select
   employeenumber,
   firstname,
   lastname,
   extension 
from
   dbs211_employees 
where
   officecode = 1
order by 
    employeenumber;
    
/*Q3.	Display customer number, customer name, contact first name and contact last name, and phone for all customers in Paris. 
(hint: be wary of case sensitivity) Sort the result based on the customer number.
*/
select
    customernumber,
    customername,
    contactfirstname,
    contactlastname,
    phone
from
    dbs211_customers
where
    city= 'Paris'
order by
    customernumber;
    
/*Q4.	Repeat the previous Query with a couple small changes:

a.	The contact’s first and last name should be in a single column in the format “lastname, firstname”.
b.	Show customers who are in Canada
c.	Sort the result based on the customer name.
*/
select
    customernumber,
    customername,
    contactlastname||', '||contactfirstname as fullcontactname,
    phone
from
    dbs211_customers
where
    country = 'Canada'
order by
    customername;
    
/*Q5.	Display customer number for customers who have payments.  Do not included any repeated 
values. Sort the result based on the customer number. (Hints: How do you know a customer has made a payment? You will need to 
access only one table for this query)
The first 10 rows of the output result. The query returns 98 rows.
*/
select
    unique(customernumber)
from
    dbs211_payments
where
    paymentdate is not null
fetch first 10 rows only;

/*Q6.	List customer numbers, check number, and amount for customers whose payment amount is not in the range of $1,500 to 
$120,000. Sort the output by top payments amount first.
*/

select 
    customernumber,
    checknumber,
    amount
from
    dbs211_payments
where 
    amount 
not between 1500 and 120000;

/*Q7.	Display order number, order date, status, and customer number for all orders that are cancelled. Sort the result 
according to order date.
*/
select
    ordernumber,
    orderdate,
    status,
    customernumber
from 
    dbs211_orders
where
    status != 'Cancelled'
order by
    orderdate;
    
/*Q8.	The company needs to know the percentage markup for each product sold.  Produce a query that outputs the ProductCode, 
ProductName, BuyPrice, MSRP in addition to
a.	The difference between MSRP and BuyPrice (i.e. MSRP-BuyPrice) called markup
b.	The percentage markup (100 * calculated by difference / BuyPrice) called percmarkup
rounded to 1 decimal place.
c.	Sort the result according to percmarkup.
d.	Show products with percmarkup greater than 140.
*/
select
    productcode,
    productname,
    buyprice,
    msrp
from dbs211_products;
