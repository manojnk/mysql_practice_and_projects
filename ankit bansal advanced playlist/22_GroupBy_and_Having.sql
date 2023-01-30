-- find student with sme marks in chemistry and physics

create table exams (student_id int, subject varchar(20), marks int);
delete from exams;
insert into exams values (1,'Chemistry',91),(1,'Physics',91)
,(2,'Chemistry',80),(2,'Physics',90)
,(3,'Chemistry',80)
,(4,'Chemistry',71),(4,'Physics',54);
select * from exams;

-- solution used group by and 2 having condition

select student_id from exams 
where subject in ('Physics','Chemistry')
group by student_id
having count(distinct subject) =2 and count(distinct marks) =1 ;
