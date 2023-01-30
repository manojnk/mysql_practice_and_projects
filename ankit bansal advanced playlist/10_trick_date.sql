-- find the start and end date from a continous date
-- create table tasks (
-- date_value date,
-- state varchar(10)
-- );

-- insert into tasks  values ('2019-01-01','success'),('2019-01-02','success'),('2019-01-03','success'),('2019-01-04','fail')
-- ,('2019-01-05','fail'),('2019-01-06','fail'),('2019-01-07','success');
select * from tasks;

with cte as (select * 
, row_number() over(partition by state) as x
, date_add(date_value, interval -(row_number() over(partition by state)) day) as diff
from tasks)
select state
,min(date_value) as start_date
,max(date_value) as end_date 
from cte
group by state,diff
order by start_date;
