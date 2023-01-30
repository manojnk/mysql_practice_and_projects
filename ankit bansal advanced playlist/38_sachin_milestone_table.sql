-- table which shows sachin number of matches and innings to reach miletone 1000, 5000, 10000 runs

with cte as 
(select matches, innings, runs
,sum(runs) over(order by innings) as cum_runs
from sachin_runs),
cte2 as 
(select 1000 as milestone_runs
union all
select 5000 milestone_runs
union all
select 10000 as milestone_runs)
select cte2.milestone_runs , min(matches) as matches, min(innings) as innings 
from cte2 
join cte1 on cte1.cum_runs > cte2.milestone_runs
group by cte2.milestone_runs;

 