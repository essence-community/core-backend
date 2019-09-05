--liquibase formatted sql
--changeset artemov_i:ATSavePageToStep.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
insert into s_mt.t_query(
  ck_id,  
  cl_select, 
  ck_provider, 
  ck_user, 
  ct_change,
  cc_query
)values(
  'ATSavePageToStep', 
  0, 
  'meta', 
  10020788, 
  CURRENT_TIMESTAMP,
  $$
--ATSavePageToStep
begin
  -- Call the function
  select pkg_json_scenario.f_modify_step(
    pv_user => :sess_ck_id,
    pv_session => :sess_session,
    pc_json => :pc_json
  ) as result;
end;
  $$
)on conflict (ck_id) do update set cc_query = excluded.cc_query, cl_select = excluded.cl_select, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change;