select top 10 * from [dbo].[retail_sales_dataset]

--Total Sales each product Category
select Product_Category,sum(Total_Amount) [Total Amount] from [dbo].[retail_sales_dataset]
group by Product_Category
order by Product_Category desc

--Grouping by Age
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


--Sales paer Month
select product_category, month(date) [Sales_Month],sum(total_amount) [Total_Sales] from [dbo].[retail_sales_dataset]
group by Product_Category,month(date)
order by Sales_Month ,Total_Sales desc

select top 10 Customer_ID,sum(total_amount) [Total_Amount] from [dbo].[retail_sales_dataset]
group by Customer_ID
order by Total_Amount desc

--One-Time or Repeat
with Customer_Behaviour as(
select customer_id ,count(*) [Purchase_Count] from [dbo].[retail_sales_dataset]
group by Customer_ID)

select Customer_ID, Purchase_Count ,
case
when Purchase_Count =1 then 'One-Time'
else 'Repeat' end Customer_Type
from Customer_Behaviour

--Average order Sales per record
select Product_Category,avg(total_amount) [Avg_Sales] from [dbo].[retail_sales_dataset]
group by Product_Category
order by Avg_Sales desc

--Aov
select Product_Category,sum(total_amount)/count(Transaction_ID) [Avg_Sales] from [dbo].[retail_sales_dataset]
group by Product_Category
order by Avg_Sales desc

--Cumulative Running
select date ,total_amount,
sum(total_amount) over(order by date) [Cumulative_Revenue]
from [dbo].[retail_sales_dataset]
