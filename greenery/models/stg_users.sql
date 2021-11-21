{{
  config(
    materialized='table'
  )
}}

with source as (

    select * from {{ source('tutorial', 'users') }}

),

users as (

    select
        id,
        user_id,
        first_name,
        last_name,
        email,
        phone_number,
        created_at,
        updated_at,
        address_id

    from source

)

select * from users
