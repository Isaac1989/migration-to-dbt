{{
  config(
    materialized='ephemeral'
  )

}}

with a as (

    
select

  

   
    "order_id" 
    
      , 
     
   
    "customer_id" 
    
      , 
     
   
    "surname" 
    
      , 
     
   
    "givenname" 
    
      , 
     
   
    "first_order_date" 
    
      , 
     
   
    "order_count" 
    
      , 
     
   
    "total_lifetime_value" 
    
      , 
     
   
    "order_value_dollars" 
    
      , 
     
   
    "order_status" 
    
      , 
     
   
    "payment_status" 
     
  



from "dbt_tutorial"."jaffle_shop"."customer_orders"


),

b as (

    
select

  

   
    "order_id" 
    
      , 
     
   
    "customer_id" 
    
      , 
     
   
    "surname" 
    
      , 
     
   
    "givenname" 
    
      , 
     
   
    "first_order_date" 
    
      , 
     
   
    "order_count" 
    
      , 
     
   
    "total_lifetime_value" 
    
      , 
     
   
    "order_value_dollars" 
    
      , 
     
   
    "order_status" 
    
      , 
     
   
    "payment_status" 
     
  



from "dbt_tutorial"."jaffle_shop"."fct_customer_orders"


),

a_intersect_b as (

    select * from a
    

    intersect


    select * from b

),

a_except_b as (

    select * from a
    

    except


    select * from b

),

b_except_a as (

    select * from b
    

    except


    select * from a

),

all_records as (

    select
        *,
        true as in_a,
        true as in_b
    from a_intersect_b

    union all

    select
        *,
        true as in_a,
        false as in_b
    from a_except_b

    union all

    select
        *,
        false as in_a,
        true as in_b
    from b_except_a

),

summary_stats as (

    select

        in_a,
        in_b,
        count(*) as count

    from all_records
    group by 1, 2

),

final as (

    -- select

    --     *,
    --     round(100.0 * count / sum(count) over (), 2) as percent_of_total

    -- from summary_stats
    -- order by in_a desc, in_b desc
    select * from all_records
    where not (in_a and in_b)
    order by order_id, in_a desc, in_b desc
)

select * from final






create or replace table dbt_tutorial.jaffle_shop.mock_orders (
    order_id integer,
    status varchar (100),
    created_at date,
    updated_at date
);

BEGIN;
insert into jaffle_shop.mock_orders (order_id, status, created_at, updated_at)
values (1, 'delivered', '2020-01-01', '2020-01-04'),
       (2, 'shipped', '2020-01-02', '2020-01-04'),
       (3, 'shipped', '2020-01-03', '2020-01-04'),
       (4, 'processed', '2020-01-04', '2020-01-04');
commit;