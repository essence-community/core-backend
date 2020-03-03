--liquibase formatted sql
--changeset artemov_i:MTGetClassModule dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTGetClassModule', '/*MTGetClassModule*/
select t.ck_id,
       t.cv_name,
       t.cv_description,
       /*Поля аудита*/
       t.ck_user,
       t.ct_change
from   
( select c.ck_id,
       c.cv_name,
       c.cv_description,
       c.ck_user,
       c.ct_change at time zone :sess_cv_timezone as ct_change
  from s_mt.t_module_class mc
  join s_mt.t_class c
    on c.ck_id = mc.ck_class
 where mc.ck_module = :json::json#>>''{master,ck_id}''
 /*##filter.ck_id*/and c.ck_id = :json::json#>>''{filter,ck_id}''/*filter.ck_id##*/
) t
 where true and ( &FILTER )
 order by &SORT
  ', 'meta', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-03-03 15:28:20.009812+03', 'select', 'po_session', NULL, 'Список классов модуля')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;

