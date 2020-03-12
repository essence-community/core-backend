--liquibase formatted sql
--changeset artemov_i:AuthGetAccountInfoField.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id,cc_query,ck_provider,ck_user,ct_change,cr_type,cr_access,cv_description)
VALUES ('AuthGetAccountInfoField','/*AuthGetAccountInfoField*/
select 
json_build_object(''type'', ''PANEL'',
			''childs'', pkg_json_account.f_get_field_info(nullif(trim(:json::json#>>''{master,ck_id}''), ''''))::json,
			''ck_page'', nullif(trim(:json::json#>>''{filter,ck_page}''), ''''),
			''reqsel'', ''true'',
			''cl_dataset'', 1,
			''contentview'', ''vbox'',
			''ck_page_object'', sys_guid(),
			''cv_helper_color'', ''red'') as json','authcore','-11','2019-08-13 18:30:00.000','select','po_session','Поля ввода')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cv_description = excluded.cv_description;