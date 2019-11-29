/*MTAttrClassList*/

select
	c.ck_id,
	c.cv_name,
	c.cv_description
from
	s_mt.t_class_attr ca
join s_mt.t_attr a on
	a.ck_id = ca.ck_attr
join s_mt.t_class c on
	c.ck_id = ca.ck_class
where
	ca.ck_attr = (cast(:json as jsonb)->'master'->>'ck_id')::varchar
order by
	ca.ck_attr asc