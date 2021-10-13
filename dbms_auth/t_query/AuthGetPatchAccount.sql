--liquibase formatted sql
--changeset artemov_i:AuthGetPatchAccount dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('AuthGetPatchAccount', '--AuthGetPatchAccount
select /*Pagination*/
       count(1) over() as jn_total_cnt,
       /*Account*/
       t.*
  from (
select
  ac.ck_id,
       ac.cv_login,
       ac.cv_name,
       ac.cv_surname,
       ac.cv_timezone,
       ac.cv_patronymic,
       ac.cv_email,
       ac.ck_user,
       ac.ct_change at time zone :sess_cv_timezone as ct_change
from t_account ac
join t_create_patch cp
  on cp.ck_id = (:json::json#>>''{master,ck_id}'')::uuid and cp.сj_param::jsonb#>>''{data,cct_account}'' is not null and ac.ck_id in (select value::uuid from jsonb_array_elements_text(cp.сj_param#>''{data,cct_account}''))
where true and ac.cl_deleted = 0::smallint
/*##filter.ck_id*/and ac.ck_id = (:json::json#>>''{filter,ck_id}'')::uuid/*filter.ck_id##*/
  ) t
 where &FILTER
 order by &SORT
offset &OFFSET rows
 fetch first &FETCH rows only
  ', 'authcore', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-24 15:31:04.052526+03', 'select', 'po_session', NULL, 'Список пользователей вошедших в патч')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cv_description = excluded.cv_description;

