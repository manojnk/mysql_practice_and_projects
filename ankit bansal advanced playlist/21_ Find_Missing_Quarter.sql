-- find the missing quater in each store and fill sales as 0 in that quater
-- method 1 : logic aggregation
-- method 2: recurisve cte for master data
-- method 3 : cross join for master data

CREATE TABLE STORES (
Store varchar(10),
Quarter varchar(10),
Amount int);

INSERT INTO STORES (Store, Quarter, Amount)
VALUES ('S1', 'Q1', 200),
('S1', 'Q2', 300),
('S1', 'Q4', 400),
('S2', 'Q1', 500),
('S2', 'Q3', 600),
('S2', 'Q4', 700),
('S3', 'Q1', 800),
('S3', 'Q2', 750),
('S3', 'Q3', 900);

select * from stores;

-- method 1 ( group by) used the sum of 1,2,3,4 as 10 

select store, concat('Q',10 - sum(right(Quarter,1))) as Quarter, 0 as Amount from stores
group by store
union all 
select * from stores
order by store,Quarter;

-- method 2 (using recursive cte)
with recursive cte as(
select distinct store ,1 as q_no from stores
union all
select store,q_no+1 as q_no from cte
where q_no<4),
q as ( select store, concat('Q',q_no) as quarter from cte)
select q.store,q.quarter,
case when amount is not null then amount else 0 end as amount from q
left join stores on q.quarter = stores.quarter and q.store = stores.store
order by q.store,q.quarter ;

-- method 3 , here cross join used to get all the combination
with q as(
select distinct s1.store as store, s2.quarter as quarter
from stores s1, stores s2
)
select q.store,q.quarter,
case when amount is not null then amount else 0 end as amount from q
left join stores on q.quarter = stores.quarter and q.store = stores.store
order by q.store,q.quarter ;
