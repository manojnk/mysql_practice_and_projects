-- Google SQL Interview Question for Data Analyst Position
-- find the companies who have atleast 2 users who speaks both english and german

create table company_users 
(
company_id int,
user_id int,
language varchar(20)
);

insert into company_users values (1,1,'English')
,(1,1,'German')
,(1,2,'English')
,(1,3,'German')
,(1,3,'English')
,(1,4,'English')
,(2,5,'English')
,(2,5,'German')
,(2,5,'Spanish')
,(2,6,'German')
,(2,6,'Spanish')
,(2,7,'English');
select * from company_users;

-- solution 

WITH cte AS (SELECT company_id , user_id FROM company_users
WHERE language IN ('English','German')
GROUP BY company_id , user_id
HAVING COUNT(DISTINCT language) =2)

SELECT company_id,COUNT(DISTINCT user_id) AS users FROM cte
GROUP BY company_id
HAVING COUNT(DISTINCT user_id) >= 2;