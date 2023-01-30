create table tickets
(
ticket_id varchar(10),
create_date date,
resolved_date date
);
delete from tickets;
insert into tickets values
(1,'2022-08-01','2022-08-03')
,(2,'2022-08-01','2022-08-12')
,(3,'2022-08-01','2022-08-16');
create table holidays
(
holiday_date date
,reason varchar(100)
);
delete from holidays;
insert into holidays values
('2022-08-11','Rakhi'),('2022-08-15','Independence day');
select * from holidays;
select * from tickets;
-- code
with 
cte as (select *, (datediff(resolved_date,create_date)+1) - (2*(week(resolved_date)-week(create_date))) as diff
from tickets),

cte1 as 
(with cte as (select *,
(case when week(holiday_date) in (1,7) or holiday_date is NULL then 0 else 1 end  ) as x
from tickets
left join holidays on holiday_date between create_date and resolved_date)
select ticket_id,sum(x) as hol from cte
group by ticket_id)

select *, diff - hol as total_days  from cte
join cte1 on cte.ticket_id = cte1.ticket_id
;


-- logic
SET @StartDate = cast('2023/01/01' as datetime);
SET @EndDate = cast('2023/01/31' as datetime);
set @holidaydate = cast('2023/01/30' as datetime);

SELECT
   (DATEDIFF(  @EndDate , @StartDate) + 1)                  -- number of days
  -((week( @EndDate) -week(@StartDate) )* 2)                -- remove weekoff using number of weeks
  -(CASE WHEN DayNAME(@StartDate) = 'Sunday' THEN 1 ELSE 0 END)  -- removes partial weekoff at startdate if any
  -(CASE WHEN DayNAME(@EndDate) = 'Saturday' THEN 1 ELSE 0 END)   -- removes partial weekoff at enddate if any
  -(case when dayofweek(@holidaydate) in (1,7) then 0 else 1 end)  -- remove the holidays and check if holidays are on weekoff to neglect them
   as days