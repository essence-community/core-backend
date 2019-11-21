--liquibase formatted sql
--changeset dudin_m:MTPageObjectAttrType.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTPageObjectAttrType', '/*MTPageObjectAttrType*/
select att.ck_id,
       att.cv_name,
       att.cv_description
  from s_mt.t_attr_type att
 where att.ck_id in (''basic'', ''behavior'', ''view'')
 union all
select ''all'',
       ''Все'',
       ''все атрибуты''', 'meta', '20783', '2019-11-21 10:59:49.352201+03', 'select', 'po_session', NULL, 'Необходимо актуализировать')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;

