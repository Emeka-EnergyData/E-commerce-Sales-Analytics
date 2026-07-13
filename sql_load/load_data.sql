COPY customers 
FROM 'C:\Users\owner\Desktop\E-commerce Sales Analytics\csv\olist_customers_dataset.csv' 
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY sellers 
FROM 'C:\Users\owner\Desktop\E-commerce Sales Analytics\csv\olist_sellers_dataset.csv' 
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY products 
FROM 'C:\Users\owner\Desktop\E-commerce Sales Analytics\csv\olist_products_dataset.csv' 
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY product_category_name_translation
FROM 'C:\Users\owner\Desktop\E-commerce Sales Analytics\csv\product_category_name_translation.csv' 
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY orders
FROM 'C:\Users\owner\Desktop\E-commerce Sales Analytics\csv\olist_orders_dataset.csv' 
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY order_items 
FROM 'C:\Users\owner\Desktop\E-commerce Sales Analytics\csv\olist_order_items_dataset.csv' 
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY order_payments
FROM 'C:\Users\owner\Desktop\E-commerce Sales Analytics\csv\olist_order_payments_dataset.csv' 
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY order_reviews
FROM 'C:\Users\owner\Desktop\E-commerce Sales Analytics\csv\olist_order_reviews_dataset.csv' 
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY geolocation 
FROM 'C:\Users\owner\Desktop\E-commerce Sales Analytics\csv\olist_geolocation_dataset.csv' 
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');








