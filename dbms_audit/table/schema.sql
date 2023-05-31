--liquibase formatted sql
--changeset artemov_i:init_audit_schema dbms:postgresql splitStatements:false stripComments:false
CREATE SCHEMA ${user.table};

-- ${user.table}.t_log definition

-- Drop table

-- DROP TABLE ${user.table}.t_log;

CREATE TABLE ${user.table}.t_log (
	ct_create timestamp NOT NULL DEFAULT now(), -- Аудит время создания записи
	ct_change timestamp NOT NULL DEFAULT now(), -- Айдит время обновление записи
	ck_user varchar(150) NOT NULL DEFAULT 999999, -- Пользователь последний модифицирующий
	ck_id varchar NOT NULL DEFAULT ${extensionSchema}.uuid_generate_v4(), -- Идентификатор
	ck_request varchar NOT NULL, -- Идентификатор запроса
	ck_query varchar NULL, -- Наименование запроса
	ck_page varchar NULL, -- Идентификатор страницы
	ck_page_object varchar NULL, -- Идентификатор объекта
	cct_request_data text NOT NULL DEFAULT '{}', -- Данные запроса
	cct_session_data text NOT NULL DEFAULT '{}', -- Данные сессии
	CONSTRAINT cin_p_log PRIMARY KEY (ck_id)
);

-- Column comments

COMMENT ON COLUMN ${user.table}.t_log.ct_create IS 'Аудит время создания записи';
COMMENT ON COLUMN ${user.table}.t_log.ct_change IS 'Айдит время обновление записи';
COMMENT ON COLUMN ${user.table}.t_log.ck_user IS 'Пользователь последний модифицирующий';
COMMENT ON COLUMN ${user.table}.t_log.ck_id IS 'Идентификатор';
COMMENT ON COLUMN ${user.table}.t_log.ck_request IS 'Идентификатор запроса';
COMMENT ON COLUMN ${user.table}.t_log.ck_query IS 'Наименование запроса';
COMMENT ON COLUMN ${user.table}.t_log.ck_page IS 'Идентификатор страницы';
COMMENT ON COLUMN ${user.table}.t_log.ck_page_object IS 'Идентификатор объекта';
COMMENT ON COLUMN ${user.table}.t_log.cct_request_data IS 'Данные запроса';
COMMENT ON COLUMN ${user.table}.t_log.cct_session_data IS 'Данные сессии';
