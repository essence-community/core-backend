--liquibase formatted sql
--changeset artemov_i:init_schema_default dbms:postgresql splitStatements:false stripComments:false
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
