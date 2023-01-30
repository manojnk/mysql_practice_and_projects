-- Customer retention refers to the ability of a company or product to retain its customers over some specified period. High customer retention means customers of the product or business tend to return to, continue to buy or in some other way not defect to another product or business, or to non-use entirely. 
-- Company programs to retain customers: Zomato Pro , Cashbacks, Reward Programs etc.
-- Once these programs in place we need to build metrics to check if programs are working or not. That is where we will write SQL to drive customer retention count.
-- Here is the script to insert data :
-- create table transactions(
-- order_id int,
-- cust_id int,
-- order_date date,
-- amount int
-- );
-- delete from transactions;
-- insert into transactions values 
-- (1,1,'2020-01-15',150)
-- ,(2,1,'2020-02-10',150)
-- ,(3,2,'2020-01-16',150)
-- ,(4,2,'2020-02-25',150)
-- ,(5,3,'2020-01-10',150)
-- ,(6,3,'2020-02-20',150)
-- ,(7,4,'2020-01-20',150)
-- ,(8,5,'2020-02-20',150)
-- ;

-- ans
-- jan ->0
-- feb (1,2,3) ->3
select * from transactions
order by order_date;

-- question 1

select monthname(t1.order_date)as order_month ,count(t2.cust_id) as count_repeat_customer_from_previous_month
from transactions t1
left join transactions t2 on t1.cust_id = t2.cust_id  and t1.order_date > t2.order_date and month(t1.order_date)- month(t2.order_date) =1
group by monthname(t1.order_date)
;
-- question 2
-- find count customer who where there this month but not in next month

select 
monthname(t1.order_date) as month
,count(t1.order_date) as curned_number_of_customers
from transactions t1
left join transactions t2 on t1.cust_id = t2.cust_id and month(t1.order_date)- month(t2.order_date) =-1
where t2.cust_id is null
group by monthname(t1.order_date)
;

