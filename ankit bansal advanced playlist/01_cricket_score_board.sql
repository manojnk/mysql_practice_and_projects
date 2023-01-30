create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);
INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');

select * from icc_world_cup;

with t1 as 
(select team_1 as teams from icc_world_cup
union all
select team_2 from icc_world_cup),
t2 as 
(select winner ,count(1) as wins from icc_world_cup group by winner
),
t3 as (select teams,count(1) as total from t1 
group by teams),
t4 as (
select teams , total , ifnull(wins,0) as wins , ifnull(total - ifnull(wins,0),0) as loss from t3
left join t2 on teams = winner
order by wins desc , teams)

select *,wins*2 as points from t4;


