--liquibase formatted sql
--changeset artemov_i:AuthGetPatchAction dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('AuthGetPatchAction', '--AuthGetPatchAction
select /*Pagination*/
       count(1) over() as jn_total_cnt,
       /*action*/
       t.*
  from (
select
  a.ck_id,
	a.cv_name,
	a.cv_description
from t_action a
join t_create_patch cp
  on cp.ck_id = (:json::json#>>''{master,ck_id}'')::uuid and cp.сj_param::jsonb#>>''{data,cct_action}'' is not null and a.ck_id in (select value::bigint from jsonb_array_elements_text(cp.сj_param#>''{data,cct_action}''))
where true
/*##filter.ck_id*/and a.ck_id = (:json::json#>>''{filter,ck_id}'')::bigint/*filter.ck_id##*/
  ) t
 where &FILTER
 order by &SORT
offset &OFFSET rows
 fetch first &FETCH rows only
  ', 'authcore', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-24 15:31:04.052526+03', 'select', 'po_session', NULL, 'Список экшенов вошедших в патч')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cv_description = excluded.cv_description;

