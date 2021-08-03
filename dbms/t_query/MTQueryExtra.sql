--liquibase formatted sql
--changeset artemov_i:MTQueryExtra dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTQueryExtra', '/*MTQueryExtra*/
select
    ck_id,
    cc_query,
    ck_provider,
    ck_user,
    ct_change at time zone :sess_cv_timezone as ct_change,
    cr_type,
    cr_access,
    cn_action,
    cv_description
from
    s_mt.t_query
where ck_id = :json::jsonb#>>''{master,ck_id}''
  ', 'meta', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-08-02 11:55:04.721523+03', 'select', 'po_session', NULL, 'Данные сервиса')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;

