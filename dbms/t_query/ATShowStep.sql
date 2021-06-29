--liquibase formatted sql
--changeset artemov_i:ATShowStep.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('ATShowStep', '/*ATShowStep*/

select 

  s.ck_id,

  s.ck_scenario,

  s.cn_order,

  s.cv_name,

  /* Поля аудита */

  s.ck_user,

  s.ct_change at time zone :sess_cv_timezone as ct_change

from s_mt.t_step s

where s.ck_scenario = (cast(:json as jsonb)->''master''->>''ck_id'')::varchar

 and ( &FILTER )

 /*##filter.ck_id*/and s.ck_id = (cast(:json as jsonb)->''filter''->>''ck_id'')::varchar/*filter.ck_id##*/

order by &SORT, s.cn_order asc

  ', 'meta', '20783', '2019-05-22 13:34:05.248676+03', 'select', 'po_session', NULL, 'Необходимо актуализировать')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cn_action = excluded.cn_action, cv_description = excluded.cv_description;

