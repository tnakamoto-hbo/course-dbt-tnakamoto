{{
  config(
    materialized='table'
  )
}}

select distinct product_id,
    product_name,
    product_price
from {{ ref('stg_products') }}
