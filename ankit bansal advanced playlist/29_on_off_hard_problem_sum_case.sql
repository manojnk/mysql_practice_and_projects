-- Solving A Hard SQL Problem | SQL ON OFF Problem | Magic of SQL
-- find the start time ,end time and on count in a sequence of input table
-- see input and output table for more clarification on question
create table event_status
(
event_time varchar(10),
status varchar(10)
);
insert into event_status 
values
('10:01','on'),
('10:02','on'),
('10:03','on'),
('10:04','off'),
('10:07','on'),
('10:08','on'),
('10:09','off'),
('10:11','on'),
('10:12','off');
select * from event_status;
-- output table
-- start_time, end_time, on_count
-- 10:01		10:04		3
-- 10:07		10:09		2
-- 10:11		10:12		1
-- ========================================================================================================================================
with cte as (select event_time
,sum(case when status='on' and prev_status ='off' then 1 else 0 end) over(order by event_time) as group_key
from 
(select * 
,lag(status,1,status) over(order by event_time) as prev_status
from event_status)A)
select min(event_time) as start_time, max(event_time) as end_time,count(1)-1 as on_count from cte
group by group_key;