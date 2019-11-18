--liquibase formatted sql
--changeset artemov_i:add_event dbms:postgresql
CREATE TRIGGER notify_semaphore_event
AFTER UPDATE ON s_mt.t_semaphore
  FOR EACH ROW EXECUTE PROCEDURE notify_event();

CREATE TRIGGER notify_notification_event
AFTER INSERT ON s_mt.t_notification
  FOR EACH ROW EXECUTE PROCEDURE notify_event();
--changeset artemov_i:CORE-36 dbms:postgresql
ALTER TABLE s_mt.t_class_attr ALTER COLUMN ck_attr SET NOT NULL;

ALTER TABLE s_mt.t_page_variable ALTER COLUMN cn_user SET NOT NULL;
ALTER TABLE s_mt.t_page_variable ALTER COLUMN ct_change SET NOT NULL;

ALTER TABLE s_mt.t_sys_setting ALTER COLUMN ct_change SET NOT NULL;
ALTER TABLE s_mt.t_sys_setting ALTER COLUMN cn_user SET NOT NULL;

ALTER TABLE s_mt.t_step ALTER COLUMN cn_user SET NOT NULL;
ALTER TABLE s_mt.t_step ALTER COLUMN ct_change SET NOT NULL;

--changeset artemov_i:CORE-64 dbms:postgresql
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change) VALUES 
(67,'error','Редактирование класса объекта запрещено',-11,'2019-04-29 16:27:00.000')

--changeset artemov_i:CORE-62 dbms:postgresql
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
VALUES (68,'error','Наименование атрибута должно быть уникальным',-11,'2019-04-29 09:47:00.000');

--changeset artemov_i:CORE-72 dbms:postgresql
UPDATE s_mt.t_message
SET cv_text='Удаление переменной невозможно, так как она все еще используется на странице в объектах "{0}"'
WHERE ck_id=44;

--changeset artemov_i:CORE-84 dbms:postgresql

ALTER TABLE s_mt.t_query ADD cn_action bigint NULL;
COMMENT ON COLUMN s_mt.t_query.cn_action IS 'Номер действия';

ALTER TABLE s_mt.t_query ADD cv_description varchar(2000) NOT NULL DEFAULT 'Необходимо актуализировать';
COMMENT ON COLUMN s_mt.t_query.cv_description IS 'Описание сервиса';

COMMENT ON COLUMN s_mt.t_query.cr_type IS 'Тип запроса:
select - запрос на выборку данных
dml - модификация данных
auth - авторизация
file_download - скачивание файла
file_upload - загрузка файла на сервер
report - сервис универсальной печати';

ALTER TABLE s_mt.t_query DROP CONSTRAINT cin_c_query_1;

ALTER TABLE s_mt.t_query ADD CONSTRAINT cin_c_query_1 CHECK (cr_type in ('select', 'dml', 'auth', 'report', 'file_download', 'file_upload'));
CREATE TABLE s_mt.t_dynamic_report (
	ck_query varchar NOT NULL,
	ck_page varchar NULL,
	cn_user int8 NOT NULL,
	ct_change timestamptz NOT NULL,
	CONSTRAINT cin_u_query UNIQUE (ck_query),
	CONSTRAINT cin_r_page FOREIGN KEY (ck_page) REFERENCES s_mt.t_page(ck_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT cin_r_query FOREIGN KEY (ck_query) REFERENCES s_mt.t_query(ck_id) ON UPDATE CASCADE ON DELETE RESTRICT
);
COMMENT ON TABLE s_mt.t_dynamic_report IS 'Связка запроса со страницей параметров';

INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
VALUES (69,'error','Необходимо указать наименование запроса',-11,'2019-07-23 10:47:00.000');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
VALUES (70,'error','Необходимо указать описание',-11,'2019-07-23 10:47:00.000');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
VALUES (71,'error','Необходимо указать тело запроса',-11,'2019-07-23 10:47:00.000');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
VALUES (72,'error','Необходимо указать действие',-11,'2019-07-23 10:47:00.000');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,cn_user,ct_change)
VALUES (73,'error','Наименование запроса должно быть уникально',-11,'2019-07-23 10:47:00.000');

--changeset artemov_i:CORE-17 dbms:postgresql
INSERT INTO s_mt.t_sys_setting (ck_id,cn_user,ct_change,cv_description)
VALUES ('smart_mask_query',1,'2019-08-05 10:15:50.000','Наименование запроса для инициализации массок');

