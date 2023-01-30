-- HARD
-- use all_;
-- create table spending 
-- (
-- user_id int,
-- spend_date date,
-- platform varchar(10),
-- amount int
-- );

-- insert into spending values(1,'2019-07-01','mobile',100),(1,'2019-07-01','desktop',100),(2,'2019-07-01','mobile',100)
-- ,(2,'2019-07-02','mobile',100),(3,'2019-07-01','desktop',100),(3,'2019-07-02','desktop',100);
select * from spending;


-- answer 1 

with cte as(select spend_date,user_id,max(platform) as platform,sum(amount) as amount
from spending
group by spend_date,user_id
having count(distinct platform) =1
union all
select spend_date,user_id,'both' as platform,sum(amount) as amount
from spending
group by spend_date,user_id
having count(distinct platform) =2
union all
select distinct spend_date, null as user_id,'both' as platform,0 as amount
from spending
union all
select distinct spend_date, null as user_id,'mobile' as platform,0 as amount
from spending
union all
select distinct spend_date, null as user_id,'desktop' as platform,0 as amount
from spending
)
select spend_date, platform,sum(amount) as amount,count(distinct user_id)
from cte
group by  spend_date,platform
order by  spend_date,platform desc;

-- answer 2 using group by concate
WITH CTE AS
(
SELECT spend_date,group_concat(platform) 'platform',SUM(amount) 'amount',user_id
FROM spending
GROUP BY spend_date,user_id
UNION ALL
SELECT distinct spend_date,'both',0,NULL
FROM spending
)

SELECT spend_date,CASE WHEN platform='mobile,desktop' THEN 'both' ELSE platform END platform,SUM(amount) 'total_amt',COUNT(DISTINCT user_id) 'total_users'
FROM CTE
GROUP BY spend_date,CASE WHEN platform='mobile,desktop' THEN 'both' ELSE platform END
ORDER BY spend_date,platform desc;




