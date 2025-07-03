-- ANALYZE CUSTOMER BEHAVIOUR
-- Dig into customer data to see which menu items are doing well/not well
-- and what the top customers seem to like best

SELECT * 
FROM order_details od
LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id;

-- what were the least and most ordered items? What categories were they in?
SELECT item_name, category, count(order_details_id) AS num_purchases
FROM order_details od
LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id
GROUP BY item_name, category
ORDER BY 3 DESC;

-- what were the top 5 orders that spent the most money
SELECT order_id, sum(price) as total_spent
FROM order_details
LEFT JOIN menu_items
ON item_id = menu_item_id
GROUP BY order_id
ORDER BY 2 DESC
LIMIT 5;

-- view the details of the highest spend order. 
-- highest spend order is of order_id = 440
SELECT * 
FROM order_details od
LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id
WHERE order_id = 440;

-- what category did the highest spend order person order the most
SELECT category, count(item_id) AS num_items
FROM order_details od
LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id
WHERE order_id = 440
GROUP BY category
ORDER BY 2 DESC;
-- They ordered Italian the most


-- Details of the top 5 highest spend orders.
-- 2675, 2075, 1957, 440, 330
SELECT category, count(item_id) AS num_items
FROM order_details od
LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id
WHERE order_id IN (2675, 2075, 1957, 440, 330)
GROUP BY category
ORDER BY 2 DESC;
-- The top 5 highes spend orders ordered Italian foods more than other foods

-- seperating the top 5 highest spend orders and their food categories
SELECT order_id, category, count(item_id) AS num_items
FROM order_details od
LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id
WHERE order_id IN (2675, 2075, 1957, 440, 330)
GROUP BY order_id, category
ORDER BY 1 DESC
