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
        case 
          when created_at is null then to_timestamp('1970-01-01', 'YYYY-MM-DD HH:MI:SS') 
          else created_at
          end at time zone 'UTC' as created_at_utc,
        order_cost,
        shipping_cost,
        order_total,
        tracking_id,
        shipping_service,
        estimated_delivery_at AT TIME ZONE 'UTC' AS estimated_delivery_at_utc,
        delivered_at AT TIME ZONE 'UTC' AS delivered_at_utc,
        status as order_status

    from source

)

select * from orders
