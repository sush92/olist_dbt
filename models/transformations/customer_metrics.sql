-- models/transformations/customer_metrics.sql
WITH customer_orders AS (
    SELECT
        o.customer_id,
        COUNT(o.order_id) AS total_orders,
        SUM(p.payment_value) AS total_spent
    FROM {{ ref('stg_orders') }} o
    JOIN {{ source('olist', 'olist_order_payments_dataset') }} p ON o.order_id = p.order_id
    GROUP BY o.customer_id
)
SELECT
    c.customer_id,
    c.customer_unique_id,
    c.customer_city,
    c.customer_state,
    co.total_orders,
    co.total_spent
FROM {{ ref('stg_customers') }} c
LEFT JOIN customer_orders co ON c.customer_id = co.customer_id
