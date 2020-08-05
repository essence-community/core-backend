--liquibase formatted sql
--changeset artemov_i:CORE-1311 dbms:postgresql
INSERT INTO s_mt.t_sys_setting (ck_id,ck_user,ct_change,cv_description)
	VALUES ('skip_update_action_page','4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-08-05 11:10:31.709','Пропустить обновление доступов у страниц') on conflict (ck_id) DO NOTHING;
