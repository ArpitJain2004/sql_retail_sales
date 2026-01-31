-- creating a database 
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


select * from retail_sales limit 10 ;
select count(*) from retail_sales ;


create view data_22_11_05 as 
select * from retail_sales where sale_date  = '2022-11-05' ; 


create view clothing_category_quant_morethan3_nov22 as 
select * from retail_sales where category  = 'Clothing' and quantiy >= 4  and sale_date >= '2022-11-01'
and sale_date < '2022-12-01'   ;



create view sum_total_sales_categorywise as 
select category ,  sum(total_sale) , count(*) as total_order
from retail_sales group by 1 ; 


create view avg_age_beuty_customer as 
select round(avg(age),2) as Avg_age from retail_sales where category =  'Beauty' ;



create view total_sales_morethan1000 as 
select * from retail_sales where total_sale >= '1000' ;



create view CountTransaction_gender_eachCategory as 
select  category  , gender , count(transactions_id) as transaction_Count from retail_sales group by  category ,  gender ; 



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




create view Customer5_highestSale as
select customer_id , sum(total_sale) as total_sale 
from retail_sales 
group by customer_id
order by total_sale desc
limit 5 ;




create view Unique_Customer_category as 
select category , 
count(Distinct customer_id) as Unique_customer_count
from retail_sales 
group by category ;






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


select hour(sale_time) from retail_sales1;

