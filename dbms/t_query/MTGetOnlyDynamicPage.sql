--liquibase formatted sql
--changeset artemov_i:MTGetOnlyDynamicPage.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTGetOnlyDynamicPage', '/*MTGetOnlyDynamicPage*/
select p.ck_id, p.cv_name
  from t_page p
 where p.cl_static = 0
   and p.cr_type = 2
   and p.cl_menu = 0
   /*##filter.cv_entered*/ and upper(p.cv_name) like upper(:json::json#>>''{filter,cv_entered}'') || ''%'' /*filter.cv_entered##*/
   and &FILTER
 order by &SORT', 'meta', '-11', '2019-07-23 06:52:27+03', 'select', 'po_session', NULL, 'Список динамических страниц')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;

