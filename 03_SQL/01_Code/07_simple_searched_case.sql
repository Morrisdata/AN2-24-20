SELECT *
FROM stores

--Simple CASE, Using Case for labels
SELECT store, name, 

CASE 
    WHEN store_status='A' Then 'Active'
    WHEN store_status='I' Then 'Inactive'
END AS new_column,

store_address

FROM stores


-- Optimize or not?
SELECT store, name, 
CASE 
    WHEN store_status='A' Then 'Active'
    ELSE 'Inactive'
END AS store_status,
store_address
FROM stores

/* Pitfall of the above is losing data that you may not know about, having it all be inactive
Let's say in about 8 months you get a new code for Relocation 'R', this will not show up
*/
-- SOLUTION
SELECT store, name, 
CASE 
    WHEN store_status='A' Then 'Active'
    WHEN store_status='I' Then 'Inactive'
END AS new_column,
store_address
FROM stores
ORDER BY 3 DESC

-- Using CASE as a filter
SELECT store, name, store, store_status
FROM stores
WHERE 
CASE 
    WHEN store_status='A' Then 'Active'
    WHEN store_status='I' Then 'Inactive'
    ELSE store_status
END = 'Active'



/* Exercise Using BETWEEN condition and the store table Create 4 Groups of stores
GROUP 1 STORES 2000 THRU 2999
GROUP 2 STORES 3000 THRU 3999
GROUP 3 STORES 4000 THRU 4999
GROUP 4 stores 5000+

Keep your new case statement in the SELECT clause and use it also in the WHERE clause to only review 
GROUP 3

BONUS use a CTE to store this in a temp table for repeated use

*/
SELECT store, 
CASE
	WHEN  expression  THEN  label 
END AS field name
FROM stores


-- SOLUTION
SELECT  
CASE 
	WHEN store BETWEEN 2000 AND 2999 THEN 'Group 1'
    WHEN store BETWEEN 3000 AND 3999 THEN 'Group 2'
    WHEN store BETWEEN 4000 AND 4999 THEN 'Group 3'
    ELSE 'Group 4'
END as "Store_Group",
store
FROM stores
WHERE
CASE 
	WHEN store BETWEEN 2000 AND 2999 THEN 'Group 1'
    WHEN store BETWEEN 3000 AND 3999 THEN 'Group 2'
    WHEN store BETWEEN 4000 AND 4999 THEN 'Group 3'
    ELSE 'Group 4'
END = 'Group 3'


--Complex CASE step 1 using 2 conditionals and applying a label
SELECT item_no, 
CASE 
	WHEN shelf_price BETWEEN 0 AND 10 AND item_description ILIKE '%Tequila%' THEN 'LC_Tequila'
    WHEN shelf_price BETWEEN 10 AND 20 AND item_description ILIKE '%Tequila%' THEN 'MLC_Tequila'
    ELSE 'no_label'
END "Tequila_price_cat"
FROM products

-- Step 2 USE the case as a filter to remove anything without a label
-- note if you place shelf_price in the ELSE you will have issues with data types
SELECT item_no, 
CASE 
	WHEN shelf_price BETWEEN 0 AND 10 AND item_description ILIKE '%Tequila%' THEN 'LC_Tequila'
    WHEN shelf_price BETWEEN 10 AND 20 AND item_description ILIKE '%Tequila%' THEN 'MLC_Tequila'
    ELSE 'no_label'
END "Tequila_price_cat"
FROM products
WHERE CASE 
	WHEN shelf_price BETWEEN 0 AND 10 AND item_description ILIKE '%Tequila%' THEN 'LC_Tequila'
    WHEN shelf_price BETWEEN 10 AND 20 AND item_description ILIKE '%Tequila%' THEN 'MLC_Tequila'
    ELSE 'no_label'
END != 'no_label'

-- Step 3 Nested CASE adding math as a result
SELECT item_no, shelf_price,
CASE
	WHEN 
    	CASE 
			WHEN shelf_price BETWEEN 0 AND 10 AND item_description ILIKE '%Tequila%' THEN 'LC_Tequila'
    		WHEN shelf_price BETWEEN 10 AND 20 AND item_description ILIKE '%Tequila%' THEN 'MLC_Tequila'
    		ELSE 'no_label'
		END = 'LC_Tequila' 
    THEN shelf_price*.02

END as "LC_markup"

FROM products
WHERE CASE 
	WHEN shelf_price BETWEEN 0 AND 10 AND item_description ILIKE '%Tequila%' THEN 'LC_Tequila'
    WHEN shelf_price BETWEEN 10 AND 20 AND item_description ILIKE '%Tequila%' THEN 'MLC_Tequila'
    ELSE 'no_label'
END != 'no_label'

-- EXERCISE 
-- Add another NESTED CASE in the above example that add a 1% markeup to MLC Tequila


-- DRILLS
-- create random groupings of populations
SELECT county, 
CASE 
	WHEN population BETWEEN 0 AND 10000 THEN 'Low Population'