--changeset artemov_i:CORE-24 dbms:postgresql
ALTER TABLE s_mt.t_query ALTER COLUMN cn_user TYPE varchar(150) USING cn_user::varchar;
ALTER TABLE s_mt.t_dynamic_report ALTER COLUMN cn_user TYPE varchar(150) USING cn_user::varchar;
ALTER TABLE s_mt.t_page_variable ALTER COLUMN cn_user TYPE varchar(150) USING cn_user::varchar;
ALTER TABLE s_mt.t_step ALTER COLUMN cn_user TYPE varchar(150) USING cn_user::varchar;
ALTER TABLE s_mt.t_class_attr ALTER COLUMN cn_user TYPE varchar(150) USING cn_user::varchar;
ALTER TABLE s_mt.t_object_attr ALTER COLUMN cn_user TYPE varchar(150) USING cn_user::varchar;
ALTER TABLE s_mt.t_page_object_attr ALTER COLUMN cn_user TYPE varchar(150) USING cn_user::varchar;
ALTER TABLE s_mt.t_attr ALTER COLUMN cn_user TYPE varchar(150) USING cn_user::varchar;
ALTER TABLE s_mt.t_class ALTER COLUMN cn_user TYPE varchar(150) USING cn_user::varchar;
ALTER TABLE s_mt.t_class_hierarchy ALTER COLUMN cn_user TYPE varchar(150) USING cn_user::varchar;
ALTER TABLE s_mt.t_module ALTER COLUMN cn_user TYPE varchar(150) USING cn_user::varchar;
ALTER TABLE s_mt.t_object ALTER COLUMN cn_user TYPE varchar(150) USING cn_user::varchar;
ALTER TABLE s_mt.t_page ALTER COLUMN cn_user TYPE varchar(150) USING cn_user::varchar;
ALTER TABLE s_mt.t_page_object ALTER COLUMN cn_user TYPE varchar(150) USING cn_user::varchar;
ALTER TABLE s_mt.t_provider ALTER COLUMN cn_user TYPE varchar(150) USING cn_user::varchar;
ALTER TABLE s_mt.t_sys_setting ALTER COLUMN cn_user TYPE varchar(150) USING cn_user::varchar;
ALTER TABLE s_mt.t_action ALTER COLUMN cn_user TYPE varchar(150) USING cn_user::varchar;
ALTER TABLE s_mt.t_scenario ALTER COLUMN cn_user TYPE varchar(150) USING cn_user::varchar;
ALTER TABLE s_mt.t_attr_type ALTER COLUMN cn_user TYPE varchar(150) USING cn_user::varchar;
ALTER TABLE s_mt.t_icon ALTER COLUMN cn_user TYPE varchar(150) USING cn_user::varchar;
ALTER TABLE s_mt.t_log ALTER COLUMN cn_user TYPE varchar(150) USING cn_user::varchar;
ALTER TABLE s_mt.t_message ALTER COLUMN cn_user TYPE varchar(150) USING cn_user::varchar;
ALTER TABLE s_mt.t_page_action ALTER COLUMN cn_user TYPE varchar(150) USING cn_user::varchar;

--changeset artemov_i:CORE-21 dbms:postgresql
ALTER TABLE s_mt.t_dynamic_report RENAME cn_user TO ck_user; 
ALTER TABLE s_mt.t_page_variable RENAME cn_user TO ck_user; 
ALTER TABLE s_mt.t_step RENAME cn_user TO ck_user; 
ALTER TABLE s_mt.t_class_attr RENAME cn_user TO ck_user; 
ALTER TABLE s_mt.t_object_attr RENAME cn_user TO ck_user; 
ALTER TABLE s_mt.t_page_object_attr RENAME cn_user TO ck_user; 
ALTER TABLE s_mt.t_attr RENAME cn_user TO ck_user; 
ALTER TABLE s_mt.t_class RENAME cn_user TO ck_user; 
ALTER TABLE s_mt.t_class_hierarchy RENAME cn_user TO ck_user; 
ALTER TABLE s_mt.t_module RENAME cn_user TO ck_user; 
ALTER TABLE s_mt.t_object RENAME cn_user TO ck_user; 
ALTER TABLE s_mt.t_page RENAME cn_user TO ck_user; 
ALTER TABLE s_mt.t_page_object RENAME cn_user TO ck_user; 
ALTER TABLE s_mt.t_provider RENAME cn_user TO ck_user; 
ALTER TABLE s_mt.t_sys_setting RENAME cn_user TO ck_user; 
ALTER TABLE s_mt.t_action RENAME cn_user TO ck_user; 
ALTER TABLE s_mt.t_scenario RENAME cn_user TO ck_user; 
ALTER TABLE s_mt.t_attr_type RENAME cn_user TO ck_user; 
ALTER TABLE s_mt.t_icon RENAME cn_user TO ck_user; 
ALTER TABLE s_mt.t_log RENAME cn_user TO ck_user; 
ALTER TABLE s_mt.t_message RENAME cn_user TO ck_user; 
ALTER TABLE s_mt.t_page_action RENAME cn_user TO ck_user; 
ALTER TABLE s_mt.t_query RENAME cn_user TO ck_user;

--changeset artemov_i:CORE-107 dbms:postgresql
COMMENT ON COLUMN s_mt.t_dynamic_report.ck_query IS 'Идентификатор';
COMMENT ON COLUMN s_mt.t_dynamic_report.ck_page IS 'Идентификатор страницы параметров';
COMMENT ON COLUMN s_mt.t_dynamic_report.ck_user IS 'Индетификатор пользователя аудит';
COMMENT ON COLUMN s_mt.t_dynamic_report.ct_change IS 'Время модификации';
ALTER TABLE s_mt.t_dynamic_report ALTER COLUMN ck_query TYPE varchar(255) USING ck_query::varchar;
ALTER TABLE s_mt.t_dynamic_report ALTER COLUMN ck_page TYPE varchar(32) USING ck_page::varchar;

