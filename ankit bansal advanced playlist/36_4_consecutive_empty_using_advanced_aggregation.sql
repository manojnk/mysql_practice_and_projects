-- PharmEasy SQL Interview Question | Consecutive Seats in a Movie Theatre | Data Analytics
-- there are 3 rows in a movie hall each with 10 seats in each row
-- write a SQL to find 4 consecutive empty seats(0)

create table movie(
seat varchar(50),occupancy int
);
insert into movie values('a1',1),('a2',1),('a3',0),('a4',0),('a5',0),('a6',0),('a7',1),('a8',1),('a9',0),('a10',0), -- a3 to a6 has 4 empty seats as per question
('b1',0),('b2',0),('b3',0),('b4',1),('b5',1),('b6',1),('b7',1),('b8',0),('b9',0),('b10',0),
('c1',0),('c2',1),('c3',0),('c4',1),('c5',1),('c6',0),('c7',1),('c8',0),('c9',0),('c10',1);
select * from movie;
-- output table
-- seat
-- a3
-- a4
-- a5
-- a6
-- ==============================================================================================================================================
-- solution 1:
with cte as 
(select *
,row_number() over() as rn
,left(seat,1) as grp 
from movie),
cte1 as 
(select * 
,row_number() over(partition by left(seat,1)) as grp_rn
,rn - row_number() over(partition by left(seat,1)) as diff
from cte 
where occupancy = 0)
select seat
from cte1 
where diff in (select diff from cte1 
group by diff
having count(diff) >=4);

-- ========================================================================================================================================
-- solution 2

with cte as 
(select *
,left(seat,1) as grp
,cast(substring(seat,2,2) as signed) as rn
from movie),
cte2 as
(select *  
,max(occupancy) over(partition by grp order by rn rows between current row and 3 following) as next_4_empty
,count(occupancy) over(partition by grp order by rn rows between current row and 3 following) as count_row_in_window
from cte),
cte3 as 
(select * from cte2 
where next_4_empty = 0 and count_row_in_window = 4)
select cte2.seat
from cte2
join cte3 on cte2.grp = cte3.grp and cte2.rn between cte3.rn and cte3.rn+3;