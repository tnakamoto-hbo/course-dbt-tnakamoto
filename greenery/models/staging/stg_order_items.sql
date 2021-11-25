{{
  config(
    materialized='table'
  )
}}

with source as (

    select * from {{ source('tutorial', 'order_items') }}

),

order_items as (

    select
        id,
        order_id,
        product_id,
        quantity

    from source

)

select * from order_items
