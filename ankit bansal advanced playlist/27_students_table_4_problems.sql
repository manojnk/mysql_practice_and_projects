CREATE TABLE students(
 studentid int NULL,
 studentname nvarchar(255) NULL,
 subject nvarchar(255) NULL,
 marks int NULL,
 testid int NULL,
 testdate date NULL
);

insert into students values (2,'Max Ruin','Subject1',63,1,'2022-01-02');
insert into students values (3,'Arnold','Subject1',95,1,'2022-01-02');
insert into students values (4,'Krish Star','Subject1',61,1,'2022-01-02');
insert into students values (5,'John Mike','Subject1',91,1,'2022-01-02');
insert into students values (4,'Krish Star','Subject2',71,1,'2022-01-02');
insert into students values (3,'Arnold','Subject2',32,1,'2022-01-02');
insert into students values (5,'John Mike','Subject2',61,2,'2022-11-02');
insert into students values (1,'John Deo','Subject2',60,1,'2022-01-02');
insert into students values (2,'Max Ruin','Subject2',84,1,'2022-01-02');
insert into students values (2,'Max Ruin','Subject3',29,3,'2022-01-03');
insert into students values (5,'John Mike','Subject3',98,2,'2022-11-02');
select * from students;

-- problem 1 : write a SQL query to get the list of students who scored above the average marks in each subjects

with cte as (select * 
,avg(marks) over(partition by subject) as average
from students  )
select * from cte where marks > average;

-- studentid, studentname, subject, marks, testid, testdate, average
-- 3			Arnold	    Subject1	95	1		2022-01-02	77.5000
-- 5			John Mike	Subject1	91	1		2022-01-02	77.5000
-- 4			Krish Star	Subject2	71	1		2022-01-02	61.6000
-- 2			Max Ruin	Subject2	84	1		2022-01-02	61.6000
-- 5			John Mike	Subject3	98	2		2022-11-02	63.5000

-- problem 2 : write a SQL query to get the percentage of students who score more than 90 in any subject amongst the total students
-- output table
-- percent
-- 40.0000
select (select count(distinct studentid) from students where marks >90)/(select count(distinct studentid) from students) *100 as percent;

-- write ans SQL query to get the second heighest and second lowest marks for each subject
-- output table
-- subject, second_heighest, second_lowest
-- Subject1	91				63
-- Subject2	71				60
-- Subject3	29				98
with cte as (select *
,dense_rank() over(partition by subject order by marks asc) as l2
,dense_rank() over(partition by subject order by marks desc) as h2
from students)
, cte1 as (select * from cte where h2 =2)
, cte2 as ( select * from cte where l2 =2)
select cte1.subject , cte1.marks as second_heighest, cte2.marks as second_lowest from cte1
join cte2 on cte1.subject = cte2.subject;

-- problem 4: for each student and test check if their marks increased or decreased from their previous test

select *  
, case when marks >prev_marks then 'inc'
  when marks < prev_marks then 'dec'
  else null end as statys
  from ( select * 
  ,lag(marks,1) over(partition by studentid order by testdate, subject ) as prev_marks
  from students) A