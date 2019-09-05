--liquibase formatted sql
--changeset artemov_i:data dbms:postgresql splitStatements:false stripComments:false
INSERT INTO s_at.t_account (cv_surname,cv_name,cv_login,cv_hash_password,ck_id,ck_user,ct_change,cv_timezone,cv_salt)
	VALUES ('admin_core','admin_core','admin_core','8cad209590c57165c25ba1da2d1d687e6f09bc34e2e08d1c96247e7f2701de07','4fd05ca9-3a9e-4d66-82df-886dfa082113','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 14:27:02.672','+03:00','a7ffd180db');
INSERT INTO s_at.t_account (cv_surname,cv_name,cv_login,cv_hash_password,ck_id,ck_user,ct_change,cv_timezone,cv_salt)
	VALUES ('view_core','view_core','view_core','2dc6c217455216b19af75b26b8614749e40ee84c962037b8f901f340f3e52d65','f167f04b-0a85-4e6f-94df-02ae416087b1','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 15:01:08.519','+03:00','d7b8cb8907');

INSERT INTO s_at.t_role (ck_id,cv_name,cv_description,ck_user,ct_change)
	VALUES ('cbd38858-e1ca-45bb-8029-fda090062390','Консультант','Доступ ко всем страницам на просмотр','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 15:18:43.931');
INSERT INTO s_at.t_role (ck_id,cv_name,cv_description,ck_user,ct_change)
	VALUES ('6df56bd7-eaf0-41d4-ab45-1d1aa49c6dff','Администратор','Доступ ко всем страницам на просмотр и редактирования','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 15:18:55.189');

INSERT INTO s_at.t_action (ck_id,cv_name,cv_description,ck_user,ct_change)
	VALUES (492,'Доступ на модификацию страницы "Атрибуты"','Доступ на модификацию страницы "Атрибуты"','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 13:56:32.567');
INSERT INTO s_at.t_action (ck_id,cv_name,cv_description,ck_user,ct_change)
	VALUES (497,'Доступ на просмотр страницы "Классы"','Доступ на просмотр страницы "Классы"','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 13:56:32.567');
INSERT INTO s_at.t_action (ck_id,cv_name,cv_description,ck_user,ct_change)
	VALUES (498,'Доступ на модификацию страницы "Классы"','Доступ на модификацию страницы "Классы"','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 13:56:32.567');
INSERT INTO s_at.t_action (ck_id,cv_name,cv_description,ck_user,ct_change)
	VALUES (499,'Доступ на просмотр страницы "Объекты"','Доступ на просмотр страницы "Объекты"','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 13:56:32.567');
INSERT INTO s_at.t_action (ck_id,cv_name,cv_description,ck_user,ct_change)
	VALUES (500,'Доступ на модификацию страницы "Объекты"','Доступ на модификацию страницы "Объекты"','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 13:56:32.567');
INSERT INTO s_at.t_action (ck_id,cv_name,cv_description,ck_user,ct_change)
	VALUES (503,'Доступ на просмотр страницы "Профиль"','Доступ на просмотр страницы "Профиль"','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 13:56:32.567');
INSERT INTO s_at.t_action (ck_id,cv_name,cv_description,ck_user,ct_change)
	VALUES (504,'Доступ на модификацию страницы "Профиль"','Доступ на модификацию страницы "Профиль"','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 13:56:32.567');
INSERT INTO s_at.t_action (ck_id,cv_name,cv_description,ck_user,ct_change)
	VALUES (511,'Доступ на просмотр страницы "Страницы"','Доступ на просмотр страницы "Страницы"','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 13:56:32.567');
INSERT INTO s_at.t_action (ck_id,cv_name,cv_description,ck_user,ct_change)
	VALUES (512,'Доступ на модификацию страницы "Страницы"','Доступ на модификацию страницы "Страницы"','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 13:56:32.567');
INSERT INTO s_at.t_action (ck_id,cv_name,cv_description,ck_user,ct_change)
	VALUES (515,'Доступ на просмотр Тестовых страниц Метамодели','Доступ на просмотр Тестовых страниц Метамодели','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 13:56:32.567');
INSERT INTO s_at.t_action (ck_id,cv_name,cv_description,ck_user,ct_change)
	VALUES (516,'Доступ на модификацию Тестовых страниц Метамодели','Доступ на модификацию Тестовых страниц Метамодели','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 13:56:32.567');
