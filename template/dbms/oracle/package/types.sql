--liquibase formatted sql
--changeset artemov_i:types_tt dbms:oracle splitStatements:true stripComments:false
CREATE OR REPLACE EDITIONABLE TYPE ${user.update}."OT_USER_DEPARTMENT" AS OBJECT
 (
  ck_user         VARCHAR2(150),
  ck_department number
);
CREATE OR REPLACE EDITIONABLE TYPE ${user.update}."CT_USER_DEPARTMENT" AS TABLE OF ${user.update}.ot_user_department;
CREATE OR REPLACE EDITIONABLE TYPE ${user.update}."OT_USER_ACTION" AS OBJECT
 (
  ck_user         VARCHAR2(150),
  cn_action number
);
CREATE OR REPLACE EDITIONABLE TYPE ${user.update}."CT_USER_ACTION" AS TABLE OF ${user.update}.ot_user_action;
CREATE OR REPLACE EDITIONABLE TYPE ${user.update}."OT_USER" AS OBJECT
 (
  ck_id         VARCHAR2(150),
  cct_data      CLOB,
  cv_login      VARCHAR2(30),
  cv_surname    VARCHAR2(30),
  cv_name       VARCHAR2(30),
  cv_patronymic VARCHAR2(30),
  cv_email      VARCHAR2(150)
);
CREATE OR REPLACE EDITIONABLE TYPE ${user.update}."CT_USER" AS TABLE OF ${user.update}.ot_user;
--changeset artemov_i:types_pkg dbms:oracle splitStatements:true stripComments:false
CREATE OR REPLACE EDITIONABLE TYPE ${user.update}."CT_VARCHAR2" is table of varchar2(4000);
CREATE OR REPLACE EDITIONABLE TYPE ${user.update}."OT_MSG_MACRO" as object
(ck_id      number,
 ck_message number,
 ct_macro   ct_varchar2);
 CREATE OR REPLACE EDITIONABLE TYPE ${user.update}."CT_MSG_MACRO" is table of ${user.update}.ot_msg_macro;
create or replace type ${user.update}.ct_number as table of number;