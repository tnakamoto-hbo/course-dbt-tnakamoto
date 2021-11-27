{{
  config(
    materialized='table'
  )
}}

SELECT created_at_utc,
    split_part(page_url, '/product/', 2) as product,
    count(event_id) as page_views
FROM {{ ref('stg_events') }}
where split_part(page_url, '/product/', 2) != ''
group by created_at_utc,
    product
order by created_at_utc,
    product
