--liquibase formatted sql
--changeset artemov_i:MTClassList.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTAttrClassList','/*MTAttrClassList*/

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
	ca.ck_attr = (cast(:json as jsonb)->''master''->>''ck_id'')::varchar
order by
	c.cv_name asc
	 ', 'meta', '20783', '2019-05-27 09:42:20.922637+03', 'select', 'po_session', NULL, 'Необходимо актуализировать')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cn_action = excluded.cn_action, cv_description = excluded.cv_description;
