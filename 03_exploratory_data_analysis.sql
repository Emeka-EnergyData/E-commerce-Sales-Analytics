-- Data Exploration Queries for E-commerce Sales Analytics

/* Customers Table Exploration */

-- Explore the unique cities of customers

SELECT DISTINCT customer_city
FROM customers
ORDER BY customer_city;

-- Explore the unique customer states
SELECT DISTINCT customer_state
FROM customers
ORDER BY customer_state;

/* Orders Table Exploration */

-- Explore the unique order statuses
SELECT DISTINCT order_status
FROM orders
ORDER BY order_status;

-- Explore the order timestamps to understand the distribution of orders over time
-- Order Purchase Timestamp
SELECT 
    MIN(order_purchase_timestamp) AS min_purchase_timestamp,
    MAX(order_purchase_timestamp) AS max_purchase_timestamp,
    AGE(MAX(order_purchase_timestamp), MIN(order_purchase_timestamp)) AS purchase_time_range
FROM orders
WHERE order_purchase_timestamp IS NOT NULL

-- Order Approved Timestamp
SELECT
    MIN(order_approved_at) AS min_approved_timestamp,
    MAX(order_approved_at) AS max_approved_timestamp,
    AGE(MAX(order_approved_at), MIN(order_approved_at)) AS approved_time_range
FROM orders
WHERE order_approved_at IS NOT NULL

/* Order Reviews Table Exploration */

-- Explore the unique review scores
SELECT DISTINCT review_score   
FROM order_reviews
ORDER BY review_score;

-- Explore the review creation and answer timestamps to find the response time for reviews
SELECT 
    AGE(review_answer_timestamp, review_creation_date) AS review_response_time_range
FROM order_reviews
WHERE review_answer_timestamp IS NOT NULL AND review_creation_date IS NOT NULL;

/* Order Payments Table Exploration */

--Explore the unique order payment types
SELECT DISTINCT payment_type
FROM order_payments
ORDER BY payment_type;

-- Explore the unique order payment installments
SELECT DISTINCT payment_installments
FROM order_payments
ORDER BY payment_installments;

-- Explore the unique order payment sequences
SELECT DISTINCT payment_sequential
FROM order_payments
ORDER BY payment_sequential;

-- Explore the payment values
SELECT 
    MIN(payment_value) AS min_payment_value,
    MAX(payment_value) AS max_payment_value,
    AVG(payment_value) AS avg_payment_value
FROM order_payments;

/* Products Table Exploration */

-- Explore the unique product categories
SELECT DISTINCT product_category_name
FROM products  
ORDER BY product_category_name;

/* Sellers Table Exploration */

-- Explore the unique seller IDs
SELECT DISTINCT seller_id
FROM sellers
ORDER BY seller_id;

-- Explore the unique seller states
SELECT DISTINCT seller_state 
FROM sellers
ORDER BY seller_state;

-- Explore the unique seller city
SELECT DISTINCT seller_city
FROM sellers
ORDER BY seller_city;

-- Metrics Report
SELECT 'Total Unique Customers' AS metric, COUNT(DISTINCT customer_id) AS value
FROM customers
UNION
SELECT 'Total Unique Sellers' AS metric, COUNT(DISTINCT seller_id) AS value
FROM sellers
UNION
SELECT 'Total Unique Products' AS metric, COUNT(DISTINCT product_id) AS value
FROM products
UNION
SELECT 'Total Unique Orders' AS metric, COUNT(DISTINCT order_id) AS value
FROM orders
UNION
SELECT 'Total Revenue' AS metric, SUM(payment_value) AS value
FROM order_payments
UNION
SELECT 'Total Product Value' AS metric, SUM(price + freight_value) AS value
FROM order_items
UNION
SELECT 'Average Review Score' AS metric, AVG(review_score) AS value
FROM order_reviews
UNION
SELECT 'Average Product Weight' AS metric, AVG(product_weight_g) AS value
FROM products
UNION
SELECT 'Average Product Length' AS metric, AVG(product_length_cm) AS value
FROM products
UNION
SELECT 'Average Product Height' AS metric, AVG(product_height_cm) AS value
FROM products
UNION
SELECT 'Average Product Width' AS metric, AVG(product_width_cm) AS value
FROM products
UNION 
SELECT 'Average Product Photos Quantity' AS metric, AVG(product_photos_qty) AS value
FROM products;


/* Magnitude Analysis */

-- Find the number of unique customers per state
SELECT 
    customer_state, 
    COUNT(DISTINCT customer_id) AS unique_customers
FROM customers
GROUP BY customer_state
ORDER BY unique_customers DESC;

-- Find the number of unique sellers per state
SELECT 
    seller_state, 
    COUNT(DISTINCT seller_id) AS unique_sellers
FROM sellers
GROUP BY seller_state
ORDER BY unique_sellers DESC;

-- Find the number of unique products per category
SELECT 
    product_category_name, 
    COUNT(DISTINCT product_id) AS unique_products
FROM products
GROUP BY product_category_name
ORDER BY unique_products DESC;

-- Find the average product weight, length, height, and width per product category
SELECT 
    COALESCE(product_category_name, 'Unknown') AS product_category_name,
    ROUND(AVG(product_weight_g), 2) AS avg_product_weight,
    ROUND(AVG(product_length_cm), 2) AS avg_product_length,
    ROUND(AVG(product_height_cm), 2) AS avg_product_height,
    ROUND(AVG(product_width_cm), 2) AS avg_product_width,
    ROUND(AVG(product_photo_qty), 2) AS avg_product_photo_qty
