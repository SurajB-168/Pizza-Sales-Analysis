# Pizza Sales Analysis — MySQL

A complete SQL-based analysis of a pizza restaurant's sales data, covering revenue, order trends, customer behavior, and product performance across a full year of operations.

---

## Project Overview

This project answers 15 real business questions using MySQL — ranging from basic KPIs like total revenue and order count to advanced analysis using window functions, subqueries, and multi-table joins.

The goal was to extract actionable insights that a pizza restaurant owner could actually use — not just run queries for the sake of it.

---

## Dataset

The dataset consists of 4 relational tables:

| Table | Description | Rows |
|---|---|---|
| orders | Order ID, date and time of each order | 21,350 |
| order_details | Line items — which pizza and quantity per order | 48,620 |
| pizzas | Pizza ID, type, size, and price | 96 |
| pizza_types | Pizza name, category, and ingredients | 32 |

Table Relationships:
orders ──(order_id)──► order_details ◄──(pizza_id)── pizzas ──(pizza_type_id)──► pizza_types

---

## Business Questions Answered

1. Total number of orders placed
2. Total revenue generated
3. Highest priced pizza
4. Common pizza size ordered
5. Top 5 most ordered pizzas by quantity
6. Total quantity ordered per pizza category
7. Order distribution by hour of the day
8. Number of distinct pizzas per category
9. Total number of pizzas ordered per day
10. Average number of pizzas ordered per day
11. Top 3 pizzas by revenue
12. Percentage contribution of each pizza to total revenue
13. Revenue and percentage contribution by category
14. Cumulative revenue generated over time
15. Top 3 pizzas by revenue within each category

---

##  Key Findings

- Total revenue of $817,860 from 21,350 orders — averaging ~$2,240 per day
- Large size is the most preferred — XL and XXL together are less than 1% of all orders
- Two peak rush windows every day — 12–1pm (lunch) and 5–7pm (dinner)
- Chicken pizzas generate the highest revenue despite having only 6 menu options
- Revenue is almost equally split across all 4 categories — Classic (26.9%), Supreme (25.5%), Chicken (24%), Veggie (23.7%)
- Thai Chicken Pizza is the single highest revenue earner at $43,434

---

## SQL Concepts Used

- INNER JOIN across multiple tables
- Aggregate functions — SUM, COUNT, ROUND, AVG
- GROUP BY, ORDER BY, LIMIT
- Subqueries (scalar and derived tables)
- Window functions — RANK() OVER(PARTITION BY), SUM() OVER(ORDER BY)
- HOUR() and date functions

---

## Files in This Repository

| File | Description |
|---|---|
| pizza_sales_analysis.sql | All SQL queries used in this project |
| Pizza_Sales_Analysis.pdf | Project presentation with queries, outputs and insights|
| orders.csv | Raw dataset — order dates and times |
| order_details.csv | Raw dataset — pizza and quantity per order |
| pizzas.csv | Raw dataset — pizza sizes and prices |
| pizza_types.csv | Raw dataset — pizza names, categories and ingredients |
| pizza_sales_data.xlsx | Complete dataset combined in Excel format |

## Recommendations

- Expand the Chicken category — highest revenue per pizza type, only 6 options currently
- Focus combo deals on Large size — most popular size by far
- Staff up during 12–1pm and 5–7pm — clear peak windows every day
- Promote or phase out XL and XXL — fewer than 600 orders combined in a full year
- Feature Thai Chicken, BBQ Chicken, Classic Deluxe and Four Cheese in promotions

---
