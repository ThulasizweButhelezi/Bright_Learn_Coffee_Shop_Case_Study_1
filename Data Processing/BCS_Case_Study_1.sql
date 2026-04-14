-- Databricks notebook source
SELECT*
FROM brightlearn_case_studies.case_studies.bright_coffee_shop_analysis_case_study_1;

--------------------------------------------------------------------------------------
--1. Exploratory Data Analysis (EDA)
--------------------------------------------------------------------------------------
--A. Checking the size of the data (Rows)= 149116 rows 
--SELECT COUNT(*) AS Data_Size,
--B. Number of transtaction= 149116
       --COUNT(DISTINCT transaction_id) AS Total_transaction,
--C. Number of products= 80
      SELECT store_location,
             product_category,
             product_type,
             product_detail,
      COUNT(DISTINCT product_id) AS Total_products, 
--D. Number of stores= 3
        --COUNT(DISTINCT store_location) AS Number_of_stores,
        unit_price,
--E. Number of quantities sold= 214470
        SUM(transaction_qty) AS Total_qty_of_product_sold,
--F. Total revenue generated= 698812.3
        SUM(transaction_qty*unit_price) AS Total_revenue,
--G. Number of product_types= 29
        COUNT(DISTINCT product_type) AS Number_of_product_types,
--H. Number of product_details= 80
        COUNT(DISTINCT product_detail) AS Number_of_product_details,
--I. Checking the data period= 6 months (1-30 Jan2023)
       --MIN(transaction_date) AS First_date_of_transaction,
       --MAX(transaction_date) AS Last_date_of_transaction,

--------------------------------------------------------------------------------------
--2. Setting up time period variables (Time inteligence) 
--------------------------------------------------------------------------------------  
        transaction_date,
        DAYNAME(transaction_date) AS Day_of_transaction,
        MONTHNAME(transaction_date) AS Month_of_transaction,
        QUARTER(transaction_date) AS Transaction_Quarter,
        DATE_FORMAT(transaction_time, 'HH:mm:ss') AS Time_of_transaction,
          CASE
           WHEN Day_of_transaction ='Sun' THEN 'Weekend'
           WHEN Day_of_transaction ='Sat' THEN 'Weekend'
           ELSE 'Weekdays'
           END AS Days_Classification,
           CASE 
            WHEN DATE_FORMAT(transaction_time,'HH:mm') BETWEEN '07:00' AND '08:59' THEN 'Early Morning'
            WHEN DATE_FORMAT(transaction_time,'HH:mm') BETWEEN '09:00' AND '11:59' THEN 'Morning'
            WHEN DATE_FORMAT(transaction_time,'HH:mm') BETWEEN '12:00' AND '13:59' THEN 'Mid Day/Lunch'
            WHEN DATE_FORMAT(transaction_time,'HH:mm') BETWEEN '14:00' AND '17:59' THEN 'Afternoon'
            ELSE 'Evening'
            END AS Time_Classification
FROM brightlearn_case_studies.case_studies.bright_coffee_shop_analysis_case_study_1
GROUP BY store_location, transaction_date,Day_of_transaction, Month_of_transaction, Time_of_transaction, transaction_time,Transaction_Quarter,product_category,product_type,product_detail,unit_price;

