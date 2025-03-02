SELECT 
    id as order_group_id,
    order_id, 
    product_id,
    user_id,
    sale_price  
FROM {{source('app_data', 'order_items')}}
WHERE status = 'Complete'