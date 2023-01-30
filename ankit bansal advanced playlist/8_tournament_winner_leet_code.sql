-- leet code 
-- write a SQl query to find the winner in each group
-- the winner in each group is the player who scored the maximum total points within the group.
-- in case of a tie, the lowest player_id wins

create table players
(player_id int,
group_id int);

insert into players values (15,1);
insert into players values (25,1);
insert into players values (30,1);
insert into players values (45,1);
insert into players values (10,2);
insert into players values (35,2);
insert into players values (50,2);
insert into players values (20,3);
insert into players values (40,3);

create table matches
(
match_id int,
first_player int,
second_player int,
first_score int,
second_score int);

insert into matches values (1,15,45,3,0);
insert into matches values (2,30,25,1,2);
insert into matches values (3,30,15,2,0);
insert into matches values (4,40,20,5,2);
insert into matches values (5,35,50,1,1);

select * from players;
select * from matches;

-- output table
-- group_id, player_id, total
-- 1			15			3
-- 2			35			1
-- 3			40			5
-- ---------------------------------------------------------------------------------------------------------------------------------------------
with player_score as(
select first_player as player, first_score as score from matches
union all
select second_player, second_score from matches)
, total_score as (
select player, sum(score) as total from player_score
group by player)
select group_id , player_id , total 
from 
(select *,
rank() over(partition by group_id order by total desc, player_id asc ) as rk from players
inner join total_score on players.player_id = total_score.player)x
where rk =1;

