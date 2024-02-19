--liquibase formatted sql
--changeset artemov_i:AuthChangePassword dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id,cc_query,ck_provider,ck_user,ct_change,cr_type,cr_access,cv_description)
VALUES ('AuthChangePassword','/* AuthChangePassword */
select pkg_json_account.f_modify_account_password(
        :sess_ck_id::varchar,
        :sess_session::varchar,
        (:json::jsonb#>>''{data,cv_password_current}'')::varchar,
        (:json::jsonb#>>''{data,cv_password_new_1}'')::varchar,
        (:json::jsonb#>>''{data,cv_password_new_2}'')::varchar
    ) as result
','authcore','4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-03-06 09:30:00.000','dml','session','Смена пароля пользователем')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cv_description = excluded.cv_description;
