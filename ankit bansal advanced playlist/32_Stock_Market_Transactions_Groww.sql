-- Groww SQL Interview Question based on Stock Market Transactions
-- Given table where buy and sell of a stock was carried out,
-- to find the table where the quantity buy and sold are as per output table

Create Table Buy (
Date Int,
Time Int,
Qty Int,
per_share_price int,
total_value int );

Create Table sell(
Date Int,
Time Int,
Qty Int,
per_share_price int,
total_value int );
INSERT INTO Buy (date, time, qty, per_share_price, total_value)
VALUES
(15, 10, 10, 10, 100),
(15, 14, 20, 10, 200);

INSERT INTO Sell(date, time, qty, per_share_price, total_value)
VALUES (15, 15, 15, 20, 300);

select * from Buy;
select * from Sell;

-- output table
-- buy_time, buy_qty, sell_qty
-- 10			10		10
-- 14			5		5
-- 14			15		Null
-- ===================================================================================================================================

with cte as 
(select b.date as buy_date ,b.time as buy_time,b.qty as buy_qty,s.qty as sell_qty 
,sum(b.qty) over(order by b.qty) as cum_buy_qty
,ifnull(sum(b.qty) over(order by b.qty rows between unbounded preceding and 1 preceding),0) as running_buy_prev
from Buy b
join Sell s on b.date = s.date and b.time < s.time)
select buy_time
, case when buy_qty <= sell_qty then buy_qty else sell_qty - running_buy_prev end as buy_qty
, case when buy_qty <= sell_qty then buy_qty else sell_qty - running_buy_prev end as sell_qty
from cte 
union all
select buy_time,cum_buy_qty - sell_qty as buy_qty, Null as sell_qty
from cte
where sell_qty<= cum_buy_qty
