-- Pizza Sales Data Analysis


-- =================================
-- Retrieve Total Number of Orders Placed
-- =================================
SELECT 
    COUNT(order_id) AS total_orders
FROM
    orders
;


-- =================================
-- Total Revenue Generated
-- =================================
SELECT 
    ROUND(SUM(quantity * price), 2) AS Total_Revenue
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
;


-- =================================
-- Highest Priced Pizza
-- =================================
SELECT 
    pizza_types.name, pizzas.size, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY price DESC
LIMIT 1
;


-- =================================
-- Common Pizza Size Ordered
-- =================================
SELECT 
    pizzas.size, COUNT(quantity) AS total_quantity
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizzas.size
ORDER BY total_quantity DESC
;


-- =================================
-- Top 5 Most Ordered Pizzas
-- =================================
SELECT 
    pt.name, SUM(quantity) AS total_quantity
FROM
    order_details AS od
        JOIN
    pizzas AS p ON p.pizza_id = od.pizza_id
        JOIN
    pizza_types AS pt ON pt.pizza_type_id = p.pizza_type_id
GROUP BY pt.name
ORDER BY total_quantity DESC
LIMIT 5
;


-- =================================
-- Total Quantity of Each Pizza Category Ordered
-- =================================
SELECT 
    pt.category, SUM(quantity) AS total_quantity
FROM
    pizza_types AS pt
        JOIN
    pizzas AS p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    order_details AS od ON od.pizza_id = p.pizza_id
GROUP BY pt.category
ORDER BY total_quantity DESC
;


-- =================================
-- Distribution of Orders by Hour
-- =================================
SELECT 
    HOUR(order_time) AS hour, COUNT(order_id) AS order_count
FROM
    orders
GROUP BY HOUR(order_time)
ORDER BY hour
;


-- =================================
-- Category Wise Distribution of Pizzas
-- =================================
SELECT 
    category, COUNT(pizza_type_id) AS pizza_count
FROM
    pizza_types
GROUP BY category
;

-- =================================
-- Total Number of Pizzas Ordered Per Day
-- =================================
SELECT 
    o.order_date, SUM(quantity) AS total_orders
FROM
    orders AS o
        JOIN
    order_details AS od ON o.order_id = od.order_id
GROUP BY o.order_date
;


-- =================================
-- Average Number of Pizzas Ordered Per Day
-- =================================
SELECT 
    ROUND(AVG(total_orders)) AS average_pizzas_per_day
FROM
    (SELECT 
        o.order_date, SUM(quantity) AS total_orders
    FROM
        orders AS o
    JOIN order_details AS od ON o.order_id = od.order_id
    GROUP BY o.order_date) AS orders_by_day
;


-- =================================
-- Top 3 Pizzas by Revenue
-- =================================
SELECT 
    pt.name, SUM(od.quantity * p.price) AS revenue
FROM
    order_details AS od
        JOIN
    pizzas AS p ON od.pizza_id = p.pizza_id
        JOIN
    pizza_types AS pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY revenue DESC
LIMIT 3
;


-- =================================
-- Percentage Contribution of Each Pizza Type To Total Revenue
-- =================================
SELECT 
    *,
    ROUND((revenue / (SELECT 
                    ROUND(SUM(quantity * price), 2) AS total_revenue
                FROM
                    order_details AS od
                        JOIN
                    pizzas AS p ON p.pizza_id = od.pizza_id)) * 100,
            2) AS contribution_percentage
FROM
    (SELECT 
        pt.name, ROUND(SUM(quantity * price), 2) AS revenue
    FROM
        order_details AS od
    JOIN pizzas AS p ON p.pizza_id = od.pizza_id
    JOIN pizza_types AS pt ON pt.pizza_type_id = p.pizza_type_id
    GROUP BY pt.name
    ORDER BY revenue DESC) AS revenue_table
;


-- =================================
-- Category Wise Generated Revenue and Their Percentage Contribution To Total Revenue
-- =================================
SELECT 
    pt.category,
    ROUND(SUM(od.quantity * p.price), 2) AS revenue,
    ROUND((SUM(od.quantity * p.price) / (SELECT 
                    SUM(od.quantity * p.price)
                FROM
                    order_details AS od
                        JOIN
                    pizzas AS p ON p.pizza_id = od.pizza_id
                        JOIN
                    pizza_types AS pt ON pt.pizza_type_id = p.pizza_type_id) * 100),
            2) AS percentage_contribution
FROM
    order_details AS od
        JOIN
    pizzas AS p ON p.pizza_id = od.pizza_id
        JOIN
    pizza_types AS pt ON pt.pizza_type_id = p.pizza_type_id
GROUP BY pt.category
ORDER BY revenue DESC
;


-- =================================
-- Cumulative Revenue Generated Over Time
-- =================================
SELECT order_date, SUM(revenue) OVER(ORDER BY order_date) AS cumulative_revenue
FROM
(SELECT o.order_date, SUM(quantity*price) AS revenue
FROM orders AS o
JOIN order_details  AS od
ON od.order_id = o.order_id
JOIN pizzas AS p
ON p.pizza_id = od.pizza_id
JOIN pizza_types AS pt
ON pt.pizza_type_id = p.pizza_type_id
GROUP BY o.order_date) AS revenue_by_day
;


-- =================================
-- Top 3 Most Ordered Pizzas Based On Revenue For Each Pizza Category
-- =================================
SELECT *
FROM
(SELECT name, category, revenue, RANK() OVER(PARTITION BY category ORDER BY revenue DESC) AS rank_num
FROM
(SELECT pt.name, pt.category, SUM(quantity*price) AS revenue, ROW_NUMBER() OVER(PARTITION BY name)
FROM order_details AS od
JOIN orders AS o
ON o.order_id = od.order_id
JOIN pizzas AS p
ON p.pizza_id = od.pizza_id
JOIN pizza_types AS pt
ON pt.pizza_type_id = p.pizza_type_id
GROUP BY pt.name, pt.category
ORDER BY category, revenue DESC) AS revenue_table) AS new_table
WHERE rank_num <= 3
;




