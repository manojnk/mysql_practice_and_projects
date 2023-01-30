-- interesting SQL interview question asked by Udaan. We will use self join to solve this question. 
-- business_city table has data from the day idaan has started operation
-- write a SQL to identify yearwise count of new cities where udaan started their operation

create table business_city (
business_date date,
city_id int
);
delete from business_city;
insert into business_city
values
(cast('2020-01-02' as date),3)
,(cast('2020-07-01' as date),7)
,(cast('2021-01-01' as date),3)
,(cast('2021-02-03' as date),19)
,(cast('2022-12-01' as date),3)
,(cast('2022-12-15' as date),3)
,(cast('2022-02-28' as date),12);

select * from business_city;
-- output table
-- year, number_of_new_business
-- 2020	2
-- 2021	1
-- 2022	1
-- ===============================================================================================================================
with cte as (select year(business_date) as year, city_id from business_city)
select c1.year,count(distinct case when c2.city_id is null then c1.city_id else null end) as number_of_new_business
from cte c1
left join cte c2 on c1.year > c2.year and c1.city_id = c2.city_id
group by c1.year;