--liquibase formatted sql
--changeset artemov_i:GetUserInfo.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('GetUserInfo', '/*GetUserInfo*/
select
    case
        when u.ck_id is not null then 
    coalesce(nullif(trim(coalesce(u.cv_surname, '''') || '' '' || coalesce(u.cv_name, '''') || '' '' || coalesce(nullif(''('' || coalesce(u.cv_email, '''') || '')'' , ''()''), '''')), ''''), u.cv_login)
        else
    ''Пользователь ('' || v_u.ck_id || '')''
    end as ck_id
from
    jsonb_to_record(:json::jsonb#>''{filter}'') as v_u(
        ck_id varchar
    )
left join tt_user u
  on
    v_u.ck_id = u.ck_id
 ', 'meta', '20783', '2019-05-28 14:12:03.226474+03', 'select', 'session', NULL, 'Пользователь из кэша')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cn_action = excluded.cn_action, cv_description = excluded.cv_description;

