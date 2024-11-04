
    
    

select
    order_id as unique_field,
    count(*) as n_records

from "olist_data"."olist_analytics"."stg_orders"
where order_id is not null
group by order_id
having count(*) > 1


