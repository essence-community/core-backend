--liquibase formatted sql
--changeset artemov_i:AuthGetPatchRole dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('AuthGetPatchRole', '--AuthGetPatchRole
select /*Pagination*/
       row_number() over(order by &SORT)as jn_rownum,
       count(1) over() as jn_total_cnt,
       /*Role*/
       t.*
  from (
select
  r.ck_id,
	r.cv_name,
	r.cv_description,
	r.ck_user,
	r.ct_change at time zone :sess_cv_timezone as ct_change
from t_role r
join t_create_patch cp
  on cp.ck_id = (:json::json#>>''{master,ck_id}'')::uuid and cp.сj_param::jsonb#>>''{data,cct_role}'' is not null and r.ck_id in (select value::uuid from jsonb_array_elements_text(cp.сj_param#>''{data,cct_role}''))
where true
/*##filter.ck_id*/and r.ck_id = (:json::json#>>''{filter,ck_id}'')::uuid/*filter.ck_id##*/
  ) t
 where &FILTER
 order by &SORT
offset &OFFSET rows
 fetch first &FETCH rows only
  ', 'authcore', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-24 15:31:04.052526+03', 'select', 'po_session', NULL, 'Список ролей вошедших в патч')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cv_description = excluded.cv_description;

