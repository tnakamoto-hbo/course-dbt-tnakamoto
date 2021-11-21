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
        name,
        price,
        quantity

    from source

)

select * from products
