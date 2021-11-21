# dbt run-operation generate_base_model --args '{"source_name": "tutorial", "table_name": "addresses"}' >> models/stg_addresses.sql
# dbt run-operation generate_base_model --args '{"source_name": "tutorial", "table_name": "events"}' >> models/stg_events.sql
# dbt run-operation generate_base_model --args '{"source_name": "tutorial", "table_name": "order_items"}' >> models/stg_order_items.sql
# dbt run-operation generate_base_model --args '{"source_name": "tutorial", "table_name": "orders"}' >> models/stg_orders.sql
# dbt run-operation generate_base_model --args '{"source_name": "tutorial", "table_name": "products"}' >> models/stg_products.sql
# dbt run-operation generate_base_model --args '{"source_name": "tutorial", "table_name": "promos"}' >> models/stg_promos.sql
# dbt run-operation generate_base_model --args '{"source_name": "tutorial", "table_name": "users"}' >> models/stg_users.sql

# dbt build

# dbt run-operation generate_model_yaml --args '{"model_name": "stg_addresses"}' >> models/schema.txt
# dbt run-operation generate_model_yaml --args '{"model_name": "stg_events"}' >> models/schema.txt
# dbt run-operation generate_model_yaml --args '{"model_name": "stg_order_items"}' >> models/schema.txt
# dbt run-operation generate_model_yaml --args '{"model_name": "stg_orders"}' >> models/schema.txt
# dbt run-operation generate_model_yaml --args '{"model_name": "stg_products"}' >> models/schema.txt
# dbt run-operation generate_model_yaml --args '{"model_name": "stg_promos"}' >> models/schema.txt
# dbt run-operation generate_model_yaml --args '{"model_name": "stg_users"}' >> models/schema.txt