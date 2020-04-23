--liquibase formatted sql
--changeset artemov_i:sequences_log dbms:oracle splitStatements:true stripComments:false
CREATE SEQUENCE  ${user.update}."SEQ_LOG"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 61521 CACHE 1000 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL;
