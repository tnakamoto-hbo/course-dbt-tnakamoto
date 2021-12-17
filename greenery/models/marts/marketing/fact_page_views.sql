{{
    config(
        materialized = 'table'
    )
}}

select  
    event_id,
    session_id,
    user_id,
    event_type,
    page_url,
    created_at_utc,
    split_part(page_url, '/product/', 2) as product_id
from {{ ref('stg_events') }}
