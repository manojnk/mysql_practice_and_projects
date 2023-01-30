/*  Market Analysis leet code :
write an sql query to find for each seller, 
wheater the brand of the second item (by date) they sold is their fav brand
if the seller has less than 2 sales return no
*/

create table users (
user_id         int     ,
 join_date       date    ,
 favorite_brand  varchar(50));

 create table orders (
 order_id       int     ,
 order_date     date    ,
 item_id        int     ,
 buyer_id       int     ,
 seller_id      int 
 );

 create table items
 (
 item_id        int     ,
 item_brand     varchar(50)
 );

 insert into users values (1,'2019-01-01','Lenovo'),(2,'2019-02-09','Samsung'),(3,'2019-01-19','LG'),(4,'2019-05-21','HP');

 insert into items values (1,'Samsung'),(2,'Lenovo'),(3,'LG'),(4,'HP');

 insert into orders values (1,'2019-08-01',4,1,2),(2,'2019-08-02',2,1,3),(3,'2019-08-03',3,2,3),(4,'2019-08-04',1,4,2)
 ,(5,'2019-08-04',1,3,4),(6,'2019-08-05',2,2,4);
 
 select * from users;
 select * from items;
 select * from orders;
 
 	/* output table
    user_id	item_favorite_brand
	1			No
	2			Yes
	3			Yes
	4			No */
 
 with rank_order as(select * ,
 rank() over(partition by seller_id order by order_date) as rk
 from orders )
 select user_id,
 case when item_brand is null then 'No' else 'Yes' end as item_favorite_brand from users
 left join rank_order on rank_order.seller_id = users.user_id and rk =2
 left join items on items.item_id = rank_order.item_id and favorite_brand = item_brand
 ;