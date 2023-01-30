create table emp(
id int,
type char(20),
amount int 
);
insert into emp (id,type,amount) values (1,"salary",5000);
insert into emp (id,type,amount) values (1,"bonus",2000);
insert into emp (id,type,amount) values (1,"increment",1000);
insert into emp (id,type,amount) values (2,"salary",6000);
insert into emp (id,type,amount) values (2,"bonus",2000);
insert into emp (id,type,amount) values (2,"increment",1000);
insert into emp (id,type,amount) values (3,"salary",7000);
insert into emp (id,type,amount) values (3,"bonus",2000);
insert into emp (id,type,amount) values (3,"increment",1000);
insert into emp (id,type,amount) values (4,"salary",8000);
insert into emp (id,type,amount) values (4,"bonus",2000);
insert into emp (id,type,amount) values (4,"increment",1500);

select * from emp;
create table emp_pivot(
id int,
salary int,
bonus int,
increment int
);
select * from emp_pivot;

insert into emp_pivot(
select id,
sum(case when type="salary" then amount end) as salary,
sum(case when type="bonus" then amount end)  as bonus,
sum(case when type="increment" then amount end) as increment
from emp
group by id)
;

select * from (select id, "salary" as type, salary as amount from emp_pivot
union all
select id, "bonus" as type, bonus as amount from emp_pivot
union all
select id, "increment" as type, increment as amount from emp_pivot)x
order by id
;
select "mankmnak" as name
union 
select "mankmank" as name
;

