select
	businessentityid as person_id,
	concat_ws(' ', title, firstname, middlename, lastname) AS person_full_name
from {{ ref('person') }}