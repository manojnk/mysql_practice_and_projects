-- create and insert script for this problem. Do try yourself without using CTE.

-- create table sales (
-- product_id int,
-- period_start date,
-- period_end date,
-- average_daily_sales int
-- );

-- insert into sales values(1,'2019-01-25','2019-02-28',100),(2,'2018-12-01','2020-01-01',10),(3,'2019-12-01','2020-01-31',1);
select * from sales;
with recursive cte as(
select min(period_start) as date,max(period_end) as max_date from sales
union all
select date_add(date, interval 1 day),max_date from cte
where date_add(date, interval 1 day)<=max_date
 )
 select product_id,year(date),sum(average_daily_sales) from cte
 join sales on date between period_start and period_end
group by  year(date) ,product_id
order by product_id,year(date) ;