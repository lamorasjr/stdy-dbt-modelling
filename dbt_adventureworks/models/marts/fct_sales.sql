with stg_sales_order_header as (
	select
		sales_order_id,
		ship_to_address_id,
		credit_card_id,
		credit_card_approval_code,
		order_status,
		customer_id,
		order_date
    from {{ ref('stg_sales_order_header') }}
),

stg_sales_order_detail as (
	select
		sales_order_id,
		sales_order_detail_id,
		product_id,
		order_qty,
		unit_price,
		revenue
    from {{ ref('stg_sales_order_detail') }}
)

select 
	{{ dbt_utils.generate_surrogate_key(['t2.sales_order_id', 't2.sales_order_detail_id']) }} as sales_key,
    {{ dbt_utils.generate_surrogate_key(['t2.product_id']) }} as product_key,
    {{ dbt_utils.generate_surrogate_key(['t1.customer_id']) }} as customer_key,
    {{ dbt_utils.generate_surrogate_key(['t1.credit_card_id']) }} as credit_card_key,
    {{ dbt_utils.generate_surrogate_key(['t1.ship_to_address_id']) }} as ship_address_key,
    {{ dbt_utils.generate_surrogate_key(['t1.sales_order_id']) }} as order_reason_key,
    {{ dbt_utils.generate_surrogate_key(['t1.order_date']) }} as order_date_key,
    t2.sales_order_id,
    t2.sales_order_detail_id,
    t2.unit_price,
    t2.order_qty,
    t2.revenue

from stg_sales_order_header as t1
	inner join stg_sales_order_detail as t2
		on t1.sales_order_id = t2.sales_order_id