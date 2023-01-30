-- drop table test;
create table test (
a int ,
b int ,
c int);

insert into test values
(1,10,5100),
(1,20,5200),
(1,30,5300),
(1,40,5400),
(2,10,5500),
(2,20,5600),
(2,30,5700),
(2,40,5800);

select * from test;
 with cte as (select a,b,sum(c) as sum_ from test group by a,b)
 select distinct test.a,c1.sum_ as sum_10,c2.sum_ as sum_20,c3.sum_ as sum_30,c4.sum_ as sum_40
 from test
join cte c1
on c1.a =test.a and c1.b=10
join cte c2
on c2.a =test.a and c2.b=20
join cte c3
 on c3.a =test.a and c3.b=30
join cte c4
 on c4.a =test.a and c4.b=40
 ;
 
 
