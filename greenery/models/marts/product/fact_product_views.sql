{{
  config(
    materialized='table'
  )
}}

select created_at_utc,
    split_part(page_url, '/product/', 2) as product_id,
    products.product_name,
    count(event_id) as page_views
from {{ ref('stg_events') }} events
left join {{ ref('stg_products') }} products
  on split_part(events.page_url, '/product/', 2) = products.product_id
where split_part(page_url, '/product/', 2) != ''
group by 1, 2, 3
