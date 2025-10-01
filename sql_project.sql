-- sql retail sales analysis--
CREATE DATABASE sql_project;
-- selecting database --
USE sql_project;

-- create table --
CREATE TABLE Retail_sales(
transaction_id INT PRIMARY KEY,
sale_date DATE,
sale_time TIME,
customer_id INT,
gender VARCHAR(25),
age INT,
category VARCHAR(25),
quantiy INT,
price_per_unit FLOAT,
cogs FLOAT,
total_sale FLOAT );
 
SELECT * FROM Retail_sales ;
SELECT COUNT(*) FROM Retail_sales;

-- Data Cleaning --

SELECT * FROM Retail_sales 
WHERE transaction_id = NULL;
  
SELECT * FROM Retail_sales 
WHERE sale_date IS NULL;
   
SELECT * FROM Retail_sales 
WHERE sale_time IS NULL;

SELECT * FROM Retail_sales 
WHERE customer_id IS NULL;

SELECT * FROM Retail_sales 
WHERE gender IS NULL;

SELECT * FROM Retail_sales 
WHERE age IS NULL;

SELECT * FROM Retail_sales 
WHERE category IS NULL;

SELECT * FROM Retail_sales 
WHERE quantiy IS NULL;

SELECT * FROM Retail_sales 
WHERE price_per_unit IS NULL;

SELECT * FROM Retail_sales 
WHERE cogs IS NULL;

SELECT * FROM Retail_sales 
WHERE total_sale IS NULL;

-- Data exploration --
-- How Many sales we have --

SELECT count(*) AS total_sale FROM Retail_sales;

-- How many unique customer we have --
SELECT  count(DISTINCT customer_id) AS total_sale FROM Retail_sales;

-- How many unique category we have 
SELECT  DISTINCT category  FROM Retail_sales;

-- Data analysis & Business key problems and answers
-- My analysis and finding
-- 0.1 Write a 50%, query to retrieve all columns for sales made on 2022-11-05
-- 0.2 Write SQL query to retrieve all transactions where the category is Clothing and the the month of Nov-2022
-- 0.3. Write a SQL query to calculate the total sales (total sole) for each category.
-- 0.4 Write a sql query to find the average age of customers who purchased itens fron the 'Beauty categoгу.
-- Q.5 Write SQL query to find all transactions where the total sale is greater than 1000.
-- Q.6 write a SQL query to find the total number of transactions (transaction id) made by each gender in each category. 
-- 0.7 Write a sqL query to calculate the average sate for each month. Find out best selling month in each year
-- 0.8 write a sql query to find the top 5 castomers based on the highest total sales
-- 0.9 Write a sql  query to find the number of unique customers who purchased items from each categогy
-- 0.10 Write a SQL query to create each shift and number of orders (Example morning <=12 Afternoon between 12 & 17 evening > 17)
 
 -- 0.1 Write a sql query to retrieve all columns for sales made on 2022-11-05
 SELECT * FROM Retail_sales
 WHERE sale_date = '2022-11-05';
 
 -- 0.2 Write SQL query to retrieve all transactions where the category is Clothing and the quantity  sold is more than 4 in the month of Nov-2022
 SELECT *
 FROM Retail_sales
 WHERE category = 'clothing'
 AND 
 sale_date >= '2022-11-01' AND sale_date <= '2022-11-30'
 AND
 quantiy >= 4;
 
 -- 0.3. Write a SQL query to calculate the total sales (total sole) for each category
 SELECT
 category, sum(total_sale) AS net_sale,
 count(*) AS total_orders
 FROM Retail_sales
 GROUP BY 1
 
-- 0.4 Write a sql qeary to find the average age of customers who purchased itens fron the 'Beauty categoгу --

SELECT
AVG(age) FROM Retail_sales
WHERE category = 'Beauty';

-- Q.5 Write SQL query to find all transactions where the total sale is greater than 1000.
SELECT * 
FROM Retail_sales
WHERE total_sale >=1000;

-- Q.6 write a SQL query to find the total number of transactions (transaction id) made by each gender in each category. 
SELECT 
count(*) AS total_transaction , gender, category FROM Retail_sales
GROUP BY gender, category
ORDER BY 1

-- 0.7 Write a sqL query to calculate the average sale for each month. Find out best selling month in each year --
SELECT * FROM(
SELECT 
YEAR(Sale_date) AS year,
MONTH(Sale_date) AS month,
AVG(total_sale) AS avg_sale,
RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS rank
FROM Retail_sales
GROUP BY 1,2
) AS t1
WHERE rank = 1

-- 0.8 write a sql query to find the top 5 castomers based on the highest total sales

SELECT 
customer_id, 
SUM(total_sale) AS total_sale
FROM Retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

-- 0.9 Write a sql  query to find the number of unique customers who purchased items from each categогy

SELECT
COUNT(DISTINCT customer_id) AS unique_customer ,
category
FROM Retail_sales
GROUP BY category

-- 0.10 Write a SQL query to create each shift and number of orders (Example morning <=12 Afternoon between 12 & 17 evening > 17)

WITH hourly_sale
(
SELECT *,
CASE
WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
ELSE 'Evening'
END AS shift
FROM Retail_sales
)
SELECT shift,
COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift

-- End of project --

 
 
 

 




  
  
 