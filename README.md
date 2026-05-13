Pizza Hut Sales Analysis — SQL

Author: Aiman Ishaq
Tools: MySQL
Dataset: Pizza Hut sales data (orders, order details, pizzas, pizza types)


What this project does

Analyzes Pizza Hut transactional data across 4 tables to answer real business
questions about revenue patterns, customer behavior, and product performance.


Dataset Tables

orders — order ID, date, time
order_details — order ID, pizza ID, quantity
pizzas — pizza ID, size, price
pizza_types — pizza type ID, name, category


Business Questions Answered

Q1. Which hour of the day generates the most revenue?
Q2. Which day of the week has the most orders?
Q3. Which pizza category is most profitable per pizza sold?
Q4. Top 3 pizzas by revenue within each size category
Q5. What is the average order value?
Q6. Do weekdays generate more revenue than weekends?
Q7. Which pizza size generates the most revenue?


Key Findings

Peak revenue hour is 12pm — lunch drives more revenue than dinner.

Friday is the busiest day while Sunday has the fewest orders.

Chicken has the highest revenue per pizza at $17.73 despite Classic having the highest total revenue — Classic sells more but at lower margins.

Weekdays generate nearly 3x weekend revenue — $595K vs $222K.

Large size dominates with $375K in revenue while XXL barely sells at $1K.


Files

pizza_hut_SQL.sql — all queries with business context comments
orders.csv — raw orders data
order_details.csv — raw order details data
pizzas.csv — pizza sizes and prices
pizza_types.csv — pizza names and categories
