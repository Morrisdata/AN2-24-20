/*SELECT description, sum(bottle_qty),
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
ORDER BY 2 desc */

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



