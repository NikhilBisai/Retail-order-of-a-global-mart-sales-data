select * from df_orderin

--find top 5 highest selling products in each region?
with cte as(
select region,product_id,sum(sale_price) as saleprice
from df_orderin
group by region,product_id)

select * from(
select *,ROW_NUMBER() over(partition by region order by sales desc) as rn
from cte) A
where rn<=5



--Find top 10 highest revenue generating products?
select top 10 product_id,sum(sale_price) as sale
from df_orderin
group by product_id
order by sale desc




--Find month over month growth comparision for 2022 and 2023 sales?
with cte as(
select year(order_date) as yr,MONTH(order_date) as mth,sum(sale_price) as salepr
from df_orderin
group by year(order_date),MONTH(order_date)
)
select yr,sum(case when yr=2022 then salepr else 0 end) as sales_2022,
sum(case when yr=2023 then salepr else 0 end) as sales_2023
from cte
group by yr
order by yr

