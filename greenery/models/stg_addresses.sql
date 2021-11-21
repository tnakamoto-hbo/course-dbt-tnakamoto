{{
  config(
    materialized='table'
  )
}}

with source as (

    select * from {{ source('tutorial', 'addresses') }}

),

addresses as (

    select
        id,
        address_id,
        address,
        zipcode,
        state,
        country

    from source

)

select * from addresses
