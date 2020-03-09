/*Partion by for Window functions. Window functions act kind of like Group by
with the cavet that you can get detail and rolled up values in the same result sets. 
It is essentially a hack to say I want to see my aggregate info plus my detail. */

/* here is an example of grouping the data and still having the detail OVER begins
the windowing process with a function, here I'm choosing AVG */
SELECT store, category_name, total,
AVG(total) OVER (PARTITION BY store) 
FROM sales 
WHERE DATE = '2014-11-13'
LIMIT 1000

-- without any partitioning the over will result in 1 answer for the entire result set
SELECT total, sum(total) OVER () 
FROM sales LIMIT 1000

/* TRY the above for average */


-- How can you get a running total?  The order by without a partition can give you that
SELECT total, sum(total) OVER (ORDER BY store, total DESC) 
FROM sales 
LIMIT 1000

#example of Rank and order by
SELECT DISTINCT store, SUM(total), 
rank() OVER (ORDER BY sum(total) DESC) 
FROM sales
WHERE DATE = '2014-11-13'
GROUP by 1
ORDER BY  3
LIMIT 1000

# lets look at three window functions side by side to see what they do

SELECT store, Category_name, sum(total),
ROW_NUMBER() OVER(ORDER BY store),
RANK() OVER(ORDER BY store),
DENSE_RANK() OVER(ORDER BY store)
FROM sales
WHERE DATE = '2014-11-13'
GROUP BY store, category_name
LIMIT 1000




# if you have to filter the results you will need to place this process in a subselect. 
# over is not allowed in Group by or having
SELECT rnk, store, category_name, total
FROM
  (SELECT  store, category_name, sum(total) AS total,
          rank() OVER (ORDER BY sum(total) DESC, category_name) AS rnk
     FROM sales
     GROUP BY store, category_name
  ) AS sq
WHERE rnk < 3
GROUP BY store, category_name, rnk
LIMIT 100

SELECT a.store, a.sumtotal,b.sumtotal,a.row1, b.row2, (a.sumtotal-b.sumtotal)
FROM

(
SELECT store, SUM(total) as sumtotal, date, 
ROW_NUMBER() OVER (PARTITION BY store) as row1
FROM sales
WHERE store = 4889
GROUP BY store, date ) A

LEFT JOIN 

(SELECT store, SUM(total) as sumtotal, date, 
ROW_NUMBER() OVER (PARTITION BY store) as row2
FROM sales
WHERE store = 4889
GROUP BY store, date ) B

ON a.store = b.store
AND a.row1 = b.row2 -1
  
  