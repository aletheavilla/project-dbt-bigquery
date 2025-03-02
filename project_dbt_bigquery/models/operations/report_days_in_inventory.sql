WITH processed_inventory_data as (
  SELECT *,
    FORMAT_DATE('%Y-%m-%d', PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%E6S%Ez', created_at)) as created_month,
    DATE_DIFF(PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%E6S%Ez', sold_at), PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%E6S%Ez', created_at), DAY) as days_in_storage
  FROM {{source('app_data', 'inventory_items')}}
)

SELECT 
  created_month,
  product_distribution_center_id as wh_id, 
  d.name as center_name,
  AVG(days_in_storage) as avg_days_in_storage,
  AVG(days_in_storage) OVER(ORDER BY created_month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) as moving_avg_3_months,
FROM processed_inventory_data as i
INNER JOIN {{source('app_data', 'distribution_centers')}} as d
  ON i.product_distribution_center_id = d.id
WHERE sold_at IS NOT NULL
GROUP BY created_month, wh_id, center_name, days_in_storage