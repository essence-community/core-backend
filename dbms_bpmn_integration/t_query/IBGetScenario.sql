--liquibase formatted sql
--changeset artemov_i:IBGetScenario dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('IBGetScenario', '--IBGetScenario
select /*Pagination*/
       count(1) over() as jn_total_cnt,
       /*Scenario*/
       t.*
  from (
select
  s.ck_id, 
	s.cn_action, 
	s.cv_description,
  s.cc_scenario,
  s.ck_user,
  s.ct_change at time zone :sess_cv_timezone as ct_change
from t_scenario s
where true
/*##filter.ck_id*/and s.ck_id = :json::json#>>''{filter,ck_id}''/*filter.ck_id##*/
  ) t
 where &FILTER
 order by &SORT
offset &OFFSET rows
 fetch first &FETCH rows only
  ', 's_ibc_adm', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-24 15:31:04.052526+03', 'select', 'po_session', NULL, 'Список сценариев')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;

