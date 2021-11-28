{{
  config(
    materialized='table'
  )
}}

select created_at_utc,
    orders.order_id,
    items.product_id,
    products.product_name,
    items.quantity
from {{ ref('stg_orders') }} orders
    left join {{ ref('stg_order_items') }} items on orders.order_id = items.order_id
    left join {{ ref('stg_products') }} products on items.product_id = products.product_id
order by created_at_utc,
    order_id
