-- ==========================================================
-- OLIST E-COMMERCE SALES ANALYSIS DATABASE
-- PostgreSQL Schema
--
-- Dataset: Olist Brazilian E-commerce Public Dataset
-- Purpose: Data Analysis & Business Intelligence Portfolio
-- Database: PostgreSQL
-- ==========================================================

/*
Description
-----------
This schema contains the core relational tables required for
analyzing sales performance, customer behavior, seller
performance, product trends, payments, and customer reviews
from the Olist Brazilian E-commerce dataset.

The geolocation table is excluded because it is not required
for the business questions explored in this project.
*/


-- ==========================================================
-- 1. CUSTOMERS
-- ==========================================================

CREATE TABLE customers (

    customer_id CHAR(32) PRIMARY KEY,

    customer_unique_id CHAR(32) NOT NULL,

    customer_zip_code_prefix CHAR(5),

    customer_city VARCHAR(50),

    customer_state CHAR(2)

);



-- ==========================================================
-- 2. SELLERS
-- ==========================================================

CREATE TABLE sellers (

    seller_id CHAR(32) PRIMARY KEY,

    seller_zip_code_prefix CHAR(5),

    seller_city VARCHAR(50),

    seller_state CHAR(2)

);



-- ==========================================================
-- 3. PRODUCTS
-- ==========================================================

CREATE TABLE products (

    product_id CHAR(32) PRIMARY KEY,

    product_category_name VARCHAR(100),

    product_name_length SMALLINT,

    product_description_length SMALLINT,

    product_photos_qty SMALLINT,

    product_weight_g INTEGER,

    product_length_cm SMALLINT,

    product_height_cm SMALLINT,

    product_width_cm SMALLINT

);



-- ==========================================================
-- 4. PRODUCT CATEGORY TRANSLATION
-- ==========================================================

CREATE TABLE product_category_name_translation (

    product_category_name VARCHAR(100) PRIMARY KEY,

    product_category_name_english VARCHAR(100)

);



-- ==========================================================
-- 5. ORDERS
-- ==========================================================

CREATE TABLE orders (

    order_id CHAR(32) PRIMARY KEY,

    customer_id CHAR(32) NOT NULL,

    order_status VARCHAR(20),

    order_purchase_timestamp TIMESTAMP,

    order_approved_at TIMESTAMP,

    order_delivered_carrier_date TIMESTAMP,

    order_delivered_customer_date TIMESTAMP,

    order_estimated_delivery_date TIMESTAMP,

    CONSTRAINT fk_orders_customers
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)

);



-- ==========================================================
-- 6. ORDER ITEMS
-- ==========================================================

CREATE TABLE order_items (

    order_id CHAR(32) NOT NULL,

    order_item_id SMALLINT NOT NULL,

    product_id CHAR(32) NOT NULL,

    seller_id CHAR(32) NOT NULL,

    shipping_limit_date TIMESTAMP,

    price NUMERIC(10,2),

    freight_value NUMERIC(10,2),

    CONSTRAINT pk_order_items
        PRIMARY KEY (order_id, order_item_id),

    CONSTRAINT fk_order_items_orders
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    CONSTRAINT fk_order_items_products
        FOREIGN KEY (product_id)
        REFERENCES products(product_id),

    CONSTRAINT fk_order_items_sellers
        FOREIGN KEY (seller_id)
        REFERENCES sellers(seller_id)

);



-- ==========================================================
-- 7. ORDER PAYMENTS
-- ==========================================================

CREATE TABLE order_payments (

    order_id CHAR(32) NOT NULL,

    payment_sequential SMALLINT NOT NULL,

    payment_type VARCHAR(20),

    payment_installments SMALLINT,

    payment_value NUMERIC(10,2),

    CONSTRAINT pk_order_payments
        PRIMARY KEY (order_id, payment_sequential),

    CONSTRAINT fk_order_payments_orders
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id)

);



-- ==========================================================
-- 8. ORDER REVIEWS
-- ==========================================================

CREATE TABLE order_reviews (

    review_id CHAR(32) PRIMARY KEY,

    order_id CHAR(32) NOT NULL,

    review_score SMALLINT,

    review_comment_title TEXT,

    review_comment_message TEXT,

    review_creation_date TIMESTAMP,

    review_answer_timestamp TIMESTAMP,

    CONSTRAINT fk_order_reviews_orders
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id)

);

-- ==============================================================
-- 9.  GEOLOCATION
-- ==============================================================

CREATE TABLE geolocation (

    geolocation_zip_code_prefix CHAR(5),

    geolocation_lat NUMERIC(10,8),

    geolocation_lng NUMERIC(11,8),

    geolocation_city VARCHAR(100),

    geolocation_state CHAR(2)

);


-- Set ownership of the tables to the postgres user

ALTER TABLE customers OWNER to postgres;
ALTER TABLE sellers OWNER to postgres;
ALTER TABLE products OWNER to postgres;
ALTER TABLE product_category_name_translation OWNER to postgres;
ALTER TABLE orders OWNER to postgres;
ALTER TABLE order_items OWNER to postgres;
ALTER TABLE order_payments OWNER to postgre
ALTER TABLE order_reviews OWNER to postgres;
ALTER TABLE geolocation OWNER to postgres;


CREATE INDEX idx_orders_customer
ON orders(customer_id);

CREATE INDEX idx_order_items_product
ON order_items(product_id);

CREATE INDEX idx_order_items_seller
ON order_items(seller_id);

CREATE INDEX idx_order_payments_order
ON order_payments(order_id);

CREATE INDEX idx_order_reviews_order
ON order_reviews(order_id);

CREATE INDEX idx_geolocation_zip
ON geolocation(geolocation_zip_code_prefix);