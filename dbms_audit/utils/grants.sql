--liquibase formatted sql
--changeset artemov_i:grants dbms:postgresql runAlways:true runOnChange:true splitStatements:false stripComments:false
--гранты на использование

GRANT USAGE ON SCHEMA ${user.table} TO ${user.connect};

GRANT USAGE ON SCHEMA ${extensionSchema} TO ${user.connect};


--гранты на выполнение

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE ${user.table}.t_log TO ${user.connect};

