-- Microsoft SQL Interview Question for Data Engineer Position | Data Analytics
-- In this problem we have to write a SQL to build a team with a combination of seniors and juniors within a given salary budget. 
/* A company wants to hire new employee. the budget of the company for the salaries is $70000
the company's caiteria for hiring are:
1.keep hiring the senior with the smallest salary until you cannot hire any more senior.
2.use the remaining budget to hire the junior with the smallest salary
3.keep hiring the junior with the smallest salary until you cannot hire any more juniors
4.write an SQL query to find the senior and junior hired under the mentioned criteria */

create table candidates (
emp_id int,
experience varchar(20),
salary int
);
delete from candidates;
insert into candidates values
 (1,'Junior',10000)
,(2,'Junior',15000)
,(3,'Junior',40000)
,(4,'Senior',16000)
,(5,'Senior',20000)
,(6,'Senior',50000);
select * from candidates;

-- output table
-- emp_id, experience, salary, cum_salary
-- 1	Junior	10000	10000
-- 2	Junior	15000	25000
-- 4	Senior	16000	16000
-- 5	Senior	20000	36000

-- =================================================================================================================================================
with cte as 
(select *
,sum(salary) over(partition by experience order by experience desc,salary) as cum_salary
from candidates),
cte1 as 
(select * from cte 
where experience = 'Senior' and cum_salary < 70000)
select * from cte 
where experience = 'Junior' and cum_salary <= 70000 - (select sum(salary) from cte1)
union all
select * from cte1;