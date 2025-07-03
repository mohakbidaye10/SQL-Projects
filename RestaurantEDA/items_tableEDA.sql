USE restaurant_db;

SELECT * 
FROM menu_items;

SELECT COUNT(menu_item_id)
FROM menu_items;

-- least and most expensive items
SELECT item_name, price
FROM menu_items
GROUP BY item_name, price
ORDER BY 2 DESC;

-- number of italian dishes on the menu
SELECT COUNT(category) as italian_dishes
FROM menu_items
WHERE category = 'Italian';

-- least and most expensive italian dishes
SELECT *
FROM menu_items
WHERE category = 'Italian'
ORDER BY price DESC;

-- how many dishes in each category
SELECT category, count(menu_item_id) as dishes
FROM menu_items
GROUP BY category;

-- avg dish price within each category
SELECT category, count(menu_item_id) as dishes, avg(price) as avg_dish_price
FROM menu_items
GROUP BY category














