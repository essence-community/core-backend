--liquibase formatted sql
--changeset artemov_i:fixed_type_ot_save_poa dbms:postgresql splitStatements:false stripComments:false
DROP TYPE public.ot_save_poa;

CREATE TYPE public.ot_save_poa as
(cv_path varchar, /* путь к объекту */
 ck_class_attr varchar(32), /* ИД атрибута класса (из POA) */
 cv_value varchar, /* Значение атрибута (из POA) */
 ck_user varchar(150),
 ct_change timestamptz
);

--changeset blackhawk-skat:optimization_use_index
CREATE UNIQUE INDEX cin_u_page_object_2 ON s_mt.t_page_object (UPPER(ck_id));