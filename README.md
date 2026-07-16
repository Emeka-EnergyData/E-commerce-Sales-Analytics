# E-Commerce-Sales-Analytics
## Overview

## Project Status
🚧 In Progress

## Current Progress
- [ X ] Repository Created
- [ X ] Load Data
- [ X ] Data Exploration
- [] Data Cleaning
- [] Exploratory Data Analysis
- [] Advanced Analysis
- [] Visualizations

## Business Task
The business task is perform an exploratory analysis of an e-commerce business and uncover actionable business insights using SQL.

## Data Exploration
This project uses the **Brazilian Olist E-commerce Dataset**, obtained from Kaggle. The dataset was originally provided as multitple CSV files. For this project the data was imported into a PostgreSQL relational database for analysis.
The database consists of 9 tables representing different aspects of an e-commerce platform, including customers, orders, products, sellers, payments, geolocation and review.  
- **customers** stores customer identifiers and location information.
- **geolocation** contains geographical information, including zip code prefixes, longitude and latitude.
- **orders** records customer orders and key timestamps throughout the order lifecycle such as purchase, approval, delivery and estimated delivery date.
- **order_item** contains details of each product within an order, including the seller, shipping deadline and price.
- **order_payments** stores payment information, including payment method, number of installments and payment value.
- **order_reviews** contains customer reviews and review scores associated with completed orders.
- **products** provides descriptive information about each product, such as its category and physical characteristics.
- **product_category_name_translation** maps Portugese product category names to their English equivalents.
- **sellers** stores seller identifiers and location information
I verified the data integrity by ensuring all datasets have consistent columns and each column has the correct type of data

## Tools
- Postgresql
- Git

## Data Cleaning Documentation
1. I checked for duplicates in each table. No duplicates where found in the customer, order_items, order_payments, order_reviews, orders, products, sellers, product_category_name_translation table

2. The geolocation table contains multiple records for the same ZIP code prefix. Inspection showed that these records often have slightly different latitude and longitude values, indicating they represent distinct geographic observations rather than exact duplicate rows. Therefore no records were removed.

3. The products table contains two category values that are not present in the product_category_name lookup table.  Because no foreign key constraint exists between these tables, the inconsistency is not prevented by the dabase schema

4. In the order_review table, the review_comment_title and review_comment_message columns contains a high proportion of missing values. However, these fields are optional free text comments, while the numerical review_score is still present for most reviews. Therefore no row removal was performed

5. There are missing timestamp values in the orders table but looking closely at the data, the order lifecycke showed that missing values are expected. Orders status such as created, processing, invoiced, shipped, cancelled and unavilable naturally lack one or more delivery-related timestamp. A very small number of orders marked as delivered contain missing timestamps, since these record represent less than 0.02% of delivered orders, they were retained in the dataset. However, they will be excluded from analysis that requie complete delivery timestamp information

6. The product table contains 611 records with missing values. Most of these records lack descriptive product metadata, while two records have missing physical dimensions. Since the missing values cannot be reliably inferred, the original data was preserved. Records with missing values wll be exculed only from analyses that require those specific attributes

## Exploratory Data Analysis