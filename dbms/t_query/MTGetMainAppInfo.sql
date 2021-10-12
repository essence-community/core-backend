--liquibase formatted sql
--changeset kutsenko:MTGetMainAppInfo dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTGetMainAppInfo', '/*MTGetMainAppInfo*/
select
	1 as ck_id,
	''<h2>CORE</h2> <div>Версия '' || coalesce(:json::json#>>''{filter,g_sys_front_branch_name}'', '''') || '' ('' || coalesce(:json::json#>>''{filter,g_sys_front_commit_id}'', '''') || '' от '' || coalesce(:json::json#>>''{filter,g_sys_front_branch_date_time}'', '''') || '')</div>'' as cv_app_info
', 'meta', '-11', '2020-02-03 12:06:22.563679+03', 'select', 'free', NULL, 'Получение HTML текста для вывода в инфо о программе')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cn_action = excluded.cn_action, cv_description = excluded.cv_description;
