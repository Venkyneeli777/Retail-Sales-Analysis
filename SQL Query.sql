## CREATING DATABASE
CREATE DATABASE sql_project_p2;

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



## DATA CLEANING
## Check for any null values in the dataset and delete records with missing data.
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
      
## DATA EXPLORATION
## Determine the total number of records in the dataset.
SELECT COUNT(*) FROM retail_sales;

## Find out how many unique customers are in the dataset.
SELECT COUNT(distinct(customer_id)) FROM retail_sales;

## Identify all unique product categories in the dataset.
SELECT distinct(category) FROM retail_sales;


## Data Analysis & Findings

SELECT * FROM retail_sales;

## Q1) Write a SQL query to retrieve all columns for sales made on '2022-11-05:

SELECT * FROM retail_sales
WHERE sale_date = "2022-11-05";

## Q2) Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022

SELECT * FROM retail_sales
WHERE category="Clothing" AND 
	  quantity > 3 AND 
      (sale_date like "2022-11-__");

## Q3) Write a SQL query to calculate the total sales (total_sale) for each category.:

SELECT category, SUM(total_sale) total_sales 
FROM retail_sales
GROUP BY category;

## Q4) Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:

SELECT category, ROUND(AVG(age),2) Average_age
FROM retail_sales
WHERE category = "Beauty"
GROUP BY category;

## Q5) Write a SQL query to find all transactions where the total_sale is greater than 1000.:

SELECT * 
FROM retail_sales
WHERE total_sale > 1000;

## Q6) Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:

SELECT category, gender,COUNT(transactions_id) Total_trans
FROM retail_sales
GROUP BY category,gender
ORDER BY category;

## Q7) Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

SELECT year,month,avg_sales FROM
		(SELECT YEAR(sale_date) as year,
			   MONTH(sale_date) as month ,
			   AVG(total_sale) as avg_sales,
			   RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY  AVG(total_sale)DESC) rank1
		 FROM retail_sales
		 GROUP BY year,month) as T1
WHERE rank1 = 1;

## Q8) **Write a SQL query to find the top 5 customers based on the highest total sales **:

SELECT customer_id, SUM(total_sale) Total_Sales
FROM retail_sales
GROUP BY customer_id
ORDER BY Total_Sales DESC
LIMIT 5;

## Q9) Write a SQL query to find the number of unique customers who purchased items from each category.:

SELECT category, COUNT(distinct(customer_id)) no_unique_cus
FROM retail_sales
Group by category;

## Q10) Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

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

