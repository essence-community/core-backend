--liquibase formatted sql
--changeset artemov_i:CORE-235 dbms:postgresql splitStatements:false stripComments:false
COMMENT ON COLUMN s_at.t_role_action.ck_id IS 'Идентификатор';
COMMENT ON COLUMN s_at.t_account_role.ck_id IS 'Идентификатор';
