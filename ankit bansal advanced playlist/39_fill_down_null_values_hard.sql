-- write a SQLto populate category values to the last not null values

create table brands 
(
category varchar(20),
brand_name varchar(20)
);
insert into brands values
('chocolates','5-star')
,(null,'dairy milk')
,(null,'perk')
,(null,'eclair')
,('Biscuits','britannia')
,(null,'good day')
,(null,'boost');
select * from brands;
-- output table
-- category,   brand_name
-- chocolates	5-star
-- chocolates	dairy milk
-- chocolates	perk
-- chocolates	eclair
-- Biscuits		britannia
-- Biscuits		good day
-- Biscuits		boost
-- ============================================================================================================================================
with cte as 
(select *
, row_number() over() as row_start
from brands),
cte1 as 
( select *,
ifnull(lead(row_start) over(),9999)-1 as row_end  
from cte where category is not null)
select cte1.category, cte.brand_name
from cte
join cte1 on cte.row_start between cte1.row_start and cte1.row_end
