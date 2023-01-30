-- find total number of messeges exchanged between each person per day
CREATE TABLE subscriber (
 sms_date date ,
 sender varchar(20) ,
 receiver varchar(20) ,
 sms_no int
);
-- insert some values
INSERT INTO subscriber VALUES ('2020-4-1', 'Avinash', 'Vibhor',10);
INSERT INTO subscriber VALUES ('2020-4-1', 'Vibhor', 'Avinash',20);
INSERT INTO subscriber VALUES ('2020-4-1', 'Avinash', 'Pawan',30);
INSERT INTO subscriber VALUES ('2020-4-1', 'Pawan', 'Avinash',20);
INSERT INTO subscriber VALUES ('2020-4-1', 'Vibhor', 'Pawan',5);
INSERT INTO subscriber VALUES ('2020-4-1', 'Pawan', 'Vibhor',8);
INSERT INTO subscriber VALUES ('2020-4-1', 'Vibhor', 'Deepak',50);

-- output table
-- person1, person2, number_of_messeges_exchanged
-- Avinash	  Vibhor	30
-- Avinash	  Pawan  	50
-- Pawan	  Vibhor	13
-- Deepak	  Vibhor	50

select 
case when sender < receiver then sender else receiver end as person1
,case when sender > receiver then sender else receiver end as person2
,sum(sms_no) as number_of_messeges_exchanged
from subscriber
group by case when sender < receiver then sender else receiver end , case when sender > receiver then sender else receiver end 