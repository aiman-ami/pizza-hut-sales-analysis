#Q1. Which hour generates the most revenue?

SELECT 
    HOUR(orders.order_time) AS hour,
    ROUND(SUM(order_details.quantity * pizzas.price), 2) AS revenue
FROM orders
JOIN order_details ON orders.order_id = order_details.order_id
JOIN pizzas ON pizzas.pizza_id = order_details.pizza_id
GROUP BY hour
ORDER BY revenue DESC;

#Q2. Which day of the week has the most orders?

SELECT 
    DAYNAME(order_date) AS day_name,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY day_name
ORDER BY total_orders DESC;

#Q3. Revenue to quantity ratio by category (which category is most profitable per pizza sold?)

SELECT 
    pizza_types.category,
    ROUND(SUM(order_details.quantity * pizzas.price), 2) AS revenue,
    SUM(order_details.quantity) AS total_quantity,
    ROUND(SUM(order_details.quantity * pizzas.price) / SUM(order_details.quantity), 2) AS revenue_per_pizza
FROM pizza_types
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY revenue_per_pizza DESC;

#Q4. Rank pizza types by revenue within each size

SELECT name, size, revenue FROM (
    SELECT 
        pizza_types.name,
        pizzas.size,
        ROUND(SUM(order_details.quantity * pizzas.price), 2) AS revenue,
        RANK() OVER (PARTITION BY pizzas.size ORDER BY SUM(order_details.quantity * pizzas.price) DESC) AS rn
    FROM pizza_types
    JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
    JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
    GROUP BY pizza_types.name, pizzas.size
) AS ranked
WHERE rn <= 3;

#Q5. Average order value (how much does each order spend on average?)

SELECT 
    ROUND(AVG(order_total), 2) AS avg_order_value
FROM (
    SELECT 
        orders.order_id,
        SUM(order_details.quantity * pizzas.price) AS order_total
    FROM orders
    JOIN order_details ON orders.order_id = order_details.order_id
    JOIN pizzas ON pizzas.pizza_id = order_details.pizza_id
    GROUP BY orders.order_id
) AS order_totals;

#Q6. Do weekends generate more revenue than weekdays?

SELECT 
    CASE 
        WHEN DAYNAME(order_date) IN ('Saturday', 'Sunday') THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    ROUND(SUM(order_details.quantity * pizzas.price), 2) AS revenue,
    COUNT(DISTINCT orders.order_id) AS total_orders
FROM orders
JOIN order_details ON orders.order_id = order_details.order_id
JOIN pizzas ON pizzas.pizza_id = order_details.pizza_id
GROUP BY day_type;

#Q7. Which pizza size generates the most revenue?

SELECT 
    pizzas.size,
    ROUND(SUM(order_details.quantity * pizzas.price), 2) AS revenue
FROM pizzas
JOIN order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY revenue DESC;