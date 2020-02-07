--liquibase formatted sql
--changeset artemov_i:AuthGetPatchInfo dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('AuthGetPatchInfo', '--AuthGetPatchInfo
select /*Pagination*/
       row_number() over(order by &SORT)as jn_rownum,
       count(1) over() as jn_total_cnt,
       /*Info*/
       t.*
  from (
select
  inf.ck_id, 
  inf.cv_description, 
  inf.cr_type, 
  inf.cl_required, 
  inf.ck_user, 
  inf.ct_change
from t_d_info inf
join t_create_patch cp
  on cp.ck_id = (:json::json#>>''{master,ck_id}'')::uuid and cp.сj_param::jsonb#>>''{data,cct_info}'' is not null and inf.ck_id in (select value from jsonb_array_elements_text(cp.сj_param#>''{data,cct_info}''))
where true
/*##filter.ck_id*/and a.ck_id = (:json::json#>>''{filter,ck_id}'')/*filter.ck_id##*/
  ) t
 where &FILTER
 order by &SORT
offset &OFFSET rows
 fetch first &FETCH rows only
  ', 'authcore', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-01-22 15:44:04.03234+03', 'select', 'po_session', NULL, 'Список доп информации вошедших в патч')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;

