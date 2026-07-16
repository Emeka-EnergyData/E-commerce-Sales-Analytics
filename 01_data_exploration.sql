
-- The database contains 9 relational tables
SELECT table_name
FROM INFORMATION_SCHEMA.TABLES
WHERE table_schema = 'public';

-- The tables collectively have 52 columns and 7 distinct data types
SELECT 
    table_name,
    column_name,
    data_type,
    is_nullable,
    ordinal_position
FROM INFORMATION_SCHEMA.COLUMNS
WHERE table_schema = 'public'
ORDER BY table_name, ordinal_position;

-- Discover the primary key structure of the database
SELECT
    t.table_name,
    k.column_name,
    t.constraint_type
FROM INFORMATION_SCHEMA.table_constraints AS t
INNER JOIN INFORMATION_SCHEMA.key_column_usage AS k
    ON t.constraint_name = k.constraint_name
WHERE t.table_schema = 'public'
AND t.constraint_type = 'PRIMARY KEY'    
ORDER BY t.table_name;

-- Discover the foreign key structure of the database
SELECT 
    t.table_name, 
    k.column_name,
    k.constraint_name,
    t.constraint_type
FROM INFORMATION_SCHEMA.table_constraints AS t
INNER JOIN INFORMATION_SCHEMA.key_column_usage AS k
    ON t.constraint_name = k.constraint_name
WHERE t.table_schema = 'public'
AND t.constraint_type = 'FOREIGN KEY'     
ORDER BY t.table_name;

-- Discover how the tables are related
SELECT 
    c.table_name AS parent_table,
    c.column_name AS primary_key,
    t.table_name AS child_table,
    k.column_name AS foreign_key
FROM INFORMATION_SCHEMA.table_constraints AS t
INNER JOIN INFORMATION_SCHEMA.key_column_usage AS k
    ON t.constraint_name = k.constraint_name
INNER JOIN INFORMATION_SCHEMA.constraint_column_usage AS c
    ON k.constraint_name = c.constraint_name
WHERE t.table_schema = 'public'
    AND t.constraint_type = 'FOREIGN KEY'
ORDER BY parent_table;

-- Number of rows in each table
SELECT 'customers' AS table_name, COUNT(*) AS row_count
FROM customers
UNION ALL
SELECT 'geolocation', COUNT(*)  FROM geolocation
UNION ALL
SELECT 'order_items', COUNT(*)  FROM order_items
UNION ALL
SELECT 'order_payments', COUNT(*)  FROM order_payments
UNION ALL
SELECT 'order_reviews', COUNT(*)  FROM order_reviews
UNION ALL
SELECT 'orders', COUNT(*)  FROM orders
UNION ALL 
SELECT 'product_category_name_translation', COUNT(*)  
FROM product_category_name_translation
UNION ALL
SELECT 'products', COUNT(*)  FROM products
UNION ALl 
SELECT 'sellers', COUNT(*)  FROM sellers
ORDER BY table_name;

-- Check the informations in tables

SELECT *
FROM customers
LIMIT 5;

SELECT *
FROM geolocation
LIMIT 5;

SELECT *
FROM order_items
LIMIT 5;

SELECT *
FROM order_payments
LIMIT 5;

SELECT *
FROM order_reviews
LIMIT 5;

SELECT *
FROM orders
LIMIT 5;

SELECT *
FROM product_category_name_translation
LIMIT 5;

SELECT *
FROM products
LIMIT 5;

SELECT *
FROM sellers
LIMIT 5;