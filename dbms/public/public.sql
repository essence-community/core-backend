--liquibase formatted sql
--changeset artemov_i:public_init dbms:postgresql splitStatements:false stripComments:false
create or replace function public.sys_guid()
returns varchar as
$$
begin
  return upper(replace(uuid_generate_v4()::varchar, '-', ''));
end;
$$language plpgsql;

create table public.dual(dummy varchar);
insert into public.dual(dummy) values('X');

--changeset artemov_i:var dbms:postgresql

create domain public.ct_varchar as varchar[];
create type public.ct_msg_macro as (ck_id bigint, ck_message bigint, ct_macro ct_varchar);

--changeset artemov_i:copy_object dbms:postgresql
create type public.ot_copy_object AS(
  ck_id_origin varchar(32),
  ck_id_new varchar(32),
  ck_class varchar(32),
  ck_parent varchar(32),
  cv_name varchar(50),
  cn_order bigint,
  ck_query varchar(255),
  cv_description varchar(2000),
  cv_displayed varchar(255),
  cv_modify varchar(255),
	ck_provider varchar(10),
	cn_level bigint
);

--changeset artemov_i:refresh_page dbms:postgresql splitStatements:false stripComments:false

CREATE TYPE public.ot_relation as
( cv_path_id varchar, /* путь самого объекта */
  cv_path_master_id varchar /* ИД объекта-мастера */
);


CREATE TYPE public.ot_save_poa as
(cv_path varchar, /* путь к объекту */
 ck_class_attr varchar(32), /* ИД атрибута класса (из POA) */
 cv_value varchar(2000), /* Значение атрибута (из POA) */
 ck_user varchar(150),
 ct_change timestamptz
);


create type public.ot_po_and_path as
(
  ck_page_object varchar(32),
  cv_path        varchar
);

create type public.ot_attr as (ck_id varchar,
                               cv_description varchar,
                               ck_attr_type varchar);
--changeset artemov_i:user dbms:postgresql

create type public.ot_user as
 (
  ck_id         varchar(150),
  cv_login      varchar(30),
  cv_surname    varchar(2000),
  cv_name       varchar(2000),
  cv_patronymic varchar(2000),
  cv_email      varchar(150),
  cct_data      json
);

create domain public.ct_user as public.ot_user[];

create type public.ot_user_action as
(
  ck_user varchar(150),
  cn_action bigint
);

create domain public.ct_user_action as public.ot_user_action[];

create type public.ot_user_department as
 (
  ck_user varchar(150),
  ck_department bigint
);

create domain public.ct_user_department as public.ot_user_department[];


--changeset artemov_i:log dbms:postgresql
CREATE SEQUENCE public.seq_log
 INCREMENT 1 MINVALUE 1
 START 1 CACHE 1;


--changeset artemov_i:notify dbms:postgresql splitStatements:false stripComments:false
CREATE OR REPLACE FUNCTION public.notify_event() RETURNS TRIGGER AS $$
  DECLARE
    record RECORD;
    payload JSON;
  BEGIN
    IF (TG_OP = 'DELETE') THEN
      record = OLD;
    ELSE
      record = NEW;
    END IF;

    payload = json_build_object('table', TG_TABLE_NAME,
                                'action', TG_OP,
                                'data', row_to_json(record));

    PERFORM pg_notify('events', payload::text);

    RETURN NULL;
  END;
$$ LANGUAGE plpgsql;
