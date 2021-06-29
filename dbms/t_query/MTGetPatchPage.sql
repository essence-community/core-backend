--liquibase formatted sql
--changeset artemov_i:MTGetPatchPage dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTGetPatchPage', '--MTGetPatchPage
select /*Pagination*/
       count(1) over() as jn_total_cnt,
       /*Page*/
       t.*
  from (
select
  p.ck_id,
  p.cv_name
from t_page p
join t_create_patch cp
  on cp.ck_id = (:json::json#>>''{master,ck_id}'')::uuid and cp.сj_param::jsonb#>>''{data,cct_page}'' is not null and p.ck_id in (select value from jsonb_array_elements_text(cp.сj_param#>''{data,cct_page}''))
where true
/*##filter.ck_id*/and p.ck_id = :json::json#>>''{filter,ck_id}''/*filter.ck_id##*/
  ) t
 where &FILTER
 order by &SORT
offset &OFFSET rows
 fetch first &FETCH rows only
  ', 'meta', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-20 14:56:04.052926+03', 'select', 'po_session', NULL, 'Список страниц вошедших в патч')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cn_action = excluded.cn_action, cv_description = excluded.cv_description;

