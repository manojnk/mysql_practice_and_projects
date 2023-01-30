/* find the largest order by value for rach sales person and display order details
get the result without using sub-queery, cte, window function, temp table */

CREATE TABLE int_orders(
 order_number int NOT NULL,
 order_date date NOT NULL,
 cust_id int NOT NULL,
 salesperson_id int NOT NULL,
 amount float NOT NULL
);
INSERT INTO int_orders (order_number, order_date, cust_id, salesperson_id, amount) VALUES (30, CAST('1995-07-14' AS Date), 9, 1, 460);
INSERT into int_orders (order_number, order_date, cust_id, salesperson_id, amount) VALUES (10, CAST('1996-08-02' AS Date), 4, 2, 540);
INSERT INTO int_orders (order_number, order_date, cust_id, salesperson_id, amount) VALUES (40, CAST('1998-01-29' AS Date), 7, 2, 2400);
INSERT INTO int_orders (order_number, order_date, cust_id, salesperson_id, amount) VALUES (50, CAST('1998-02-03' AS Date), 6, 7, 600);
INSERT into int_orders (order_number, order_date, cust_id, salesperson_id, amount) VALUES (60, CAST('1998-03-02' AS Date), 6, 7, 720);
INSERT into int_orders (order_number, order_date, cust_id, salesperson_id, amount) VALUES (20, CAST('1999-01-30' AS Date), 4, 8, 1800);
select * from int_orders;
-- output table
-- order_number, order_date, cust_id, salesperson_id, amount
-- 30			1995-07-14		9			1			460
-- 40			1998-01-29		7			2			2400
-- 60			1998-03-02		6			7			720
-- 20			1999-01-30		4			8			1800
-- -----------------------------------------------------------------------------------------------------------------------------------------------
select a.order_number, a.order_date, a.cust_id, a.salesperson_id, a.amount from int_orders a
join int_orders b on a.salesperson_id =  b.salesperson_id
group by a.order_number, a.order_date, a.cust_id, a.salesperson_id,a.amount
having a.amount >= max(b.amount)


