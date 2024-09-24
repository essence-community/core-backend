--liquibase formatted sql
--changeset artemov_i:Login.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description, cc_query)
 VALUES('Login', 'authcore', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2024-09-24T15:39:35.418+0300', 'auth', 'free', null, 'Сервис авторизации',
 '/*Login*/
select u.ck_id, jsonb_build_object(''ck_id'', u.ck_id,
                   ''cv_login'', u.cv_login,
                   ''cv_name'', u.cv_name,
                   ''cv_surname'', u.cv_surname,
                   ''cv_patronymic'', u.cv_patronymic,
                   ''cv_email'', u.cv_email,
                   ''ca_actions'', (
                        select jsonb_agg(distinct dra.ck_action) 
                        from s_at.t_account_role ur
                        join s_at.t_role_action dra on ur.ck_role = dra.ck_role
                        where ur.ck_account = u.ck_id
                   ),
                   ''cv_timezone'', u.cv_timezone) || coalesce(info.attr, ''{}''::jsonb) as json
  from (
        select pkg_json_account.f_get_user(:cv_login::varchar, :cv_password::varchar, :cv_token::varchar, 1::smallint) as ck_id
  ) as t
  join s_at.t_account u
    on u.ck_id = t.ck_id::uuid
  left join (select a.ck_id,
                jsonb_object_agg(a.ck_d_info, pkg_json_account.f_decode_attr(ainf.cv_value, a.cr_type)) as attr
          from (select ac.ck_id, inf.ck_id as ck_d_info, inf.cr_type
                  from s_at.t_account ac, s_at.t_d_info inf) a
          left join s_at.t_account_info ainf
            on a.ck_d_info = ainf.ck_d_info and a.ck_id = ainf.ck_account
          where ainf.cv_value is not null
         group by a.ck_id) as info
    on u.ck_id = info.ck_id'
) on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cn_action = excluded.cn_action, cv_description = excluded.cv_description;

