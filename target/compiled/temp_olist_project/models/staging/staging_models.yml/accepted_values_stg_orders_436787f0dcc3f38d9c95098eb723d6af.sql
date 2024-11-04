
    
    

with all_values as (

    select
        order_status as value_field,
        count(*) as n_records

    from "olist_data"."olist_analytics"."stg_orders"
    group by order_status

)

select *
from all_values
where value_field not in (
    'delivered','shipped','canceled','processing'
)

