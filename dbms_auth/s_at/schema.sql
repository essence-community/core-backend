--liquibase formatted sql
--changeset artemov_i:s_at dbms:postgresql splitStatements:false stripComments:false
CREATE SCHEMA s_at;

CREATE TABLE s_at.t_log
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

COMMENT ON TABLE s_at.t_log
    IS 'Лог';

COMMENT ON COLUMN s_at.t_log.ck_id
    IS 'ИД записи лога';

COMMENT ON COLUMN s_at.t_log.cv_session
    IS 'ИД сессии';

COMMENT ON COLUMN s_at.t_log.cc_json
    IS 'JSON';

COMMENT ON COLUMN s_at.t_log.cv_table
    IS 'Имя таблицы';

COMMENT ON COLUMN s_at.t_log.cv_id
    IS 'ИД записи в таблице';

COMMENT ON COLUMN s_at.t_log.cv_action
    IS 'ИД действия';

COMMENT ON COLUMN s_at.t_log.cv_error
    IS 'Код ошибки';

COMMENT ON COLUMN s_at.t_log.ck_user
    IS 'ИД пользователя';

COMMENT ON COLUMN s_at.t_log.ct_change
    IS 'Дата последнего изменения';

CREATE TABLE s_at.t_d_info
(
    ck_id varchar(150) NOT NULL,
    cv_description varchar(2000) NOT NULL,
    cr_type varchar(20) NOT NULL,
    cl_required smallint NOT NULL DEFAULT 0,
    ck_user varchar(150) NOT NULL,
    ct_change timestamp with time zone NOT NULL,
    CONSTRAINT cin_p_d_info PRIMARY KEY (ck_id),
    CONSTRAINT cin_c_d_info_1 CHECK (cr_type in ('text', 'date', 'integer', 'numeric', 'boolean', 'textarea', 'custom'))
);

COMMENT ON TABLE s_at.t_d_info
    IS 'Дополнительные атрибуты';

COMMENT ON COLUMN s_at.t_d_info.ck_id
    IS 'Код поля';

COMMENT ON COLUMN s_at.t_d_info.cv_description
    IS 'Описание';

COMMENT ON COLUMN s_at.t_d_info.cr_type
    IS 'Тип значения';

COMMENT ON COLUMN s_at.t_d_info.cl_required
    IS 'Признак обязательности';

COMMENT ON COLUMN s_at.t_d_info.ck_user
    IS 'ИД пользователя аудит';

COMMENT ON COLUMN s_at.t_d_info.ct_change
    IS 'Время модификации';


CREATE INDEX cin_i_d_info_1
    ON s_at.t_d_info
    (cv_description);


CREATE TABLE s_at.t_account
(
    cv_surname varchar(200) NOT NULL,
    cv_name varchar(200) NOT NULL,
    cv_login varchar(100) NOT NULL,
    cv_hash_password varchar(500) NOT NULL,
    ck_id uuid NOT NULL DEFAULT public.uuid_generate_v4(),
    ck_user varchar(150) NOT NULL,
    ct_change timestamp with time zone NOT NULL,
    cv_timezone varchar(6) NOT NULL DEFAULT '+03:00'::varchar,
    cv_salt varchar(12) NOT NULL,
    cv_email varchar(100),
    cv_patronymic varchar(200),
    CONSTRAINT cin_p_account PRIMARY KEY (ck_id),
    CONSTRAINT cin_u_account_1 UNIQUE (cv_login)
);

COMMENT ON TABLE s_at.t_account
    IS 'Пользователи';

COMMENT ON COLUMN s_at.t_account.cv_surname
    IS 'Фамилия';

COMMENT ON COLUMN s_at.t_account.cv_name
    IS 'Имя';

COMMENT ON COLUMN s_at.t_account.cv_login
    IS 'Логин';

COMMENT ON COLUMN s_at.t_account.cv_hash_password
    IS 'Хэш пароля';

COMMENT ON COLUMN s_at.t_account.ck_id
    IS 'Идентификатор';

COMMENT ON COLUMN s_at.t_account.ck_user
    IS 'Идентификатор аудит';

COMMENT ON COLUMN s_at.t_account.ct_change
    IS 'Время модификации аудит';

COMMENT ON COLUMN s_at.t_account.cv_timezone
    IS 'Таймзона пользователя';

