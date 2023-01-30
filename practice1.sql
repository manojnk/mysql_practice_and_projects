with emp as
(select 1 as emp_id,1000 as emp_salary, 1 as dep_id
union all select 2 as emp_id,2000 as emp_salary, 3 as dep_id
union all select 3 as emp_id,3000 as emp_salary, 1 as dep_id
union all select 4 as emp_id,3000 as emp_salary, 2 as dep_id
union all select 5 as emp_id,4000 as emp_salary, 1 as dep_id
union all select 6 as emp_id,4000 as emp_salary, 2 as dep_id
),
dep as (
select 1 as dep_id, "d1" as dept_name
union all select 2 as dep_id, "d3" as dept_name
union all select 3 as dep_id, "d3" as dept_name
)
select * from emp
inner join dep on emp.dep_id= dep.dep_id;


with cte as (
select "apple" as name, 4 as num
union all 
select "banana" as name, 2 as num
),;
create table cte (
name char(20),
num int);
insert into cte values ("apple",4),("orange",3);
select * from cte;
drop table cte;
-- select repeat(name,num) from cte;
with 
frt as (
select name, num from cte
union all
select name,num-1 from frt
where num>1
)
select * from frt 
order by name;

-- cumulative addition
with cte as (
select 1 as num
union all select 2 as num
union all select 2 as num
union all select 3 as num
union all select 4 as num
)
select num,
sum(num) over(order by num asc rows between current row and unbounded following) as sum_
from cte;





