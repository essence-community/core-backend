--liquibase formatted sql
--changeset artemov_i:auth-init dbms:postgresql runOnChange:true
INSERT INTO s_mt.t_provider (ck_id, cv_name, ck_user, ct_change) VALUES('authcore', 'Авторизация CORE', '1', '2019-08-13 23:29:30.884') on conflict (ck_id) do update set cv_name = excluded.cv_name, ck_user = excluded.ck_user, ct_change = excluded.ct_change;

--changeset artemov_i:CORE-24-auth dbms:postgresql
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,ck_user,ct_change)
VALUES (200,'error','Необходимо указать {0}','-11','2019-08-13 16:20:00.000');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,ck_user,ct_change)
VALUES (201,'error','{0} должно быть уникально','-11','2019-08-15 09:30:00.000');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,ck_user,ct_change)
VALUES (202,'warning','{0} используется в {1}','-11','2019-08-15 09:30:00.000');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,ck_user,ct_change)
VALUES (203,'error','Уже существует пользователь с таким Логином','-11','2019-08-15 09:30:00.000');

--changeset artemov_i:CORE-399 dbms:postgresql
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,ck_user,ct_change)
VALUES (204,'error','Удаление невозможно, т.к. существуют связанные записи','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-10-30 10:30:00.000');

--changeset artemov_i:CORE-1035 dbms:postgresql runOnChange:true
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('c7871bbd0e855693a47185a29b2b79f1','ru_RU','static','Гостевая учетная запись','4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-03-04 20:58:14.658') on conflict on constraint cin_u_localization_1 DO NOTHING;
INSERT INTO s_mt.t_sys_setting (ck_id,cv_value,ck_user,ct_change,cv_description)
    VALUES ('g_sys_enable_guest_login','false','4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-03-04 20:58:14.658','Включаем гостевой доступ') on conflict (ck_id) DO NOTHING;

--changeset artemov_i:CORE-1035-rename dbms:postgresql runOnChange:true
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('02776da507494f2f9956ba9e0f37b1f1','ru_RU','static','как гость','4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-03-04 08:00:00.000') on conflict on constraint cin_u_localization_1 DO NOTHING;

--changeset artemov_i:CORE-1035-auto-connect dbms:postgresql
INSERT INTO s_mt.t_sys_setting (ck_id,cv_value,ck_user,ct_change,cv_description)
    VALUES ('auto_connect_guest','false','4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-03-04 20:58:14.658','По умолчанию авторизуемся как гость');

--changeset artemov_i:delete-warn dbms:postgresql
INSERT INTO s_mt.t_localization
(ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)
VALUES('6fcb7feea53e4ca9b2b5634ac1832164', 'ru_RU', 'message', 'Учетная запись будет удалена безвозвратно', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:36:08.818') on conflict on constraint cin_u_localization_1 DO NOTHING;

--changeset artemov_i:deleted_account dbms:postgresql
INSERT INTO s_mt.t_localization
(ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)
VALUES('b26c57fa632e4567895b9c31f6085ee8', 'ru_RU', 'message', 'Учетная запись удалена', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-10-13 15:54:34.405') on conflict on constraint cin_u_localization_1 DO NOTHING;
