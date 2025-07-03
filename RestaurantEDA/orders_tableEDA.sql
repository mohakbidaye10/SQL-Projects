SELECT *
FROM order_details;

SELECT count(*)
FROM order_details;

-- finding the date range of this table
SELECT MIN(order_date), MAX(order_date)
FROM order_details;

-- how many orders where made within this date range
SELECT COUNT(DISTINCT order_id) as num_orders
FROM order_details;

-- how many items were ordered within this date range
SELECT count(*)
FROM order_details;

-- which orders had the most number of items
SELECT order_id, count(item_id) as num_items
FROM order_details
GROUP BY order_id
ORDER BY 2 DESC;

-- how many orders had more than 12 items 
WITH num_orders AS (
SELECT order_id, count(item_id) as num_items
FROM order_details
GROUP BY order_id
HAVING num_items > 12
)
SELECT COUNT(*) as items_num
FROM num_orders;

select item_id, count(order_details_id) as num_purchases
from order_details
group by item_id
order by 2 desc