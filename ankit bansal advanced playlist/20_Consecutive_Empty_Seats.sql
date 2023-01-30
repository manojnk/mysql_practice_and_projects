create table bms (seat_no int ,is_empty varchar(10));
insert into bms values
(1,'N')
,(2,'Y')
,(3,'N')
,(4,'Y')
,(5,'Y')
,(6,'Y')
,(7,'N')
,(8,'Y')
,(9,'Y')
,(10,'Y')
,(11,'Y')
,(12,'N')
,(13,'Y')
,(14,'Y');
select * from bms;
-- 3 consecutive empty seats

-- method 1  : lead lag
select * from 
(select *
,lag(is_empty,1) over(order by seat_no) as lag1
,lag(is_empty,2) over(order by seat_no) as lag2
,lead(is_empty,1) over(order by seat_no) as lead1
,lead(is_empty,2) over(order by seat_no) as lead2
 from bms)x
 where is_empty = 'Y' and lag1 = 'Y' and lag2= 'Y' 
 or is_empty = 'Y' and lead1 = 'Y' and lead2= 'Y' 
 or is_empty = 'Y' and lag1 = 'Y' and lead1= 'Y' 
order by seat_no;

-- method 2 : used advanced aggregation
select * from
(select *
,sum(case when is_empty='Y' then 1 else 0 end) over(order by seat_no rows between 2 preceding and current row) as top
,sum(case when is_empty='Y' then 1 else 0 end) over(order by seat_no rows between 1 preceding and 1 following) as middle
,sum(case when is_empty='Y' then 1 else 0 end) over(order by seat_no rows between current row and 2 following) as bottom
 from bms)x
 where top =3 or middle =3 or bottom =3 ;
 
 -- method 3: 
 with cte as (select *,
 seat_no - row_number() over(order by seat_no) as rn
 from bms
 where is_empty = 'Y')
 select * from cte where rn in (select rn from cte group by rn having count(rn)>=3)
 
