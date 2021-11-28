{{
  config(
    materialized='table'
  )
}}

select users.*,
    orders.lifetime_revenue
FROM {{ ref('dim_users') }} users
    left join (
        select user_id,
            sum(order_total) as lifetime_revenue
        from {{ ref('fact_orders') }}
        group by user_id
    ) orders on users.user_id = orders.user_id
