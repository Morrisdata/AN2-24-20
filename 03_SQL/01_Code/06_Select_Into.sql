-- Example of creating a table using INTO
SELECT item_no
INTO test
FROM products

DROP TABLE test

-- Create item_count table
SELECT item_no, count(DISTINCT item_no) AS itm_cnt
INTO item_count
FROM products
GROUP BY item_no

-- review created table
SELECT sum(itm_cnt)
FROM item_count

-- CREATE tequila_count table
SELECT item_no, count(DISTINCT item_no) AS itm_cnt
INTO tequila_count
FROM products
WHERE item_description ILIKE '%tequila%'
GROUP BY item_no

-- review tequila_count table
SELECT SUM(itm_cnt)
FROM tequila_count

-- Join item count with tequila count to found out percentage of tequila
SELECT *
FROM item_count a
JOIN tequila_count b
ON a.itm_cnt = b.itm_cnt

-- try to calculate the percentage of Tequila products available