FROM products
GROUP BY product_category_name
ORDER BY avg_product_weight DESC;

-- Find the number of unique orders per status
SELECT 
    order_status, 
    COUNT(DISTINCT order_id) AS unique_orders
FROM orders
GROUP BY order_status
ORDER BY unique_orders DESC;

-- Find the average product weight, length, height, and width per product customer state
SELECT 
    o.order_id,
    ROUND(AVG(product_weight_g),2) AS avg_product_weight_g,
    ROUND(AVG(product_length_cm),2) AS avg_product_lenght_cm,
    ROUND(AVG(product_height_cm),2) AS avg_product_height_cm,
    ROUND(AVG(product_width_cm),2) AS avg_product_width_cm
FROM products AS p
LEFT JOIN order_items AS o
ON p.product_id = o.product_id
GROUP BY o.order_id;

-- Find the average review score and total review per order ID
SELECT
    order_id,
    ROUND(AVG(review_score),2) AS avg_review_score,
    COUNT(order_id) AS total_review
FROM order_reviews
GROUP BY order_id
ORDER BY avg_review_score DESC, total_review DESC;

-- Find the total payment value per payment type
SELECT 
    payment_type, 
    SUM(payment_value) AS total_revenue
FROM order_payments
GROUP BY payment_type
ORDER BY total_revenue DESC;

-- Find the total payment value per order IDS
SELECT 
    order_id,
    SUM(payment_value) AS total_revenue
FROM order_payments
GROUP BY order_id
ORDER BY total_revenue;

-- Find the number of orders per payment type
SELECT
    payment_type,
    COUNT(order_id) AS number_of_orders
FROM order_payments
GROUP BY payment_type
ORDER BY number_of_orders;

-- Find the average payment value per payment type
SELECT
    payment_type,
    AVG(payment_value) AS avg_payment_value
FROM order_payments
GROUP BY payment_type
ORDER BY payment_type;

-- Find the average review score per product category
SELECT 
    COALESCE(p.product_category_name, 'Unknown') AS product_category_name, 
    AVG(r.review_score) AS avg_review_score
FROM products p
LEFT JOIN order_items oi 
ON p.product_id = oi.product_id
LEFT JOIN order_reviews r
ON oi.order_id = r.order_id
GROUP BY p.product_category_name
ORDER BY avg_review_score DESC;

-- Find the average product weight, length, height, and width per product customer state
SELECT 
    c.customer_state,
    AVG(product_weight_g) AS avg_product_weight_g,
    AVG(product_length_cm) AS avg_product_lenght_cm,
    AVG(product_height_cm) AS avg_product_height_cm,
    AVG(product_width_cm) AS avg_product_width_cm
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id
LEFT JOIN order_items AS oi
ON o.order_id = oi.order_id
LEFT JOIN products AS p
ON oi.product_id = p.product_id
GROUP BY c.customer_state;


/* Rankings */

-- Find the top ranked states by number of unique customers
SELECT 
    customer_state, 
    COUNT(DISTINCT customer_id) AS unique_customers
FROM customers
GROUP BY customer_state
ORDER BY unique_customers DESC;

-- Find the least ranked states by number of unique customers
SELECT 
    customer_state, 
    COUNT(DISTINCT customer_id) AS unique_customers
FROM customers
GROUP BY customer_state
ORDER BY unique_customers ASC;

-- Find the top ranked states by number of unique sellers
SELECT 
    seller_state, 
    COUNT(DISTINCT seller_id) AS unique_sellers
FROM sellers
GROUP BY seller_state
ORDER BY unique_sellers DESC;

-- Find the least ranked states by number of unique sellers
SELECT 
    seller_state, 
    COUNT(DISTINCT seller_id) AS unique_sellers
FROM sellers
GROUP BY seller_state
ORDER BY unique_sellers ASC;

-- Find the top product categories by number of unique products
SELECT 
    product_category_name, 
    COUNT(DISTINCT product_id) AS unique_products
FROM products
GROUP BY product_category_name
ORDER BY unique_products DESC
LIMIT 5;

-- Top 5 product category by average review score 
SELECT 
    COALESCE(p.product_category_name, 'Unknown') AS product_category_name, 
    ROUND(AVG(r.review_score),2) AS avg_review_score
FROM products p
LEFT JOIN order_items oi 
ON p.product_id = oi.product_id
LEFT JOIN order_reviews r
ON oi.order_id = r.order_id
GROUP BY p.product_category_name
ORDER BY avg_review_score DESC
LIMIT 5;

-- Find the top payment type by number of orders
SELECT
    payment_type,
    COUNT(order_id) AS number_of_orders
FROM order_payments
GROUP BY payment_type
ORDER BY number_of_orders DESC;

-- Find the top payment type by average payment value
SELECT
    payment_type,
    ROUND(AVG(payment_value),2) AS avg_payment_value
FROM order_payments
GROUP BY payment_type
ORDER BY avg_payment_value DESC;

-- Top payment type by total payment value
SELECT 
    payment_type, 
    SUM(payment_value) AS total_revenue
FROM order_payments
GROUP BY payment_type
ORDER BY total_revenue DESC;





-- Find the top products that most customers from SP buy

SELECT p.product_category_name, COUNT(c.customer_state) we
FROM products AS p
FULL OUTER JOIN order_items AS oi
ON p.product_id = oi.product_id
JOIN orders AS o 
ON oi.order_id = o.order_id
FULL OUTER JOIN customers AS c
ON c.customer_id = o.customer_id
WHERE customer_state = 'SP'
GROUP BY product_category_name
HAVING COUNT(c.customer_state) > 5
ORDER BY we DESC;
