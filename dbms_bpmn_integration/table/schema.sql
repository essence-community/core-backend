--liquibase formatted sql
--changeset artemov_i:init_schema_bpmn dbms:postgresql splitStatements:false stripComments:false
CREATE SCHEMA ${user.table};

CREATE TABLE ${user.table}.t_log
(
    ck_id varchar(32) NOT NULL,
    cv_session varchar(100),
    cc_json text,
    cv_table varchar(4000),
    cv_id varchar(4000),
    cv_action varchar(30),
    cv_error varchar(4000),
    ck_user varchar(150) NOT NULL,
    ct_change timestamp with time zone NOT NULL,
    CONSTRAINT cin_p_log PRIMARY KEY (ck_id)
);

COMMENT ON TABLE ${user.table}.t_log IS 'Лог';
COMMENT ON COLUMN ${user.table}.t_log.ck_id IS 'ИД записи лога';
COMMENT ON COLUMN ${user.table}.t_log.cv_session IS 'ИД сессии';
COMMENT ON COLUMN ${user.table}.t_log.cc_json IS 'JSON';
COMMENT ON COLUMN ${user.table}.t_log.cv_table IS 'Имя таблицы';
COMMENT ON COLUMN ${user.table}.t_log.cv_id IS 'ИД записи в таблице';
COMMENT ON COLUMN ${user.table}.t_log.cv_action IS 'ИД действия';
COMMENT ON COLUMN ${user.table}.t_log.cv_error IS 'Код ошибки';
COMMENT ON COLUMN ${user.table}.t_log.ck_user IS 'ИД пользователя';
COMMENT ON COLUMN ${user.table}.t_log.ct_change IS 'Дата последнего изменения';

CREATE TABLE ${user.table}.t_d_interface 
  (	ck_id varchar(50) not null, 
    cv_description varchar(500),
	ck_user varchar(150) NOT NULL,
    ct_change timestamp with time zone NOT NULL, 
    CONSTRAINT cin_p_d_interface PRIMARY KEY (ck_id)
  );

COMMENT ON COLUMN ${user.table}.t_d_interface.ck_id is 'ИД типа интегр. интерфейса';
COMMENT ON COLUMN ${user.table}.t_d_interface.cv_description is 'Имя';
COMMENT ON COLUMN ${user.table}.t_d_interface.ck_user IS 'ИД пользователя аудит';
COMMENT ON COLUMN ${user.table}.t_d_interface.ct_change IS 'Время модификации аудит';
COMMENT ON TABLE ${user.table}.t_d_interface is 'Тип интеграционного интерфейса';

CREATE TABLE ${user.table}.t_d_provider 
   (	ck_id varchar(50) not null, 
	    cv_description varchar(500),
		ck_user varchar(150) NOT NULL,
    	ct_change timestamp with time zone NOT NULL, 
	    CONSTRAINT cin_p_d_provider PRIMARY KEY (ck_id)
  );

COMMENT ON COLUMN ${user.table}.t_d_provider.ck_id IS 'ИД источника данных';
COMMENT ON COLUMN ${user.table}.t_d_provider.cv_description IS 'Имя';
COMMENT ON COLUMN ${user.table}.t_d_provider.ck_user IS 'ИД пользователя аудит';
COMMENT ON COLUMN ${user.table}.t_d_provider.ct_change IS 'Время модификации аудит';
COMMENT ON TABLE ${user.table}.t_d_provider  IS 'Источник данных';

CREATE TABLE ${user.table}.t_interface 
   (	
    ck_id VARCHAR(50) NOT NULL, 
	ck_d_interface VARCHAR(50) NOT NULL, 
	ck_d_provider VARCHAR(50) NOT NULL, 
	cc_query TEXT, 
	cv_description VARCHAR(4000),
	ck_user varchar(150) NOT NULL,
    ct_change timestamp with time zone NOT NULL, 
	CONSTRAINT cin_p_interface PRIMARY KEY (ck_id), 
	CONSTRAINT cin_r_interface_1 FOREIGN KEY (ck_d_interface)
	  REFERENCES ${user.table}.t_d_interface (ck_id), 
	CONSTRAINT cin_r_interface_2 FOREIGN KEY (ck_d_provider)
	  REFERENCES ${user.table}.t_d_provider (ck_id)
   );

COMMENT ON COLUMN ${user.table}.t_interface.ck_id IS 'ИД интеграционного интерфейса';
COMMENT ON COLUMN ${user.table}.t_interface.ck_d_interface IS 'ИД типа интегр. интерфейса';
COMMENT ON COLUMN ${user.table}.t_interface.ck_d_provider IS 'ИД источника данных';
COMMENT ON COLUMN ${user.table}.t_interface.cc_query IS 'Текст запроса получения данных';
COMMENT ON COLUMN ${user.table}.t_interface.cv_description IS 'Описание интерфейса';
COMMENT ON COLUMN ${user.table}.t_interface.ck_user IS 'ИД пользователя аудит';
COMMENT ON COLUMN ${user.table}.t_interface.ct_change IS 'Время модификации аудит';
COMMENT ON TABLE ${user.table}.t_interface IS 'Интеграционный интерфейс';

CREATE TABLE ${user.table}.t_scenario
   (	
    ck_id VARCHAR(50) NOT NULL, 
	cc_scenario JSONB,
	cn_action BIGINT, 
	cv_description VARCHAR(4000),
	ck_user varchar(150) NOT NULL,
    ct_change timestamp with time zone NOT NULL, 
	CONSTRAINT cin_p_scenario PRIMARY KEY (ck_id)
   );
COMMENT ON COLUMN ${user.table}.t_scenario.ck_id IS 'ИД интеграционного интерфейса';
COMMENT ON COLUMN ${user.table}.t_scenario.cc_scenario IS 'JSON сценарий';
COMMENT ON COLUMN ${user.table}.t_scenario.cv_description IS 'Описание интерфейса';
COMMENT ON COLUMN ${user.table}.t_scenario.cn_action IS 'Код действия';
COMMENT ON COLUMN ${user.table}.t_scenario.ck_user IS 'ИД пользователя аудит';
COMMENT ON COLUMN ${user.table}.t_scenario.ct_change IS 'Время модификации аудит';
COMMENT ON TABLE ${user.table}.t_scenario IS 'BPM сценарий';

CREATE TABLE ${user.table}.t_create_patch (
	ck_id uuid NOT NULL,
	cv_file_name varchar(200) NOT NULL,
	ck_user varchar(100) NOT NULL,
	ct_change timestamptz NOT NULL,
	сj_param jsonb NOT NULL,
	cd_create date NOT NULL,
	cn_size bigint NULL,
	CONSTRAINT cin_p_create_patch PRIMARY KEY (ck_id)
);
COMMENT ON COLUMN ${user.table}.t_create_patch.ck_id IS 'Идентификатор';
COMMENT ON COLUMN ${user.table}.t_create_patch.cv_file_name IS 'Наименование файла';
COMMENT ON COLUMN ${user.table}.t_create_patch.ck_user IS 'Аудит идентификатор пользователя';
COMMENT ON COLUMN ${user.table}.t_create_patch.ct_change IS 'Аудит время модификации';
COMMENT ON COLUMN ${user.table}.t_create_patch.сj_param IS 'Параметры запуска';
COMMENT ON COLUMN ${user.table}.t_create_patch.cd_create IS 'Дата сборки';
COMMENT ON COLUMN ${user.table}.t_create_patch.cn_size IS 'Размер сборки';
