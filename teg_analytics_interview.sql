create table teams ( 
team1 char(15), 
team2 char(15), 
winner char(15));
Insert into teams values('India','Pakistan','India');
Insert into teams values('India','Srilanka','India');
Insert into teams values('Srilanka','Pakistan','Srilanka');
Insert into teams values('Bangaladesh','Pakistan','Pakistan');
Insert into teams values('Srilanka','Bangaladesh','Srilanka');
Insert into teams values('Bangaladesh','India','India');
select * from teams;

with x as (select team_.team1 AS team ,count(team_.team1) as total_matches 
               from (select team1 from teams union all select team2 from teams) as team_ group by team_.team1),
	 y as (select winner , count(winner) as wins from teams group by winner) 
     select x.team, x.total_matches , iFnull(y.wins,0) AS WINS , (total_matches-IFNULL(wins,0)) AS LOST, IFNULL(WINS*2,0) AS POINTS  from x left join y on x.team = y.winner order by winner;







