--liquibase formatted sql
--changeset artemov_i:AuthGetPatch dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('AuthGetPatch', '--AuthGetPatch
select /*Pagination*/
       row_number() over(order by &SORT)as jn_rownum,
       count(1) over() as jn_total_cnt,
       /*Patch*/
       t.*
  from (
select
  p.ck_id,
  p.cv_file_name,
  p.cd_create,
  p.cn_size,
  (p.cn_size::numeric/(1024*1024)) as cn_size_view,
  p.ck_user,
  p.ct_change at time zone :sess_cv_timezone as ct_change
from t_create_patch p
where true 
/*##filter.ck_id*/and p.ck_id = (:json::json#>>''{filter,ck_id}'')::uuid/*filter.ck_id##*/
  ) t
 where &FILTER
 order by &SORT
offset &OFFSET rows
 fetch first &FETCH rows only
  ', 'authcore', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-05 12:56:04.052926+03', 'select', 'po_session', NULL, 'Список созданых патчей')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;

