/* =========================================================
   RESTAURANT ORDER ANALYSIS - Taste of the World Cafe
   Maven Analytics - Beginner Guided Project (Alice Zhao)
   ========================================================= */

/* ---------------------------------------------------------
   PART 1 - Menu Items
   --------------------------------------------------------- */

-- 01: View the menu_items table

select *
from menu_items;

-- 02: Count the number of items on the menu

select
    count(menu_item_id) as num_of_item
from menu_items;
-- There are 32 items on the menu

-- 03: What are the least and most expensive items on the menu?

select
    max(price) as max_price,
    min(price) as min_price
from menu_items;
-- Most expensive item: $19.95 | Least expensive item: $5.00

-- 04: How many Italian dishes are on the menu?
--     What are the least and most expensive Italian dishes?

select
    count(item_name) as num_of_italian_dishes
from menu_items
where category = 'italian';

select
    min(price) as min_italian_dish_price
from menu_items
where category = 'italian';

select
    max(price) as max_italian_dish_price
from menu_items
where category = 'italian';

-- Number of Italian dishes: 9
-- Least expensive Italian dish: $14.50
-- Most expensive Italian dish: $19.95

-- 05: How many dishes are in each category?
--     What is the average price in each category?

select
    category,
    count(menu_item_id) as nb_of_dish,
    avg(price) as avg_price
from menu_items
group by category;

/* American : 6 dishes | avg price: $10.06
   Asian     : 8 dishes | avg price: $13.47
   Mexican   : 9 dishes | avg price: $11.80
   Italian   : 9 dishes | avg price: $16.75 */


/* ---------------------------------------------------------
   PART 2 - Orders
   --------------------------------------------------------- */

-- 01: View the order_details table

select *
from order_details;

-- 02: What is the date range of this table?

select
    min(order_date) as min_order_date,
    max(order_date) as max_order_date
from order_details;

-- Alternative method

select distinct
    max(month(order_date)) as month_order,
    max(year(order_date))  as year_order
from order_details;

-- 03: How many unique orders were made within this range?

select count(distinct order_id)
from order_details;
-- 5,370 unique orders

-- 04: How many items were ordered within this date range?

select count(*) as item_ordered
from order_details;
-- 12,234 items ordered

-- 05: Which orders had the highest number of items?

select
    order_id,
    count(item_id) as num_of_item
from order_details
group by order_id
order by num_of_item desc;

-- 06: How many orders had more than 12 items?

select
    count(*)
from (
    select
        order_id,
        count(item_id) as num_of_item
    from order_details
    group by order_id
    having num_of_item > 12
    order by num_of_item desc
) as num_order;


/* ---------------------------------------------------------
   PART 3 - Combining Menu Items & Order Details
   --------------------------------------------------------- */

-- 01: Combine menu_items and order_details into a single table

select *
from order_details as o
left join menu_items as m
    on o.item_id = m.menu_item_id;

-- Note: a LEFT JOIN is used to keep every record from the
-- transactional table (order_details) regardless of matches.

-- 02: What were the least and most ordered items?
--     What categories were they in?

select
    item_name,
    category,
    count(item_id) as num_purchase
from order_details as o
left join menu_items as m
    on o.item_id = m.menu_item_id
group by item_name, category
order by num_purchase desc;

-- Most ordered item: Hamburger (American category)
-- Least ordered item: Chicken Tacos (Mexican category)

-- 03: What were the top 5 orders that spent the most money?

select
    order_id,
    sum(price) as sum_order
from order_details as o
left join menu_items as m
    on o.item_id = m.menu_item_id
group by order_id
order by sum_order desc
limit 5;

-- 04: View the details of the highest paid order
--     and gather insights from the result

select
    category,
    count(item_id) as num_of_item
from order_details as o
left join menu_items as m
    on o.item_id = m.menu_item_id
where order_id = 440
group by category;

-- Insight: in the highest paid order, most items ordered
-- belong to the Italian category.

-- 05: View the details of the top 5 highest spending orders
--     Top 5 order IDs: 440, 2075, 1957, 330, 2675

select
    order_id,
    category,
    count(item_id) as num_of_item
from order_details as o
left join menu_items as m
    on o.item_id = m.menu_item_id
where order_id in (440, 2075, 1957, 330, 2675)
group by order_id, category;
