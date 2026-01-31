# sql_retail_sales

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `p1_retail_db`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `p1_retail_db`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
create database sql_project_p1 ;
use sql_project_p1;

-- creating a table in the database 
create table retail_sales(
transactions_id int not null primary key ,
sale_date date null,
sale_time time null,
customer_id int null,
gender varchar(15) null,
age int null,
category varchar(15) null,
quantiy int null,
price_per_unit float null,
cogs float null,
total_sale float null
);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.

```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
create view data_22_11_05 as 
select *
from retail_sales
where sale_date  = '2022-11-05' ; 
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
create view clothing_category_quant_morethan3_nov22 as 
select *
from retail_sales
where category  = 'Clothing' and quantiy >= 4
and sale_date >= '2022-11-01'
and sale_date < '2022-12-01'   ;
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
create view sum_total_sales_categorywise as 
select
category ,  sum(total_sale) , count(*) as total_order
from retail_sales
group by 1 ; 
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
create view avg_age_beuty_customer as 
select
round(avg(age),2) as Avg_age
from retail_sales
where category =  'Beauty' ;
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
CREATE VIEW total_sales_morethan1000 AS
    SELECT 
        *
    FROM
        retail_sales
    WHERE
        total_sale >= '1000';
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
CREATE VIEW CountTransaction_gender_eachCategory AS
    SELECT 
        category,
        gender,
        COUNT(transactions_id) AS transaction_Count
    FROM
        retail_sales
    GROUP BY category , gender;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
create view avg_sale_Eachmonth_best_selling_month as 
select * from
(select 
year(sale_date) as year ,
month(sale_date) as month , 
avg(total_sale) as avg_sale , 
RANK() OVER (
    PARTITION BY year(sale_date)
    ORDER BY avg(total_sale) Desc) as rank1 
from retail_sales 
group by year , month  		
) as t1 
where rank1 =  1  ; 
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
CREATE VIEW Customer5_highestSale AS
    SELECT 
        customer_id, SUM(total_sale) AS total_sale
    FROM
        retail_sales
    GROUP BY customer_id
    ORDER BY total_sale DESC
    LIMIT 5;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
CREATE VIEW Unique_Customer_category AS
    SELECT 
        category,
        COUNT(DISTINCT customer_id) AS Unique_customer_count
    FROM
        retail_sales
    GROUP BY category;
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
create view Shift_orders as 
with hourly_sale as
(select * ,
case 
when hour(sale_time) < 12 then 'Morning'
when hour(sale_time) between 12 and 17  then 'Afternoon'
else 'Evening'
end as shift
from retail_sales1)
select shift , count(customer_id) as total_orders
from hourly_sale 
group by shift;
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
