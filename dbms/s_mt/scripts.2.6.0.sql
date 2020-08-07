--liquibase formatted sql
--changeset artemov_i:CORE-1311 dbms:postgresql
INSERT INTO s_mt.t_sys_setting (ck_id,ck_user,ct_change,cv_description)
	VALUES ('skip_update_action_page','4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-08-05 11:10:31.709','Пропустить обновление доступов у страниц') on conflict (ck_id) DO NOTHING;

--changeset artemov_i:CORE-1316 dbms:postgresql
ALTER TABLE s_mt.t_class_attr ADD cl_empty int2 NOT NULL DEFAULT 0;
COMMENT ON COLUMN s_mt.t_class_attr.cl_empty IS 'Признак того что значение может быть пустой строкой';

DELETE FROM s_mt.t_object_attr o_attr
WHERE nullif(o_attr.cv_value, '') is null and o_attr.ck_class_attr in (select ck_id from s_mt.t_class_attr where cl_empty = 0);

DELETE FROM s_mt.t_page_object_attr po_attr
WHERE nullif(po_attr.cv_value, '') is null and po_attr.ck_class_attr in (select ck_id from s_mt.t_class_attr where cl_empty = 0);

INSERT INTO s_mt.t_localization (ck_id,ck_d_lang,cr_namespace,cv_value,ck_user,ct_change)
	VALUES ('eea00f8cc53e471bbf7b8306e3927b5a','ru_RU','message','Необходимо указать значение','4fd05ca9-3a9e-4d66-82df-886dfa082113','2020-08-07 14:14:44.489') on conflict on constraint cin_u_localization_1 DO NOTHING;
