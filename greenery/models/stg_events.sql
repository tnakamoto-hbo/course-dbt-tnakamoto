{{
  config(
    materialized='table'
  )
}}

with source as (

    select * from {{ source('tutorial', 'events') }}

),

events as (

    select
        id,
        event_id,
        session_id,
        user_id,
        page_url,
        created_at,
        event_type

    from source

)

select * from events
