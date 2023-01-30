-- Walmart Labs SQL Interview Question for Senior Data Analyst Position | Data Analytics
-- a very interesting problem where from a phone log history we need to find if the caller had done first and last call for the day to the same person. 

create table phonelog(
    Callerid int, 
    Recipientid int,
    Datecalled datetime
);

insert into phonelog(Callerid, Recipientid, Datecalled)
values(1, 2, '2019-01-01 09:00:00.000'),
       (1, 3, '2019-01-01 17:00:00.000'),
       (1, 4, '2019-01-01 23:00:00.000'),
       (2, 5, '2019-07-05 09:00:00.000'),
       (2, 3, '2019-07-05 17:00:00.000'),
       (2, 3, '2019-07-05 17:20:00.000'),
       (2, 5, '2019-07-05 23:00:00.000'),
       (2, 3, '2019-08-01 09:00:00.000'),
       (2, 3, '2019-08-01 17:00:00.000'),
       (2, 5, '2019-08-01 19:30:00.000'),
       (2, 4, '2019-08-02 09:00:00.000'),
       (2, 5, '2019-08-02 10:00:00.000'),
       (2, 5, '2019-08-02 10:45:00.000'),
       (2, 4, '2019-08-02 11:00:00.000');
select * from phonelog;

-- output table       
-- Callerid, date_only       
-- 2	2019-07-05
-- 2	2019-08-02     
-- ===================================================================================================================================================
  
with cte as 
(select distinct Callerid, date(Datecalled) as date_only,
first_value(Recipientid) over(partition by Callerid, date(Datecalled) order by Datecalled rows between unbounded preceding and unbounded following) as first_calls
from phonelog),
cte1 as 
(select distinct Callerid,date(Datecalled)as date_only,
last_value(Recipientid) over(partition by Callerid,date(Datecalled) order by Datecalled rows between unbounded preceding and unbounded following) as last_calls
from phonelog)
select cte.Callerid, cte.date_only
from cte 
join cte1 on cte.Callerid = cte1.Callerid and cte.date_only = cte1.date_only and first_calls = last_calls;


