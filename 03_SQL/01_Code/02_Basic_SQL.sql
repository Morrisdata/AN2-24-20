----------------------------------------------------------------
-- SELECT FROM LIMIT                                          --
----------------------------------------------------------------

/* Starting a complex SELECT statement always begins with */
SELECT *
FROM products
LIMIT 100

-- Once you see your results you can then choose some fields that are interesting to you
SELECT  vendor, item_description, bottle_price
FROM products
LIMIT 100

-- Once you see your results you can then choose some fields that are interesting to you
SELECT  vendor, item_description, bottle_price
FROM products
--ORDER BY bottle_price
--ORDERY BY 3
--ORDER BY vendor_name, item_description 
ORDER BY inner_pack+1
LIMIT 100



-- BUILD THE CODE
'I would like to see all of the stores we have their status and addresses, 
Sorted by Status ascending and store_name descending
'




-----------------------------------------------------
--    MATH, AS AND CAST                             -
-----------------------------------------------------
-- bottle_price is how much it costs a store to buy a bottle, lets factor in cost of shipping at 2%
SELECT  vendor, item_description, bottle_price*.02
FROM products
LIMIT 100


SELECT  vendor, item_description, bottle_price, bottle_price*.02,  (bottle_price*.02)+bottle_price
FROM products
LIMIT 100

SELECT  vendor, item_description, bottle_price, bottle_price*.02 AS shipping_est,  (bottle_price*.02)+bottle_price AS NLC
FROM products
LIMIT 100

-- CAST(field AS data type)
-- let's say in the above scenario you now want to calculate profit
SELECT  
vendor, 
item_description, 
bottle_price, 
bottle_price*.02 AS markup,  
(bottle_price*.02)+bottle_price AS new_price,
shelf_price - (bottle_price*.02)+bottle_price

FROM products
LIMIT 100

--SOLUTION
SELECT  
vendor, 
item_description, 
bottle_price, 
bottle_price*.02 AS markup,  
(bottle_price*.02)+bottle_price AS new_price,
shelf_price,
(shelf_price - Cast( ((bottle_price*.02)+bottle_price) AS DEC)) AS profit

FROM products
LIMIT 100




-----------------------------------------------------
--    DISTINCT & COUNT                              -
-----------------------------------------------------


SELECT vendor
FROM products
ORDER BY 1

SELECT DISTINCT vendor
FROM products
ORDER BY 1


SELECT DISTINCT COUNT(vendor)
FROM products
ORDER BY 1

-- 271 records 
SELECT COUNT(DISTINCT vendor)
FROM products

/* debrief answer the question why SELECT distinct brought back duplicates but
Select COUNT(DISTINCE field) removed duplicates */

-- EXERCISE
/* Try a SELECT DISTINCT on category_name and a Count Distinct
In your own words what is happening?*/



-- next throw a filter on your results to help with speed and validation
SELECT DISTINCT vendor, item_description , bottle_price, shelf_price
FROM products 
WHERE Vendor = 305
ORDER BY 2
LIMIT 100;

/* Example of using the WHERE clause with a Boolean operator 
also removing the limit 100 filter now that we have a small segment of data*/
SELECT DISTINCT vendor,item_description, bottle_price, shelf_price
FROM products 
WHERE vendor = 305 
AND case_cost < 70 
AND pack > 12
ORDER BY 1;


/* Run the same statement but with an OR  notice how it behaves*/
SELECT DISTINCT vendor,item_description, bottle_price, shelf_price
FROM products 
WHERE vendor = 305 
AND case_cost < 70 
OR pack > 12
ORDER BY 1;

/* Building off of the previous example if you wanted to only see Vendor 305
And after that you wanted where the case_cost was <70 or the pack was >12 
you would need to use the order of operations () to group your parameters. */

SELECT DISTINCT vendor,category_name, bottle_price, shelf_price
FROM products 
WHERE vendor = 305 
AND (case_cost < 70 
OR pack > 12)
ORDER BY 1;


--EXERCISE
'
The client wants to see item_descriptions, bottle_size, pack, inner_pack
Inner pack needs to be greater than 1, pack should be >1 or the bottle_size greater
than 750 sort in a descening order by bottle_size
'

-----------------------------------------------------
--    INFORMATION_SCHEMA                            -
-----------------------------------------------------
SELECT *
FROM information_schema.columns WHERE table_name='stores'


'Using what you know review information schema for all tables 
But only bring back Column_name, is_nullable and data_type
'