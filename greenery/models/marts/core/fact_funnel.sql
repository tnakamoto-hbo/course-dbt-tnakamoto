{{
    config(
        materialized = 'table'
    )
}}

 {%- set event_types = dbt_utils.get_column_values(
     table = ref('fact_page_views'),
     column = 'event_type'
 ) -%}

with
session_event
as
(
    select
        session_id
        ,date_trunc('day', min(created_at_utc)) as session_start
        ,date_trunc('day', max(created_at_utc)) as session_end
        {% for event_type in event_types %}
        ,sum(case when event_type = '{{event_type}}' then 1 else 0 end) as {{event_type}}
        {% endfor %}
    from {{ ref('fact_page_views') }}
    group by 
        session_id
)
select
    session_start
    ,count(distinct session_id) as total_session
    {% for event_type in ['page_view','add_to_cart','checkout'] %}
    ,sum(case when {{event_type}} > 0 then 1 else 0 end) sessions_with_{{event_type}}
    {% endfor %}
from session_event
group by session_start
order by session_start
