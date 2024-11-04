-- models/staging/stg_orders.sql
WITH raw_orders AS (
    SELECT * FROM "olist_data"."olist_analytics"."olist_orders_dataset"
)
SELECT
    order_id,
    customer_id,
    order_purchase_timestamp,
    order_delivered_customer_date::date AS order_delivered_customer_date,
    order_estimated_delivery_date::date AS order_estimated_delivery_date,
    (order_estimated_delivery_date::date - order_delivered_customer_date::date) AS delivery_delay
FROM raw_orders
WHERE order_status = 'delivered'