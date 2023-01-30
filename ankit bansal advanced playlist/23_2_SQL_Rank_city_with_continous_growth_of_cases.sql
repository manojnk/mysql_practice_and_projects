-- find cities where covid cases are increasing continously

create table covid(city varchar(50),days date,cases int);
delete from covid;
insert into covid values('DELHI','2022-01-01',100);
insert into covid values('DELHI','2022-01-02',200);
insert into covid values('DELHI','2022-01-03',300);

insert into covid values('MUMBAI','2022-01-01',100);
insert into covid values('MUMBAI','2022-01-02',100);
insert into covid values('MUMBAI','2022-01-03',300);

insert into covid values('CHENNAI','2022-01-01',100);
insert into covid values('CHENNAI','2022-01-02',200);
insert into covid values('CHENNAI','2022-01-03',150);

insert into covid values('BANGALORE','2022-01-01',100);
insert into covid values('BANGALORE','2022-01-02',300);
insert into covid values('BANGALORE','2022-01-03',200);
insert into covid values('BANGALORE','2022-01-04',400);

select * from covid;

-- solution (used 2 rank for date and score to compare theor relative growth in same direction)
with cte as (select * 
, dense_rank() over(partition by city order by days asc) as date_rk
, dense_rank() over(partition by city order by cases asc) as case_rk
,cast(dense_rank() over(partition by city order by days asc) as signed)-cast(dense_rank() over(partition by city order by cases asc) as signed) as score
from covid)
select city from cte
group by city 
having sum(score) = 0  and count(distinct score) = 1;

