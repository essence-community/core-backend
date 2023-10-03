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

--changeset artemov_i:query_cache dbms:postgresql splitStatements:false stripComments:false
ALTER TABLE s_mt.t_query ADD cr_cache varchar NOT NULL DEFAULT 'off';
COMMENT ON COLUMN s_mt.t_query.cr_cache IS 'Режим кэширования';
ALTER TABLE s_mt.t_query ADD CONSTRAINT cin_c_query_3 CHECK (cr_cache in ('off','front','back','all'));
ALTER TABLE s_mt.t_query ADD cv_cache_key_param varchar NOT NULL DEFAULT '["json"]';
COMMENT ON COLUMN s_mt.t_query.cv_cache_key_param IS 'Наименование ключа для кэширования';
ALTER TABLE s_mt.t_query ADD CONSTRAINT cin_c_query_4 CHECK (jsonb_typeof(cv_cache_key_param::jsonb) = 'array');
