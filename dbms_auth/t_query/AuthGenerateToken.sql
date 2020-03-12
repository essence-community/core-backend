--liquibase formatted sql
--changeset artemov_i:AuthGenerateToken dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id,cc_query,ck_provider,ck_user,ct_change,cr_type,cr_access,cn_action,cv_description)
VALUES ('AuthGenerateToken','/*AuthGenerateToken*/
select
    pkg_json_account.f_modify_auth_token(
        :sess_ck_id::varchar,
        :sess_session::varchar,
        jsonb_build_object(''data'', jsonb_build_object(''ck_account'', :cv_account), ''service'', jsonb_build_object(''cv_action'', ''I''))
    )::json->>''ck_id'' as cv_token
','authcore','4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-03-06 09:30:00.000','select','session',89999,'Генерация токена')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cn_action = excluded.cn_action, cv_description = excluded.cv_description;
