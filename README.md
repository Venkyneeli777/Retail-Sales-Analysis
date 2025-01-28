# Retail Sales Analysis with SQL and Excel

## Project Overview

**Project Title**: Retail Sales Analysis  
**Tools Used**: MySQL,Excel  
**Database**: `p1_retail_db`

This project focuses on analyzing retail sales data using SQL and Excel to extract insights and answer key business questions. It showcases SQL skills for database creation, data cleaning, exploratory data analysis (EDA), and deriving actionable insights. The project highlights the importance of data-driven decision-making in retail.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Handle missing or null records to ensure data accuracy.
3. **Exploratory Data Analysis (EDA)**: Analyze sales patterns, customer behavior, and category performance.
4. **Business Insights**: Use SQL queries to solve real-world business problems.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `p1_retail_db`.

```sql
## CREATING DATABASE
CREATE DATABASE sql_project_p2;
```

- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
## CREATE TABLE
CREATE TABLE retail_sales (
transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```

### 2. Data Cleaning

**Null Value Check**: Cleaned the data by removing null or incomplete records to maintain data integrity.

```sql
SELECT * FROM retail_sales
WHERE transactions_id is NULL OR
      sale_date is NULL OR
      sale_time is NULL OR
      customer_id is NULL OR
      gender is NULL OR
      age is NULL OR
      category is NULL OR
      quantity is NULL OR
      price_per_unit is NULL OR
      cogs is NULL OR
      total_sale is NULL;
      
DELETE FROM retail_sales
Where transactions_id is NULL OR
      sale_date is NULL OR
      sale_time is NULL OR
      customer_id is NULL OR
      gender is NULL OR
      age is NULL OR
      category is NULL OR
      quantity is NULL OR
      price_per_unit is NULL OR
      cogs is NULL OR
      total_sale is NULL;
```

### 3. Data Exploration

- **Record Count**: Determine the total number of records in the dataset.
```sql
SELECT COUNT(*) FROM retail_sales;
```
- **Customer Count**: Find out how many unique customers are in the dataset.
```sql
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
```
- **Category Count**: Identify all unique product categories in the dataset.
```sql
SELECT DISTINCT category FROM retail_sales;
```

### 4. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05'.**:
```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in November 2022.**:
```sql
SELECT *
FROM retail_sales
WHERE category="Clothing" AND 
	  quantity > 3 AND 
      (sale_date like "2022-11-__");
```

3. **Write a SQL query to calculate the total sales (total_sale) for each product category**:
```sql
SELECT category, 
	   SUM(total_sale) total_sales 
FROM retail_sales
GROUP BY category;
```

4. **Write a SQL query to calculate the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT category, 
	   ROUND(AVG(age),2) Average_age
FROM retail_sales
WHERE category = "Beauty"
GROUP BY category;
```

5. **Write a SQL query to retrieve all transactions where the total sales amount is greater than 1,000.**:
```sql
SELECT * 
FROM retail_sales
WHERE total_sale > 1000;
```

6. **Write a SQL query to find the total number of transactions made by each gender in each product category.**:
```sql
SELECT category, 
	   gender,
       COUNT(transactions_id) Total_trans
FROM retail_sales
GROUP BY category,gender
ORDER BY category;
```

7. **Write a SQL query to calculate the average monthly sales and find the best-selling month for each year.**:
```sql
SELECT year,
       month,
       avg_sales 
FROM
(
SELECT YEAR(sale_date) as year,
		MONTH(sale_date) as month ,
		AVG(total_sale) as avg_sales,
		RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY  AVG(total_sale)DESC) rank1
 FROM retail_sales
GROUP BY year,month
) as T1
WHERE rank1 = 1;
```

8. **Write a SQL query to identify the top 5 customers with the highest total sales.**:
```sql
SELECT customer_id, 
       SUM(total_sale) Total_Sales
FROM retail_sales
GROUP BY customer_id
ORDER BY Total_Sales DESC
LIMIT 5;
```

9. **Write a SQL query to calculate the number of unique customers who purchased items in each product category.**:
```sql
SELECT category, 
	   COUNT(distinct(customer_id)) no_unique_cus
FROM retail_sales
Group by category;
```

10. **Write a SQL query to categorize transactions into shifts (Morning: before 12 PM, Afternoon: between 12 PM and 5 PM, and Evening: after 5 PM) and calculate the number of orders for each shift.**:
```sql
WITH hourly_Sales
AS
(
SELECT *,
	CASE
       WHEN HOUR(sale_time) < 12 THEN "Morning"
       WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN "Afternoon"
	   ELSE "Evening"
    END as Shift
FROM retail_sales
)
SELECT Shift, COUNT(*) as Total_Orders
FROM hourly_Sales
GROUP BY Shift;
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

