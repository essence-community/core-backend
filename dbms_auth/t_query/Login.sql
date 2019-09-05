--liquibase formatted sql
--changeset artemov_i:Login.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
update s_mt.t_query 
set ck_provider='authcore', cc_query = '/*Login*/
select pkg_json_account.f_get_user(:cv_login::varchar, :cv_password::varchar, :cv_token::varchar, 1::smallint) as ck_id'
where ck_id = 'Login';
