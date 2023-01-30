-- In this video we will discuss a Spotify case study. This case study has 5 questions and with each question difficulty level will go up.
-- Script to create and insert data:
CREATE table activity
(
user_id varchar(20),
event_name varchar(20),
event_date date,
country varchar(20)
);
delete from activity;
insert into activity values (1,'app-installed','2022-01-01','India')
,(1,'app-purchase','2022-01-02','India')
,(2,'app-installed','2022-01-01','USA')
,(3,'app-installed','2022-01-01','USA')
,(3,'app-purchase','2022-01-03','USA')
,(4,'app-installed','2022-01-03','India')
,(4,'app-purchase','2022-01-03','India')
,(5,'app-installed','2022-01-03','SL')
,(5,'app-purchase','2022-01-03','SL')
,(6,'app-installed','2022-01-04','Pakistan')
,(6,'app-purchase','2022-01-04','Pakistan');

select * from activity;

-- 1. find totalactive users eacy day
-- solution
-- 2022-01-01	3
-- 2022-01-02	1
-- 2022-01-03	3
-- 2022-01-04	1
-- query
select event_date , count(distinct user_id) as active_users
from activity
group by event_date;

-- 2. total active users each week 
-- solution
-- 2022	0	3
-- 2022	1	5
SELECT 
YEAR(event_date) AS year
,WEEK(event_date) AS week
,COUNT(DISTINCT user_id) AS active_users_this_week 
FROM activity
group by YEAR(event_date), week(event_date);

-- 3. date wise total number of user who installed and purchased on the same date
-- solution
-- 2022-01-01	0
-- 2022-01-02	0
-- 2022-01-03	2
-- 2022-01-04	1
-- solution1 self join
with cte as (
select a1.event_date as date,count(1) as pro_user 
from activity a1
join activity a2 on a1.event_date = a2.event_date and a1.user_id = a2.user_id and a1.event_name!=a2.event_name and a1.event_name > a2.event_name
group by a1.event_date
union all
select distinct event_date , null from activity)
select date,count(pro_user) as pro_user from cte
group by date 
order by date;

-- solution 2 group by
select event_date as date, count(user_id) as pro_user
from(
select event_date,user_id,count(event_name)
from activity
group by  event_date,user_id having count(event_name) =2
union all
select distinct event_date , null ,null from activity)x
 group by event_date
 order by date;
 
 -- solution 3 used case to insert dummy

select event_date ,count(id_x) as pro_users
from(
select event_date,user_id
,case when count(event_name)=2 then user_id else null end as id_x
from activity
group by  event_date,user_id )x
group by event_date
order by event_date;

 
 -- 4. percentage of paid user in India, US , Others
--  solution
--  India	40.0000
-- USA	20.0000
-- others	40.0000

select renamed_country, cnt / sum(cnt) over() * 100 as percentage
from(
select count(1) as cnt, case when country = 'India' or country = 'USA' then country else 'others' end as renamed_country 
 from activity 
 where event_name = 'app-purchase'
 group by  case when country = 'India' or country = 'USA' then country else 'others' end)x;

-- cross join some hard code words
 with cte as (select 5 as users union all select 2 as users),
 cte1 as (select 5 as users union all select 2 as users)
 select * from cte,cte1;
 
 -- 5.of all the users who installed the numbers of users who installed on the very next day , day wise result
 
with t1 as (select * from activity 
where event_name = 'app-installed'),
t2 as (
select * from activity 
where event_name = 'app-purchase')
select * from t1 left join t2 on t1.user_id  = t2.user_id and datediff(t1.);

with cte1 as (select * 
from activity 
where event_name = 'app-purchase'),
cte2 as (
select * 
from activity 
where event_name= 'app-installed'
),
cte3 as (select cte1.user_id ,cte1.event_date from cte1 
join cte2 on cte1.user_id = cte2.user_id and datediff(cte1.event_date,cte2.event_date) = 1),
cte4 as (select distinct event_date from activity)
select cte4.event_date, count(cte3.user_id) as count from cte4 
left join cte3 on cte4.event_date = cte3.event_date
group by cte4.event_date;
