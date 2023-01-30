-- create table orders
-- (
-- order_id int,
-- customer_id int,
-- product_id int
-- );

-- insert into orders VALUES 
-- (1, 1, 1),
-- (1, 1, 2),
-- (1, 1, 3),
-- (2, 2, 1),
-- (2, 2, 2),
-- (2, 2, 4),
-- (3, 1, 5);

-- create table products (
-- id int,
-- name varchar(10)
-- );
-- insert into products VALUES 
-- (1, 'A'),
-- (2, 'B'),
-- (3, 'C'),
-- (4, 'D'),
-- (5, 'E');

select * from orders;
select * from products;

select concat(x1.name ,' ',x2.name) as pair,count(1) as purchase_freq from orders o1
join orders o2 on o1.order_id = o2.order_id and o1.product_id!=o2.product_id and o1.product_id < o2.product_id
join products x1 on  o1.product_id = x1.id
join products x2 on o2.product_id = x2.id
group by  x1.name,x2.name;
