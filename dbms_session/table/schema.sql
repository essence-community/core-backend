--liquibase formatted sql
--changeset artemov_i:init_schema_bpmn dbms:postgresql splitStatements:false stripComments:false
CREATE SCHEMA ${user.table};

-- ${user.table}.t_cache definition

-- Drop table

-- DROP TABLE ${user.table}.t_cache;

CREATE TABLE ${user.table}.t_cache (
	ct_create timestamptz NOT NULL DEFAULT now(), -- Аудит время создания записи
	ct_change timestamptz NOT NULL DEFAULT now(), -- Айдит время обновление записи
	ck_user varchar(100) NOT NULL DEFAULT 999999, -- Пользователь последний модифицирующий
	ck_id varchar NOT NULL, -- Идентификатор
	cct_data text NOT NULL, -- Данные
	CONSTRAINT cin_p_cache PRIMARY KEY (ck_id)
);

-- Column comments

COMMENT ON COLUMN ${user.table}.t_cache.ct_create IS 'Аудит время создания записи';
COMMENT ON COLUMN ${user.table}.t_cache.ct_change IS 'Айдит время обновление записи';
COMMENT ON COLUMN ${user.table}.t_cache.ck_user IS 'Пользователь последний модифицирующий';
COMMENT ON COLUMN ${user.table}.t_cache.ck_id IS 'Идентификатор';
COMMENT ON COLUMN ${user.table}.t_cache.cct_data IS 'Данные';
-- ${user.table}.t_session definition

-- Drop table

-- DROP TABLE ${user.table}.t_session;

CREATE TABLE ${user.table}.t_session (
	ct_create timestamptz NOT NULL DEFAULT now(), -- Аудит время создания записи
	ct_change timestamptz NOT NULL DEFAULT now(), -- Айдит время обновление записи
	ck_user varchar(100) NOT NULL DEFAULT 999999, -- Пользователь последний модифицирующий
	ck_id varchar NOT NULL, -- Идентификатор сессии
	cct_data text NOT NULL, -- Данные сессии
	ct_expire timestamptz NOT NULL, -- Дата истечения сессии
	cl_delete bool NULL, -- Признак удаления
	CONSTRAINT cin_p_session PRIMARY KEY (ck_id)
);
CREATE INDEX cin_i_session_1 ON ${user.table}.t_session USING btree (ct_expire);
CREATE INDEX cin_i_session_2 ON ${user.table}.t_session USING btree (ct_expire, cl_delete);

-- Column comments

COMMENT ON COLUMN ${user.table}.t_session.ct_create IS 'Аудит время создания записи';
COMMENT ON COLUMN ${user.table}.t_session.ct_change IS 'Айдит время обновление записи';
COMMENT ON COLUMN ${user.table}.t_session.ck_user IS 'Пользователь последний модифицирующий';
COMMENT ON COLUMN ${user.table}.t_session.ck_id IS 'Идентификатор сессии';
COMMENT ON COLUMN ${user.table}.t_session.cct_data IS 'Данные сессии';
COMMENT ON COLUMN ${user.table}.t_session.ct_expire IS 'Дата истечения сессии';
COMMENT ON COLUMN ${user.table}.t_session.cl_delete IS 'Признак удаления';

-- ${user.table}.t_user definition

-- Drop table

-- DROP TABLE ${user.table}.t_user;

CREATE TABLE ${user.table}.t_user (
	ct_create timestamptz NOT NULL DEFAULT now(), -- Аудит время создания записи
	ct_change timestamptz NOT NULL DEFAULT now(), -- Айдит время обновление записи
	ck_user varchar(100) NOT NULL DEFAULT 999999, -- Пользователь последний модифицирующий
	ck_id varchar NOT NULL, -- Идентификатор пользователя
	ck_d_provider varchar NOT NULL, -- Индетификатор провайдера
	cct_data text NOT NULL, -- Данные пользователя
	cv_login varchar NULL, -- Логин
	CONSTRAINT cin_p_user PRIMARY KEY (ck_id)
);

-- Column comments

COMMENT ON COLUMN ${user.table}.t_user.ct_create IS 'Аудит время создания записи';
COMMENT ON COLUMN ${user.table}.t_user.ct_change IS 'Айдит время обновление записи';
COMMENT ON COLUMN ${user.table}.t_user.ck_user IS 'Пользователь последний модифицирующий';
COMMENT ON COLUMN ${user.table}.t_user.ck_id IS 'Идентификатор пользователя';
COMMENT ON COLUMN ${user.table}.t_user.ck_d_provider IS 'Индетификатор провайдера';
COMMENT ON COLUMN ${user.table}.t_user.cct_data IS 'Данные пользователя';
COMMENT ON COLUMN ${user.table}.t_user.cv_login IS 'Логин';
