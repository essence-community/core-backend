--liquibase formatted sql
--changeset artemov_i:UPDEV-6614 dbms:postgresql splitStatements:false stripComments:false
delete from s_mt.t_page_object_attr poa
where poa.ck_class_attr in (select ck_id from s_mt.t_class_attr ca where ca.ck_attr = 'clipboardpastetype');
delete from s_mt.t_object_attr oa
where oa.ck_class_attr in (select ck_id from s_mt.t_class_attr ca where ca.ck_attr = 'clipboardpastetype');
delete from s_mt.t_class_attr ca where ca.ck_attr = 'clipboardpastetype';

--changeset artemov_i:UPDEV-6644 dbms:postgresql splitStatements:false stripComments:false
INSERT INTO s_mt.t_attr(ck_id, cv_description, ck_attr_type, ck_d_data_type, cv_data_type_extra, ck_user, ct_change)VALUES('defaultisclear', 'При очистке выставлять defaultvalue если заполнен', 'basic', 'boolean', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2024-06-06T20:12:05.016+0000') on conflict (ck_id) do update set cv_description = excluded.cv_description, ck_attr_type = excluded.ck_attr_type, ck_d_data_type = excluded.ck_d_data_type, cv_data_type_extra = excluded.cv_data_type_extra, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
UPDATE s_mt.t_class_attr
SET ck_attr='defaultisclear'
WHERE ck_attr='notisempty';
