
/*
SELECT item, description
FROM sales
LIMIT 100 */

-- CONCAT(field1, field2, field3…)

SELECT CONCAT(item,' -  ',description)
FROM sales
LIMIT 100


-- LENGTH(field1)
-- Use case Understanding your data, MIN MAX, ... Use order by to view top and bottoms
SELECT LENGTH(vendor), Vendor
FROM sales
LIMIT 100


-- LOWER: Converts a field or expression to lowercase.
Syntax: LOWER(field1)
Syntax: UPPER(field1)

SELECT UPPER(CONCAT(item,' -  ',description))
FROM sales
LIMIT 100


LEFT: Selects characters from left side.
RIGHT: Selects characters from right side.

LEFT(field1, length)

SELECT CONCAT(item,' -  ',description),  
LEFT(LOWER(CONCAT(item,' -  ',description)),5)
FROM sales
LIMIT 100


SUBSTRING(field1, starting_position, number_of_characters)

SELECT SUBSTRING(CONCAT(item,' -  ',description),9,35)
FROM sales
LIMIT 100

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

-- EXERCISE
-- Using Split_part, substring, concat and lower, Turn Category_name from products in to proper case
Left/Right Trim:
LTRIM(field1)

SELECT LTRIM(CONCAT(item,' -  ',description))
FROM sales
LIMIT 100



TRIM: Removes specified characters from start of field, ending part of field, or both.
SYNTAX
TRIM( leading ‘characters’, from field1)
TRIM( trailing ‘characters’, from field1)
TRIM( both ‘characters’, from field1)	
EXAMPLE
SELECT 
description, 
TRIM( Leading 'A' from description), 
TRIM (TRAILING 'a' from description), 
TRIM(BOTH 'A' FROM description)
FROM sales
LIMIT 100

-- Exercise
-- remove any MISC at the beginning of any category name

RELACE(field_to_change,  content_to_replace,  new_content)
EXAMPLE
SELECT REPLACE(description, 'Absolut', 'Grey Goose')
FROM sales
LIMIT 100

 
CURRRENT_ DATE returns the current date from the system.

SELECT item, total, date, CURRENT_DATE
FROM sales
LIMIT 100

AGE returns the difference between two dates. 
SYNTAX
Age( date1, date2)
EXAMPLE
SELECT item, total, date, CURRENT_DATE, age(date, CURRENT_DATE)
FROM sales
LIMIT 100

-- system functions
SELECT NOW()
-- another way to CAST
SELECT NOW()::date

-- To manipulate dates further you may need to turn them into a charecter
-- 
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
EXERCISE
You may or may not complete the following problem in the class time. 
Continue to work through it, though, and see if you can come up with a solution. 
 
Categorize all of the items by age, based on list date and ranges of: 
0-10 years, 11-20 years, 21-30 years, 31-40 years and 41+ years. 
Then bring in the total sales.
*/

--SOLUTION


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













