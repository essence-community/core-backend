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