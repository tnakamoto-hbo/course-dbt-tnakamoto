{{
  config(
    materialized='table'
  )
}}

with source as (

    select * from {{ source('tutorial', 'products') }}

),

products as (

    select
        id,
        product_id,
        name as product_name,
        price as product_price,
        quantity as product_quantity

    from source

)

select * from products
