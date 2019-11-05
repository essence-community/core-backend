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
