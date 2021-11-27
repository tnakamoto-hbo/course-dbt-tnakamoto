{% snapshot addresses_snapshot %} 

  {{ 
    config(
      target_schema='snapshots',
      unique_key='address_id',

      strategy='check',
      check_cols=['address', 'zipcode', 'state', 'country']
    ) 
  }}

  SELECT *
  FROM {{ source('tutorial', 'addresses') }} 

{% endsnapshot %}