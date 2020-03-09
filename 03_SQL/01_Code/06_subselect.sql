 /* COMMON TABLE EXPRESSIONS(CTE) and Inline Views otherwise known as SUBSELECTS
 
A CTE is a temporary result set that is created from an SQL statement. The temp result is not stored
but can be used to run another query off of within the same statement.

You have done this before with a calculator. If you add 1+1 you will see the result of 2
The number 2 is temporarily stored in the result view of the calculator but you can run more
calculations over that temp number like * 4  you will get 8 then you can +4 to get 12. However, once you
turn the calculator off and on those numbers are gone, not stored. Same with CTE's and inline views.

Few of the main reasons why you might use a CTE
1. Running an aggregate over an aggregate. You may recall the shout out to not being able to run an AVG(COUNT(fiedl))
with a CTE you could run a query that does the count then run another query over that result set which now views that count as 
a value not a function. and run the average over the value. 

example

COUNT(stores) as NoLongerCount_Just_a_Value

AVG(NoLongerCount_Just_a_Value)


2. Another reason is using the Subselect is to create a filter on your data and then run your query. Example would be you 
have 2 massive files, you could filter each one down to smaller tables before joining them. This would provide optimization
*/

-- AGGREGATE and AGGREGATE EXAMPLE
/* first we will review the queries seperatly then put them together*/
SELECT 
   county,
   COUNT(DISTINCT store) AS NumOfStores, -- when you run this query take not the function turns into a field with values
   SUM(total) AS total_sales
   FROM sales
   WHERE category_name LIKE '%TEQUILA%'
   GROUP BY county, store
   HAVING count(store)>2 AND sum(total)<10000 
 
-- The next query we would want to run is, this wont run because the above query is 
SELECT county,
       SUM(NumOfStores)
FROM county_sales
GROUP BY county;

/*This would take that new field and sum it because it is no longer the count. The problem though is because we are running 
a new query it is like turning the calculator off and back on we have lost that temporary info from the first query. 
Solution! put them all in 1 query */

 /* Step 1 Using WITH, create a temp table called county_sales that retrieves county, store number of stores 
 and total sales where catagory name is like TEQUILA and counties have more than 5 stores plus more than
 Step 2 you can now build a query to query your temp table county_sales*/
 WITH county_sales AS (
                       SELECT 
                       county,
 		                      COUNT(DISTINCT store) AS NumOfStores, 
                              SUM(total) AS total_sales
                       FROM sales
                       WHERE category_name LIKE '%TEQUILA%'
                       GROUP BY county, store
                       HAVING count(store)>2 AND sum(total)<10000 
                       )  

SELECT county,
       SUM(NumOfStores)
FROM county_sales
GROUP BY county; 


/* Here is the exact same example just built a different way using what is known as an inline view
There is not much difference in performance choosing 1 vs the other comes down to style(readability)
and if you will use the view or temp table more than once. Prime example of using a temp table or view more than once
is a UNION. In this case an inline view will be pretty messy. Where as with a the CTE you only have to code it once. */
-- Inline view
SELECT county, SUM(NumOfStores)
FROM 
     (SELECT county, store, COUNT(DISTINCT store) AS NumOfStores, 
      SUM(total) AS total_sales
      FROM sales
      WHERE Category_name LIKE '%TEQUILA%'
      GROUP BY county, store
      HAVING count(store)>20 AND sum(total)>500000 ) AS county_sales
GROUP BY county





/* USING CTE AND INLINE VIEWS TO Joining 2 subselects together */

WITH 
a AS (SELECT county, COUNT(DISTINCT county) as county_cnt, SUM(population)
FROM counties
WHERE population >5000
GROUP BY county),

b AS (SELECT county, store, sum(total) as total_sales 
FROM sales 
GROUP BY  county, store),

SELECT *
FROM a
JOIN b
ON a.county = b.county 

-- same example but with an inline view

SELECT *
FROM

(SELECT county, population
FROM counties
WHERE population >5000) as a

JOIN

(SELECT county, sum(total) as total_sales 
FROM sales 
GROUP BY  county) as b

ON a.county = b.county 

-- Here is an example of creating 2 temp tables, joining them and then doing some math
WITH
A AS (
SELECT county, count(DISTINCT county) AS Total_county
FROM counties
GROUP BY county ),
B AS (SELECT county, count(DISTINCT county) AS HS_county
FROM sales
WHERE category_name ILIKE 'tequila'      
GROUP BY county
HAVING SUM(total)>1000000)
SELECT 
SUM(a.Total_county), SUM(b.HS_county), CONCAT((CAST(SUM(b.HS_county)/SUM(a.Total_county)*100 AS DEC))::numeric (3,2),'%')
FROM A a
LEFT JOIN B b
ON a.county=b.county

-- To review more on Workflows check out SELECT INTO
