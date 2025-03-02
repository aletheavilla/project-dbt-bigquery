WITH order_items as (
  SELECT 
    shipped_at,
    product_id, 
    inventory_item_id,
    order_id,
    status,
    sale_price
  FROM {{source('app_data', 'order_items')}}
)

SELECT
  FORMAT_DATE('%Y-%m-%d', DATE_TRUNC(PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%E6S%Ez', o.created_at), MONTH)) AS order_month,
  i.order_id,
  p.sku,
  i.status,
  i.sale_price,
  n.product_distribution_center_id as wh_id,
  d.name as center_name,
FROM order_items as i
LEFT JOIN {{source('app_data', 'inventory_items')}} as n
  ON i.inventory_item_id = n.id
LEFT JOIN {{source('app_data', 'products')}} as p
  ON i.product_id = p.id
INNER JOIN {{source('app_data', 'orders')}} as o
  ON i.order_id = o.order_id
INNER JOIN {{source('app_data', 'distribution_centers')}} as d
  ON n.product_distribution_center_id = d.id