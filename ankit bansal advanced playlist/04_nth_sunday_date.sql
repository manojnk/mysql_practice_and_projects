-- find the nth sunday date from the given date
set @today_date = cast('2023/01/01' as datetime);
set @n=3;
select date_add(@today_date,interval (8-dayofweek(@today_date)+7*(@n-1)) day);
select dayofweek(@today_date)+3*@n;