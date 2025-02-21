with orders as (
  select * from {{ ref('stg_jaffle_shop__orders')}}
),
customers as (
  select * from {{ ref('stg_jaffle_shop__customers')}}
),
customer_orders as (
  select c.customer_id,
     min(order_date) as first_order_date,
     max(order_date) as most_recent_order_date,
     count(orders.order_id) as number_of_orders
  from customers c 
  left join orders 
  on orders.customer_id = c.customer_id 
  group by 1
  )
select * from customer_orders
