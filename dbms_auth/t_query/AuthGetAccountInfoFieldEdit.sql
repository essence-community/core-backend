--liquibase formatted sql
--changeset artemov_i:AuthGetAccountInfoFieldEdit.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id,cc_query,ck_provider,ck_user,ct_change,cr_type,cr_access,cv_description)
VALUES ('AuthGetAccountInfoFieldEdit','/*AuthGetAccountInfoFieldEdit*/
select pkg_json_account.f_get_field_info(null, nullif(trim(:json::json#>>''{filter,gck_d_info}''), ''''), ''cv_value'') as json','authcore','-11','2019-08-13 18:30:00.000','select','po_session','Поля ввода')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;
