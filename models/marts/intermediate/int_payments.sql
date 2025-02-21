with payments as (
  select * from {{ ref('stg_stripe__payments')}}
  where payment_status <> 'fail'
),
total_payments as (
  select 
    order_id,
    max(created) as payment_finalized_date,
    sum(payment_amount) as total_amount_paid
  from payments
  group by 1
  )
  select * from total_payments