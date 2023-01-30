-- write an SQL query to report the students ( student_id,student_name) being "quite" in ALL exams 
-- A "quite" stduent is the one who took at least one exam and didn't score neither the high scorenor the low score in any of the exam
-- don't return the students who has never taken any exam. Return the result table ordered by student id
create table students
(
student_id int,
student_name varchar(20)
);
insert into students values
(1,'Daniel'),(2,'Jade'),(3,'Stella'),(4,'Jonathan'),(5,'Will');

create table exams
(
exam_id int,
student_id int,
score int);

insert into exams values
(10,1,70),(10,2,80),(10,3,90),(20,1,80),(30,1,70),(30,3,80),(30,4,90),(40,1,60)
,(40,2,70),(40,4,80);

select * from students;
select * from exams;
-- output table
-- student_id, student_name
-- 2			Jade
-- ==============================================================================================================================================
with cte as 
(select *
,min(score) over(partition by exam_id) as min_score
,max(score) over(partition by exam_id) as max_score
from exams),
cte1 as 
( select student_id from cte 
  where score = min_score 
  union
  select student_id from cte 
  where score = max_score)
select distinct exams.student_id, students.student_name
from exams
left join cte1 on exams.student_id = cte1.student_id
join students on exams.student_id = students.student_id
where cte1.student_id is NULL;
  
  

  