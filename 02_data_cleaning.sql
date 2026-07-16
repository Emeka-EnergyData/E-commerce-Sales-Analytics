/* 
    Checking for duplicate records
*/

-- customers table
SELECT *,COUNT(*)
FROM customers
GROUP BY 1, 2,3,4,5
HAVING COUNT(*) > 1;

-- geolocation table
SELECT *,COUNT(*)
FROM geolocation
GROUP BY 1, 2,3,4,5
HAVING COUNT(*) > 1;

-- order_items table
SELECT *, COUNT(*)
FROM order_items
GROUP BY 1, 2,3,4,5,6,7
HAVING COUNT(*) > 1;

-- order_payments table
SELECT *, COUNT(*)
FROM order_payments
GROUP BY 1, 2,3,4,5
HAVING COUNT(*) > 1;

-- order_reviews table
SELECT *, COUNT(*)
FROM order_reviews
GROUP BY 1, 2,3,4,5,6,7
HAVING COUNT(*) > 1;

-- orders table
SELECT *, COUNT(*)
FROM orders
GROUP BY 1, 2,3,4,5,6,7,8
HAVING COUNT(*) > 1;

--products table
SELECT *, COUNT(*)
FROM products
GROUP BY 1, 2,3,4,5,6,7,8,9
HAVING COUNT(*) > 1;

--sellers table
SELECT *, COUNT(*)
FROM sellers
GROUP BY 1, 2,3,4
HAVING COUNT(*) > 1;

-- product_category_name_translation table
SELECT *, COUNT(*)
FROM product_category_name_translation
GROUP BY 1, 2
HAVING COUNT(*) > 1;


/* 
    Check for missing values
*/

-- customers table
SELECT *
FROM customers
WHERE customer_id IS NULL 
    OR customer_unique_id IS NULL
    OR customer_zip_code_prefix IS NULL
    OR customer_city IS NULL
    OR customer_state IS NULL;

-- geolocation table
SELECT *
FROM geolocation
WHERE geolocation_zip_code_prefix IS NULL
    OR geolocation_lat IS NULL
    OR geolocation_lng IS NULL
    OR geolocation_city IS NULL
    OR geolocation_state IS NULL;

-- order_items table
SELECT *
FROM order_items
WHERE order_id IS NULL
    OR order_item_id IS NULL
    OR product_id IS NULL
    OR seller_id IS NULL
    OR shipping_limit_date IS NULL
    OR price IS NULL
    OR freight_value IS NULL;

-- order_payments table
SELECT *
FROM order_payments
WHERE order_id IS NULL
    OR payment_sequential IS NULL
    OR payment_type IS NULL
    OR payment_installments IS NULL
    OR payment_value IS NULL;

-- order_reviews table
SELECT *
FROM order_reviews
WHERE review_id IS NULL
    OR order_id IS NULL
    OR review_score IS NULL
    OR review_comment_title IS NULL
    OR review_comment_message IS NULL
    OR review_creation_date IS NULL
    OR review_answer_timestamp IS NULL;

-- orders table
SELECT *
FROM orders
WHERE order_id IS NULL
    OR customer_id IS NULL
    OR order_status IS NULL
    OR order_purchase_timestamp IS NULL
    OR order_approved_at IS NULL
    OR order_delivered_customer_date IS NULL
    OR order_delivered_carrier_date IS NULL
    OR order_estimated_delivery_date IS NULL;

-- Checking why there are missing values in orders table
SELECT 
    order_status,
    COUNT(*) total_orders,
    COUNT(order_approved_at) AS approved,
    COUNT(order_delivered_carrier_date) AS handed_to_carrier,
    COUNT(order_delivered_customer_date) delivered
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

--products table
SELECT *
FROM products
WHERE product_id IS NULL
    OR product_category_name IS NULL
    OR product_name_length IS NULL
    OR product_description_length IS NULL
    OR product_photos_qty IS NULL
    OR product_height_cm IS NULL
    OR product_weight_g IS NULL
    OR product_length_cm IS NULL
    OR product_width_cm IS NULL;

--sellers table
SELECT *
FROM sellers
WHERE seller_id IS NULL
    OR seller_city IS NULL
    OR seller_state IS NULL
    OR seller_zip_code_prefix IS NULL

-- product_category_name_translation table
SELECT *
FROM product_category_name_translation
WHERE product_category_name IS NULL
    OR product_category_name_english IS NULL