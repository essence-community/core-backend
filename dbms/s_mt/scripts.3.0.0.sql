--liquibase formatted sql
--changeset artemov_i:add_md_type dbms:postgresql splitStatements:false stripComments:false
ALTER TABLE s_mt.t_d_attr_data_type ADD ck_parent varchar(50) NULL;
COMMENT ON COLUMN s_mt.t_d_attr_data_type.ck_parent IS 'Родительский тип';
ALTER TABLE s_mt.t_d_attr_data_type ADD CONSTRAINT cin_r_d_attr_data_type_1 FOREIGN KEY (ck_parent) REFERENCES s_mt.t_d_attr_data_type(ck_id);

--changeset artemov_i:add_md_type_2 dbms:postgresql splitStatements:false stripComments:false
UPDATE s_mt.t_d_attr_data_type
	SET ck_parent='array'
	WHERE ck_id='order';
UPDATE s_mt.t_d_attr_data_type
	SET ck_parent='array'
	WHERE ck_id='global';

--changeset artemov_i:added_page_history_update dbms:postgresql splitStatements:false stripComments:false
CREATE TABLE s_mt.t_page_update_history (
	ck_id varchar NOT NULL, -- Идентификатор страницы
	ct_change timestamp with time zone NOT NULL -- Время изменения
);

-- Column comments

COMMENT ON COLUMN s_mt.t_page_update_history.ck_id IS 'Идентификатор страницы';
COMMENT ON COLUMN s_mt.t_page_update_history.ct_change IS 'Время изменения';

CREATE TRIGGER notify_page_update_event
AFTER INSERT ON s_mt.t_page_update_history
  FOR EACH ROW EXECUTE PROCEDURE notify_event();

--changeset artemov_i:added_multi_page dbms:postgresql splitStatements:false stripComments:false
ALTER TABLE s_mt.t_page ADD cv_redirect_url varchar NULL;
COMMENT ON COLUMN s_mt.t_page.cv_redirect_url IS 'Ссылка на внешний ресурс';
ALTER TABLE s_mt.t_page ADD cl_multi int2 NOT NULL DEFAULT 0;
COMMENT ON COLUMN s_mt.t_page.cl_multi IS 'Признак что страницу можжно открывать во множестве';

--changeset artemov_i:added_check_action_unic dbms:postgresql splitStatements:false stripComments:false
ALTER TABLE s_mt.t_page_action ADD CONSTRAINT cin_c_page_action_2 UNIQUE (ck_page,cr_type);
