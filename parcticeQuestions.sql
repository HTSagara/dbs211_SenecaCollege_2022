--Q1
SELECT
   title,
   retail 
FROM
   books 
WHERE
   retail < (
   select
      avg(retail) 
   FROM
      books);
--Q2
SELECT
   category,
   avg(cost) 
FROM
   books 
GROUP BY
   category;
   
SELECT
   b1.title,
   b1.category,
   b1.cost 
FROM
   books b1,
   (
      SELECT
         category,
         avg(cost) AVGCOST 
      FROM
         books 
      GROUP BY
         category
   )
   b2 
WHERE
   b1.category = b2.category 
   AND b1.cost < b2.avgcost;

--Q3
SELECT SHIPSTATE FROM ORDERS WHERE ORDER#=1014;
SELECT
   ORDER# 
FROM
   ORDERS o1,
   (
      SELECT
         SHIPSTATE 
      FROM
         ORDERS 
      WHERE
         ORDER# = 1014
   )
   o2 
WHERE
   o1.shipstate = o2.shipstate;
   
--Q4
select category, avg(retail), max(retail) from books group by category;


select o.order#, c.firstname from orders o left join customers c ON o.customer# = c.customer# where shipstate = 'FL';