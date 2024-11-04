
  create view "olist_data"."olist_analytics"."stg_customers__dbt_tmp"
    
    
  as (
    -- models/staging/stg_customers.sql
WITH raw_customers AS (
    SELECT * FROM "olist_data"."olist_analytics"."olist_customers_dataset"
)
SELECT
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state
FROM raw_customers
  );