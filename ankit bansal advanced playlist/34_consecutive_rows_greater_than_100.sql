-- we are going to discuss a hard leet code problem called human traffic of stadium.
-- We will be using SQL analytical functions to solve the problem.
-- Write a Query to display the record which have 3 or more consecutive rows
-- with the number of people more than 100 (inclusive) each day??
create table stadium (
id int,
visit_date date,
no_of_people int
);

insert into stadium
values (1,'2017-07-01',10)
,(2,'2017-07-02',109)
,(3,'2017-07-03',150)
,(4,'2017-07-04',99)
,(5,'2017-07-05',145)
,(6,'2017-07-06',1455)
,(7,'2017-07-07',199)
,(8,'2017-07-08',188);
select * from stadium;

-- output table
-- id, visit_date, no_of_people
-- 5	2017-07-05		145
-- 6	2017-07-06		1455
-- 7	2017-07-07		199
-- 8	2017-07-08		188
-- =====================================================================================================================================
-- solution 1
with cte as 
(select *
,ifnull(lag(no_of_people,1) over(order by visit_date),0) as lag_1
,ifnull(lag(no_of_people,2) over(order by visit_date),0) as lag_2
,ifnull(lead(no_of_people,1) over(order by visit_date),0) as lead_1
,ifnull(lead(no_of_people,2) over(order by visit_date),0) as lead_2
 from stadium)
 select id, visit_date, no_of_people
 from cte 
 where no_of_people >= 100 and ((lag_1 >100 and lag_2>100) or (lead_1 >100 and lead_2>100) or (lag_1 >100 and lead_1>100));
 
 -- solution 2
 with cte as 
 (select *
 ,row_number() over(order by visit_date) as rn
 ,id - row_number() over(order by visit_date) as diff
 from stadium 
 where no_of_people >=100)
 select id, visit_date, no_of_people
 from cte
 where diff in (select diff from cte 
 group by diff
 having count(diff) >=3);