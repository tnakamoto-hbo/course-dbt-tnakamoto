{% set event_types = dbt_utils.get_column_values(table=ref('stg_events'), column='event_type') %}

select session_id
    {% for event in event_types %} 

        ,sum(
            case
                when event_type = '{{ event }}' then 1 else 0
            end
        ) as {{ event }}_cnt

    {% endfor %}
from {{ ref('stg_events') }}
group by 1
