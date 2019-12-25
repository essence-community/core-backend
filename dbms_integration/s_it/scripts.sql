--liquibase formatted sql
--changeset artemov_i:CORE-640 dbms:postgresql
CREATE TABLE s_it.t_create_patch (
	ck_id uuid NOT NULL,
	cv_file_name varchar(200) NOT NULL,
	ck_user varchar(100) NOT NULL,
	ct_change timestamptz NOT NULL,
	сj_param jsonb NOT NULL,
	cd_create date NOT NULL,
	cn_size bigint NULL,
	CONSTRAINT cin_p_create_patch PRIMARY KEY (ck_id)
);
COMMENT ON COLUMN s_it.t_create_patch.ck_id IS 'Идентификатор';
COMMENT ON COLUMN s_it.t_create_patch.cv_file_name IS 'Наименование файла';
COMMENT ON COLUMN s_it.t_create_patch.ck_user IS 'Аудит идентификатор пользователя';
COMMENT ON COLUMN s_it.t_create_patch.ct_change IS 'Аудит время модификации';
COMMENT ON COLUMN s_it.t_create_patch.сj_param IS 'Параметры запуска';
COMMENT ON COLUMN s_it.t_create_patch.cd_create IS 'Дата сборки';
COMMENT ON COLUMN s_it.t_create_patch.cn_size IS 'Размер сборки';
