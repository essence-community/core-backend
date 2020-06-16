--liquibase formatted sql
--changeset kutsenko_o:DTRoute.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('DTRoute', '/*DTRoute*/
select * from (values ((select cv_value from s_mt.t_sys_setting where ck_id = ''project_documentation_root''), null, 1, ''Документация'', 1, 0, null, null, 1, ''false'', 0)) as t (ck_id, ck_parent, cr_type, cv_name, cn_order, cl_static, cv_url, ck_icon, cl_menu, leaf, cl_noload)
union
select * from (values (''A732E27B938245A9A4A5047B761CD267'', (select cv_value from s_mt.t_sys_setting where ck_id = ''project_documentation_root''), 2, ''Разработка'', 1, 0, null, null, 1, ''true'', 0)) as t (ck_id, ck_parent, cr_type, cv_name, cn_order, cl_static, cv_url, ck_icon, cl_menu, leaf, cl_noload)
union
select * from (values (''classes'', null, 1, ''Классы'', 200, 0, null, null, 1, ''false'', 1)) as t (ck_id, ck_parent, cr_type, cv_name, cn_order, cl_static, cv_url, ck_icon, cl_menu, leaf, cl_noload)
union
select
	tc.ck_id,
	''classes'' as ck_parent,
	2 as cr_type,
	tc.cv_name,
	999999 as cn_order,
	1 as cl_static,
	replace(lower(coalesce(tc.cv_name, '''')), '' '', ''-'') as cv_url,
	null as ck_icon,
	1 as cl_menu,
	''true'' as leaf,
	1 as cl_noload
from
	s_mt.t_class tc
where ( &FILTER )
order by
	cv_name
', 'meta', '-11', '2020-06-11 09:18:27.503811+03', 'select', 'free', NULL, 'Список страниц документации')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;