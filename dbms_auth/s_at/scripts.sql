--liquibase formatted sql
--changeset artemov_i:CORE-235 dbms:postgresql splitStatements:false stripComments:false
COMMENT ON COLUMN s_at.t_role_action.ck_id IS 'Идентификатор';
COMMENT ON COLUMN s_at.t_account_role.ck_id IS 'Идентификатор';

--changeset artemov_i:CORE-640 dbms:postgresql
CREATE TABLE s_at.t_create_patch (
	ck_id uuid NOT NULL,
	cv_file_name varchar(200) NOT NULL,
	ck_user varchar(100) NOT NULL,
	ct_change timestamptz NOT NULL,
	сj_param jsonb NOT NULL,
	cd_create date NOT NULL,
	cn_size bigint NULL,
	CONSTRAINT cin_p_create_patch PRIMARY KEY (ck_id)
);
COMMENT ON COLUMN s_at.t_create_patch.ck_id IS 'Идентификатор';
COMMENT ON COLUMN s_at.t_create_patch.cv_file_name IS 'Наименование файла';
COMMENT ON COLUMN s_at.t_create_patch.ck_user IS 'Аудит идентификатор пользователя';
COMMENT ON COLUMN s_at.t_create_patch.ct_change IS 'Аудит время модификации';
COMMENT ON COLUMN s_at.t_create_patch.сj_param IS 'Параметры запуска';
COMMENT ON COLUMN s_at.t_create_patch.cd_create IS 'Дата сборки';
COMMENT ON COLUMN s_at.t_create_patch.cn_size IS 'Размер сборки';

--changeset artemov_i:CORE-797_add_CONSTRAINT dbms:postgresql
ALTER TABLE s_at.t_account_info ADD CONSTRAINT cin_u_account_info_1 UNIQUE (ck_d_info,ck_account);

--changeset artemov_i:CORE-870_add_INDEX dbms:postgresql
CREATE UNIQUE INDEX cin_u_account_2 ON s_at.t_account (UPPER(cv_login));

--changeset artemov_i:CORE-225 dbms:postgresql
CREATE TRIGGER notify_account_event
AFTER INSERT OR UPDATE OR DELETE ON s_at.t_account
  FOR EACH ROW EXECUTE PROCEDURE notify_event();
CREATE TRIGGER notify_account_role_event
AFTER INSERT OR UPDATE OR DELETE ON s_at.t_account_role
  FOR EACH ROW EXECUTE PROCEDURE notify_event();
CREATE TRIGGER notify_account_info_event
AFTER INSERT OR UPDATE OR DELETE ON s_at.t_account_info
  FOR EACH ROW EXECUTE PROCEDURE notify_event();
CREATE TRIGGER notify_role_action_event
AFTER INSERT OR UPDATE OR DELETE ON s_at.t_role_action
  FOR EACH ROW EXECUTE PROCEDURE notify_event();
