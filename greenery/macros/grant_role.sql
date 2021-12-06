{% macro apply_grant_all(role) %}

{% set sql %}
    GRANT ALL ON SCHEMA {{ schema }} TO {{ role }};
{% endset %}

{% set table = run_query(sql) %}

{% endmacro %}