COMMENT ON COLUMN s_at.t_account.cv_salt
    IS 'Соль';

COMMENT ON COLUMN s_at.t_account.cv_email
    IS 'Email адрес';

COMMENT ON COLUMN s_at.t_account.cv_patronymic
    IS 'Отчество';


CREATE INDEX cin_i_account_2
    ON s_at.t_account (cv_name);

CREATE INDEX cin_i_account_3
    ON s_at.t_account (cv_surname);

CREATE TABLE s_at.t_account_info
(
    ck_account uuid NOT NULL,
    ck_d_info varchar(32) NOT NULL,
    cv_value text NOT NULL,
    ct_change timestamp with time zone NOT NULL,
    ck_user varchar(150) NOT NULL,
    ck_id uuid NOT NULL DEFAULT public.uuid_generate_v4(),
    CONSTRAINT cin_p_account_info PRIMARY KEY (ck_id)
);

COMMENT ON TABLE s_at.t_account_info
    IS 'Дополнительные атрибуты  пользователя';

COMMENT ON COLUMN s_at.t_account_info.ck_account
    IS 'Идентификатор пользователя';

COMMENT ON COLUMN s_at.t_account_info.ck_d_info
    IS 'Код поля';

COMMENT ON COLUMN s_at.t_account_info.cv_value
    IS 'Значение';

COMMENT ON COLUMN s_at.t_account_info.ct_change
    IS 'Время модификации аудит';

COMMENT ON COLUMN s_at.t_account_info.ck_user
    IS 'ИД пользователя аудит';

COMMENT ON COLUMN s_at.t_account_info.ck_id
    IS 'Идентификатор';

CREATE UNIQUE INDEX cin_i_account_info_1
    ON s_at.t_account_info (ck_d_info, ck_account);

CREATE INDEX cin_i_account_info_2
    ON s_at.t_account_info (ck_d_info);

CREATE TABLE s_at.t_role
(
    ck_id uuid NOT NULL DEFAULT public.uuid_generate_v4(),
    cv_name varchar(100) NOT NULL,
    cv_description varchar(200),
    ck_user varchar(150) NOT NULL,
    ct_change timestamp with time zone NOT NULL,
    CONSTRAINT cin_p_role PRIMARY KEY (ck_id),
    CONSTRAINT cin_u_role_1 UNIQUE (cv_name)
);

COMMENT ON TABLE s_at.t_role
    IS 'Роли';

COMMENT ON COLUMN s_at.t_role.ck_id
    IS 'Идентификатор роли';

COMMENT ON COLUMN s_at.t_role.cv_name
    IS 'Наименование';

COMMENT ON COLUMN s_at.t_role.cv_description
    IS 'Описание';

COMMENT ON COLUMN s_at.t_role.ck_user
    IS 'ИД пользователя аудит';

COMMENT ON COLUMN s_at.t_role.ct_change
    IS 'Время изменения';

CREATE UNIQUE INDEX cin_i_role_1
    ON s_at.t_role (cv_name);

CREATE TABLE s_at.t_action
(
    ck_id bigint NOT NULL,
    cv_name varchar(100) NOT NULL,
    cv_description varchar(200),
    ck_user varchar(150) NOT NULL,
    ct_change timestamp with time zone NOT NULL,
    CONSTRAINT cin_p_action PRIMARY KEY (ck_id),
    CONSTRAINT cin_u_action_1 UNIQUE (cv_name)
);

COMMENT ON TABLE s_at.t_action
    IS 'Действия';

COMMENT ON COLUMN s_at.t_action.ck_id
    IS 'Код действия';

COMMENT ON COLUMN s_at.t_action.cv_name
    IS 'Наименование';

COMMENT ON COLUMN s_at.t_action.cv_description
    IS 'Описание';

COMMENT ON COLUMN s_at.t_action.ck_user
    IS 'ИД пользователя аудит';

COMMENT ON COLUMN s_at.t_action.ct_change
    IS 'Время модификации аудит';

CREATE UNIQUE INDEX cin_i_action_1
    ON s_at.t_action (cv_name);

