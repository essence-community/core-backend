--liquibase formatted sql
--changeset artemov_i:ITGetPatchInterface dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('ITGetPatchInterface', '--ITGetPatchInterface
select /*Pagination*/
       row_number() over(order by &SORT)as jn_rownum,
       count(1) over() as jn_total_cnt,
       /*Interface*/
       t.*
  from (
select
  i.ck_id, 
	i.ck_d_interface, 
	i.ck_d_provider, 
	i.cn_action,
	i.cv_description, 
	i.ck_parent
from t_interface i
join t_create_patch cp
  on cp.ck_id = (:json::json#>>''{master,ck_id}'')::uuid and cp.сj_param::jsonb#>>''{data,cct_interface}'' is not null and i.ck_id in (select value from jsonb_array_elements_text(cp.сj_param#>''{data,cct_interface}''))
where true
/*##filter.ck_id*/and r.ck_id = :json::json#>>''{filter,ck_id}''/*filter.ck_id##*/
  ) t
 where &FILTER
 order by &SORT
offset &OFFSET rows
 fetch first &FETCH rows only
  ', 's_ic_adm', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-24 15:31:04.052526+03', 'select', 'po_session', NULL, 'Список интерфейсов вошедших в патч')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;

