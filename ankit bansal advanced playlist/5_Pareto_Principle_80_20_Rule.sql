/* 
dataset link:
https://www.youtube.com/redirect?event=video_description&redir_token=QUFFLUhqa29SbXRheDh0SWd6VE9obmJkMjlCOXNBTHctQXxBQ3Jtc0ttY3BtWUNCbDNzYkxCbTdpbldvcXNUUkJvYXZYMGZrTVk1d1Z3cjZRLW9hLUtoaVdmemdPRENoNjBXM1NISlRuUVVES2Y3bTcxWWFpNDlGOFdwZTJvTDNzNWVVZlN4LWIwRmJWN1Q0SXIydmxYX1kxNA&q=https%3A%2F%2Fdrive.google.com%2Fdrive%2Ffolders%2F1Dc81McsB4lp1JUIwssDmmOaw6Z7rBK8T&v=oGgE180oaTs
The Pareto principle states that for many outcomes,roughly 80% of consequences come from 20% of causes
1. 80% of the productivity come from 20% of the employees
2. 80% of your sales come from 20% of your client 
3. 80% of decisions in a meeting are made in 20% of time 

4. 80% of your sales comes from 20% of your product or services */
-- select sum(sales)*0.8 from orders;
-- 1837760


with product_wise_table as 
(
select product_id , sum(sales) as product_sales
from orders
group by product_id)
,calc_sales as (
select product_id, product_sales
,sum(product_sales) over(order by product_sales desc rows between unbounded preceding and current row) as running_sales
,0.8*sum(product_sales) over() as total_sales
from product_wise_table)
select * from calc_sales where running_sales <= total_sales;
