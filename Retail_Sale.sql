/*
=========================================
Retail Sales Performance Analysis
Author: Farha Fatima
Tools: SQL Server, Excel, Tableau
=========================================
*/

--------Display the first 10 records of the dataset--------
select top 10 * from [dbo].[retail_sales_dataset]

-------Calculate total Sales by product Category--------
select Product_Category,sum(Total_Amount) [Total Amount] from [dbo].[retail_sales_dataset]
group by Product_Category
order by Product_Category desc

--------Analyze total sales by age group---------
select Product_Category,Gender,
case when age between 18 and 27 then '18-27'
	when age between 28 and 37 then '28-37'
	else '38+'
	end as Age_Group,
sum(Total_Amount) [Total Sales]
from [dbo].[retail_sales_dataset]
group by Product_Category,Gender,
case when age between 18 and 27 then '18-27'
	when age between 28 and 37 then '28-37'
	else '38+'
	end 
order by [Total Sales] desc


----------Calculate Monthly Sales Trend----------

select product_category, month(date) [Sales_Month],sum(total_amount) [Total_Sales] from [dbo].[retail_sales_dataset]
group by Product_Category,month(date)
order by Sales_Month ,Total_Sales desc

-----Identify the top 10 customers by total sales---------
select top 10 Customer_ID,sum(total_amount) [Total_Amount] from [dbo].[retail_sales_dataset]
group by Customer_ID
order by Total_Amount desc

-----Classify customers One-Time or Repeat purchasers using a CTE------
with Customer_Behaviour as(
select customer_id ,count(*) [Purchase_Count] from [dbo].[retail_sales_dataset]
group by Customer_ID)
select Customer_ID, Purchase_Count ,
case
when Purchase_Count =1 then 'One-Time'
else 'Repeat' end Customer_Type
from Customer_Behaviour

-------Calcuate Average Order Value(AOV) by Product category-------
select Product_Category,sum(total_amount)/count(Transaction_ID) [Average_Order_Value] from [dbo].[retail_sales_dataset]
group by Product_Category
order by Average_Order_Value desc

--------Calculate cumulative revenue using a window function------
select date ,total_amount,
sum(total_amount) over(order by date) [Cumulative_Revenue]
from [dbo].[retail_sales_dataset]
