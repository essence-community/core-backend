--liquibase formatted sql
--changeset artemov_i:MTGetPatchMessage dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTGetPatchMessage', '--MTGetPatchMessage
select /*Pagination*/
       row_number() over(order by &SORT)as jn_rownum,
       count(1) over() as jn_total_cnt,
       /*Message*/
       t.*
  from (
select
  m.ck_id,
  m.cv_text
from t_message m
join t_create_patch cp
  on cp.ck_id = (:json::json#>>''{master,ck_id}'')::uuid and cp.сj_param::jsonb#>>''{data,cct_message}'' is not null and m.ck_id in (select value::bigint from jsonb_array_elements_text(cp.сj_param#>''{data,cct_message}''))
where true
/*##filter.ck_id*/and m.ck_id = :json::json#>>''{filter,ck_id}''/*filter.ck_id##*/
  ) t
 where &FILTER
 order by &SORT
offset &OFFSET rows
 fetch first &FETCH rows only
  ', 'meta', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-05 12:56:04.052926+03', 'select', 'po_session', NULL, 'Список ошибок вошедших в патч')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;

