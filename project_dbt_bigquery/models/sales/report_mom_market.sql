with fulfilled_orders as (
  SELECT * FROM {{ref('stg_fulfilled_orders')}}
),

combined_tables as (
  SELECT * FROM {{ref('stg_combined_tables')}}
)

select *,
  CAST(sale_price as FLOAT64) - CAST(cost as FLOAT64) as profit
from combined_tables

