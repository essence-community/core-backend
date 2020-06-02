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

--changeset kutsenko:CORE-1395 dbms:postgresql
-- DELETE FROM "s_mt"."t_localization" where ck_id in ('2ff612aa52314ddea65a5d303c867eb8','bcdc7e54547e405c9873b3ebea4f84c4','4b4ef9aed688462799f24efe8413da9f','cad7307902954c1b92b626e42da53aa3','4fdb2cdb2e5047048da10f9dbe83188d','cecc548fc7444813a3d00eb7bb067a3f','d22b1f7a48b9402e9c0c17b508c5a906','179cc83540e94b87a8d8aff919552f22','e6f8166771e04b849855254c5d926ff6','06dfd0c3b97b45e5abc146a14c0fab37','44e3485c6b0c47dc8a0792c90af62962','23cd49d589b74476acaa0b347b207d00','1d5ca35298f346cab823812e2b57e15a','5bf781f61f9c44b8b23c76aec75e5d10','b5a60b8ff5cd419ebe487a68215f4490','993c801f7f8b4284b3b1a0f624496ac8','4b067f4b55154c46b0a8d6b34d4d9bfb','b621b9209813416dba9d5c12ccc93fdf','27a9d844da20453195f59f75185d7c99','7ef1547ac7084e178bf1447361e3ccc3','0d43efb6fc3546bbba80c8ac24ab3031','4fdb3577f24440ceb8c717adf68bac48','515a199e09914e3287afd9c95938f3a7','2d209550310a4fae90389134a5b12353','83490c56debb4a399f05518608e3bace','5c3108d6508a4141bdca1e52881e196d','3dd42493c346447897d017af3668d998','5327513a9d344e2184cca94cde783a52','8fe6e023ee11462db952d62d6b8b265e','f9c3bf3691864f4d87a46a9ba367a855','d4055d1153af44a4ba5eb73ac9bc437e','d56944511bd243b1a0914ccdea58ce0d','47b7b12c1d9c413da54a08331191aded','cfac299d53f8466d9745ddfa53e09958','40dd53ff1c214bfab79ecd40612de8f5','c3513e8150484b31a4ad4227f9664e7f','b6c8c1519907418caad7f647068d1fb2','4cf741cfcf18478ab4ed3c3c79255a39','344bbb5fb4a84d89b93c448a5c29e1d7','58715205c88c4d60aac6bfe2c3bfa516','8004527cce454f8f83c7d739460f5822','6cf398ee03df42529323bd4ff9f584d5','d016a5a3d0964cd69fd15c6e283db77e','26686005b3584a12aeb9ca9e96e54753','8aebd9c71dda43fc8583d96f1d4d0d01','8d380b7c5e6d4fcfb9d608d69464fe2a','664bdebac78e47079bb685732899c5f6','a54bed8bf1574dc185aaf1f74aa85148','1764da1153734ec8b4fc4cf48cc78c88','e7f66e6d5b5340909ea4ded06f5a034f','b35d5fa33cb14a1db46c4f684dc14037','6f93ca102d5f488aa3082e0344486e9e','dda349a2de0049408168eb5d148442df','86d945313cbd41beb5f5068c2696bcec','6512d68884cd4848ba6129655dec51d4','0d9c5a0b816947a781f02baad2c2ce22','e8281a11d60542c684f76ffab31216aa','fad9bcdb1bf54640ab58d1781546c72c','82eafeb106eb41aaa205152471b1b7b6','9c97fa4879f144a7b571c4905fa020cc','d39cbeb8128e4f68b201b25291889dd2','a43c94932e3a48c9867ac7b39bb22e60','a376942ff8af4ec58eeb18ea5a05e772','9a381df0ef4948ebaacb05852324d036','c038518f0652435ba9914848f8693454','0852f8c548c741d39521833cd739a9f4','ad56476c04ff4d6091d5e87f5d823a9b','ef1415ca80804e149ceb5356efb2df97','8c0119ba23c74e158c5d50c83884fcb5','4ae012ef02dd4cf4a7eafb422d1db827');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('2ff612aa52314ddea65a5d303c867eb8', 'ru_RU', 'meta', 'Оповещение', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 15:08:32.643929+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('bcdc7e54547e405c9873b3ebea4f84c4', 'ru_RU', 'meta', 'Ошибка подключения к серверу оповещения, превышен лимит попыток переподключения', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 15:47:05.060527+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('4b4ef9aed688462799f24efe8413da9f', 'ru_RU', 'meta', 'Ошибка подключения к серверу оповещения', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 15:47:41.170901+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('cad7307902954c1b92b626e42da53aa3', 'ru_RU', 'meta', 'Блокировка', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 16:13:03.879902+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('4fdb2cdb2e5047048da10f9dbe83188d', 'ru_RU', 'meta', 'Отладка', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 16:14:36.568268+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('cecc548fc7444813a3d00eb7bb067a3f', 'ru_RU', 'meta', 'Ошибка загрузки', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 16:14:57.84827+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('d22b1f7a48b9402e9c0c17b508c5a906', 'ru_RU', 'meta', 'Снятие блокировки', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 16:16:03.154231+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('179cc83540e94b87a8d8aff919552f22', 'ru_RU', 'meta', 'Загружено', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 16:16:19.190664+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('e6f8166771e04b849855254c5d926ff6', 'ru_RU', 'meta', 'Предупреждение', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 16:16:30.887141+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('06dfd0c3b97b45e5abc146a14c0fab37', 'ru_RU', 'meta', 'Превышено время ожидания', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 16:19:36.964909+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('44e3485c6b0c47dc8a0792c90af62962', 'ru_RU', 'meta', 'Неизвестное количество страниц', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 16:20:39.070788+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('23cd49d589b74476acaa0b347b207d00', 'ru_RU', 'meta', 'Сервер авторизации временно недоступен', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 18:33:04.514535+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('1d5ca35298f346cab823812e2b57e15a', 'ru_RU', 'meta', 'Не удалось получить доступ к сервису', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 18:33:28.208186+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('5bf781f61f9c44b8b23c76aec75e5d10', 'ru_RU', 'meta', 'Сессия недействительна', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 18:33:48.410325+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('b5a60b8ff5cd419ebe487a68215f4490', 'ru_RU', 'meta', 'Неверные имя пользователя или пароль', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 18:34:17.042857+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('993c801f7f8b4284b3b1a0f624496ac8', 'ru_RU', 'meta', 'Ошбика при выполнении parse:', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 18:37:25.387894+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('4b067f4b55154c46b0a8d6b34d4d9bfb', 'ru_RU', 'meta', 'Ошибка парсинга', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 18:38:42.336101+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('b621b9209813416dba9d5c12ccc93fdf', 'ru_RU', 'meta', 'Ошибка запуска', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 18:39:04.785026+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('27a9d844da20453195f59f75185d7c99', 'ru_RU', 'meta', 'Ошибка при сохранении данных:', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 18:46:46.782377+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('7ef1547ac7084e178bf1447361e3ccc3', 'ru_RU', 'meta', 'Существует неудаленная store, нужно удалять ненужные сторы!.', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 18:53:53.804151+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('0d43efb6fc3546bbba80c8ac24ab3031', 'ru_RU', 'meta', 'Не могу загрузить данны. Не задан ck_query для конфига:', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 18:55:47.935536+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('4fdb3577f24440ceb8c717adf68bac48', 'ru_RU', 'meta', 'Сервис временно недоступен - {{query}}. Попробуйте выполнить операцию позднее.', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 19:02:05.663535+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('515a199e09914e3287afd9c95938f3a7', 'ru_RU', 'meta', 'Ошибка обращения к сервису {{query}}', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 19:03:23.210717+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('2d209550310a4fae90389134a5b12353', 'ru_RU', 'meta', 'Не получилось распознать ошибку. Возможно, возникла проблема с сетевым подключением', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 19:04:49.004726+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('83490c56debb4a399f05518608e3bace', 'ru_RU', 'meta', 'Не определана reloadStoreAction для {{name}}', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 20:19:57.593537+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('5c3108d6508a4141bdca1e52881e196d', 'ru_RU', 'meta', 'Не определана clearStoreAction для {{name}}', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 20:20:38.578497+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('3dd42493c346447897d017af3668d998', 'ru_RU', 'meta', '{{currentpage}} из {{pages}}', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 20:26:34.262861+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('5327513a9d344e2184cca94cde783a52', 'ru_RU', 'meta', 'Превышено время ожидаения формы.', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 20:45:30.979623+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('8fe6e023ee11462db952d62d6b8b265e', 'ru_RU', 'meta', 'Ошибка получения оповещения {{message}}', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 20:57:34.954955+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('f9c3bf3691864f4d87a46a9ba367a855', 'ru_RU', 'meta', 'Данные изменены вне формы:', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 20:58:02.791504+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('d4055d1153af44a4ba5eb73ac9bc437e', 'ru_RU', 'meta', 'Поле может работать некорректно без column, автогенерируемое значение: {{key}}', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 21:02:18.234109+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('d56944511bd243b1a0914ccdea58ce0d', 'ru_RU', 'meta', 'Поле не может быть построено: {{key}}', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 21:03:33.747219+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('47b7b12c1d9c413da54a08331191aded', 'ru_RU', 'meta', 'Ошибка:', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 21:04:22.568202+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('cfac299d53f8466d9745ddfa53e09958', 'ru_RU', 'meta', 'Информация:', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 21:05:13.926542+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('40dd53ff1c214bfab79ecd40612de8f5', 'ru_RU', 'meta', 'Необходимо заполнить orderproperty для дальнейшей работы таблицы', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 21:06:22.489723+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('c3513e8150484b31a4ad4227f9664e7f', 'ru_RU', 'meta', 'Поле может работать некорректно без ck_page_object, автогенерируемое значение: {{name}}', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 21:09:22.945713+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('b6c8c1519907418caad7f647068d1fb2', 'ru_RU', 'meta', 'Описание: {{description}}', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 21:13:22.043651+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('4cf741cfcf18478ab4ed3c3c79255a39', 'ru_RU', 'meta', 'Код ошибки: {{code}}', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 21:14:02.601628+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('344bbb5fb4a84d89b93c448a5c29e1d7', 'ru_RU', 'meta', 'Ожидание загрузки привышено {{timeout}}ms, проверьте циклиность использования глобальных переменных для сервиса {{query}}', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 21:20:47.81942+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('58715205c88c4d60aac6bfe2c3bfa516', 'ru_RU', 'meta', 'Запрос ''reloadStoreAction'' запрещен в TableFieldModel', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 21:25:15.155544+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('8004527cce454f8f83c7d739460f5822', 'ru_RU', 'meta', 'Ок', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 21:26:21.711238+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('6cf398ee03df42529323bd4ff9f584d5', 'ru_RU', 'meta', 'О программе', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 21:32:57.46811+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('d016a5a3d0964cd69fd15c6e283db77e', 'ru_RU', 'meta', 'Имя пользователя', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 21:56:27.291091+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('26686005b3584a12aeb9ca9e96e54753', 'ru_RU', 'meta', 'Версия {{BRANCH_NAME}} ({{COMMIT_ID}} от {{BRANCH_DATE_TIME}})', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 21:50:11.846311+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('8aebd9c71dda43fc8583d96f1d4d0d01', 'ru_RU', 'meta', 'Загрузка...', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 21:51:02.336924+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('8d380b7c5e6d4fcfb9d608d69464fe2a', 'ru_RU', 'meta', 'Пароль', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 21:56:53.421009+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('664bdebac78e47079bb685732899c5f6', 'ru_RU', 'meta', 'Войти', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 21:57:21.327377+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('a54bed8bf1574dc185aaf1f74aa85148', 'ru_RU', 'meta', 'Главная страница', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 21:58:04.655767+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('1764da1153734ec8b4fc4cf48cc78c88', 'ru_RU', 'meta', 'Страница не обнаружена или заполнена неверно!', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 22:05:03.595948+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('e7f66e6d5b5340909ea4ded06f5a034f', 'ru_RU', 'meta', 'Не найдена информация о фильтрации!', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 22:05:25.533006+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('b35d5fa33cb14a1db46c4f684dc14037', 'ru_RU', 'meta', 'Вы пытаетесь перейти на страницу c такими параметрами:', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 22:05:48.286738+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('6f93ca102d5f488aa3082e0344486e9e', 'ru_RU', 'meta', 'Страница: {{page}}', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 22:06:31.618177+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('dda349a2de0049408168eb5d148442df', 'ru_RU', 'meta', 'Фильтр: {{filter}}', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 22:07:03.811901+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('86d945313cbd41beb5f5068c2696bcec', 'ru_RU', 'meta', 'Параметры заданы не верно', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 22:07:40.772072+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('6512d68884cd4848ba6129655dec51d4', 'ru_RU', 'meta', 'Статус авторизации: {{status}}', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 22:08:11.139732+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('0d9c5a0b816947a781f02baad2c2ce22', 'ru_RU', 'meta', 'авторизирован', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 22:10:06.876637+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('e8281a11d60542c684f76ffab31216aa', 'ru_RU', 'meta', 'не авторизирован', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 22:10:23.636256+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('fad9bcdb1bf54640ab58d1781546c72c', 'ru_RU', 'meta', 'Продолжить', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 22:10:57.400211+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('82eafeb106eb41aaa205152471b1b7b6', 'ru_RU', 'meta', 'Войти', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 22:11:13.581695+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('9c97fa4879f144a7b571c4905fa020cc', 'ru_RU', 'meta', 'Настройки системы', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 22:12:34.889618+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('d39cbeb8128e4f68b201b25291889dd2', 'ru_RU', 'meta', 'Задержка Tooltip перед показом (delayTooltipShow)', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 22:12:50.604175+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('a43c94932e3a48c9867ac7b39bb22e60', 'ru_RU', 'meta', 'Отступ Tooltip по диагонали (offsetTooltip)', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 22:13:11.519113+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('a376942ff8af4ec58eeb18ea5a05e772', 'ru_RU', 'meta', 'Задержка Tooltip при движении (debounceTooltipTime)', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 22:13:27.118233+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('9a381df0ef4948ebaacb05852324d036', 'ru_RU', 'meta', 'Включить режим объединения ячеек таблиц в wysiwyg (wysiwygCombineFields)', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 22:13:55.376282+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('c038518f0652435ba9914848f8693454', 'ru_RU', 'meta', 'Включить режим отображения отладочного окна при передаче параметров извне (redirectDebugWindow)', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 22:14:18.030375+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('0852f8c548c741d39521833cd739a9f4', 'ru_RU', 'meta', 'Включить эксперементальный режим (experimentalUI)', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 22:14:34.791854+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('ad56476c04ff4d6091d5e87f5d823a9b', 'ru_RU', 'meta', 'Список модулей (modules)', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 22:14:58.589949+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('ef1415ca80804e149ceb5356efb2df97', 'ru_RU', 'meta', 'Сохранить', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 22:15:12.867199+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('8c0119ba23c74e158c5d50c83884fcb5', 'ru_RU', 'meta', 'Выход', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 22:23:30.398244+03');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('4ae012ef02dd4cf4a7eafb422d1db827', 'ru_RU', 'meta', 'Язык', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-18 22:25:53.736532+03');

--changeset romanyuk_a:CORE-556 dbms:postgresql
COMMENT ON COLUMN s_mt.t_page_variable.cv_value IS 'Значение при инициализации';

--changeset dudin_m:CORE-1393 dbms:postgresql 
ALTER TABLE s_mt.t_attr_type ADD cv_name varchar(100);
COMMENT ON COLUMN s_mt.t_attr_type.cv_name IS 'Наименование';
COMMENT ON COLUMN s_mt.t_attr_type.cv_description IS 'Описание';
INSERT INTO s_mt.t_attr_type (ck_id, cv_description, ck_user, ct_change, cv_name) 
        VALUES ('view', 'атрибут, влияющий на визуализацию', '-11', '2019-11-19 10:07:44.714+03', 'Отображение');
UPDATE s_mt.t_attr_type SET cv_name ='Основной' WHERE ck_id = 'basic';
UPDATE s_mt.t_attr_type SET cv_name ='Поведение' WHERE ck_id = 'behavior';
UPDATE s_mt.t_attr_type SET cv_name ='Расположение' WHERE ck_id = 'placement';
UPDATE s_mt.t_attr_type SET cv_name ='Системный' WHERE ck_id = 'system';
ALTER TABLE s_mt.t_attr_type ALTER COLUMN cv_name SET NOT NULL;

--changeset dudin_m:CORE-1394 dbms:postgresql 
INSERT INTO s_mt.t_message(ck_id, cr_type, cv_text, ck_user, ct_change)
VALUES(205, 'error', 'Объект может быть добавлен только на Страницу', '-11', '2019-11-25 19:00:00.000');

--changeset kutsenko:CORE-1397 dbms:postgresql
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('37023be03a484bd5928791eebcd47f51', 'ru_RU', 'meta', 'Отображаемое имя', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-25T10:25:13.736Z');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('3a0b8d771a0d497e8aa1c44255fa6e83', 'ru_RU', 'meta', 'Наименование', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-25T14:01:03.544Z');

--changeset kutsenko:CORE-1397-v2 dbms:postgresql
CREATE TRIGGER notify_localization_event
AFTER INSERT OR UPDATE OR DELETE ON s_mt.t_localization
  FOR EACH ROW EXECUTE PROCEDURE notify_event();

--changeset romanyuk_a:CORE-572-v2 dbms:postgresql
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('89ad8abd91d54514b23520186b551190', 'ru_RU', 'meta', 'В каких классах используется', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-29 13:39:38');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('80c7b0a9f8714587b77391263cffb324', 'ru_RU', 'meta', 'Описание класса', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-29 13:39:38');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('3989aec5860044ec80f41db907599238', 'ru_RU', 'meta', 'Наименование класса', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-29 13:39:38');
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('b6c1344216e64cfb8f3253e8f13f8cca', 'ru_RU', 'meta', 'Классы', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-29 13:39:38');
	
--changeset romanyuk_a:CORE-593 dbms:postgresql
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('6d12c16cd7fa46579477a107a53f0790', 'ru_RU', 'meta', 'Создать', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-04 13:39:38');

--changeset artemov_i:CORE-601_message dbms:postgresql
UPDATE s_mt.t_message
SET cr_type='error', cv_text='c08baa5d99974f9d9555ae44e41b18cd', ck_user='-11', ct_change='2018-02-23 23:08:10.188'
WHERE ck_id=-6;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='b8ba48c4780e45afbdcda3c5ba9917dc', ck_user='-11', ct_change='2018-02-23 23:08:10.188'
WHERE ck_id=-5;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='3c9eb848e69c4958bbbfa0b74b777c69', ck_user='-11', ct_change='2018-02-23 23:08:10.188'
WHERE ck_id=-4;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='23b215e437af4f3c90b68f1e921d0cf4', ck_user='-11', ct_change='2018-02-23 23:08:10.188'
WHERE ck_id=-3;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='43bb21440083403caf6ed4c1800036c7', ck_user='-11', ct_change='2018-02-23 23:08:10.188'
WHERE ck_id=-2;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='32f4d1c5f308404ab8911d6a5302d99e', ck_user='-11', ct_change='2018-02-23 23:08:10.188'
WHERE ck_id=-1;
UPDATE s_mt.t_message
SET cr_type='info', cv_text='3f4f82fafa954eb6a259c7fc09aa2d39', ck_user='-11', ct_change='2018-02-23 23:08:10.188'
WHERE ck_id=0;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='d6e519c7fd4045d8826bbe3f6854f3b4', ck_user='-11', ct_change='2018-02-23 23:08:10.188'
WHERE ck_id=1;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='190ab8dfb5e44944841344bff486047c', ck_user='-11', ct_change='2018-02-23 23:08:10.188'
WHERE ck_id=2;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='c81341a504004e1db56ab2a5e314ad70', ck_user='-11', ct_change='2018-02-23 23:08:10.188'
WHERE ck_id=3;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='354facd8187b49319cc609279f90015d', ck_user='-11', ct_change='2018-02-23 23:08:10.188'
WHERE ck_id=4;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='3ef425b2db2f46b4a2dd243aff188222', ck_user='-11', ct_change='2018-02-23 23:08:10.188'
WHERE ck_id=6;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='529c8cdc8fd44e2f8f53701d95b5ab15', ck_user='-11', ct_change='2018-12-09 04:30:56.463'
WHERE ck_id=7;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='1d69c258b7674891af9604f0d83732db', ck_user='-11', ct_change='2018-02-23 23:08:10.188'
WHERE ck_id=8;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='ae188172015640c69cb2c312526bb923', ck_user='-11', ct_change='2018-02-23 23:08:10.188'
WHERE ck_id=9;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='76f77a8491474e2b9e96f6f434132c0d', ck_user='-11', ct_change='2018-02-23 23:08:10.188'
WHERE ck_id=10;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='b0d82321533345b5a6a44ce6e82712ae', ck_user='-11', ct_change='2018-02-23 23:08:10.188'
WHERE ck_id=11;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='84ba870984f049cf8d6021a16e98ea36', ck_user='-11', ct_change='2019-01-05 01:19:37.501'
WHERE ck_id=12;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='b6ce7ce1fd4e4f4ca2c6ada3eb7c6737', ck_user='-11', ct_change='2018-02-23 23:08:10.188'
WHERE ck_id=13;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='95f50f78fcfe4422a1e8af47b87ecad4', ck_user='-11', ct_change='2018-02-23 23:08:10.188'
WHERE ck_id=14;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='c0ddf1fa7e2a4c799c846780fdc11159', ck_user='-11', ct_change='2018-10-19 01:13:57.903'
WHERE ck_id=17;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='151062e2b14b49aebb8fa203db9061fe', ck_user='-11', ct_change='2018-02-23 23:08:10.188'
WHERE ck_id=18;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='5e210b678a4945babef580ea78400f53', ck_user='-11', ct_change='2018-02-23 23:08:10.188'
WHERE ck_id=19;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='1968a9c78d8848fa93e92cd19ab14ef8', ck_user='-11', ct_change='2018-02-23 23:08:10.188'
WHERE ck_id=20;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='87edefcd4df14c86a368e26a73ca8dad', ck_user='-11', ct_change='2018-10-18 23:59:03.580'
WHERE ck_id=21;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='883e46a1bd8a4636bc15ba9d0f004a90', ck_user='-11', ct_change='2018-10-18 23:51:56.611'
WHERE ck_id=22;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='21a475c5c1054347a58afc786a14ce8c', ck_user='-11', ct_change='2018-02-23 23:08:10.188'
WHERE ck_id=23;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='f9139ac6cf8046d59660b7a598340916', ck_user='-11', ct_change='2018-08-02 02:56:52.662'
WHERE ck_id=24;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='3f9ddd349835436fb1fe2b98ae5fc127', ck_user='-11', ct_change='2018-02-23 23:08:10.188'
WHERE ck_id=25;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='142170e59c8a477fbd4f39d54364e54f', ck_user='-11', ct_change='2018-02-23 23:08:10.188'
WHERE ck_id=26;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='595055183ebc45148dd1e7d7e09bb883', ck_user='-11', ct_change='2018-02-23 23:08:10.188'
WHERE ck_id=27;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='0223b7f839764bd0a660131707b548ab', ck_user='-11', ct_change='2018-08-02 02:56:52.669'
WHERE ck_id=28;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='67ef5328bbf548c79cc1f526bd633bce', ck_user='-11', ct_change='2018-10-18 23:51:56.615'
WHERE ck_id=29;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='c316c0fd1ffd42038b4e70dec7a042bf', ck_user='-11', ct_change='2018-02-23 23:08:10.188'
WHERE ck_id=30;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='c1ce26a3b65c4d11ae5d24f5dc20adca', ck_user='-11', ct_change='2018-08-02 02:57:25.839'
WHERE ck_id=31;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='853b9d5413844c18aee8cabd42803d21', ck_user='-11', ct_change='2018-02-23 23:08:10.188'
WHERE ck_id=32;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='1149038ef9a44ddfaa201071635da78e', ck_user='-11', ct_change='2018-02-23 23:08:10.188'
WHERE ck_id=33;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='67469690fdda43988f81371596a9e986', ck_user='-11', ct_change='2018-02-23 23:08:10.188'
WHERE ck_id=34;
UPDATE s_mt.t_message
SET cr_type='warning', cv_text='b68af8a442914c9483f7625168f4af62', ck_user='-11', ct_change='2018-02-23 23:08:10.188'
WHERE ck_id=35;
UPDATE s_mt.t_message
SET cr_type='warning', cv_text='e7430e7601744c9f9bf3bbca045136e7', ck_user='-11', ct_change='2018-02-23 23:08:10.188'
WHERE ck_id=36;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='f7fe671ea1464d3f816745afa5a1d705', ck_user='10020788', ct_change='2018-03-18 10:03:27.525'
WHERE ck_id=37;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='7051393e9a1b4b578aa9f56c5e896c6f', ck_user='10020788', ct_change='2018-03-18 10:03:27.560'
WHERE ck_id=38;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='74343541b06c4271892782d9530783f0', ck_user='10020788', ct_change='2018-05-13 00:13:39.225'
WHERE ck_id=40;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='be7f19ac263b415e8a39c1c5c13ee875', ck_user='10020788', ct_change='2018-07-23 00:47:03.317'
WHERE ck_id=42;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='654a5824080043aa83f08c0ebf4877d3', ck_user='10020788', ct_change='2018-07-23 00:54:44.567'
WHERE ck_id=43;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='d70cf4b900eb4bdab1c96a2fa3814b37', ck_user='10020788', ct_change='2018-10-19 01:23:22.302'
WHERE ck_id=44;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='bfb1e7f940ea47ab9cd7dbb14f8d9233', ck_user='10020788', ct_change='2018-09-15 03:38:34.055'
WHERE ck_id=45;
UPDATE s_mt.t_message
SET cr_type='warning', cv_text='e1466a521dec4ec6b2caeaa09fe7daee', ck_user='10020788', ct_change='2018-08-23 23:37:07.210'
WHERE ck_id=46;
UPDATE s_mt.t_message
SET cr_type='info', cv_text='77ea166c17a34527980b1a81eab83c9d', ck_user='10020788', ct_change='2018-08-17 03:55:33.534'
WHERE ck_id=47;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='866666a811db4f9bb48ef5699643d0cd', ck_user='10020788', ct_change='2018-10-19 01:23:22.307'
WHERE ck_id=48;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='8b783d08dffd45bfaab14b03b811b0bc', ck_user='10020788', ct_change='2018-08-21 03:22:56.537'
WHERE ck_id=49;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='b3df6be1a47846ee934a39b0b14b88cb', ck_user='10020788', ct_change='2018-08-21 23:17:55.494'
WHERE ck_id=50;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='37b938509c654b729dd22166ed22e927', ck_user='10020788', ct_change='2018-08-21 23:17:55.503'
WHERE ck_id=51;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='898fadef7d9949568709fea96787da97', ck_user='10020788', ct_change='2018-09-10 02:08:59.860'
WHERE ck_id=52;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='d3e02cacc3d64a118e038ce683e69790', ck_user='10020788', ct_change='2018-11-04 06:14:55.146'
WHERE ck_id=53;
UPDATE s_mt.t_message
SET cr_type='warning', cv_text='0c744aab8307446e820d9470ef895d08', ck_user='10020788', ct_change='2019-01-07 02:11:18.047'
WHERE ck_id=54;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='280f02920fb746aeb9451fb1f2e04e7a', ck_user='10020788', ct_change='2018-12-04 04:40:35.327'
WHERE ck_id=55;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='8b5af8e2372c49f0be86cab184ee85b6', ck_user='10020788', ct_change='2019-02-08 03:25:27.309'
WHERE ck_id=56;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='97d67066d8fc4d30b12b2fc94c180510', ck_user='10020978', ct_change='2019-03-19 08:01:08.097'
WHERE ck_id=57;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='df58d09768744598bd4e9f9ec2d40c58', ck_user='10020978', ct_change='2019-03-19 08:01:25.987'
WHERE ck_id=58;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='3f210f2e7c064adea44f21027dfc42e0', ck_user='10020978', ct_change='2019-03-19 08:01:53.392'
WHERE ck_id=59;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='f381bf9194524207a87af7dfd4b14078', ck_user='10020978', ct_change='2019-03-20 01:02:32.503'
WHERE ck_id=60;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='696dbf4b6c69438dbdefe731e9276d86', ck_user='10020978', ct_change='2019-03-20 01:29:00.125'
WHERE ck_id=61;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='aadfb629a260451c9bdd9ab451de8a96', ck_user='10020978', ct_change='2019-03-20 02:13:03.289'
WHERE ck_id=62;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='776f32915eae408ca861964d7d5903bf', ck_user='10020978', ct_change='2019-03-20 05:39:32.697'
WHERE ck_id=63;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='d453afb2e82e475e82fd5110225e307b', ck_user='40025111', ct_change='2019-03-21 23:41:33.726'
WHERE ck_id=64;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='a6abbe90206640d3b0e82db2e19a5177', ck_user='40025111', ct_change='2019-04-18 06:50:53.653'
WHERE ck_id=65;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='b79f7ce074e84d59b45e4c418540434e', ck_user='20783', ct_change='2019-04-30 00:29:14.246'
WHERE ck_id=66;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='10cf09577f7f4bbaae0bd6cedd45ad3f', ck_user='-11', ct_change='2019-04-30 00:27:00.000'
WHERE ck_id=67;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='64c12b57785c497f87f397aaa8e0e5fc', ck_user='-11', ct_change='2019-04-29 17:47:00.000'
WHERE ck_id=68;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='5903e7eac6044bc6be2925e6cc777dce', ck_user='-11', ct_change='2019-07-23 18:47:00.000'
WHERE ck_id=69;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='f47217bb17604a60b8c5acfac79df10b', ck_user='-11', ct_change='2019-07-23 18:47:00.000'
WHERE ck_id=70;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='115ad21ba9f54926a983c4d7a03c7121', ck_user='-11', ct_change='2019-07-23 18:47:00.000'
WHERE ck_id=71;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='a0071384a57c40aba7de66f14f334dc5', ck_user='-11', ct_change='2019-07-23 18:47:00.000'
WHERE ck_id=72;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='ec071d0460a6414dbbb9fe5d93f59042', ck_user='-11', ct_change='2019-07-23 18:47:00.000'
WHERE ck_id=73;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='46735625b41c48559fae404724eb408a', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-12 10:47:00.000'
WHERE ck_id=74;
UPDATE s_mt.t_message
SET cr_type='warning', cv_text='7985a9e97dba46ff935b6e26e611d1b4', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-12 10:47:00.000'
WHERE ck_id=75;
UPDATE s_mt.t_message
SET cr_type='warning', cv_text='0fdb11bafaa14f01845d7ef724cdb928', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-12 10:47:00.000'
WHERE ck_id=76;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='071292b46e5242808623843f6c067c9b', ck_user='-11', ct_change='2019-08-14 00:20:00.000'
WHERE ck_id=200;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='9b6c7947e2924a9aa37253af064cca0e', ck_user='-11', ct_change='2019-08-15 17:30:00.000'
WHERE ck_id=201;
UPDATE s_mt.t_message
SET cr_type='warning', cv_text='0d46cf1cc1b24ab2bbf9960eb433bb1a', ck_user='-11', ct_change='2019-08-15 17:30:00.000'
WHERE ck_id=202;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='026254893e4b4a2a978e5dcb8bd6535c', ck_user='-11', ct_change='2019-08-15 17:30:00.000'
WHERE ck_id=203;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='7b289d82628542a4ba3c7cc2a63547fb', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-10-30 10:30:00.000'
WHERE ck_id=204;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='ae5f1eb355a7481db96a4e772bd55dd6', ck_user='-11', ct_change='2019-11-26 03:00:00.000'
WHERE ck_id=205;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='4d5eb5f5ffe745b58362160c84a1ea4b', ck_user='-11', ct_change='2018-02-23 23:08:10.188'
WHERE ck_id=500;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='b202c2f390e84fc48651c5c86f8ebf6e', ck_user='-11', ct_change='2018-02-23 23:08:10.188'
WHERE ck_id=501;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='005adc04bd454377961a6676f53c4da2', ck_user='-11', ct_change='2018-02-23 23:08:10.188'
WHERE ck_id=502;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='a1a1c30ea80d4b9b887e622fc5cb0a50', ck_user='-11', ct_change='2018-02-23 23:08:10.188'
WHERE ck_id=503;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='c30703e742994f96887166f1468e976a', ck_user='-11', ct_change='2018-02-23 23:08:10.188'
WHERE ck_id=504;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='391d75337735425aae28cb89ad31b70f', ck_user='-11', ct_change='2018-02-23 23:08:10.188'
WHERE ck_id=505;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='aed842ffadfe4169969aa820bfef3e60', ck_user='-11', ct_change='2018-02-23 23:08:10.188'
WHERE ck_id=506;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='80ab25c37f674b1b82e8149110240e5c', ck_user='-11', ct_change='2018-02-23 23:08:10.188'
WHERE ck_id=507;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='3fc338b797cb45f089253c79afe12e6a', ck_user='-11', ct_change='2018-02-23 23:08:10.188'
WHERE ck_id=508;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='a32399aec87a4cf48045e2e54b40b043', ck_user='-11', ct_change='2018-02-23 23:08:10.188'
WHERE ck_id=509;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='9977f31e35d545568f4a9db308ebe2fd', ck_user='-11', ct_change='2018-02-23 23:08:10.188'
WHERE ck_id=510;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='3f87a0d370bb46cca97d6463fb04d2af', ck_user='-11', ct_change='2018-02-23 23:08:10.188'
WHERE ck_id=511;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='480f4ea3e2724bd7a632eb7ca96d955f', ck_user='-11', ct_change='2018-02-23 23:08:10.188'
WHERE ck_id=512;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='08f467bb1b79428d9b7bec42e8f19d84', ck_user='-11', ct_change='2018-02-23 23:08:10.188'
WHERE ck_id=513;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='6a65748c7e27479d8e441f8c779945db', ck_user='10020788', ct_change='2018-04-10 05:13:59.519'
WHERE ck_id=514;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='a8cfc099eb694385842c05f7d705cd0d', ck_user='10020788', ct_change='2018-11-30 04:50:36.806'
WHERE ck_id=517;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='153fb312b52346909836c50bebfcc0b3', ck_user='10020788', ct_change='2018-09-10 00:08:10.994'
WHERE ck_id=518;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='da83ebf916bc4f539fc93161c239a40c', ck_user='10020788', ct_change='2019-01-23 22:10:00.358'
WHERE ck_id=900;
UPDATE s_mt.t_message
SET cr_type='error', cv_text='76b447331a2246ae9a5f3fac765a444e', ck_user='-11', ct_change='2018-02-23 23:08:10.188'
WHERE ck_id=1000;

--changeset artemov_i:CORE-597 dbms:postgresql
INSERT INTO s_mt.t_sys_setting (ck_id,cv_value,ck_user,ct_change,cv_description)
	VALUES ('clearing_object_during_update','false','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-12-15 07:54:25.000','Очищаем неиспользуемые объекты при обновление страницы');

--changeset kutsenko:CORE-1468 dbms:postgresql
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change) 
	VALUES ('a240c31303c74c5490623d7781964c11', 'ru_RU', 'meta', 'Минимальная длина этого поля :maxsize', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-12-23 17:25:53.736532+03');

--changeset artemov_i:CORE-640 dbms:postgresql
CREATE TABLE s_mt.t_create_patch (
	ck_id uuid NOT NULL,
	cv_file_name varchar(200) NOT NULL,
	ck_user varchar(100) NOT NULL,
	ct_change timestamptz NOT NULL,
	сj_param jsonb NOT NULL,
	cd_create date NOT NULL,
	cn_size bigint NULL,
	CONSTRAINT cin_p_create_patch PRIMARY KEY (ck_id)
);
COMMENT ON COLUMN s_mt.t_create_patch.ck_id IS 'Идентификатор';
COMMENT ON COLUMN s_mt.t_create_patch.cv_file_name IS 'Наименование файла';
COMMENT ON COLUMN s_mt.t_create_patch.ck_user IS 'Аудит идентификатор пользователя';
COMMENT ON COLUMN s_mt.t_create_patch.ct_change IS 'Аудит время модификации';
COMMENT ON COLUMN s_mt.t_create_patch.сj_param IS 'Параметры запуска';
COMMENT ON COLUMN s_mt.t_create_patch.cd_create IS 'Дата сборки';
COMMENT ON COLUMN s_mt.t_create_patch.cn_size IS 'Размер сборки';

--changeset artemov_i:CORE-650 dbms:postgresql
ALTER TABLE s_mt.t_localization DROP CONSTRAINT cin_c_localization_2;
ALTER TABLE s_mt.t_localization ADD CONSTRAINT cin_c_localization_2 CHECK (cr_namespace in ('meta', 'message', 'static'));
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Загрузка', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 15:12:44.764'
WHERE ck_id='ad39828554114893872302a0aaa031af' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Формат даты: ''гггг''', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 21:14:23.551'
WHERE ck_id='773ed9a089214ab9b0bd149be5685ba0' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Да', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-12 19:00:24.442'
WHERE ck_id='dacf7ab025c344cb81b700cfcc50e403' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Нет', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-14 21:22:10.312'
WHERE ck_id='f0e9877df106481eb257c2c04f8eb039' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Продолжить?', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 13:06:38.134'
WHERE ck_id='5a33b10058114ae7876067447fde8242' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Печать', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 13:18:34.541'
WHERE ck_id='937e99f97aea414f97f501e3b8a0b843' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Отмена', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 13:18:56.415'
WHERE ck_id='64aacc431c4c4640b5f2c45def57cae9' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Hаименование файла', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 13:19:25.168'
WHERE ck_id='662d857575ed4a26bca536b18fbac6ff' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Печать в excel', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 13:19:55.869'
WHERE ck_id='7578080854a84cc3b4faad62d4499a4b' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Добавить все', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 13:23:54.780'
WHERE ck_id='d78431bbcb484da4b516bc00626965ba' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Добавить выделенное', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 13:24:12.810'
WHERE ck_id='833289fd818f4340b584beb9068f670b' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Удалить выделенное', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 13:24:33.842'
WHERE ck_id='67677d8e457c409daaef5fe5b90ec491' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Удалить все', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 13:24:53.715'
WHERE ck_id='c4684efb2ea444f4b9192db3c4b4b843' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Развернуть фильтры', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 13:29:44.094'
WHERE ck_id='76dd4f170842474d9776fe712e48d8e6' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Скрыть фильтры', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 13:30:04.724'
WHERE ck_id='72b93dbe37884153a95363420b9ceb59' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Очистить', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 13:30:26.871'
WHERE ck_id='cda88d85fb7e4a88932dc232d7604bfb' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Поиск', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 13:30:50.219'
WHERE ck_id='704af666dbd3465781149e4282df5dcf' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Дата с', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 13:41:21.377'
WHERE ck_id='6aa4a0027b7e41309787b086de051536' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Дата по', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 13:41:37.168'
WHERE ck_id='f806e79ffa3342ff81b150ce2279099f' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Точная дата', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 13:41:50.636'
WHERE ck_id='e001f50e66034472a486099ea5f96218' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Настройки пользователя', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 13:42:24.549'
WHERE ck_id='102972d8258947b7b3cf2b70b258278a' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Сохранить', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 13:44:17.777'
WHERE ck_id='8a930c6b5dd440429c0f0e867ce98316' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Отменить', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 13:45:13.588'
WHERE ck_id='3d27a32643ed4a7aa52b7e4b8a36806b' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Колонка с типом', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 13:46:06.715'
WHERE ck_id='223dbd23bba54e4c91f59ef4cdea8ffa' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Показать/скрыть колонки', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 13:46:55.899'
WHERE ck_id='017af47503474ec58542b9db53bdeeff' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Отображение Истории', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 13:47:57.198'
WHERE ck_id='20732b2df62f4dd5baf97d12cf2a3e9c' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Населенный пункт', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 13:56:57.196'
WHERE ck_id='d0e89e0caa6c476e87fb9564ca0d45ac' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Регион', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 13:57:11.300'
WHERE ck_id='dd72982c8ecd46e094823c088e2aa91e' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Улица', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 13:57:31.648'
WHERE ck_id='efdf47b812344d3aaa5228520f04a04e' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Дом', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 13:57:57.590'
WHERE ck_id='c215efe4c3254c9690a5d0744c0a89b4' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Добавление документа', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 13:58:35.100'
WHERE ck_id='6a4c7f4488164e7e8fabd46e0cc01ccc' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Добавить', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 13:58:54.286'
WHERE ck_id='3a5239ee97d9464c9c4143c18fda9815' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Кнопка добавления документа', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 13:59:13.344'
WHERE ck_id='a1ff62833ba8490fb626baa1ddf0f0f7' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Добавить файл', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 13:59:33.217'
WHERE ck_id='0e55e1e9994c44f7978f3b76f5bd819f' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Отменить?', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 13:59:59.298'
WHERE ck_id='9b475e25ae8a40b0b158543b84ba8c08' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Загрузить', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 14:00:42.107'
WHERE ck_id='02260da507494f2f9956ba9e0f37b1f1' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Удалить', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 14:01:24.295'
WHERE ck_id='f7e324760ede4c88b4f11f0af26c9e97' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Удалить?', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 14:01:59.153'
WHERE ck_id='0cd0fc9bff2641f68f0f9712395f7b82' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Информация', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 14:02:15.173'
WHERE ck_id='627518f4034947aa9989507c5688cfff' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Обновить', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 14:02:35.992'
WHERE ck_id='33c9b02a9140428d9747299b9a767abb' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Клонировать', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 14:13:44.047'
WHERE ck_id='54e15e2eec334f3c839a64cde73c2dcb' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Настройки системы', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-19 03:12:34.889'
WHERE ck_id='9c97fa4879f144a7b571c4905fa020cc' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Редактировать', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 14:15:21.398'
WHERE ck_id='deb1b07ddddf43c386682b20504fea0d' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Предыдущая запись', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 14:15:46.967'
WHERE ck_id='d529fbf32aae4b85b9971fca87b4e409' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Следующая запись', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 14:16:02.669'
WHERE ck_id='e00978fb845249fdbdf003cd0aa2898e' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Наименование объекта обслуживания', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 14:18:28.313'
WHERE ck_id='1dabbff97463462f9776c1c62160c0ed' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Назад', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 14:22:45.973'
WHERE ck_id='85c19e316e9e446d9383a9ffe184d19a' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Далее', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 14:23:02.791'
WHERE ck_id='dcfd5234c348410994c690eec7d28028' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Выбрать', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 14:24:03.180'
WHERE ck_id='147bb56012624451971b35b1a4ef55e6' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Поля должны быть заполнены в требуемом количестве', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 14:35:50.274'
WHERE ck_id='a5a5d7213d1f4f77861ed40549ee9c57' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Добавить ещё', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 14:46:08.782'
WHERE ck_id='ba416597affb4e3a91b1be3f8e0c8960' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Очистить все', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 15:01:40.668'
WHERE ck_id='b0c16afd6507416196e01223630f9d62' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Все', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 15:05:41.492'
WHERE ck_id='bfecce4e8b9844afab513efa5ea53353' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Ошибки', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 15:06:12.123'
WHERE ck_id='7185a3b731b14e1ea8fb86056b571fe5' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Предупреждения', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 15:06:25.690'
WHERE ck_id='10666aec26534e179b22f681700f22b7' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Оповещения', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 15:06:41.581'
WHERE ck_id='880a932500234fa2b2f22a4b36bd6cd8' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Разработка', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 15:06:59.611'
WHERE ck_id='1650aebec6b348f094680ba725441ef0' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Прочитать все', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 15:08:20.514'
WHERE ck_id='f42e28fe1287412fa6ec91b421377139' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Неуспешно', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 15:12:30.039'
WHERE ck_id='73de7f460cc04bc8a068429d66e684ce' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Успешно', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 15:13:01.907'
WHERE ck_id='5454b0c6f64b41daab8deb88f948a4f1' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Закрыть вкладку', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 15:21:41.571'
WHERE ck_id='74776ef247274a55a2a76f7df34ffe41' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Закрыть другие вкладки', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 15:22:11.329'
WHERE ck_id='63b54227225e4ea5a2ba644eced838ec' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Закрыть вкладки справа', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 15:22:44.209'
WHERE ck_id='bceed776538747b9a0c88d4f73b70711' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Закрыть все вкладки', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 15:23:02.551'
WHERE ck_id='a0cb66a96d8740a19397ece02d537f86' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Тема', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 15:36:06.908'
WHERE ck_id='0b5e4673fa194e16a0c411ff471d21d2' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Темная тема', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 15:36:26.395'
WHERE ck_id='66ef0068472a4a0394710177f828a9b1' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Светлая тема', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 15:37:11.390'
WHERE ck_id='fd7c7f3539954cc8a55876e3514906b5' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='c', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 18:52:43.682'
WHERE ck_id='d7d40d765f0840beb7f0db2b9298ac0c' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='по', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 18:53:22.916'
WHERE ck_id='acc7f22ccbc6407bb253f8c47a684c45' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Сбросить все данные?', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 20:04:31.804'
WHERE ck_id='b03cbbb047ca438f920c799c5f48ecaf' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Корневой каталог', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 20:12:21.071'
WHERE ck_id='e3e33760864d44f88a9ecfe8f5da7a0b' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Загрузка файла завершена', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 20:16:29.398'
WHERE ck_id='31b05bf92be1431894c448c4c3ef95bb' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Сохранение файла...', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 20:16:58.368'
WHERE ck_id='aff0422be07246fb844794e2329fc578' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Ошибка', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 20:17:36.737'
WHERE ck_id='c80abfb5b59c400ca1f8f9e868e4c761' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Удалить файл', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 20:21:41.903'
WHERE ck_id='b711be91555b46bab25971b7da959653' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='от', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 20:22:44.137'
WHERE ck_id='1f560294a2a446c4a23fb3f9d7f94dc6' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Максимальная длина этого поля :maxsize', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 20:25:00.489'
WHERE ck_id='e668fef0db6d4eeb9eb72c62a8d31052' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Значение этого поля не может быть больше :maxvalue', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 20:25:22.763'
WHERE ck_id='58b71773e7664e70874020a45705bc4c' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Значение этого поля не может быть меньше :minvalue', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 20:26:01.755'
WHERE ck_id='31d96e87a5514f509c75bc701b772504' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Обязателен для заполнения', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 20:26:25.277'
WHERE ck_id='58c125b1b34f445c9ae5640ff3122e03' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Неверный формат поля :attribute.', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 20:27:02.394'
WHERE ck_id='f488a90cb69e4567a092325fecffb1ed' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Дата "по" не может быть меньше даты "с"', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 20:27:25.890'
WHERE ck_id='4f5060a1dc7c4f5ca76a606b4977f868' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Дата "с" не может быть больше даты "по"', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 20:27:58.031'
WHERE ck_id='93e0035fa0684768839021399baed028' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Изменен', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 20:31:33.253'
WHERE ck_id='a51733f718974db891606a516a906d4a' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Пользователь', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 20:32:35.350'
WHERE ck_id='359b72856d284d1baf5ff9e14e8293c9' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Первая страница', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 20:34:51.119'
WHERE ck_id='23264e86a9cd446f83cee0eb86c20bd9' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Предыдущая страница', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 20:35:37.881'
WHERE ck_id='267e96bb282843abaa25b3e78bd874f1' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Следующая страница', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 20:36:03.007'
WHERE ck_id='d4d9e481a0e14bbd9e1e76537e8cbfd0' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Последняя страница', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 20:36:27.227'
WHERE ck_id='d0f0a046dee344d1b5bbbadcd8d848db' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Ошибка в разпознавании данных', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 20:42:52.928'
WHERE ck_id='63538aa4bcd748349defdf7510fc9c10' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Превышен максимальный допустимый размер для загружаемого файла. Разрешены файлы размером не более', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 20:46:26.402'
WHERE ck_id='7d9d6e64612643cfa6bb568cd3bde543' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Данный формат файлов не поддерживается. Разрешены форматы:', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 20:48:09.628'
WHERE ck_id='5d4e96bd15bb429195f2bbef3e0ff126' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='байт', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 20:49:24.044'
WHERE ck_id='bc377ecb59164cc4915c669130e298ef' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='тб', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 20:52:32.062'
WHERE ck_id='05eab6e983464c5f8708045bd5131ebe' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='гб', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 20:53:03.071'
WHERE ck_id='8d7f133d5ef04c4485748e38635fe9eb' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='мб', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 20:54:30.475'
WHERE ck_id='58f3245889924db1b023691819f34607' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='кб', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 20:54:48.052'
WHERE ck_id='82c9683d5aa7483aadc6b0b21f3dd174' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Глобальные переменные для', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 20:57:06.800'
WHERE ck_id='dcfb61366b054c6e95ae83593cfb9cd9' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Выбрана', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 21:00:27.869'
WHERE ck_id='e28e56d7b12e4ea2b7663b3e66473b9e' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Выбрано', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 21:01:02.407'
WHERE ck_id='783922ac8cf84a5eac8d1b17c77de544' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='запись', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 21:01:24.090'
WHERE ck_id='0cd9a67ed46d4d70959182cc6260b221' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='записи', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 21:02:00.241'
WHERE ck_id='87acd17f8ae243798e97549a5761cfaf' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='записей', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 21:02:38.835'
WHERE ck_id='2485088fda3d4d9cb5de9c25534cdf23' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Инициазилация с', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 21:09:20.382'
WHERE ck_id='e077e7f97f954e85905a8e754511e441' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Выполнение', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 21:09:45.062'
WHERE ck_id='9207ff3b431a4dc58f16a28d2aae0ea8' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Исходный код', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 21:10:23.407'
WHERE ck_id='6029c25920ff4f79b9b52d664322b3d9' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Переменные', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 21:10:47.322'
WHERE ck_id='a363461339754846881b1f84b6706851' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Значение для', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 21:11:22.661'
WHERE ck_id='a326c00cf6b54d7ebdc358e283383ccb' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Результат', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 21:12:06.533'
WHERE ck_id='b4458be782404651a4cfcad47d2ae17a' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Тип данных в результате', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 21:12:36.019'
WHERE ck_id='c816bc224d6e4ae5b60d9c7dd2e6b612' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='не является правильной датой - дата должна быть указана в формате ''гггг''', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 21:14:54.864'
WHERE ck_id='271b81793a72461192644b7f4578ac51' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value=':inputValue не является правильной датой - дата должна быть указана в формате ''гггг''', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 21:15:30.945'
WHERE ck_id='3c205218305a4a25bada37004775789c' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Формат даты: ''ммм гггг''', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 21:16:15.576'
WHERE ck_id='02983497059143b9b97cc0e7d0c4691d' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='не является правильной датой - дата должна быть указана в формате ''ммм гггг''', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 21:16:41.456'
WHERE ck_id='a40a4372823f44ffa7a69e699b0b15db' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value=':inputValue не является правильной датой - дата должна быть указана в формате ''ммм гггг''', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 21:17:37.022'
WHERE ck_id='6b6305d16db148d986e782a66c4318da' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Формат даты: ''дд.мм.гггг''', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 21:18:14.216'
WHERE ck_id='acfdddfef80c4e5c90a3052e286d7919' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='не является правильной датой - дата должна быть указана в формате ''дд.мм.гггг''', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 21:18:35.109'
WHERE ck_id='f0f42f35a2d241f3b51cd16747c37186' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value=':inputValue не является правильной датой - дата должна быть указана в формате ''дд.мм.гггг''', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 21:19:17.581'
WHERE ck_id='77050515e7b2462e95429b9df33a7958' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Формат даты: ''дд.мм.гггг чч:00''', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 21:19:52.648'
WHERE ck_id='149c3a8684224bc2939e613271f5c704' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='не является правильной датой - дата должна быть указана в формате ''дд.мм.гггг чч:00''', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 21:20:32.478'
WHERE ck_id='ce35e3e6067d4343af8b30ea38d01f96' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value=':inputValue не является правильной датой - дата должна быть указана в формате ''дд.мм.гггг чч:00''', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 21:21:06.399'
WHERE ck_id='1583ea7e4b054c759818771219303c3c' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Формат даты: ''дд.мм.гггг чч:ми''', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 21:21:32.428'
WHERE ck_id='6b5f29158ba142c3963649e1219a8f1e' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='не является правильной датой - дата должна быть указана в формате ''дд.мм.гггг чч:ми''', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 21:22:11.033'
WHERE ck_id='c43175882dda4f7abce9bb7325cd8847' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value=':inputValue не является правильной датой - дата должна быть указана в формате ''дд.мм.гггг чч:ми''', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 21:22:44.853'
WHERE ck_id='a1fadf8d7e73453b8a1ed526f3d1103e' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Формат даты: ''дд.мм.гггг чч:ми:сс''', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 21:23:26.919'
WHERE ck_id='52f802c6dab84eacbb4e6068aedcaa77' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='не является правильной датой - дата должна быть указана в формате ''дд.мм.гггг чч:ми:сс''', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 21:23:49.486'
WHERE ck_id='6b95585ef5f442e6922459c81db7c1f3' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value=':inputValue не является правильной датой - дата должна быть указана в формате ''дд.мм.гггг чч:ми:сс''', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 21:24:44.183'
WHERE ck_id='5f09f8f54f174ecfb6befd64ca4c3423' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Изображение', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 21:28:15.957'
WHERE ck_id='157badbc579e439d8cae1d60ceff9aa9' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Добавление', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 21:34:56.756'
WHERE ck_id='aa75a46ca0a44a6a8a16ffa1357ec313' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Клонирование', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 21:35:32.757'
WHERE ck_id='7437988e948f4962abba9656e4988adc' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Редактирование', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 21:35:55.082'
WHERE ck_id='8059806cc90c4ba4be7fa5ae15d5e64b' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Подтверждение', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 21:40:22.726'
WHERE ck_id='ec238e2ccc1842d780b140a4bbedfdaf' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Невозможно загрузить модули', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 21:46:58.721'
WHERE ck_id='b9c874da6b0e4694b93db69088a556da' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Модули', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 21:47:20.709'
WHERE ck_id='02f274362cf847cba8d806687d237698' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Супер Глобальные переменные', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 21:55:02.415'
WHERE ck_id='d2c071c58aca4b73853c1fcc6e2f08a3' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Описание', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 21:57:48.828'
WHERE ck_id='900d174d0a994374a01b0005756521bc' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Код ошибки', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-15 21:58:18.748'
WHERE ck_id='67aefce5785a4326920bef69acb5a403' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Оповещение', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-18 20:08:32.643'
WHERE ck_id='2ff612aa52314ddea65a5d303c867eb8' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Ошибка подключения к серверу оповещения, превышен лимит попыток переподключения', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-18 20:47:05.060'
WHERE ck_id='bcdc7e54547e405c9873b3ebea4f84c4' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Ошибка подключения к серверу оповещения', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-18 20:47:41.170'
WHERE ck_id='4b4ef9aed688462799f24efe8413da9f' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Блокировка', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-18 21:13:03.879'
WHERE ck_id='cad7307902954c1b92b626e42da53aa3' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Отладка', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-18 21:14:36.568'
WHERE ck_id='4fdb2cdb2e5047048da10f9dbe83188d' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Ошибка загрузки', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-18 21:14:57.848'
WHERE ck_id='cecc548fc7444813a3d00eb7bb067a3f' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Снятие блокировки', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-18 21:16:03.154'
WHERE ck_id='d22b1f7a48b9402e9c0c17b508c5a906' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Загружено', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-18 21:16:19.190'
WHERE ck_id='179cc83540e94b87a8d8aff919552f22' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Предупреждение', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-18 21:16:30.887'
WHERE ck_id='e6f8166771e04b849855254c5d926ff6' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Превышено время ожидания', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-18 21:19:36.964'
WHERE ck_id='06dfd0c3b97b45e5abc146a14c0fab37' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Неизвестное количество страниц', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-18 21:20:39.070'
WHERE ck_id='44e3485c6b0c47dc8a0792c90af62962' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Сервер авторизации временно недоступен', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-18 23:33:04.514'
WHERE ck_id='23cd49d589b74476acaa0b347b207d00' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Не удалось получить доступ к сервису', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-18 23:33:28.208'
WHERE ck_id='1d5ca35298f346cab823812e2b57e15a' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Сессия недействительна', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-18 23:33:48.410'
WHERE ck_id='5bf781f61f9c44b8b23c76aec75e5d10' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Неверные имя пользователя или пароль', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-18 23:34:17.042'
WHERE ck_id='b5a60b8ff5cd419ebe487a68215f4490' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Ошбика при выполнении parse:', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-18 23:37:25.387'
WHERE ck_id='993c801f7f8b4284b3b1a0f624496ac8' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Ошибка парсинга', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-18 23:38:42.336'
WHERE ck_id='4b067f4b55154c46b0a8d6b34d4d9bfb' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Ошибка запуска', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-18 23:39:04.785'
WHERE ck_id='b621b9209813416dba9d5c12ccc93fdf' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Ошибка при сохранении данных:', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-18 23:46:46.782'
WHERE ck_id='27a9d844da20453195f59f75185d7c99' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Существует неудаленная store, нужно удалять ненужные сторы!.', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-18 23:53:53.804'
WHERE ck_id='7ef1547ac7084e178bf1447361e3ccc3' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Не могу загрузить данны. Не задан ck_query для конфига:', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-18 23:55:47.935'
WHERE ck_id='0d43efb6fc3546bbba80c8ac24ab3031' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Сервис временно недоступен - {{query}}. Попробуйте выполнить операцию позднее.', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-19 00:02:05.663'
WHERE ck_id='4fdb3577f24440ceb8c717adf68bac48' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Ошибка обращения к сервису {{query}}', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-19 00:03:23.210'
WHERE ck_id='515a199e09914e3287afd9c95938f3a7' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Не получилось распознать ошибку. Возможно, возникла проблема с сетевым подключением', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-19 00:04:49.004'
WHERE ck_id='2d209550310a4fae90389134a5b12353' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Не определана reloadStoreAction для {{name}}', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-19 01:19:57.593'
WHERE ck_id='83490c56debb4a399f05518608e3bace' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Не определана clearStoreAction для {{name}}', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-19 01:20:38.578'
WHERE ck_id='5c3108d6508a4141bdca1e52881e196d' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='{{currentpage}} из {{pages}}', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-19 01:26:34.262'
WHERE ck_id='3dd42493c346447897d017af3668d998' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Превышено время ожидаения формы.', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-19 01:45:30.979'
WHERE ck_id='5327513a9d344e2184cca94cde783a52' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Ошибка получения оповещения {{message}}', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-19 01:57:34.954'
WHERE ck_id='8fe6e023ee11462db952d62d6b8b265e' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Данные изменены вне формы:', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-19 01:58:02.791'
WHERE ck_id='f9c3bf3691864f4d87a46a9ba367a855' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Поле может работать некорректно без column, автогенерируемое значение: {{key}}', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-19 02:02:18.234'
WHERE ck_id='d4055d1153af44a4ba5eb73ac9bc437e' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Поле не может быть построено: {{key}}', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-19 02:03:33.747'
WHERE ck_id='d56944511bd243b1a0914ccdea58ce0d' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Ошибка:', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-19 02:04:22.568'
WHERE ck_id='47b7b12c1d9c413da54a08331191aded' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Информация:', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-19 02:05:13.926'
WHERE ck_id='cfac299d53f8466d9745ddfa53e09958' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Необходимо заполнить orderproperty для дальнейшей работы таблицы', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-19 02:06:22.489'
WHERE ck_id='40dd53ff1c214bfab79ecd40612de8f5' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Поле может работать некорректно без ck_page_object, автогенерируемое значение: {{name}}', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-19 02:09:22.945'
WHERE ck_id='c3513e8150484b31a4ad4227f9664e7f' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Описание: {{description}}', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-19 02:13:22.043'
WHERE ck_id='b6c8c1519907418caad7f647068d1fb2' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Код ошибки: {{code}}', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-19 02:14:02.601'
WHERE ck_id='4cf741cfcf18478ab4ed3c3c79255a39' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Ожидание загрузки привышено {{timeout}}ms, проверьте циклиность использования глобальных переменных для сервиса {{query}}', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-19 02:20:47.819'
WHERE ck_id='344bbb5fb4a84d89b93c448a5c29e1d7' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Запрос ''reloadStoreAction'' запрещен в TableFieldModel', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-19 02:25:15.155'
WHERE ck_id='58715205c88c4d60aac6bfe2c3bfa516' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Ок', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-19 02:26:21.711'
WHERE ck_id='8004527cce454f8f83c7d739460f5822' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='О программе', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-19 02:32:57.468'
WHERE ck_id='6cf398ee03df42529323bd4ff9f584d5' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Имя пользователя', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-19 02:56:27.291'
WHERE ck_id='d016a5a3d0964cd69fd15c6e283db77e' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Версия {{BRANCH_NAME}} ({{COMMIT_ID}} от {{BRANCH_DATE_TIME}})', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-19 02:50:11.846'
WHERE ck_id='26686005b3584a12aeb9ca9e96e54753' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Загрузка...', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-19 02:51:02.336'
WHERE ck_id='8aebd9c71dda43fc8583d96f1d4d0d01' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Пароль', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-19 02:56:53.421'
WHERE ck_id='8d380b7c5e6d4fcfb9d608d69464fe2a' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Войти', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-19 02:57:21.327'
WHERE ck_id='664bdebac78e47079bb685732899c5f6' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Главная страница', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-19 02:58:04.655'
WHERE ck_id='a54bed8bf1574dc185aaf1f74aa85148' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Страница не обнаружена или заполнена неверно!', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-19 03:05:03.595'
WHERE ck_id='1764da1153734ec8b4fc4cf48cc78c88' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Не найдена информация о фильтрации!', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-19 03:05:25.533'
WHERE ck_id='e7f66e6d5b5340909ea4ded06f5a034f' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Вы пытаетесь перейти на страницу c такими параметрами:', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-19 03:05:48.286'
WHERE ck_id='b35d5fa33cb14a1db46c4f684dc14037' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Страница: {{page}}', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-19 03:06:31.618'
WHERE ck_id='6f93ca102d5f488aa3082e0344486e9e' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Фильтр: {{filter}}', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-19 03:07:03.811'
WHERE ck_id='dda349a2de0049408168eb5d148442df' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Параметры заданы не верно', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-19 03:07:40.772'
WHERE ck_id='86d945313cbd41beb5f5068c2696bcec' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Статус авторизации: {{status}}', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-19 03:08:11.139'
WHERE ck_id='6512d68884cd4848ba6129655dec51d4' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='авторизирован', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-19 03:10:06.876'
WHERE ck_id='0d9c5a0b816947a781f02baad2c2ce22' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='не авторизирован', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-19 03:10:23.636'
WHERE ck_id='e8281a11d60542c684f76ffab31216aa' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Продолжить', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-19 03:10:57.400'
WHERE ck_id='fad9bcdb1bf54640ab58d1781546c72c' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Задержка Tooltip перед показом (delayTooltipShow)', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-19 03:12:50.604'
WHERE ck_id='d39cbeb8128e4f68b201b25291889dd2' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Отступ Tooltip по диагонали (offsetTooltip)', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-19 03:13:11.519'
WHERE ck_id='a43c94932e3a48c9867ac7b39bb22e60' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Задержка Tooltip при движении (debounceTooltipTime)', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-19 03:13:27.118'
WHERE ck_id='a376942ff8af4ec58eeb18ea5a05e772' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Включить режим объединения ячеек таблиц в wysiwyg (wysiwygCombineFields)', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-19 03:13:55.376'
WHERE ck_id='9a381df0ef4948ebaacb05852324d036' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Включить режим отображения отладочного окна при передаче параметров извне (redirectDebugWindow)', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-19 03:14:18.030'
WHERE ck_id='c038518f0652435ba9914848f8693454' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Включить эксперементальный режим (experimentalUI)', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-19 03:14:34.791'
WHERE ck_id='0852f8c548c741d39521833cd739a9f4' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Список модулей (modules)', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-19 03:14:58.589'
WHERE ck_id='ad56476c04ff4d6091d5e87f5d823a9b' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Выход', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-19 03:23:30.398'
WHERE ck_id='8c0119ba23c74e158c5d50c83884fcb5' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Язык', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-19 03:25:53.736'
WHERE ck_id='4ae012ef02dd4cf4a7eafb422d1db827' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Отображаемое имя', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-25 18:25:13.736'
WHERE ck_id='37023be03a484bd5928791eebcd47f51' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Наименование', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-11-25 22:01:03.544'
WHERE ck_id='3a0b8d771a0d497e8aa1c44255fa6e83' AND ck_d_lang='ru_RU';
UPDATE s_mt.t_localization
SET cr_namespace='static', cv_value='Минимальная длина этого поля :maxsize', ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2019-12-23 22:25:53.736'
WHERE ck_id='a240c31303c74c5490623d7781964c11' AND ck_d_lang='ru_RU';

--changeset artemov_i:CORE-847 dbms:postgresql
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('16b6a8b83c0a44a4a2366af0127b6873','ru_RU','message','Создание переменных g_sys* или g_sess* запрещено!','4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-01-27 18:30:07.292');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,ck_user,ct_change)
	VALUES (77,'error','16b6a8b83c0a44a4a2366af0127b6873','4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-01-27 10:47:00.000');

--changeset artemov_i:CORE-178 dbms:postgresql
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('2ac8f691eb154962bd174f3512ae2f61','ru_RU','message','Недопустимый символ в параметре "{0}"','4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-01-29 13:04:06.759');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,ck_user,ct_change)
	VALUES (78,'error','2ac8f691eb154962bd174f3512ae2f61','4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-01-29 08:06:00.000');
DROP INDEX s_mt.cin_i_page_2;
CREATE UNIQUE INDEX cin_i_page_2 ON s_mt.t_page (upper(cv_url));

--changeset artemov_i:CORE-908 dbms:postgresql
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('09bd93d52fad476ab9f1314269b2f166','ru_RU','message','Системная ошибка: редактирование уникального идентификатора запрещено','4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-02-06 19:49:00.701');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,ck_user,ct_change)
	VALUES (519,'error','09bd93d52fad476ab9f1314269b2f166','4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-02-06 14:50:10.000');

--changeset artemov_i:CORE-907 dbms:postgresql
ALTER TABLE s_mt.t_provider ALTER COLUMN ck_id TYPE varchar(32) USING ck_id::varchar;
INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('c7871bbd0e844793a47185a29b2b79f1','ru_RU','message','Максимальное количество символов {0} у параметра "{1}"','4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-02-06 20:58:14.658');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,ck_user,ct_change)
	VALUES (79,'error','c7871bbd0e844793a47185a29b2b79f1','4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-02-06 16:06:00.000');

--changeset kutsenko:CORE-1550 dbms:postgresql
UPDATE s_mt.t_localization SET cr_namespace = 'static' WHERE ck_id IN (
	SELECT ck_id FROM s_mt.t_localization l WHERE l.cr_namespace = 'static'
)

--changeset artemov_i:CORE-989 dbms:postgresql
ALTER TABLE s_mt.t_query ALTER COLUMN ck_provider TYPE varchar(32) USING ck_provider::varchar;

--changeset kutsenko:CORE-1671 dbms:postgresql
DELETE FROM s_mt.t_page_object_attr tpoa WHERE tpoa.ck_class_attr IN (SELECT tca.ck_class FROM s_mt.t_class_attr tca WHERE tca.ck_attr = 'reloadservice');
DELETE FROM s_mt.t_object_attr toa WHERE toa.ck_class_attr IN (SELECT tca.ck_class FROM s_mt.t_class_attr tca WHERE tca.ck_attr = 'reloadservice');
DELETE FROM s_mt.t_class_attr tca WHERE tca.ck_attr = 'reloadservice';
DELETE FROM s_mt.t_attr ta WHERE ck_id = 'reloadservice';

--changeset artemov_i:CORE-1137 dbms:postgresql
INSERT INTO s_mt.t_sys_setting (ck_id,cv_value,cv_description,ck_user,ct_change)
VALUES ('anonymous_action','99999','Действие для анонимного входа','4fd05ca9-3a9e-4d66-82df-886dfa082113','2019-08-05 10:15:50.000');

--changeset artemov_i:CORE-1153 dbms:postgresql
CREATE TABLE s_mt.t_d_attr_data_type (
	ck_id varchar(50) NOT NULL, -- ИД типа атрибута
	cv_description varchar(500) NULL, -- Описание
	cl_extra smallint NOT NULL DEFAULT 0::smallint, -- Признак что есть дополнительное описание
	ck_user varchar(150) NOT NULL, -- ИД пользователя
	ct_change timestamptz NOT NULL, -- Дата последнего изменения
	CONSTRAINT cin_p_d_attr_data_type PRIMARY KEY (ck_id)
);
COMMENT ON TABLE s_mt.t_d_attr_data_type IS 'Тип данных атрибута';

-- Column comments

COMMENT ON COLUMN s_mt.t_d_attr_data_type.ck_id IS 'ИД типа атрибута';
COMMENT ON COLUMN s_mt.t_d_attr_data_type.cv_description IS 'Описание';
COMMENT ON COLUMN s_mt.t_d_attr_data_type.cl_extra IS 'Признак что есть дополнительное описание';
COMMENT ON COLUMN s_mt.t_d_attr_data_type.ck_user IS 'ИД пользователя';
COMMENT ON COLUMN s_mt.t_d_attr_data_type.ct_change IS 'Дата последнего изменения';

INSERT INTO s_mt.t_d_attr_data_type (ck_id,cv_description,cl_extra,ck_user,ct_change)
	VALUES ('boolean','Логический тип данных',0,'4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-04-09 10:55:27.199');
INSERT INTO s_mt.t_d_attr_data_type (ck_id,cv_description,cl_extra,ck_user,ct_change)
	VALUES ('integer','Целое число',0,'4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-04-09 10:55:27.199');
INSERT INTO s_mt.t_d_attr_data_type (ck_id,cv_description,cl_extra,ck_user,ct_change)
	VALUES ('numeric','Число с плавующей точкой',0,'4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-04-09 10:55:27.199');
INSERT INTO s_mt.t_d_attr_data_type (ck_id,cv_description,cl_extra,ck_user,ct_change)
	VALUES ('array','JSON массив',0,'4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-04-09 10:55:27.199');
INSERT INTO s_mt.t_d_attr_data_type (ck_id,cv_description,cl_extra,ck_user,ct_change)
	VALUES ('enum','Перечисляемый тип (Хранится в формате json массива)',1,'4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-04-09 10:55:27.199');
INSERT INTO s_mt.t_d_attr_data_type (ck_id,cv_description,cl_extra,ck_user,ct_change)
	VALUES ('text','Строковый тип данных',0,'4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-04-09 10:55:27.199');
INSERT INTO s_mt.t_d_attr_data_type (ck_id,cv_description,cl_extra,ck_user,ct_change)
	VALUES ('date','Дата в ISO8601: YYYY-MM-DDThh:mm:ss 2005-08-09T18:31:42',0,'4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-04-09 10:55:27.199');
INSERT INTO s_mt.t_d_attr_data_type (ck_id,cv_description,cl_extra,ck_user,ct_change)
	VALUES ('localization','Поле бередся из локализации',0,'4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-04-09 10:55:27.199');
INSERT INTO s_mt.t_d_attr_data_type (ck_id,cv_description,cl_extra,ck_user,ct_change)
	VALUES ('object','JSON Объект',0,'4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-04-09 10:55:27.199');

ALTER TABLE s_mt.t_attr ADD ck_d_data_type varchar(50) NOT NULL DEFAULT 'text'::varchar;
COMMENT ON COLUMN s_mt.t_attr.ck_d_data_type IS 'Тип данных';
ALTER TABLE s_mt.t_attr ADD cv_data_type_extra text NULL;
COMMENT ON COLUMN s_mt.t_attr.cv_data_type_extra IS 'Дополнительное описание типа';
ALTER TABLE s_mt.t_attr ADD CONSTRAINT cin_r_attr_2 FOREIGN KEY (ck_d_data_type) REFERENCES s_mt.t_d_attr_data_type(ck_id);

ALTER TABLE s_mt.t_class_attr ADD cv_data_type_extra text NULL;
COMMENT ON COLUMN s_mt.t_attr.cv_data_type_extra IS 'Дополнительное описание типа';

--changeset kutsenko:CORE-1709 dbms:postgresql
UPDATE s_mt.t_sys_setting SET ck_id = 'g_sys_anonymous_action' where ck_id = 'anonymous_action'

--changeset artemov_i:CORE-1160 dbms:postgresql
CREATE INDEX cin_i_page_object_1 ON s_mt.t_page_object USING btree (ck_master);
CREATE INDEX cin_i_page_object_2 ON s_mt.t_page_object USING btree (ck_parent);
CREATE INDEX cin_i_class_attr_1 ON s_mt.t_class_attr USING btree (ck_attr);

--changeset artemov_i:CORE-1160_2 dbms:postgresql
CREATE INDEX cin_i_page_object_attr_1 ON s_mt.t_page_object_attr USING btree (ck_page_object, ck_class_attr);
CREATE INDEX cin_i_object_attr_1 ON s_mt.t_object_attr USING btree (ck_object, ck_class_attr);
CREATE INDEX cin_i_page_object_3 ON s_mt.t_page_object USING btree (ck_id, ck_master);
CREATE INDEX cin_i_class_attr_2 ON s_mt.t_class_attr USING btree (ck_class);

--changeset artemov_i:CORE-1163 dbms:postgresql
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,ck_user,ct_change)
	VALUES (80,'error','0839e8d67a474065bee7e3c8fad177a6','4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-04-24 16:06:00.000');
INSERT INTO s_mt.t_message (ck_id,cr_type,cv_text,ck_user,ct_change)
	VALUES (81,'error','a31559869a7249539ad9d694f3305c3e','4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-04-24 16:06:00.000');

--changeset kutsenko:CORE-1710 dbms:postgresql
INSERT INTO s_mt.t_sys_setting (ck_id,cv_value,ck_user,ct_change,cv_description)
	VALUES ('g_sys_ws_gate_url','/notification','-11','2020-05-19 13:10:31.709','WS URL шлюза');

--changeset artemov_i:CORE-1182 dbms:postgresql
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)VALUES('36cb0beb301d467a9db8e8e7d2383da3', 'ru_RU', 'static', 'Сегодня', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-05-19T13:57:00.000+0300') on conflict on constraint cin_u_localization_1 do update set ck_id = excluded.ck_id, ck_d_lang = excluded.ck_d_lang, cr_namespace = excluded.cr_namespace, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)VALUES('aa61a7fd162846e09ee931d39a8fa03f', 'ru_RU', 'static', 'Сейчас', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-05-19T13:57:00.000+0300') on conflict on constraint cin_u_localization_1 do update set ck_id = excluded.ck_id, ck_d_lang = excluded.ck_d_lang, cr_namespace = excluded.cr_namespace, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)VALUES('954505d8a7d740fe8bf76e3cf06ef898', 'ru_RU', 'static', 'Текущая дата', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-05-19T13:57:00.000+0300') on conflict on constraint cin_u_localization_1 do update set ck_id = excluded.ck_id, ck_d_lang = excluded.ck_d_lang, cr_namespace = excluded.cr_namespace, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)VALUES('226194bd1d3a41f09602675c1b7fd793', 'ru_RU', 'static', 'Ok', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-05-19T13:57:00.000+0300') on conflict on constraint cin_u_localization_1 do update set ck_id = excluded.ck_id, ck_d_lang = excluded.ck_d_lang, cr_namespace = excluded.cr_namespace, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)VALUES('c59a78d73c914073afe70802f0fae2fd', 'ru_RU', 'static', 'Очистить', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-05-19T13:57:00.000+0300') on conflict on constraint cin_u_localization_1 do update set ck_id = excluded.ck_id, ck_d_lang = excluded.ck_d_lang, cr_namespace = excluded.cr_namespace, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)VALUES('8c949483dfb14758b795cd7ee55cacc0', 'ru_RU', 'static', 'Месяц', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-05-19T13:57:00.000+0300') on conflict on constraint cin_u_localization_1 do update set ck_id = excluded.ck_id, ck_d_lang = excluded.ck_d_lang, cr_namespace = excluded.cr_namespace, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)VALUES('301a776e6b6341c29339282f1dee9d8f', 'ru_RU', 'static', 'Год', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-05-19T13:57:00.000+0300') on conflict on constraint cin_u_localization_1 do update set ck_id = excluded.ck_id, ck_d_lang = excluded.ck_d_lang, cr_namespace = excluded.cr_namespace, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)VALUES('7426f6ea435b4341af5f9fcc40158f5d', 'ru_RU', 'static', 'Выбрать время', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-05-19T13:57:00.000+0300') on conflict on constraint cin_u_localization_1 do update set ck_id = excluded.ck_id, ck_d_lang = excluded.ck_d_lang, cr_namespace = excluded.cr_namespace, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)VALUES('546d8902e79b47db827cdadf04df383a', 'ru_RU', 'static', 'Выбрать дату', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-05-19T13:57:00.000+0300') on conflict on constraint cin_u_localization_1 do update set ck_id = excluded.ck_id, ck_d_lang = excluded.ck_d_lang, cr_namespace = excluded.cr_namespace, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)VALUES('9b725b9abc42454ab717c6e5227122a5', 'ru_RU', 'static', 'Выбрать месяц', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-05-19T13:57:00.000+0300') on conflict on constraint cin_u_localization_1 do update set ck_id = excluded.ck_id, ck_d_lang = excluded.ck_d_lang, cr_namespace = excluded.cr_namespace, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)VALUES('84956bf9e0a44fa58e34c538f92473a3', 'ru_RU', 'static', 'Выбрать год', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-05-19T13:57:00.000+0300') on conflict on constraint cin_u_localization_1 do update set ck_id = excluded.ck_id, ck_d_lang = excluded.ck_d_lang, cr_namespace = excluded.cr_namespace, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)VALUES('82b334d3e0b74459b3d1362344920d74', 'ru_RU', 'static', 'Выбрать десятилетие', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-05-19T13:57:00.000+0300') on conflict on constraint cin_u_localization_1 do update set ck_id = excluded.ck_id, ck_d_lang = excluded.ck_d_lang, cr_namespace = excluded.cr_namespace, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)VALUES('5cc2e62d672e4f698c1707221ffb29ef', 'ru_RU', 'static', 'YYYY', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-05-19T13:57:00.000+0300') on conflict on constraint cin_u_localization_1 do update set ck_id = excluded.ck_id, ck_d_lang = excluded.ck_d_lang, cr_namespace = excluded.cr_namespace, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)VALUES('c4687c6bb79e48aa8898d62d65f7b081', 'ru_RU', 'static', 'D-M-YYYY', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-05-19T13:57:00.000+0300') on conflict on constraint cin_u_localization_1 do update set ck_id = excluded.ck_id, ck_d_lang = excluded.ck_d_lang, cr_namespace = excluded.cr_namespace, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)VALUES('1bc42c0b876c40a3b601d5b8b63517c4', 'ru_RU', 'static', 'D', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-05-19T13:57:00.000+0300') on conflict on constraint cin_u_localization_1 do update set ck_id = excluded.ck_id, ck_d_lang = excluded.ck_d_lang, cr_namespace = excluded.cr_namespace, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)VALUES('deece5fcda5247a793d5e3ed54e05593', 'ru_RU', 'static', 'D-M-YYYY HH:mm:ss', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-05-19T13:57:00.000+0300') on conflict on constraint cin_u_localization_1 do update set ck_id = excluded.ck_id, ck_d_lang = excluded.ck_d_lang, cr_namespace = excluded.cr_namespace, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)VALUES('4b15fb094f164e5b9b39cfb9e7abc809', 'ru_RU', 'static', 'true', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-05-19T13:57:00.000+0300') on conflict on constraint cin_u_localization_1 do update set ck_id = excluded.ck_id, ck_d_lang = excluded.ck_d_lang, cr_namespace = excluded.cr_namespace, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)VALUES('f4e21fd3f2824dfa9d8f120b2b0a9705', 'ru_RU', 'static', 'Предыдущий месяц (PageUp)', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-05-19T13:57:00.000+0300') on conflict on constraint cin_u_localization_1 do update set ck_id = excluded.ck_id, ck_d_lang = excluded.ck_d_lang, cr_namespace = excluded.cr_namespace, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)VALUES('914c30e709ca47e0961c6a5b34a141a7', 'ru_RU', 'static', 'Следующий месяц (PageDown)', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-05-19T13:57:00.000+0300') on conflict on constraint cin_u_localization_1 do update set ck_id = excluded.ck_id, ck_d_lang = excluded.ck_d_lang, cr_namespace = excluded.cr_namespace, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)VALUES('ea43acee3f454d1e9c5c0afa1a2f3c22', 'ru_RU', 'static', 'Предыдущий год (Control + left)', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-05-19T13:57:00.000+0300') on conflict on constraint cin_u_localization_1 do update set ck_id = excluded.ck_id, ck_d_lang = excluded.ck_d_lang, cr_namespace = excluded.cr_namespace, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)VALUES('5def211033c3430392621f6c530e418d', 'ru_RU', 'static', 'Следующий год (Control + right)', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-05-19T13:57:00.000+0300') on conflict on constraint cin_u_localization_1 do update set ck_id = excluded.ck_id, ck_d_lang = excluded.ck_d_lang, cr_namespace = excluded.cr_namespace, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)VALUES('11c8e521d1e74313826367d328cd1c92', 'ru_RU', 'static', 'Предыдущее десятилетие', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-05-19T13:57:00.000+0300') on conflict on constraint cin_u_localization_1 do update set ck_id = excluded.ck_id, ck_d_lang = excluded.ck_d_lang, cr_namespace = excluded.cr_namespace, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)VALUES('2b4d49c7238c4c2b8084279eb406730c', 'ru_RU', 'static', 'Следущее десятилетие', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-05-19T13:57:00.000+0300') on conflict on constraint cin_u_localization_1 do update set ck_id = excluded.ck_id, ck_d_lang = excluded.ck_d_lang, cr_namespace = excluded.cr_namespace, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)VALUES('82825a8b65a84e6abf3637c9f1a3de39', 'ru_RU', 'static', 'Предыдущий век', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-05-19T13:57:00.000+0300') on conflict on constraint cin_u_localization_1 do update set ck_id = excluded.ck_id, ck_d_lang = excluded.ck_d_lang, cr_namespace = excluded.cr_namespace, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)VALUES('9d105387e4e140f898d5abd0fd8a4db6', 'ru_RU', 'static', 'Следующий век', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-05-19T13:57:00.000+0300') on conflict on constraint cin_u_localization_1 do update set ck_id = excluded.ck_id, ck_d_lang = excluded.ck_d_lang, cr_namespace = excluded.cr_namespace, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;

--changeset kutsenko_o:CORE-1782 dbms:postgresql
-- Object insert, update to insert-editing, update-editing
update s_mt.t_object_attr set cv_value = cv_value || '-editing'
	where ck_id in (
		select toa.ck_id from s_mt.t_class_attr tca
			join s_mt.t_class_attr tca2 on tca.ck_class = tca2.ck_class and tca2.ck_attr = 'visibleinwindow'
			join s_mt.t_object_attr toa on tca.ck_id = toa.ck_class_attr 
			join s_mt.t_object o on o.ck_id = toa.ck_object 
			left join s_mt.t_object_attr toa2 on toa2.ck_object = o.ck_id and toa2.ck_class_attr = tca2.ck_id
            left join s_mt.t_page_object po on po.ck_object = o.ck_id
			left join s_mt.t_page_object_attr tpoa on tpoa.ck_page_object = po.ck_id and tpoa.ck_class_attr = tca2.ck_id
			where tca.ck_attr = 'editmode' and toa.cv_value in ('insert', 'update') 
            and (tpoa.cv_value = 'true' or toa2.cv_value = 'true' or (tpoa.cv_value is null and toa2.cv_value is null and tca2.cv_value = 'true'))
	);

-- Object disabled to hidden
update s_mt.t_object_attr set cv_value = 'hidden'
	where ck_id in (
		select tca.ck_id from s_mt.t_class_attr tca
			join s_mt.t_class_attr tca2 on tca.ck_class = tca2.ck_class and tca2.ck_attr = 'visibleinwindow'
			join s_mt.t_object_attr toa on tca.ck_id = toa.ck_class_attr 
			join s_mt.t_object o on o.ck_id = toa.ck_object 
			left join s_mt.t_object_attr toa2 on toa2.ck_object = o.ck_id and toa2.ck_class_attr = tca2.ck_id
            left join s_mt.t_page_object po on po.ck_object = o.ck_id
			left join s_mt.t_page_object_attr tpoa on tpoa.ck_page_object = po.ck_id and tpoa.ck_class_attr = tca2.ck_id
			where tca.ck_attr = 'editmode' and toa.cv_value = 'disabled' 
            and (tpoa.cv_value = 'false' or toa2.cv_value = 'false' or (tpoa.cv_value is null and toa2.cv_value is null and tca2.cv_value = 'false'))
	);

-- Page insert, update to insert-editing, update-editing
update s_mt.t_page_object_attr set cv_value = cv_value || '-editing'
	where ck_id in (
		select tpoa.ck_id from s_mt.t_class_attr tca
			join s_mt.t_class_attr tca2 on tca.ck_class = tca2.ck_class and tca2.ck_attr = 'visibleinwindow'
			join s_mt.t_page_object_attr tpoa on tca.ck_id = tpoa.ck_class_attr
            join s_mt.t_page_object tpo on tpo.ck_id = tpoa.ck_page_object
			join s_mt.t_object o on o.ck_id = tpo.ck_object 
			left join s_mt.t_object_attr toa2 on toa2.ck_object = o.ck_id and toa2.ck_class_attr = tca2.ck_id
			left join s_mt.t_page_object_attr tpoa2 on tpoa.ck_page_object = tpo.ck_id and tpoa.ck_class_attr = tca2.ck_id
			where tca.ck_attr = 'editmode' and tpoa.cv_value in ('insert', 'update') 
            and (tpoa2.cv_value = 'true' or toa2.cv_value = 'true' or (tpoa2.cv_value is null and toa2.cv_value is null and tca2.cv_value = 'true'))
	);

-- Page disabled to hidden
update s_mt.t_page_object_attr set cv_value = 'hidden'
	where ck_id in (
		select tpoa.ck_id from s_mt.t_class_attr tca
			join s_mt.t_class_attr tca2 on tca.ck_class = tca2.ck_class and tca2.ck_attr = 'visibleinwindow'
			join s_mt.t_page_object_attr tpoa on tca.ck_id = tpoa.ck_class_attr
            join s_mt.t_page_object tpo on tpo.ck_id = tpoa.ck_page_object
			join s_mt.t_object o on o.ck_id = tpo.ck_object 
			left join s_mt.t_object_attr toa2 on toa2.ck_object = o.ck_id and toa2.ck_class_attr = tca2.ck_id
			left join s_mt.t_page_object_attr tpoa2 on tpoa.ck_page_object = tpo.ck_id and tpoa.ck_class_attr = tca2.ck_id
			where tca.ck_attr = 'editmode' and tpoa.cv_value = 'hidden' 
            and (tpoa2.cv_value = 'false' or toa2.cv_value = 'false' or (tpoa2.cv_value is null and toa2.cv_value is null and tca2.cv_value = 'false'))
	);

--changeset kutsenko_o:CORE-1782-visibleinwindow dbms:postgresql
-- Object: remove value for visibleinwindow
delete from s_mt.t_object_attr where ck_class_attr in (
	select tca.ck_id from s_mt.t_class_attr tca
		where tca.ck_attr = 'visibleinwindow'
);

-- Page: remove value for visibleinwindow
delete from s_mt.t_page_object_attr where ck_class_attr in (
	select tca.ck_id from s_mt.t_class_attr tca
		where tca.ck_attr = 'visibleinwindow'
);

-- Remove visibleinwindow attribute for all classes
delete from s_mt.t_class_attr where ck_attr = 'visibleinwindow';
