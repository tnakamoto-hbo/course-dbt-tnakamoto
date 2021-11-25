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
        id,
        promo_id,
        discout,
        status

    from source

)

select * from promos
