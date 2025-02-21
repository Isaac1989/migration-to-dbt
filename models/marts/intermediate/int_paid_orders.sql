with orders as (
  select * from {{ ref('stg_jaffle_shop__orders')}}
),
customers as (
  select * from {{ ref('stg_jaffle_shop__customers')}}
),
total_payments as (
  select * from {{ref('int_payments')}}
),
paid_orders as (select orders.order_id as order_id,
    orders.customer_id,
    orders.order_date as order_placed_at,
    orders.order_status,
    p.total_amount_paid,
    p.payment_finalized_date,
    c.givenname    as customer_first_name,
    c.surname as customer_last_name
from orders
left join total_payments p on orders.order_id = p.order_id
left join customers c on orders.customer_id = c.customer_id 
)
select * from paid_orders