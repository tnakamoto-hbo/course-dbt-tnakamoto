{{
  config(
    materialized='table'
  )
}}

WITH orders AS (
    SELECT *
    FROM {{ ref('stg_orders') }}
),
addresses AS (
    SELECT *
    FROM {{ ref('stg_addresses') }}
),
promos AS (
    SELECT *
    FROM {{ ref('stg_promos') }}
)

SELECT order_id,
    user_id,
    o.promo_id,
    p.promo_discount,
    a.address as delivery_address,
    shipping_service,
    o.order_status,
    estimated_delivery_at_utc,
    created_at_utc,
    delivered_at_utc,
    order_cost,
    shipping_cost,
    order_total
FROM orders o
    LEFT JOIN addresses a ON o.address_id = a.address_id
    left join promos p on o.promo_id = p.promo_id
