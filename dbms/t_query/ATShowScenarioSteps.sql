--liquibase formatted sql
--changeset artemov_i:ATShowScenarioSteps.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
insert into s_mt.t_query(
  ck_id,  
  cl_select, 
  ck_provider, 
  ck_user, 
  ct_change,
  cc_query
)values(
  'ATShowScenarioSteps', 
  1, 
  'meta', 
  10020788, 
  CURRENT_TIMESTAMP,
  $$
--ATShowScenarioSteps
select
  s.ck_id,
  s.ck_scenario,
  s.cn_order,
  s.cv_key,
  s.cv_value,
  s.cv_description,
  /* Поля аудита */
  s.ck_user,
  s.ct_change at time zone :sess_cv_timezone as ct_change
from s_mt.t_step s
where s.ck_scenario = (cast(:json as jsonb)->'master'->>'ck_id')::bigint
and ( &FILTER )
order by &SORT, s.cn_order asc
  $$
)on conflict (ck_id) do update set cc_query = excluded.cc_query, cl_select = excluded.cl_select, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change;