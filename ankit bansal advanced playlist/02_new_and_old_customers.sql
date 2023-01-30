create table customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
);
select * from customer_orders;
insert into customer_orders values(1,100,cast('2022-01-01' as date),2000),(2,200,cast('2022-01-01' as date),2500),(3,300,cast('2022-01-01' as date),2100)
,(4,100,cast('2022-01-02' as date),2000),(5,400,cast('2022-01-02' as date),2200),(6,500,cast('2022-01-02' as date),2700)
,(7,100,cast('2022-01-03' as date),3000),(8,400,cast('2022-01-03' as date),1000),(9,600,cast('2022-01-03' as date),3000)
;

with t1 as (select customer_id,min(order_date) as first_order_date
from customer_orders
group by customer_id),
t2 as(
select c.*, first_order_date,
case when order_date = first_order_date then "new"  else "old" end as x
from customer_orders c 
join t1 on c.customer_id = t1.customer_id
order by c.customer_id)

select order_date,
count(case when x = "new" then 1 end )as new_,
count(case when x = "old" then 1 end )as old_
from t2
group by order_date
;