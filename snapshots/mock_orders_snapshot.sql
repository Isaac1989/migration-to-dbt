{% snapshot mock_orders_snapshot %}

{{

    config(
        target_database='dbt_tutorial',
        target_schema='jaffle_shop',
        strategy='timestamp',
        unique_key='order_id',
        updated_at='updated_at'
    )
}}

select * from dbt_tutorial.jaffle_shop.mock_orders

{% endsnapshot %}