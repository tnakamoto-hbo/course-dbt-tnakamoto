{{
  config(
    materialized='table'
  )
}}

with source as (

    select * from {{ source('tutorial', 'orders') }}

),

orders as (

    select
        id,
        order_id,
        user_id,
        promo_id,
        address_id,
        created_at,
        order_cost,
        shipping_cost,
        order_total,
        tracking_id,
        shipping_service,
        estimated_delivery_at,
        delivered_at,
        status

    from source

)

select * from orders
