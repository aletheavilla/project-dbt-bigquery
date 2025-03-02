SELECT 
    o.delivered_at as fulfilled_at,
    FORMAT_DATE('%Y-%m-%d', DATE_TRUNC(PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%E6S%Ez', o.delivered_at), MONTH)) AS month,
    f.order_group_id,
    f.order_id, 
    f.product_id,
    f.user_id,
    u.age,
    u.gender,
    u.city, 
    u.country,
    u.traffic_source as lead_source,
    p.name as product_name,
    p.cost,
    f.sale_price  
FROM {{ref('stg_fulfilled_orders')}} as f
LEFT JOIN {{source('app_data', 'products')}} as p
    ON f.product_id = p.id
LEFT JOIN {{source('app_data', 'users')}} as u
    ON f.user_id = u.id
LEFT JOIN {{source('app_data', 'orders')}} as o
    ON f.order_id = o.order_id