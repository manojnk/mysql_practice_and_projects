-- Given the following two tables, return the fraction of users, rounded to two decimal places,
-- who accessed Amazon music and upgraded to prime membership within the first 30 days of signing up. 

create table users
(
user_id integer,
name varchar(20),
join_date date
);
insert into users
values (1, 'Jon', CAST('20-2-14' AS date)), 
(2, 'Jane', CAST('20-2-14' AS date)), 
(3, 'Jill', CAST('20-2-15' AS date)), 
(4, 'Josh', CAST('20-2-15' AS date)), 
(5, 'Jean', CAST('20-2-16' AS date)), 
(6, 'Justin', CAST('20-2-17' AS date)),
(7, 'Jeremy', CAST('20-2-18' AS date));

create table events
(
user_id integer,
type varchar(10),
access_date date
);

insert into events values
(1, 'Pay', CAST('20-3-1' AS date)), 
(2, 'Music', CAST('20-3-2' AS date)), 
(2, 'P', CAST('20-3-12' AS date)),
(3, 'Music', CAST('20-3-15' AS date)), 
(4, 'Music', CAST('20-3-15' AS date)), 
(1, 'P', CAST('20-3-16' AS date)), 
(3, 'P', CAST('20-3-22' AS date));

select * from users;
select * from events;

select * from events
where type='Music' or  type='P' 
order by user_id;

-- query 
select 
round(sum(case when datediff(access_date,join_date)<=30 then 1 else 0 end)
/ count(distinct users.user_id)*100,2) as percentage from users 
left join events on users.user_id = events.user_id and events.type='P'
where users.user_id in (select user_id from events where type= 'Music')

