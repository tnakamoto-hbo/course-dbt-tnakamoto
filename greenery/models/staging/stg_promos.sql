{{
  config(
    materialized='table'
  )
}}

with source as (

    select * from {{ source('tutorial', 'promos') }}

),

promos as (

    select
        promo_id,
        discout as promo_discount,
        status as promo_status

    from source

)

select * from promos