INSERT INTO s_at.t_action (ck_id,cv_name,cv_description,ck_user,ct_change)
	VALUES (533,'Доступ на просмотр страницы "Администрирование Шлюза"','Доступ на просмотр страницы "Администрирование Шлюза"  Администрирование (МЕТАМОДЕЛЬ)','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 13:56:32.567');
INSERT INTO s_at.t_action (ck_id,cv_name,cv_description,ck_user,ct_change)
	VALUES (534,'Доступ на модификацию страницы "Администрирование Шлюза"','Доступ на модификацию страницы "Администрирование Шлюза" Администрирование (МЕТАМОДЕЛЬ)','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 13:56:32.567');
INSERT INTO s_at.t_action (ck_id,cv_name,cv_description,ck_user,ct_change)
	VALUES (692,'Доступ на просмотр страницы УСПО','Доступ на просмотр страницы УСПО','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 13:56:32.567');
INSERT INTO s_at.t_action (ck_id,cv_name,cv_description,ck_user,ct_change)
	VALUES (693,'Доступ на просмотр и модификацию страницы УСПО','Доступ на просмотр и модификацию страницы УСПО','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 13:56:32.567');
INSERT INTO s_at.t_action (ck_id,cv_name,cv_description,ck_user,ct_change)
	VALUES (704,'Доступ на просмотр страницы Системные настройки','Доступ на просмотр страницы Системные настройки','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 13:56:32.567');
INSERT INTO s_at.t_action (ck_id,cv_name,cv_description,ck_user,ct_change)
	VALUES (705,'Доступ на модификацию страницы Системные настройки','Доступ на модификацию страницы Системные настройки','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 13:56:32.567');
INSERT INTO s_at.t_action (ck_id,cv_name,cv_description,ck_user,ct_change)
	VALUES (491,'Доступ на просмотр страницы "Атрибуты"','Доступ на просмотр страницы "Атрибуты"','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-26 21:16:32.765');

INSERT INTO s_at.t_account_role (ck_role,ck_user,ct_change,ck_account)
	VALUES ('6df56bd7-eaf0-41d4-ab45-1d1aa49c6dff','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 14:24:15.609','4fd05ca9-3a9e-4d66-82df-886dfa082113');
INSERT INTO s_at.t_account_role (ck_role,ck_user,ct_change,ck_account)
	VALUES ('cbd38858-e1ca-45bb-8029-fda090062390','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 15:29:17.602','f167f04b-0a85-4e6f-94df-02ae416087b1');

INSERT INTO s_at.t_role_action (ck_action,ck_user,ct_change,ck_role)
	VALUES (491,'4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 14:01:08.187','6df56bd7-eaf0-41d4-ab45-1d1aa49c6dff');
INSERT INTO s_at.t_role_action (ck_action,ck_user,ct_change,ck_role)
	VALUES (491,'4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 15:19:14.382','cbd38858-e1ca-45bb-8029-fda090062390');
INSERT INTO s_at.t_role_action (ck_action,ck_user,ct_change,ck_role)
	VALUES (492,'4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 14:01:08.187','6df56bd7-eaf0-41d4-ab45-1d1aa49c6dff');
INSERT INTO s_at.t_role_action (ck_action,ck_user,ct_change,ck_role)
	VALUES (497,'4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 14:01:08.187','6df56bd7-eaf0-41d4-ab45-1d1aa49c6dff');
INSERT INTO s_at.t_role_action (ck_action,ck_user,ct_change,ck_role)
	VALUES (497,'4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 15:19:16.129','cbd38858-e1ca-45bb-8029-fda090062390');
INSERT INTO s_at.t_role_action (ck_action,ck_user,ct_change,ck_role)
	VALUES (498,'4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 14:01:08.187','6df56bd7-eaf0-41d4-ab45-1d1aa49c6dff');
INSERT INTO s_at.t_role_action (ck_action,ck_user,ct_change,ck_role)
	VALUES (499,'4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 14:01:08.187','6df56bd7-eaf0-41d4-ab45-1d1aa49c6dff');
INSERT INTO s_at.t_role_action (ck_action,ck_user,ct_change,ck_role)
	VALUES (499,'4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 15:19:18.251','cbd38858-e1ca-45bb-8029-fda090062390');