END as "pop_group"
FROM counties
ORDER BY 2 

-- break random groups into seperate columns
SELECT county, 
CASE 
	WHEN population BETWEEN 0 AND 10000 THEN 'Low-pop'
END as "low_population",
CASE
	WHEN population BETWEEN 10000 AND 20000 THEN 'Mid_to_low_pop'
END as "mid_to_low_pop"
FROM counties
ORDER BY 2

-- Try combining groups from above using nested case statements.
-- yes increasing your range would do the same but then you wouldnt have a cool drill

SELECT county, 
CASE
	WHEN
		CASE 
			WHEN population BETWEEN 0 AND 10000 THEN 'Low-pop'
		END ='low_population'
	
    OR
    
    	CASE
			WHEN population BETWEEN 10000 AND 20000 THEN 'Mid_to_low_pop'
		END = 'Mid_to_low_pop'
	THEN 'Below_avg_pop'
END as "POP_VIEW"
FROM counties
ORDER BY 2 


-- EXTRAS
-- Trick to aggregate an aggregate. See if you can figure it out. What is the SUM of 
-- inactive and active stores
SELECT store, name, 
CASE 
    WHEN store_status='A' Then 'Active'
    WHEN store_status='I' Then 'Inactive'
    ELSE store_status
END AS store_status,
store_address
FROM stores


-- NESTED CASE with Additional conditional
SELECT item_no, shelf_price,
CASE
	WHEN 
    	CASE 
			WHEN shelf_price BETWEEN 0 AND 10 AND item_description ILIKE '%Tequila%' THEN 'LC_Tequila'
    		WHEN shelf_price BETWEEN 10 AND 20 AND item_description ILIKE '%Tequila%' THEN 'MLC_Tequila'
    		ELSE 'no_label'
		END = 'LC_Tequila'
    
    AND case_cost >20
    
    THEN shelf_price*.02
END as "LC_markup"

FROM products
WHERE CASE 
	WHEN shelf_price BETWEEN 0 AND 10 AND item_description ILIKE '%Tequila%' THEN 'LC_Tequila'
    WHEN shelf_price BETWEEN 10 AND 20 AND item_description ILIKE '%Tequila%' THEN 'MLC_Tequila'
    ELSE 'no_label'
END != 'no_label'

-- Sample business matrix
SELECT description, sum(bottle_qty),
  CASE 	
	WHEN cast(SUM(btl_price - state_btl_cost)as Decimal) < 25 THEN 'Low_profit' 
	WHEN cast(SUM(btl_price - state_btl_cost)as Decimal)  BETWEEN 25 AND 250 THEN 'Medium_profit' 
	ELSE 'High_Profit'
  END AS Profit,
  
  CASE 
	WHEN SUM(bottle_qty) >250000 THEN 'High Volume'
    WHEN SUM(bottle_qty) BETWEEN 50000 AND 250000 THEN 'Medium Volume'
    WHEN SUM(bottle_qty) <50000 THEN 'Low Volume'
  END AS Volume 

FROM sales
GROUP BY description
ORDER BY 2 desc 

SELECT description, sum(bottle_qty), cast(SUM(btl_price - state_btl_cost)as Decimal),
CASE 
	WHEN
		CASE 	
			WHEN cast(SUM(btl_price - state_btl_cost)as Decimal) < 10000 THEN 'Low_profit' 
			WHEN cast(SUM(btl_price - state_btl_cost)as Decimal)  BETWEEN 25000 AND 2500000 THEN 'Medium_profit' 
			ELSE 'High_Profit'
  		END = 'Low_profit'
  		AND
  	CASE 
		WHEN SUM(bottle_qty) >100000 THEN 'High Volume'
    	WHEN SUM(bottle_qty) BETWEEN 10000 AND 100000 THEN 'Medium Volume'
    	WHEN SUM(bottle_qty) <10000 THEN 'Low Volume'
  	END IN ('High Volume', 'Medium Volume') THEN 'Increase price by 5%' END AS Adjustment

FROM sales
GROUP BY description
HAVING 
CASE 
	WHEN
		CASE 	
			WHEN cast(SUM(btl_price - state_btl_cost)as Decimal) < 10000 THEN 'Low_profit' 
			WHEN cast(SUM(btl_price - state_btl_cost)as Decimal)  BETWEEN 25000 AND 2500000 THEN 'Medium_profit' 
			ELSE 'High_Profit'
  		END = 'Low_profit'
  		AND
  	CASE 
		WHEN SUM(bottle_qty) >100000 THEN 'High Volume'
    	WHEN SUM(bottle_qty) BETWEEN 10000 AND 100000 THEN 'Medium Volume'
    	WHEN SUM(bottle_qty) <10000 THEN 'Low Volume'
  	END IN ('High Volume') THEN 'Increase price by 5%' END IS NOT NULL

ORDER BY 3 DESC

