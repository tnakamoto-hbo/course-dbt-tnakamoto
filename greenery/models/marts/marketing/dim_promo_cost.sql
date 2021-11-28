{{
  config(
    materialized='table'
  )
}}

select orders.promo_id,
    promo_status,
    promo_discount,
    count(order_id) as promo_use_cnt,
    promo_discount * count(order_id) as promo_cost
from {{ ref('stg_orders') }} orders
    left join {{ ref('stg_promos') }} promos on orders.promo_id = promos.promo_id
where orders.promo_id is not null
group by 1, 2, 3
