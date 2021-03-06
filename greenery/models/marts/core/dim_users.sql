{{
  config(
    materialized='table'
  )
}}

with first_and_last as (
    select distinct user_id,
        first_value(created_at_utc) over (
            partition by user_id
            order by created_at_utc
        ) as first_order_utc,
        last_value(created_at_utc) over (
            partition by user_id
            order by created_at_utc rows between current row
                and unbounded following
        ) as last_order_utc
    from {{ ref('stg_orders') }}
    order by user_id
),

lifetime_order_cnt as (
    select distinct users.user_id,
        case
            when orders.lifetime_order_cnt is null then 0
            else orders.lifetime_order_cnt
        end as lifetime_order_cnt
    from {{ ref('stg_users') }} users
        left join (
            select user_id,
                count(distinct order_id) as lifetime_order_cnt
            from {{ ref('stg_orders') }}
            group by user_id
        ) orders 
          on users.user_id = orders.user_id
)

select usr.user_id,
    usr.first_name,
    addr.zipcode,
    addr.state,
    addr.country,
    usr.created_at,
    usr.updated_at,
    loc.lifetime_order_cnt,
    fal.first_order_utc,
    fal.last_order_utc
from {{ ref('stg_users') }} usr
left join {{ ref('stg_addresses') }} addr
    on usr.address_id = addr.address_id
left join lifetime_order_cnt loc
    on usr.user_id = loc.user_id
left join first_and_last fal 
    on usr.user_id = fal.user_id
