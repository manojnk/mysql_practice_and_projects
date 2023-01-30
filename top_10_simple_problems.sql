-- how to find duplicate records
select id, count(1)  from emp 
group by id
having count(1) > 1;

-- how to delete duplicates
with cte as (
       select * , row_number() over(partition by id order by id) as rn
	   from emp)
delete from cte where rn >1;
select * from emp;

-- difference bwt union and union all
-- UNION: only keeps unique records after combining all records from both tables 
-- UNION ALL: keeps all records, including duplicates.

select submission_date from submissions
union all
select submission_date from submissions;

-- difference btw rank() , dense_rank() and row-number()
--     rank()dense_rank()row_number()   
-- 1		1		1		1
-- 1		1		1		2	
-- 1     	1		1		3				
-- 1		1		1		4
-- 2		5		2		5
-- 3		6		3		6
-- 4		7		4		7
-- 4		7		4		8
-- 5		9		5		9

-- employee whos department are not present in depertment tabke
-- table emp and dept
select * from emp 
where emp_dept_id not in (select distinct dept_id from dept);
-- subquery performance is not good
-- other way using left join

select emp.*,dept_name,dept_id from emp 
left join dept on emp.emp_dept_id = dept.dept_id
where dept.dept_name is NULL;

-- second heightest salary in each department
DROP TABLE IF EXISTS dept;
DROP TABLE IF EXISTS salgrade;
DROP TABLE IF EXISTS emp;

CREATE TABLE salgrade(
grade int(4) not null primary key,
losal decimal(10,2),
hisal decimal(10,2));

CREATE TABLE dept(
deptno int(2) not null primary key,
dname varchar(50) not null,
location varchar(50) not null);

CREATE TABLE emp(
empno int(4) not null primary key,
ename varchar(50) not null,
job varchar(50) not null,
mgr int(4),
hiredate date,
sal decimal(10,2),
comm decimal(10,2),
deptno int(2) not null);

insert into dept values (10,'Accounting','New York');

insert into dept values (20,'Research','Dallas');

insert into dept values (30,'Sales','Chicago');

insert into dept values (40,'Operations','Boston');



insert into emp values (7369,'SMITH','CLERK',7902,'93/6/13',800,0.00,20);

insert into emp values (7499,'ALLEN','SALESMAN',7698,'98/8/15',1600,300,30);

insert into emp values (7521,'WARD','SALESMAN',7698,'96/3/26',1250,500,30);

insert into emp values (7566,'JONES','MANAGER',7839,'95/10/31',2975,null,20);

insert into emp values (7698,'BLAKE','MANAGER',7839,'92/6/11',2850,null,30);

insert into emp values (7782,'CLARK','MANAGER',7839,'93/5/14',2450,null,10);

insert into emp values (7788,'SCOTT','ANALYST',7566,'96/3/5',3000,null,20);

insert into emp values (7839,'KING','PRESIDENT',null,'90/6/9',5000,0,10);

insert into emp values (7844,'TURNER','SALESMAN',7698,'95/6/4',1500,0,30);

insert into emp values (7876,'ADAMS','CLERK',7788,'99/6/4',1100,null,20);

insert into emp values (7900,'JAMES','CLERK',7698,'00/6/23',950,null,30);

insert into emp values (7934,'MILLER','CLERK',7782,'00/1/21',1300,null,10);

insert into emp values (7902,'FORD','ANALYST',7566,'97/12/5',3000,null,20);

insert into emp values (7654,'MARTIN','SALESMAN',7698,'98/12/5',1250,1400,30);


insert into salgrade values (1,700,1200);

insert into salgrade values (2,1201,1400);

insert into salgrade values (3,1401,2000);

insert into salgrade values (4,2001,3000);

insert into salgrade values (5,3001,99999);

select * from emp;

select * from (select emp.*, dense_rank() over(partition by deptno order by sal desc) as rank_
from emp)x
where rank_ = 2;

-- select all orders done by shilpa ( case in-sensitive)
select * from orders where upper(customer_name) = "SHILPA";

-- self join,find the employee with salary grater than manager salary from table emp
select e.name as emp_name, m.name as manager_name from emp e
inner join emp m
on e.manager_id = m.employee_id
where e.salary > m.salary;
--  Find the Employee Id and Name of the managers who have minimum 7 employees directly reporting to them.
SELECT ManagerID, ManagerName
FROM (
       SELECT E1.EmpID, E1.EmpName, E2.EmpName AS ManagerName, E2.EmpID AS ManagerID
       FROM Employee_Info AS E1 INNER JOIN Employee_Info AS E2
       ON E1.ManagerID = E2.EmpID) AS Table1
GROUP BY ManagerID, ManagerName
HAVING COUNT(EmpID) >= 7

update orders set customer_gender = case when customers_gender  = "male" then"female"
					when customer_gender ="female" then "male"
                    end;


                    





