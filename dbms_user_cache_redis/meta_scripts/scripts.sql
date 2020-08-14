--liquibase formatted sql
--changeset artemov_i:CORE-1267 dbms:postgresql runOnChange:true
INSERT INTO s_mt.t_provider (ck_id, cv_name, ck_user, ct_change) 
    VALUES('${provider}', 'Провайдер пользовательских настроек', '4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-07-14 15:58:14.658')
    on conflict (ck_id) do update set cv_name = excluded.cv_name, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_sys_setting (ck_id,cv_value,ck_user,ct_change,cv_description)
    VALUES ('use_remote_storage_cache','true','4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-07-14 15:58:14.658','Включаем внешнюю систему сохранения пользовательских настроек')
    on conflict (ck_id) do update set cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_sys_setting (ck_id,cv_value,ck_user,ct_change,cv_description)
    VALUES ('remote_storage_load_query','UCRLoad','4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-07-14 15:58:14.658','Сервис загрузки пользовательских настроек')
    on conflict (ck_id) do update set cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_sys_setting (ck_id,cv_value,ck_user,ct_change,cv_description)
    VALUES ('remote_storage_add_query','UCRAdd','4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-07-14 15:58:14.658','Сервис добавления пользовательских настроек')
    on conflict (ck_id) do update set cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_sys_setting (ck_id,cv_value,ck_user,ct_change,cv_description)
    VALUES ('remote_storage_delete_query','UCRDelete','4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-07-14 15:58:14.658','Сервис удаления пользовательских настроек')
    on conflict (ck_id) do update set cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
