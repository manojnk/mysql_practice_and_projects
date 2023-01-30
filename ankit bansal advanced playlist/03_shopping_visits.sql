create table entries ( 
name varchar(20),
address varchar(20),
email varchar(20),
floor int,
resources varchar(10));

insert into entries 
values ('A','Bangalore','A@gmail.com',1,'CPU'),('A','Bangalore','A1@gmail.com',1,'CPU'),('A','Bangalore','A2@gmail.com',2,'DESKTOP')
,('B','Bangalore','B@gmail.com',2,'DESKTOP'),('B','Bangalore','B1@gmail.com',2,'DESKTOP'),('B','Bangalore','B2@gmail.com',1,'MONITOR');

select * from entries;

with t1 as (
select name , count(1) as total_visits
from entries
group by name
),
t2 as (
select name , floor, count(1) as most_visited_floor,
rank() over(partition by name order by count(1) desc) as rn
from entries
group by name, floor
),
t3 as (
select name, group_concat( distinct resources) as most_bought_resources
from entries
group by name
),
t4 as (
select * from t2 
where rn =1
)
select t1.name, t1.total_visits , t4.floor as most_visited_floor, t3.most_bought_resources from t1 
join t4 on t1.name = t4.name
join t3 on t1.name = t3.name;

