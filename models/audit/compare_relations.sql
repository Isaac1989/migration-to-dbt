
{% set old_relation = adapter.get_relation(
      database = "dbt_tutorial",
      schema = "jaffle_shop",
      identifier = "customer_orders"
) -%}

{% set dbt_relation = ref('fct_customer_orders') %}

{% if execute %}
{{ audit_helper.compare_relations(
    a_relation = old_relation,
    b_relation = dbt_relation,
    primary_key = "order_id"
) }}
{% endif %}