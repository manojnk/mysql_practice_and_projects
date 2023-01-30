/*LeetCode Hard SQL problem | Students Reports By Geography | Pivot Ka Baap
A LeetCode problem where we need to pivot the data from row to column. 
The interesting part about this problem is we don't have a common key to pivot the data on.*/

create table players_location
(
name varchar(20),
city varchar(20)
);
delete from players_location;
insert into players_location values 
('Sachin','Mumbai'),
('Virat','Delhi') , 
('Rahul','Bangalore'),
('Rohit','Mumbai'),
('Mayank','Bangalore');
select * from players_location;
-- ouput table
-- Bangalore, Mumbai, Delhi
-- Mayank		Rohit	Virat
-- Rahul		Sachin	Null
-- =====================================================================================================================================================
select
 max(case when city = 'Bangalore' then name else null end) as Bangalore
, max(case when city = 'Mumbai' then name else null end) as Mumbai
, max(case when city = 'Delhi' then name else null end) as Delhi
from (select *,
row_number() over( partition by city order by name) as player_group
from players_location) A
group by player_group;

