-- Meesho HackerRank SQL Interview Question and Answer | Customer Budget
-- find how many products fall into customer budget along with list of products???
-- incase of clash choose the less costly product

create table products
(
product_id varchar(20) ,
cost int
);
insert into products values ('P1',200),('P2',300),('P3',500),('P4',800);

create table customer_budget
(
customer_id int,
budget int
);

insert into customer_budget values (100,400),(200,800),(300,1500);

select * from products;
select * from customer_budget;

-- solution query

with cte as (select * 
,sum(cost) over(order by cost) as cum_sum
from products)
select customer_id,budget,count(product_id) as number_of_products, group_concat(product_id) as list_of_products
from customer_budget
left join cte on cte.cum_sum < customer_budget.budget
group by customer_id,budget;

-- query output 
-- customer_id,budget,number_of_products,list_of_products
-- 100	         400	   1	             P1
-- 200	         800	   2	             P1,P2
-- 300	         1500	   3	             P1,P2,P3

