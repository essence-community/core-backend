--liquibase formatted sql
--changeset artemov_i:GTGetEventSetting dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('GTGetEventSetting', NULL, 'admingate', '4fd05ca9-3a9e-4d66-82df-886dfa082113', CURRENT_TIMESTAMP, 'select', 'po_session', NULL, 'Настройки плагина')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;