--changeset artemov_i:CORE-206 dbms:postgresql
ALTER TABLE s_mt.t_module ADD cc_config text NOT NULL DEFAULT '{}'::varchar;
COMMENT ON COLUMN s_mt.t_module.cc_config IS 'Файл описания модуля';
ALTER TABLE s_mt.t_module ALTER COLUMN cc_manifest SET NOT NULL;
ALTER TABLE s_mt.t_module ALTER COLUMN ck_class SET NOT NULL;
ALTER TABLE s_mt.t_module ADD cv_version_api varchar(100) NOT NULL DEFAULT ''::varchar;
COMMENT ON COLUMN s_mt.t_module.cv_version_api IS 'Версия апи';
ALTER TABLE s_mt.t_module ALTER COLUMN cv_version TYPE varchar(100) USING cv_version::varchar;

--changeset artemov_i:CORE-206_1 dbms:postgresql
CREATE TABLE s_mt.t_module_class (
	ck_id varchar(32) NOT NULL DEFAULT public.sys_guid(),
	ck_module varchar(32) NOT NULL,
	ck_class varchar(32) NOT NULL,
	ck_user varchar(150) NOT NULL,
	ct_change timestamptz NOT NULL,
	CONSTRAINT cin_p_module_class PRIMARY KEY (ck_id),
	CONSTRAINT cin_u_module_class_1 UNIQUE (ck_module,ck_class)
);
ALTER TABLE s_mt.t_module_class ADD CONSTRAINT cin_r_module_class_1 FOREIGN KEY (ck_module) REFERENCES s_mt.t_module(ck_id);
ALTER TABLE s_mt.t_module_class ADD CONSTRAINT cin_r_module_class_2 FOREIGN KEY (ck_class) REFERENCES s_mt.t_class(ck_id);

COMMENT ON TABLE s_mt.t_module_class IS 'Связь модулей с классами';

COMMENT ON COLUMN s_mt.t_module_class.ck_id IS 'Идентификатор';
COMMENT ON COLUMN s_mt.t_module_class.ck_module IS 'Идентификатор модуля';
COMMENT ON COLUMN s_mt.t_module_class.ck_class IS 'Идентификатор класса';
COMMENT ON COLUMN s_mt.t_module_class.ck_user IS 'Идентификатор юзера аудит';
COMMENT ON COLUMN s_mt.t_module_class.ct_change IS 'Время модификации';

insert into s_mt.t_module_class (ck_module, ck_class, ck_user, ct_change)
select ck_id as ck_module, ck_class, ck_user, ct_change from s_mt.t_module;

ALTER TABLE s_mt.t_module DROP COLUMN ck_class;

INSERT INTO s_mt.t_sys_setting (ck_id,cv_value,ck_user,ct_change,cv_description)
	VALUES ('module_url','/api_module','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-09-14 23:54:25.693','Контекст получения модулей');

--changeset kutsenko:CORE-1249 dbms:postgresql
UPDATE s_mt.t_sys_setting SET ck_id='g_sys_module_url' WHERE ck_id='module_url';

--changeset kutsenko:CORE-1267 dbms:postgresql
INSERT INTO s_mt.t_sys_setting (ck_id,cv_value,ck_user,ct_change,cv_description)
	VALUES ('g_sys_gate_url','/api','-11','2019-10-11 13:10:31.709','URL шлюза');

--changeset kutsenko:CORE-1267-v2 dbms:postgresql
INSERT INTO s_mt.t_sys_setting (ck_id,cv_value,ck_user,ct_change,cv_description)
	VALUES ('project_applications_page','22D2F53FE7E24680917B85D9A95237BD','-11','2019-10-15 13:10:31.709','ИД страниицы-приложений');

--changeset artemov_i:CORE-438 dbms:postgresql
INSERT INTO s_mt.t_sys_setting (ck_id,cv_value,ck_user,ct_change,cv_description)
	VALUES ('g_sys_theme','light','-11','2019-10-15 13:10:31.709','Тема по умолчанию');

--changeset kutsenko:CORE-1304 dbms:postgresql
UPDATE s_mt.t_object_attr SET cv_value = '##first##'  where ck_class_attr in (select ck_id from s_mt.t_class_attr where ck_attr = 'defaultvalue') AND cv_value = 'first';
UPDATE s_mt.t_page_object_attr SET cv_value = '##first##' where ck_class_attr in (select ck_id from s_mt.t_class_attr where ck_attr = 'defaultvalue') AND cv_value = 'first';

UPDATE s_mt.t_object_attr SET cv_value = '##alwaysfirst##' where ck_class_attr in (select ck_id from s_mt.t_class_attr where ck_attr = 'defaultvalue') AND cv_value = 'alwaysfirst';
UPDATE s_mt.t_page_object_attr SET cv_value = '##alwaysfirst##' where ck_class_attr in (select ck_id from s_mt.t_class_attr where ck_attr = 'defaultvalue') AND cv_value = 'alwaysfirst';

