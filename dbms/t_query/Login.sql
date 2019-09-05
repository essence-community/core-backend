--liquibase formatted sql
--changeset artemov_i:Login.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('Login', '/*Login*/
select pkg_json_account.f_get_user(:cv_login::varchar, :cv_password::varchar, :cv_token::varchar, 1::smallint) as ck_id', 'auth', '-11', '2018-12-10 11:55:18.461265+03', 'auth', 'free', NULL, 'Необходимо актуализировать')
on conflict (ck_id) DO NOTHING;