INSERT INTO s_at.t_role_action (ck_action,ck_user,ct_change,ck_role)
	VALUES (500,'4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 14:01:08.187','6df56bd7-eaf0-41d4-ab45-1d1aa49c6dff');
INSERT INTO s_at.t_role_action (ck_action,ck_user,ct_change,ck_role)
	VALUES (503,'4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 14:01:08.187','6df56bd7-eaf0-41d4-ab45-1d1aa49c6dff');
INSERT INTO s_at.t_role_action (ck_action,ck_user,ct_change,ck_role)
	VALUES (503,'4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 15:19:20.640','cbd38858-e1ca-45bb-8029-fda090062390');
INSERT INTO s_at.t_role_action (ck_action,ck_user,ct_change,ck_role)
	VALUES (504,'4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 14:01:08.187','6df56bd7-eaf0-41d4-ab45-1d1aa49c6dff');
INSERT INTO s_at.t_role_action (ck_action,ck_user,ct_change,ck_role)
	VALUES (511,'4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 14:01:08.187','6df56bd7-eaf0-41d4-ab45-1d1aa49c6dff');
INSERT INTO s_at.t_role_action (ck_action,ck_user,ct_change,ck_role)
	VALUES (511,'4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 15:21:39.219','cbd38858-e1ca-45bb-8029-fda090062390');
INSERT INTO s_at.t_role_action (ck_action,ck_user,ct_change,ck_role)
	VALUES (512,'4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 14:01:08.187','6df56bd7-eaf0-41d4-ab45-1d1aa49c6dff');
INSERT INTO s_at.t_role_action (ck_action,ck_user,ct_change,ck_role)
	VALUES (515,'4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 14:01:08.187','6df56bd7-eaf0-41d4-ab45-1d1aa49c6dff');
INSERT INTO s_at.t_role_action (ck_action,ck_user,ct_change,ck_role)
	VALUES (515,'4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 15:21:41.426','cbd38858-e1ca-45bb-8029-fda090062390');
INSERT INTO s_at.t_role_action (ck_action,ck_user,ct_change,ck_role)
	VALUES (516,'4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 14:01:08.187','6df56bd7-eaf0-41d4-ab45-1d1aa49c6dff');
INSERT INTO s_at.t_role_action (ck_action,ck_user,ct_change,ck_role)
	VALUES (533,'4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 14:01:08.187','6df56bd7-eaf0-41d4-ab45-1d1aa49c6dff');
INSERT INTO s_at.t_role_action (ck_action,ck_user,ct_change,ck_role)
	VALUES (533,'4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 15:21:43.369','cbd38858-e1ca-45bb-8029-fda090062390');
INSERT INTO s_at.t_role_action (ck_action,ck_user,ct_change,ck_role)
	VALUES (534,'4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 14:01:08.187','6df56bd7-eaf0-41d4-ab45-1d1aa49c6dff');
INSERT INTO s_at.t_role_action (ck_action,ck_user,ct_change,ck_role)
	VALUES (692,'4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 14:01:08.187','6df56bd7-eaf0-41d4-ab45-1d1aa49c6dff');
INSERT INTO s_at.t_role_action (ck_action,ck_user,ct_change,ck_role)
	VALUES (692,'4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 15:21:45.643','cbd38858-e1ca-45bb-8029-fda090062390');
INSERT INTO s_at.t_role_action (ck_action,ck_user,ct_change,ck_role)
	VALUES (693,'4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 14:01:08.187','6df56bd7-eaf0-41d4-ab45-1d1aa49c6dff');
INSERT INTO s_at.t_role_action (ck_action,ck_user,ct_change,ck_role)
	VALUES (693,'4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 15:21:49.868','cbd38858-e1ca-45bb-8029-fda090062390');
INSERT INTO s_at.t_role_action (ck_action,ck_user,ct_change,ck_role)
	VALUES (704,'4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 14:01:08.187','6df56bd7-eaf0-41d4-ab45-1d1aa49c6dff');
INSERT INTO s_at.t_role_action (ck_action,ck_user,ct_change,ck_role)
	VALUES (704,'4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 15:21:52.392','cbd38858-e1ca-45bb-8029-fda090062390');
INSERT INTO s_at.t_role_action (ck_action,ck_user,ct_change,ck_role)
	VALUES (705,'4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-23 14:01:08.187','6df56bd7-eaf0-41d4-ab45-1d1aa49c6dff');
