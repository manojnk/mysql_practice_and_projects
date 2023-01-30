-- In this video we will discuss a scenario based SQL problem. I will be solving it using Analytical function.
--  You will learn how to use Lead analytical function with partition by clause and how to deal with data ranges in SQL.
create table billings 
(
emp_name varchar(10),
bill_date date,
bill_rate int
);
delete from billings;
insert into billings values
('Sachin','1990-01-01',25)
,('Sehwag' ,'1989-01-01', 15)
,('Dhoni' ,'1989-01-01', 20)
,('Sachin' ,'1991-02-05', 30)
;

create table HoursWorked 
(
emp_name varchar(20),
work_date date,
bill_hrs int
);
insert into HoursWorked values
('Sachin', '1990-07-01' ,3)
,('Sachin', '1990-08-01', 5)
,('Sehwag','1990-07-01', 2)
,('Sachin','1991-07-01', 4);
select * from billings;
select * from HoursWorked;

-- query 1 
with cte as(SELECT h.emp_name,h.work_date,h.bill_hrs,b.bill_date,b.bill_rate
,datediff(h.work_date, b.bill_date) as diff
,min(datediff(h.work_date, b.bill_date)) over(partition by h.emp_name,h.work_date) as mini
FROM HoursWorked h
JOIN billings b ON  h.emp_name = b.emp_name and h.work_date > b.bill_date)
select emp_name, sum(bill_hrs*bill_rate) as earning  from cte
where diff =mini
group by emp_name;

-- query 2 same as q1 ( better then q1)

with cte as (select *
,lead(bill_date,1,'9999-12-30') over(partition by emp_name order by bill_date) as end_date
from billings )
select b.emp_name, sum(b.bill_rate*h.bill_hrs)from cte b
join HoursWorked h on b.emp_name = h.emp_name and h.work_date between b.bill_date and b.end_date
group by b.emp_name;

