--liquibase formatted sql
--changeset patcher-core:classes_clean dbms:postgresql runOnChange:true splitStatements:false stripComments:false
delete from s_mt.t_attr a where a.ck_id not in (select ck_attr from s_mt.t_class_attr);
