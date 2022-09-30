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
