/* write a query to find person_id , name, number of friends, sum of marks 
of a person who have friends with total score greater than 100 */
create table person (
person_id int primary key,
name char(20),
email char(40),
score int);
delete from person;

create table friend(
person_id int,
friend_id int);
delete from friend;

insert into person values (1,'alice','alice2018@hotmail.com',88),(2,'bob','bob2018@hotmail.com',11)
                         ,(3,'davis','davis2018@hotmail.com',27),(4,'tara','tara2018@hotmail.com',45) 
                         ,(5,'john','john2018@hotmail.com',63);

insert into friend values(1,2),(1,3),(2,1),(2,3),(3,5),(4,2),(4,3),(4,5);

-- inputs table person
-- 	1	alice	alice2018@hotmail.com	88
-- 	2	bob	    bob2018@hotmail.com	    11
-- 	3	davis	davis2018@hotmail.com	27
-- 	4	tara	tara2018@hotmail.com	45
-- 	5	john	john2018@hotmail.com	63

-- input table friend
-- 1	2
-- 1	3
-- 2	1
-- 2	3
-- 3	5
-- 4	2
-- 4	3
-- 4	5

-- output table
-- c.person_id,p.name,c.number_of_friends,c.total_score_of_friends
-- 2	          bob	    2	                115
-- 4	          tara	    3	                101

select * from person;
select * from friend;
-- ------------------------------------------------------------------------------------------------------------------------------
with cte as 
(select f.person_id
,count(1) as number_of_friends
,sum(p.score) as total_score_of_friends 
from friend f
inner join person p on p.person_id = f.friend_id
group by f.person_id
having sum(p.score)>100)

select c.person_id,p.name,c.number_of_friends,c.total_score_of_friends
from cte c 
inner join person p on c.person_id = p.person_id;

-- -------------------------------------------------------------------------------------------------------------------------------
-- This question considers it is a one way friendship. 
-- To make it more interesting, also assume that it's a two way friendship. 
-- That way, 3 is friends with 1,2,5 and 4.
-- Query for that:

with cte
as (
  select distinct id1, 
  count(id2) over (partition by id1 order by id1) as no_of_friends,
  sum(p.score) over (partition by id1 order by id1) as friend_score
  from (
    select person_id as id1, friend_id as id2 from friend
    UNION ALL
    select friend_id as id1, person_id as id2 from friend)t
  join person p
  on t.id2 = p.person_id)

select a.id1 as person_id, b.name as Name, no_of_friends, friend_score as
sum_of_marks
from cte a join person b on a.id1 = b.person_id
where friend_score > 100;


