------------------------------------------------------
--              COUNTIES                            --
------------------------------------------------------


-- 99 rows
SELECT DISTINCT
county
FROM counties

-- 100 rows
SELECT DISTINCT
county
FROM sales

-- INNER JOIN 99 rows
SELECT DISTINCT
a.county,
b.county
FROM counties a
JOIN sales b
ON a.county = b.county

-- LEFT JOIN 100 ROWS
SELECT DISTINCT
a.county,
b.county
FROM sales a
LEFT JOIN counties b
ON a.county = b.county

-- RIGHT JOIN
SELECT DISTINCT
a.county,
b.county
FROM sales a
RIGHT JOIN counties b
ON a.county = b.county

--What are the NULLS?
SELECT DISTINCT
a.*,
b.county
FROM sales a
LEFT JOIN counties b
ON a.county = b.county
WHERE a.county IS NULL
LIMIT 100

-- Using COALESCE to substitute NULLS with a value
SELECT DISTINCT
a.county_number, 
COALESCE(b.county,'Corp')
FROM sales a
LEFT JOIN counties b
ON a.county = b.county
WHERE a.county IS NULL
LIMIT 100

-- Remove Exception
SELECT DISTINCT
a.county_number, 
COALESCE(b.county,'Corp')
FROM sales a
LEFT JOIN counties b
ON a.county = b.county
-- WHERE a.county IS NULL
LIMIT 100


/* NOTES
There is 1 store #0 that is not set up with a county. There are products and sales for this store
The store type is a convience store. Should this be included excluded or how should this be dealt with?
*/

--------------------------------------------
--             PRODUCTS                   --
--------------------------------------------

-- sales 3715 rows
SELECT DISTINCT item
FROM sales

-- products 9977 rows, we have a lot of products that are either not being sold or not selling
SELECT DISTINCT item_no
FROM products

-- INNER JOIN 3627 rows, there are products being sold that are not set up in the products table
SELECT DISTINCT a.item, b.item_no
FROM sales a
JOIN products b
ON a.item = b.item_no


-- LEFT JOIN 3715 rows, all products that are selling
SELECT DISTINCT a.item, b.item_no
FROM sales a
LEFT JOIN products b
ON a.item = b.item_no

-- RIGHT JOIN 9977 rows, all products set up in the products table
SELECT DISTINCT a.item, b.item_no
FROM sales a
RIGHT JOIN products b
ON a.item = b.item_no

-- LEFT EXCEPTION JOIN 88 rows, all products being sold that are not set up in products table
SELECT DISTINCT a.item, b.item_no
FROM sales a
LEFT JOIN products b
ON a.item = b.item_no
WHERE b.item_no IS NULL
