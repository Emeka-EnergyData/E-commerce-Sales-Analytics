-- How many rows are in each table
SELECT COUNT(*)
FROM ORDERS;

-- Are there missing values
SELECT *
FROM [Table]
WHERE [column_name is null]

-- Are there duplicate records
SELECT (*)
FROM [TABLE]
GROUP BY 
HAVING COUNT(*) > 1