UPDATE s_mt.t_object_attr SET cv_value = 'new:' where ck_class_attr in (select ck_id from s_mt.t_class_attr where ck_attr = 'allownew') AND nullif(trim(cv_value), '') is not null;
UPDATE s_mt.t_page_object_attr SET cv_value = 'new:' where ck_class_attr in (select ck_id from s_mt.t_class_attr where ck_attr = 'allownew') AND nullif(trim(cv_value), '') is not null;

--changeset kutsenko:CORE-1254 dbms:postgresql
INSERT INTO s_mt.t_attr SELECT 'visibleinwindow' ck_id, cv_description, ck_attr_type, ck_user, ct_change from s_mt.t_attr where ck_id = 'visibileinwindow';
UPDATE s_mt.t_class_attr SET ck_attr = 'visibleinwindow' where ck_attr = 'visibileinwindow';
DELETE FROM s_mt.t_attr where ck_id = 'visibileinwindow';

--changeset artemov_i:CORE-429 dbms:postgresql
CREATE TABLE s_mt.t_d_lang (
	ck_id varchar(10) NOT NULL,
	cv_name varchar(100) NOT NULL,
	cl_default smallint NOT NULL DEFAULT 0,
	CONSTRAINT cin_p_d_lang PRIMARY KEY (ck_id)
);
COMMENT ON TABLE s_mt.t_d_lang IS 'Список языков';

-- Column comments

COMMENT ON COLUMN s_mt.t_d_lang.ck_id IS 'Идентификатор';
COMMENT ON COLUMN s_mt.t_d_lang.cv_name IS 'Наименование';
COMMENT ON COLUMN s_mt.t_d_lang.cl_default IS 'Признак основного язык';

CREATE TABLE s_mt.t_localization (
	ck_id varchar(32) NOT NULL,
	ck_d_lang varchar(10) NOT NULL,
	сr_namespace varchar(50) NOT NULL,
	cv_value text NOT NULL,
	CONSTRAINT cin_u_localization_1 UNIQUE (ck_id,ck_d_lang),
	CONSTRAINT cin_c_localization_2 CHECK (сr_namespace in ('meta','message')),
	CONSTRAINT cin_f_localization_3 FOREIGN KEY (ck_d_lang) REFERENCES s_mt.t_d_lang(ck_id) ON DELETE RESTRICT ON UPDATE RESTRICT
);
COMMENT ON TABLE s_mt.t_localization IS 'Таблица локализации';

-- Column comments

COMMENT ON COLUMN s_mt.t_localization.ck_id IS 'Идентификатор';
COMMENT ON COLUMN s_mt.t_localization.ck_d_lang IS 'Код языка';
COMMENT ON COLUMN s_mt.t_localization.сr_namespace IS 'Место использования';
COMMENT ON COLUMN s_mt.t_localization.cv_value IS 'Перевод';

insert into s_mt.t_d_lang (ck_id, cv_name, cl_default) VALUES ('ru_RU', 'Русский (Россия)', 1);

--changeset kutsenko:CORE-1278 dbms:postgresql
INSERT INTO s_mt.t_attr SELECT 'splitter' ck_id, cv_description, ck_attr_type, ck_user, ct_change from s_mt.t_attr where ck_id = 'spliter';
UPDATE s_mt.t_class_attr SET ck_attr = 'splitter' where ck_attr = 'spliter';
DELETE FROM s_mt.t_attr where ck_id = 'spliter';

--changeset artemov_i:CORE-429_2 dbms:postgresql
ALTER TABLE s_mt.t_d_lang ADD ck_user varchar(100) NULL;
COMMENT ON COLUMN s_mt.t_d_lang.ck_user IS 'Аудит идентификатор пользователя';
ALTER TABLE s_mt.t_d_lang ADD ct_change timestamptz NULL;
COMMENT ON COLUMN s_mt.t_d_lang.ct_change IS 'Аудит время модификации';
ALTER TABLE s_mt.t_localization ADD ck_user varchar(100) NOT NULL;
COMMENT ON COLUMN s_mt.t_localization.ck_user IS 'Аудит идентификатор пользователя';
ALTER TABLE s_mt.t_localization ADD ct_change timestamptz NOT NULL;
COMMENT ON COLUMN s_mt.t_localization.ct_change IS 'Аудит время модификации';
UPDATE s_mt.t_d_lang
	set ck_user = '4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change = CURRENT_TIMESTAMP;
UPDATE s_mt.t_localization
	set ck_user = '4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change = CURRENT_TIMESTAMP;
ALTER TABLE s_mt.t_d_lang ALTER COLUMN ck_user SET NOT NULL;
ALTER TABLE s_mt.t_d_lang ALTER COLUMN ct_change SET NOT NULL;
ALTER TABLE s_mt.t_localization ALTER COLUMN ck_user SET NOT NULL;
ALTER TABLE s_mt.t_localization ALTER COLUMN ct_change SET NOT NULL;

