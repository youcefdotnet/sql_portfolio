# 🍽️ Restaurant Order Analysis — Taste of the World Café

A beginner-level guided SQL project from **Maven Analytics** (by Alice Zhao).
This was my first hands-on SQL project, applied with MySQL.

## Business Context

I take on the role of a newly hired Data Analyst at *Taste of the World Café*,
a restaurant with a diverse, international menu. The goal is to analyze order
data to understand which menu items and cuisines perform best (and worst),
and to extract insights that could support business decisions.

## Database

- **Engine:** MySQL
- **Tables:**
  - `menu_items` — menu item names, categories, and prices
  - `order_details` — individual order transactions
- **Source:** [Maven Analytics Data Playground](https://mavenanalytics.io/data-playground)

## Data

Source files are available in [`/data`](./data), originally downloaded from
the [Maven Analytics Data Playground](https://mavenanalytics.io/data-playground):

- `menu_items.csv` — raw menu data
- `order_details.csv` — raw order transaction data
- [`create_restaurant_db.sql`](./data/create_restaurant_db.sql) — script to create the database schema and load the demo data

To reproduce this analysis: run [`create_restaurant_db.sql`](./data/create_restaurant_db.sql)
first to set up the `menu_items` and `order_details` tables, then run
[`queries.sql`](./queries.sql).

## Skills Practiced

- `SELECT`, `WHERE`, `ORDER BY`, `GROUP BY`, `HAVING`
- Aggregate functions: `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`
- `LEFT JOIN` across two tables
- Subqueries
- Date functions (`MONTH()`, `YEAR()`)

## Key Questions Answered

- How many items are on the menu, and what's the price range?
- How many dishes fall into each category, and what's the average price per category?
- What is the date range covered by the orders?
- How many unique orders and total items were placed?
- Which orders contained the most items?
- Which menu items were ordered the most and the least — and from which category?
- Which 5 orders generated the most revenue, and what did they contain?

## Sample Insight

The highest-spending order (`order_id = 440`) was dominated by items from the
**Italian** category — consistent with Italian dishes having the highest
average price on the menu ($16.75), suggesting that big-ticket orders tend
to lean toward higher-priced categories.

## File

👉 [`queries.sql`](./queries.sql) — all queries, organized in 3 parts with comments and result summaries

## What I Learned

Working with subqueries (Part 2, Q6) was the trickiest part — realizing that
some questions require aggregating an already-aggregated result meant
wrapping a `GROUP BY` query inside a subquery rather than trying to filter
with a single-level query. This project also reinforced how `LEFT JOIN`
preserves all rows from the transactional table even when a match isn't
guaranteed.

---
*Part of my [SQL portfolio](../) — beginner track.*
