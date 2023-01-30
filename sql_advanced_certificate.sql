create table contest( 
         event_id int ,
         p_name char(20),
         score float
         ) ;
insert into contest (event_id ,p_name ,score ) values
          (1434,"aurora",9.98),
          (1434,"manoj",9.88),
          (1434,"tesla",9.85),
          (1434,"mufa",9.76),
          (2626,"anita",9.95),
          (2626,"laura",9.95),
          (2626,"chris",9.94),
          (2626,"harsh",9.72),
          (2626,"jhon",9.68),
          (1434,"mia",9.88);
          
select * from contest;

with 
t1 as (select contest.*,
dense_rank() over(partition by event_id order by score desc ) as rk from contest),
t2 as (select * from t1 where rk <=3),
t3 as (select event_id , case when rk =1  then p_name else Null end as first from t2 where rk=1),
t4 as (select event_id , case when rk =2  then p_name else Null end as second from t2 where rk=2),
t5 as (select event_id , case when rk =3  then p_name else Null end as third from t2 where rk=3), 
t6 as (select t3.event_id , t3.first, t4.second , t5.third from t3 join t4 on t3.event_id = t4.event_id join t5 on t3.event_id = t5.event_id)
select event_id , group_concat(distinct first) as first ,group_concat(distinct second) as second , group_concat(distinct third) as third from t6 group by event_id;

