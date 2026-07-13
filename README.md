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