CREATE TABLE s_at.t_role_action
(
    ck_id uuid NOT NULL DEFAULT public.uuid_generate_v4(),
    ck_action bigint NOT NULL,
    ck_user varchar(150) NOT NULL,
    ct_change timestamp with time zone NOT NULL,
    ck_role uuid NOT NULL,
    CONSTRAINT cin_p_role_action PRIMARY KEY (ck_id),
    CONSTRAINT cin_u_role_action_1 UNIQUE (ck_action, ck_role),
    CONSTRAINT cin_r_role_action_1 FOREIGN KEY (ck_action)
        REFERENCES s_at.t_action (ck_id) MATCH SIMPLE
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,
    CONSTRAINT cin_r_role_action_2 FOREIGN KEY (ck_role)
        REFERENCES s_at.t_role (ck_id) MATCH SIMPLE
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
);

COMMENT ON TABLE s_at.t_role_action
    IS 'Связь ролей и действий';

COMMENT ON COLUMN s_at.t_role_action.ck_action
    IS 'Код действия';

COMMENT ON COLUMN s_at.t_role_action.ck_user
    IS 'ИД пользователя аудит';

COMMENT ON COLUMN s_at.t_role_action.ct_change
    IS 'Время модификации аудит';

COMMENT ON COLUMN s_at.t_role_action.ck_role
    IS 'Индетификатор роли';

CREATE UNIQUE INDEX cin_i_role_action
    ON s_at.t_role_action
    (ck_action, ck_role);

CREATE TABLE s_at.t_account_role
(
    ck_id uuid NOT NULL DEFAULT public.uuid_generate_v4(),
    ck_role uuid NOT NULL,
    ck_user varchar(150) NOT NULL,
    ct_change timestamp with time zone NOT NULL,
    ck_account uuid NOT NULL,
    CONSTRAINT cin_p_account_role PRIMARY KEY (ck_id),
    CONSTRAINT cin_u_account_role_1 UNIQUE (ck_account, ck_role),
    CONSTRAINT cin_r_account_role_1 FOREIGN KEY (ck_account)
        REFERENCES s_at.t_account (ck_id) MATCH SIMPLE
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,
    CONSTRAINT cin_r_account_role_2 FOREIGN KEY (ck_role)
        REFERENCES s_at.t_role (ck_id) MATCH SIMPLE
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
);


COMMENT ON TABLE s_at.t_account_role
    IS 'Связь пользователей и ролей';

COMMENT ON COLUMN s_at.t_account_role.ck_role
    IS 'Идентификатор роли';

COMMENT ON COLUMN s_at.t_account_role.ck_user
    IS 'ИД пользователя аудит';

COMMENT ON COLUMN s_at.t_account_role.ct_change
    IS 'Время модификации аудит';

COMMENT ON COLUMN s_at.t_account_role.ck_account
    IS 'Идентификатор пользователя';

CREATE UNIQUE INDEX cin_i_account_role
    ON s_at.t_account_role (ck_role, ck_account);

CREATE TABLE s_at.t_account_ext
(
    ck_account_int uuid,
    ck_account_ext varchar(150) NOT NULL,
    ck_provider varchar(20) NOT NULL,
    ck_user varchar(150) NOT NULL,
    ct_change timestamp with time zone NOT NULL,
    ck_id uuid NOT NULL DEFAULT public.uuid_generate_v4(),
    CONSTRAINT cin_p_account_ext PRIMARY KEY (ck_id),
    CONSTRAINT cin_u_account_ext_1 UNIQUE (ck_account_ext, ck_provider),
    CONSTRAINT cin_r_account_ext_1 FOREIGN KEY (ck_account_int)
        REFERENCES s_at.t_account (ck_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

COMMENT ON TABLE s_at.t_account_ext
    IS 'Таблица связи внешних пользователей с нашими';

COMMENT ON COLUMN s_at.t_account_ext.ck_account_int
    IS 'Идентификатор пользователя внутрений';

COMMENT ON COLUMN s_at.t_account_ext.ck_account_ext
    IS 'Идентификатор пользователя внешний';

COMMENT ON COLUMN s_at.t_account_ext.ck_provider
    IS 'Идентификатор провайдера';

COMMENT ON COLUMN s_at.t_account_ext.ck_user
    IS 'ИД пользователя аудит';

COMMENT ON COLUMN s_at.t_account_ext.ct_change
    IS 'Время модификации';

COMMENT ON COLUMN s_at.t_account_ext.ck_id
    IS 'Идентификатор';