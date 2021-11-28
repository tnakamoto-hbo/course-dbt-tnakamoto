{{
  config(
    materialized='table'
  )
}}

with hourly_orders as (
    select date_trunc('hour', created_at_utc) as hour_utc,
        product_id,
        product_name,
        sum(quantity) as hourly_order_cnt
    from {{ ref('product_orders') }}
    group by hour_utc,
        product_id,
        product_name
),
hourly_views as (
    select date_trunc('hour', created_at_utc) as hour_utc,
        product_id,
        product_name,
        sum(page_views) as hourly_view_cnt
    from {{ ref('product_views') }}
    group by hour_utc,
        product_id,
        product_name
)
select COALESCE(views.hour_utc, orders.hour_utc) as hour_utc,
    COALESCE(views.product_id, orders.product_id) as product_id,
    COALESCE(views.product_name, orders.product_name) as product_name,
    COALESCE(hourly_view_cnt, 0) as hourly_view_cnt,
    COALESCE(hourly_order_cnt, 0) as hourly_order_cnt
from hourly_views views
    full outer join hourly_orders orders on views.product_id = orders.product_id
    and views.hour_utc = orders.hour_utc