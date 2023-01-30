-- write a query to find the number of profit rides for the driver
-- a ride is profit ride when the end location of a ride is same as start location of next ride

create table drivers(id varchar(10), start_time time, end_time time, start_loc varchar(10), end_loc varchar(10));
insert into drivers values('dri_1', '09:00', '09:30', 'a','b'),('dri_1', '09:30', '10:30', 'b','c'),('dri_1','11:00','11:30', 'd','e');
insert into drivers values('dri_1', '12:00', '12:30', 'f','g'),('dri_1', '13:30', '14:30', 'c','h');
insert into drivers values('dri_2', '12:15', '12:30', 'f','g'),('dri_2', '13:30', '14:30', 'c','h');

select * from drivers;
select  id, count(1) as total_rides, count(x) as profit 
from (select *,
case when start_loc = lag(end_loc,1) over(partition by id order by start_time) then 1 end as x
from drivers d)x
group by id;

with cte as 
(select  d.*,
row_number() over(partition by id) as row_
from drivers d)
select x.id,count(1) as total_ride,count(y.id) as profit_ride 
from cte x
left join cte y 
on x.id =y.id and x.end_loc = y.start_loc and x.row_+1 = y.row_
group by x.id;

