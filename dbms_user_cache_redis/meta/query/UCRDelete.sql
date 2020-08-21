--liquibase formatted sql
--changeset patcher-core:UCRDelete dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description, cc_query)
 VALUES('UCRDelete', '${provider}', '4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-07-14 15:58:14.658', 'dml', 'session', null, 'Удаление пользовательских настроек',
 '{
     "command": "HDEL",
     "args": ["{sess_ck_id}", "{data.ck_id}"]
 }')
 on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cn_action = excluded.cn_action, cv_description = excluded.cv_description;
