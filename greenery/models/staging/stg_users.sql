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
        created_at AT TIME ZONE 'UTC' AS created_at,
        updated_at AT TIME ZONE 'UTC' AS updated_at,
        address_id 

    from source

)

select * from users
