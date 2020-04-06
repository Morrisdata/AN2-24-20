
------STRING FUNCTIONS------

-- LENGTH(field1)
-- Use case Understanding your data, MIN MAX, ... Use order by to view top and bottoms
SELECT LENGTH(vendor), Vendor
FROM sales
LIMIT 100


-- CONCAT(field1, field2, field3…)

SELECT CONCAT(item,' -  ',description)
FROM sales
LIMIT 100

-- BREAK Try concat on your own  with 3 fields in the stores table 


-- LOWER: Converts a field or expression to lowercase.
-- Syntax: LOWER(field1)
-- Syntax: UPPER(field1)

SELECT UPPER(CONCAT(item,' -  ',description))
FROM sales
LIMIT 100


-- LEFT: Selects characters from left side.
-- RIGHT: Selects characters from right side.

-- SYNTAX: LEFT(field1, length)

SELECT CONCAT(item,' -  ',description),  
LEFT(LOWER(CONCAT(item,' -  ',description)),5)
FROM sales
LIMIT 100

--- BREAK Use LEFT to Bring back 3 from the left side of county in the counties table

SELECT counties
FROM county


-- SUBSTRING(field1, starting_position, number_of_characters)

SELECT SUBSTRING(CONCAT(item,' -  ',description),9,35)
FROM sales
LIMIT 100



-- BREAK using substring from starting position 9 bring back 5 characters from description in sales
SELECT category_name
FROM sales
limit 100

-- BREAK use the above code in a where clause to only bring back Category with VODKA do not use ILIKE



-- SPLIT_PART ( split_part(field, what constitutes split, which number of the split))
SELECT category_name,
split_part(category_name, ' ', 1),
split_part(category_name, ' ', 2),
split_part(category_name, ' ', 3),
split_part(category_name, ' ', 4),
split_part(category_name, ' ', 5)
FROM products
WHERE category_name IS NOT NULL
ORDER BY 6 DESC


-- BREAK How might you use this in Mozilla firefox data? 10 minute exercise

-- EXERCISE
-- Using Split_part, substring, concat and lower, Turn Category_name from products in to proper case






-- Left/Right Trim:
-- LTRIM(field1)

SELECT 
LENGTH(description), 
LENGTH(CONCAT(description,'    ')),
LENGTH(RTRIM(CONCAT(description,'   ')))
FROM sales
LIMIT 100



-- TRIM: Removes specified characters from start of field, ending part of field, or both.
-- SYNTAX
-- TRIM( leading ‘characters’, from field1)
-- TRIM( trailing ‘characters’, from field1)
-- TRIM( both ‘characters’, from field1)	

-- EXAMPLE
SELECT 
description, 
TRIM( Leading 'A' from description), 
TRIM (TRAILING 'a' from description), 
TRIM(BOTH 'A' FROM description)
FROM sales
LIMIT 100

-- Exercise
-- Remove any MISC at the beginning of any category name

RELACE(field_to_change,  content_to_replace,  new_content)
EXAMPLE
SELECT REPLACE(description, 'Absolut', 'Grey Goose')
FROM sales
LIMIT 100

--------------------------------------------------------
--                DATES
--------------------------------------------------------
--CURRRENT_ DATE returns the current date from the system.

SELECT item, total, date, CURRENT_DATE
FROM sales
LIMIT 100

SELECT 
CURRENT_DATE,
CURRENT_DATE - 1 AS YESTERDAY,
CURRENT_DATE - 7 AS LAST_WEEK,  
CURRENT_DATE - 30 AS LAST_PERIOD, 
CURRENT_DATE - 365 AS LAST_YEAR,
CURRENT_DATE - 366 AS YESTERDAY_LAST_YEAR,
CURRENT_DATE - 372 AS LAST_WEEK_LAST_YEAR,
CURRENT_DATE - 395 AS LAST_PERIOD_LAST_YEAR

-- BREAK try the above code What other special dates can you think of?

-- INTERVIEW TYPE QUESTION " how would you get sales from last week on a rolling basis"
SELECT sales
FROM table
WHERE sales_date = CURRENT_DATE - 7

-- daily query to temp table "Special Days". 



-- AGE returns the difference between two dates. 
-- SYNTAX
-- AGE( date1, date2)

-- EXAMPLE
SELECT item, total, date, CURRENT_DATE, age(CURRENT_DATE, date)
FROM sales
LIMIT 100

-- System functions
SELECT NOW()

-- another way to CAST
SELECT NOW()::date

-- To manipulate dates further you may need to turn them into a charecter
-- TO_CHAR
SELECT TO_CHAR(NOW() :: DATE, 'dd/mm/yyyy');

/*
How are dates used in your department? 
●	Billing date by day of week? 
●	Changes in day of week by year? 
●	Comparison of days of the week by two dates? 
●	Estimation based on day of week? 
●	Estimation based on previous year? 
●	How many customers on a given day? 
●	Order date to ship date?
*/

/*
Putting it all together
*/


SELECT DISTINCT b.item_no, b.item_description, b.list_date,
CASE 
	WHEN CAST(LEFT(CAST(AGE(CURRENT_DATE, b.list_date) as varchar),2)as integer) BETWEEN 0 AND 10 THEN '0-10 YEARS'
	WHEN CAST(LEFT(CAST(AGE(CURRENT_DATE, b.list_date) as varchar),2)as integer) BETWEEN 11 AND 20 THEN '11-20 YEARS' 
	WHEN CAST(LEFT(CAST(AGE(CURRENT_DATE, b.list_date) as varchar),2)as integer) BETWEEN 21 AND 30 THEN '21-30 YEARS'
	WHEN CAST(LEFT(CAST(AGE(CURRENT_DATE, b.list_date) as varchar),2)as integer) BETWEEN 0 AND 10 THEN '31-40 YEARS'
	ELSE  '41+ YEARS'
	END AS "YEAR BINS",
	SUM(a.total) 
FROM sales a
JOIN products b
ON a.item = b.item_no
GROUP BY b.item_no, b.item_description
ORDER BY 3 
LIMIT 1000

/* 
What is a good first step when approaching any new SQL problem? 
Answer: Keep it simple and get something basic working, first.
*/








