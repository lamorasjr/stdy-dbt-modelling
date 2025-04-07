select
	salesorderid as sales_order_id,
	shiptoaddressid  as ship_to_address_id,
    creditcardid as credit_card_id,
	creditcardapprovalcode as credit_card_approval_code,
	"status" as order_status,
	customerid as customer_id,
	cast(orderdate as date) as order_date
from {{ ref('sales_order_header') }}