--changeset artemov_i:CORE-429_3 dbms:postgresql
ALTER TABLE s_mt.t_localization RENAME сr_namespace TO cr_namespace;

--changeset artemov_i:CORE-431 dbms:postgresql
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,ck_user,ct_change)
VALUES (74,'error','Запрещено удалять, язык по умолчанию','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-12 10:47:00.000');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,ck_user,ct_change)
VALUES (75,'warning','Будут удалены все переводы данного языка','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-12 10:47:00.000');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,ck_user,ct_change)
VALUES (76,'warning','Будут удалены все переводы данного слова/фразы','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-12 10:47:00.000');

--changeset artemov_i:fix-notification dbms:postgresql
ALTER TABLE s_mt.t_notification ALTER COLUMN ck_user TYPE varchar(100) USING ck_user::varchar;

--changeset artemov_i:CORE-401 dbms:postgresql
CREATE UNIQUE INDEX cin_i_page_2 ON s_mt.t_page (cv_url);
--rollback DROP INDEX s_mt.cin_i_page_2;

--changeset artemov_i:CORE-427 dbms:postgresql
ALTER TABLE s_mt.t_page_variable ADD cv_value varchar(200) NULL;
COMMENT ON COLUMN s_mt.t_page_variable.cv_value IS 'Значени при инициализации';

--changeset artemov_i:CORE-363 dbms:postgresql
ALTER TABLE s_mt.t_notification DROP COLUMN cv_param;
--rollback ALTER TABLE s_mt.t_notification ADD cv_param varchar(4000) NULL;

--changeset artemov_i:CORE-494 dbms:postgresql
INSERT INTO s_mt.t_sys_setting (ck_id,cv_value,ck_user,ct_change,cv_description)
	VALUES ('g_sys_lang','ru_RU','-11','2019-10-15 13:10:31.709','Язык по умолчанию');

