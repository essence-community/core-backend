--liquibase formatted sql
--changeset artemov_i:UPDEV-6614 dbms:postgresql splitStatements:false stripComments:false
delete from s_mt.t_page_object_attr poa
where poa.ck_class_attr in (select ck_id from s_mt.t_class_attr ca where ca.ck_attr = 'clipboardpastetype');
delete from s_mt.t_object_attr oa
where oa.ck_class_attr in (select ck_id from s_mt.t_class_attr ca where ca.ck_attr = 'clipboardpastetype');
delete from s_mt.t_class_attr ca where ca.ck_attr = 'clipboardpastetype';