--changeset artemov_i:CORE-494-localization dbms:postgresql splitStatements:false stripComments:false
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('dacf7ab025c344cb81b700cfcc50e403','ru_RU','meta','Да','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-12 19:00:24.442');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('f0e9877df106481eb257c2c04f8eb039','ru_RU','meta','Нет','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-14 21:22:10.312');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('5a33b10058114ae7876067447fde8242','ru_RU','meta','Продолжить?','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 13:06:38.134');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('937e99f97aea414f97f501e3b8a0b843','ru_RU','meta','Печать','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 13:18:34.541');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('64aacc431c4c4640b5f2c45def57cae9','ru_RU','meta','Отмена','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 13:18:56.415');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('662d857575ed4a26bca536b18fbac6ff','ru_RU','meta','Hаименование файла','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 13:19:25.168');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('7578080854a84cc3b4faad62d4499a4b','ru_RU','meta','Печать в excel','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 13:19:55.869');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('d78431bbcb484da4b516bc00626965ba','ru_RU','meta','Добавить все','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 13:23:54.780');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('833289fd818f4340b584beb9068f670b','ru_RU','meta','Добавить выделенное','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 13:24:12.810');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('67677d8e457c409daaef5fe5b90ec491','ru_RU','meta','Удалить выделенное','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 13:24:33.842');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('c4684efb2ea444f4b9192db3c4b4b843','ru_RU','meta','Удалить все','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 13:24:53.715');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('76dd4f170842474d9776fe712e48d8e6','ru_RU','meta','Развернуть фильтры','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 13:29:44.094');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('72b93dbe37884153a95363420b9ceb59','ru_RU','meta','Скрыть фильтры','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 13:30:04.724');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('cda88d85fb7e4a88932dc232d7604bfb','ru_RU','meta','Очистить','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 13:30:26.871');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('704af666dbd3465781149e4282df5dcf','ru_RU','meta','Поиск','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 13:30:50.219');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('6aa4a0027b7e41309787b086de051536','ru_RU','meta','Дата с','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 13:41:21.377');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('f806e79ffa3342ff81b150ce2279099f','ru_RU','meta','Дата по','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 13:41:37.168');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('e001f50e66034472a486099ea5f96218','ru_RU','meta','Точная дата','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 13:41:50.636');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('102972d8258947b7b3cf2b70b258278a','ru_RU','meta','Настройки пользователя','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 13:42:24.549');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('8a930c6b5dd440429c0f0e867ce98316','ru_RU','meta','Сохранить','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 13:44:17.777');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('3d27a32643ed4a7aa52b7e4b8a36806b','ru_RU','meta','Отменить','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 13:45:13.588');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('223dbd23bba54e4c91f59ef4cdea8ffa','ru_RU','meta','Колонка с типом','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 13:46:06.715');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('017af47503474ec58542b9db53bdeeff','ru_RU','meta','Показать/скрыть колонки','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 13:46:55.899');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('20732b2df62f4dd5baf97d12cf2a3e9c','ru_RU','meta','Отображение Истории','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 13:47:57.198');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('d0e89e0caa6c476e87fb9564ca0d45ac','ru_RU','meta','Населенный пункт','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 13:56:57.196');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('dd72982c8ecd46e094823c088e2aa91e','ru_RU','meta','Регион','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 13:57:11.300');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('efdf47b812344d3aaa5228520f04a04e','ru_RU','meta','Улица','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 13:57:31.648');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('c215efe4c3254c9690a5d0744c0a89b4','ru_RU','meta','Дом','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 13:57:57.590');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('6a4c7f4488164e7e8fabd46e0cc01ccc','ru_RU','meta','Добавление документа','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 13:58:35.100');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('3a5239ee97d9464c9c4143c18fda9815','ru_RU','meta','Добавить','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 13:58:54.286');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('a1ff62833ba8490fb626baa1ddf0f0f7','ru_RU','meta','Кнопка добавления документа','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 13:59:13.344');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('0e55e1e9994c44f7978f3b76f5bd819f','ru_RU','meta','Добавить файл','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 13:59:33.217');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('9b475e25ae8a40b0b158543b84ba8c08','ru_RU','meta','Отменить?','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 13:59:59.298');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('02260da507494f2f9956ba9e0f37b1f1','ru_RU','meta','Загрузить','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 14:00:42.107');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('f7e324760ede4c88b4f11f0af26c9e97','ru_RU','meta','Удалить','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 14:01:24.295');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('0cd0fc9bff2641f68f0f9712395f7b82','ru_RU','meta','Удалить?','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 14:01:59.153');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('627518f4034947aa9989507c5688cfff','ru_RU','meta','Информация','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 14:02:15.173');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('33c9b02a9140428d9747299b9a767abb','ru_RU','meta','Обновить','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 14:02:35.992');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('54e15e2eec334f3c839a64cde73c2dcb','ru_RU','meta','Клонировать','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 14:13:44.047');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('deb1b07ddddf43c386682b20504fea0d','ru_RU','meta','Редактировать','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 14:15:21.398');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('d529fbf32aae4b85b9971fca87b4e409','ru_RU','meta','Предыдущая запись','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 14:15:46.967');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('e00978fb845249fdbdf003cd0aa2898e','ru_RU','meta','Следующая запись','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 14:16:02.669');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('1dabbff97463462f9776c1c62160c0ed','ru_RU','meta','Наименование объекта обслуживания','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 14:18:28.313');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('85c19e316e9e446d9383a9ffe184d19a','ru_RU','meta','Назад','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 14:22:45.973');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('dcfd5234c348410994c690eec7d28028','ru_RU','meta','Далее','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 14:23:02.791');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('147bb56012624451971b35b1a4ef55e6','ru_RU','meta','Выбрать','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 14:24:03.180');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('a5a5d7213d1f4f77861ed40549ee9c57','ru_RU','meta','Поля должны быть заполнены в требуемом количестве','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 14:35:50.274');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('ba416597affb4e3a91b1be3f8e0c8960','ru_RU','meta','Добавить ещё','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 14:46:08.782');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('b0c16afd6507416196e01223630f9d62','ru_RU','meta','Очистить все','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 15:01:40.668');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('bfecce4e8b9844afab513efa5ea53353','ru_RU','meta','Все','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 15:05:41.492');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('7185a3b731b14e1ea8fb86056b571fe5','ru_RU','meta','Ошибки','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 15:06:12.123');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('10666aec26534e179b22f681700f22b7','ru_RU','meta','Предупреждения','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 15:06:25.690');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('880a932500234fa2b2f22a4b36bd6cd8','ru_RU','meta','Оповещения','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 15:06:41.581');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('1650aebec6b348f094680ba725441ef0','ru_RU','meta','Разработка','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 15:06:59.611');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('f42e28fe1287412fa6ec91b421377139','ru_RU','meta','Прочитать все','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 15:08:20.514');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('73de7f460cc04bc8a068429d66e684ce','ru_RU','meta','Неуспешно','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 15:12:30.039');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('ad39828554114893872302a0aaa031af','ru_RU','meta','Загрузка','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 15:12:44.764');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('5454b0c6f64b41daab8deb88f948a4f1','ru_RU','meta','Успешно','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 15:13:01.907');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('74776ef247274a55a2a76f7df34ffe41','ru_RU','meta','Закрыть вкладку','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 15:21:41.571');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('63b54227225e4ea5a2ba644eced838ec','ru_RU','meta','Закрыть другие вкладки','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 15:22:11.329');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('bceed776538747b9a0c88d4f73b70711','ru_RU','meta','Закрыть вкладки справа','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 15:22:44.209');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('a0cb66a96d8740a19397ece02d537f86','ru_RU','meta','Закрыть все вкладки','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 15:23:02.551');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('0b5e4673fa194e16a0c411ff471d21d2','ru_RU','meta','Тема','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 15:36:06.908');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('66ef0068472a4a0394710177f828a9b1','ru_RU','meta','Темная тема','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 15:36:26.395');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('fd7c7f3539954cc8a55876e3514906b5','ru_RU','meta','Светлая тема','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 15:37:11.390');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('d7d40d765f0840beb7f0db2b9298ac0c','ru_RU','meta','c','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 18:52:43.682');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('acc7f22ccbc6407bb253f8c47a684c45','ru_RU','meta','по','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 18:53:22.916');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('b03cbbb047ca438f920c799c5f48ecaf','ru_RU','meta','Сбросить все данные?','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 20:04:31.804');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('e3e33760864d44f88a9ecfe8f5da7a0b','ru_RU','meta','Корневой каталог','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 20:12:21.071');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('31b05bf92be1431894c448c4c3ef95bb','ru_RU','meta','Загрузка файла завершена','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 20:16:29.398');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('aff0422be07246fb844794e2329fc578','ru_RU','meta','Сохранение файла...','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 20:16:58.368');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('c80abfb5b59c400ca1f8f9e868e4c761','ru_RU','meta','Ошибка','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 20:17:36.737');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('b711be91555b46bab25971b7da959653','ru_RU','meta','Удалить файл','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 20:21:41.903');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('1f560294a2a446c4a23fb3f9d7f94dc6','ru_RU','meta','от','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 20:22:44.137');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('e668fef0db6d4eeb9eb72c62a8d31052','ru_RU','meta','Максимальная длина этого поля :maxsize','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 20:25:00.489');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('58b71773e7664e70874020a45705bc4c','ru_RU','meta','Значение этого поля не может быть больше :maxvalue','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 20:25:22.763');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('31d96e87a5514f509c75bc701b772504','ru_RU','meta','Значение этого поля не может быть меньше :minvalue','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 20:26:01.755');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('58c125b1b34f445c9ae5640ff3122e03','ru_RU','meta','Обязателен для заполнения','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 20:26:25.277');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('f488a90cb69e4567a092325fecffb1ed','ru_RU','meta','Неверный формат поля :attribute.','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 20:27:02.394');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('4f5060a1dc7c4f5ca76a606b4977f868','ru_RU','meta','Дата "по" не может быть меньше даты "с"','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 20:27:25.890');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('93e0035fa0684768839021399baed028','ru_RU','meta','Дата "с" не может быть больше даты "по"','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 20:27:58.031');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('a51733f718974db891606a516a906d4a','ru_RU','meta','Изменен','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 20:31:33.253');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('359b72856d284d1baf5ff9e14e8293c9','ru_RU','meta','Пользователь','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 20:32:35.350');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('23264e86a9cd446f83cee0eb86c20bd9','ru_RU','meta','Первая страница','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 20:34:51.119');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('267e96bb282843abaa25b3e78bd874f1','ru_RU','meta','Предыдущая страница','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 20:35:37.881');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('d4d9e481a0e14bbd9e1e76537e8cbfd0','ru_RU','meta','Следующая страница','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 20:36:03.007');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('d0f0a046dee344d1b5bbbadcd8d848db','ru_RU','meta','Последняя страница','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 20:36:27.227');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('63538aa4bcd748349defdf7510fc9c10','ru_RU','meta','Ошибка в разпознавании данных','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 20:42:52.928');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('7d9d6e64612643cfa6bb568cd3bde543','ru_RU','meta','Превышен максимальный допустимый размер для загружаемого файла. Разрешены файлы размером не более','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 20:46:26.402');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('5d4e96bd15bb429195f2bbef3e0ff126','ru_RU','meta','Данный формат файлов не поддерживается. Разрешены форматы:','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 20:48:09.628');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('bc377ecb59164cc4915c669130e298ef','ru_RU','meta','байт','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 20:49:24.044');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('05eab6e983464c5f8708045bd5131ebe','ru_RU','meta','тб','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 20:52:32.062');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('8d7f133d5ef04c4485748e38635fe9eb','ru_RU','meta','гб','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 20:53:03.071');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('58f3245889924db1b023691819f34607','ru_RU','meta','мб','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 20:54:30.475');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('82c9683d5aa7483aadc6b0b21f3dd174','ru_RU','meta','кб','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 20:54:48.052');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('dcfb61366b054c6e95ae83593cfb9cd9','ru_RU','meta','Глобальные переменные для','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 20:57:06.800');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('e28e56d7b12e4ea2b7663b3e66473b9e','ru_RU','meta','Выбрана','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 21:00:27.869');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('783922ac8cf84a5eac8d1b17c77de544','ru_RU','meta','Выбрано','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 21:01:02.407');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('0cd9a67ed46d4d70959182cc6260b221','ru_RU','meta','запись','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 21:01:24.090');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('87acd17f8ae243798e97549a5761cfaf','ru_RU','meta','записи','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 21:02:00.241');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('2485088fda3d4d9cb5de9c25534cdf23','ru_RU','meta','записей','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 21:02:38.835');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('e077e7f97f954e85905a8e754511e441','ru_RU','meta','Инициазилация с','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 21:09:20.382');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('9207ff3b431a4dc58f16a28d2aae0ea8','ru_RU','meta','Выполнение','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 21:09:45.062');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('6029c25920ff4f79b9b52d664322b3d9','ru_RU','meta','Исходный код','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 21:10:23.407');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('a363461339754846881b1f84b6706851','ru_RU','meta','Переменные','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 21:10:47.322');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('a326c00cf6b54d7ebdc358e283383ccb','ru_RU','meta','Значение для','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 21:11:22.661');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('b4458be782404651a4cfcad47d2ae17a','ru_RU','meta','Результат','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 21:12:06.533');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('c816bc224d6e4ae5b60d9c7dd2e6b612','ru_RU','meta','Тип данных в результате','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 21:12:36.019');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('773ed9a089214ab9b0bd149be5685ba0','ru_RU','meta','Формат даты: ''гггг''','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 21:14:23.551');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('271b81793a72461192644b7f4578ac51','ru_RU','meta','не является правильной датой - дата должна быть указана в формате ''гггг''','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 21:14:54.864');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('3c205218305a4a25bada37004775789c','ru_RU','meta',':inputValue не является правильной датой - дата должна быть указана в формате ''гггг''','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 21:15:30.945');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('02983497059143b9b97cc0e7d0c4691d','ru_RU','meta','Формат даты: ''ммм гггг''','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 21:16:15.576');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('a40a4372823f44ffa7a69e699b0b15db','ru_RU','meta','не является правильной датой - дата должна быть указана в формате ''ммм гггг''','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 21:16:41.456');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('6b6305d16db148d986e782a66c4318da','ru_RU','meta',':inputValue не является правильной датой - дата должна быть указана в формате ''ммм гггг''','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 21:17:37.022');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('acfdddfef80c4e5c90a3052e286d7919','ru_RU','meta','Формат даты: ''дд.мм.гггг''','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 21:18:14.216');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('f0f42f35a2d241f3b51cd16747c37186','ru_RU','meta','не является правильной датой - дата должна быть указана в формате ''дд.мм.гггг''','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 21:18:35.109');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('77050515e7b2462e95429b9df33a7958','ru_RU','meta',':inputValue не является правильной датой - дата должна быть указана в формате ''дд.мм.гггг''','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 21:19:17.581');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('149c3a8684224bc2939e613271f5c704','ru_RU','meta','Формат даты: ''дд.мм.гггг чч:00''','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 21:19:52.648');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('ce35e3e6067d4343af8b30ea38d01f96','ru_RU','meta','не является правильной датой - дата должна быть указана в формате ''дд.мм.гггг чч:00''','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 21:20:32.478');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('1583ea7e4b054c759818771219303c3c','ru_RU','meta',':inputValue не является правильной датой - дата должна быть указана в формате ''дд.мм.гггг чч:00''','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 21:21:06.399');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('6b5f29158ba142c3963649e1219a8f1e','ru_RU','meta','Формат даты: ''дд.мм.гггг чч:ми''','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 21:21:32.428');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('c43175882dda4f7abce9bb7325cd8847','ru_RU','meta','не является правильной датой - дата должна быть указана в формате ''дд.мм.гггг чч:ми''','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 21:22:11.033');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('a1fadf8d7e73453b8a1ed526f3d1103e','ru_RU','meta',':inputValue не является правильной датой - дата должна быть указана в формате ''дд.мм.гггг чч:ми''','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 21:22:44.853');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('52f802c6dab84eacbb4e6068aedcaa77','ru_RU','meta','Формат даты: ''дд.мм.гггг чч:ми:сс''','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 21:23:26.919');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('6b95585ef5f442e6922459c81db7c1f3','ru_RU','meta','не является правильной датой - дата должна быть указана в формате ''дд.мм.гггг чч:ми:сс''','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 21:23:49.486');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('5f09f8f54f174ecfb6befd64ca4c3423','ru_RU','meta',':inputValue не является правильной датой - дата должна быть указана в формате ''дд.мм.гггг чч:ми:сс''','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 21:24:44.183');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('157badbc579e439d8cae1d60ceff9aa9','ru_RU','meta','Изображение','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 21:28:15.957');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('4a401209683245609626506a762717af','ru_RU','meta','Загрузить','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 21:29:14.749');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('aa75a46ca0a44a6a8a16ffa1357ec313','ru_RU','meta','Добавление','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 21:34:56.756');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('7437988e948f4962abba9656e4988adc','ru_RU','meta','Клонирование','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 21:35:32.757');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('8059806cc90c4ba4be7fa5ae15d5e64b','ru_RU','meta','Редактирование','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 21:35:55.082');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('ec238e2ccc1842d780b140a4bbedfdaf','ru_RU','meta','Подтверждение','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 21:40:22.726');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('b9c874da6b0e4694b93db69088a556da','ru_RU','meta','Невозможно загрузить модули','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 21:46:58.721');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('02f274362cf847cba8d806687d237698','ru_RU','meta','Модули','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 21:47:20.709');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('d2c071c58aca4b73853c1fcc6e2f08a3','ru_RU','meta','Супер Глобальные переменные','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 21:55:02.415');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('900d174d0a994374a01b0005756521bc','ru_RU','meta','Описание','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 21:57:48.828');
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('67aefce5785a4326920bef69acb5a403','ru_RU','meta','Код ошибки','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-11-15 21:58:18.748');