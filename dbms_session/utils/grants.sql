--liquibase formatted sql
--changeset artemov_i:grants dbms:postgresql runAlways:true runOnChange:true splitStatements:false stripComments:false
--гранты на использование

GRANT USAGE ON SCHEMA ${user.table} TO ${user.connect};

GRANT USAGE ON SCHEMA public TO ${user.connect};

GRANT USAGE ON SCHEMA public TO ${user.update};

GRANT USAGE ON SCHEMA ${user.table} TO ${user.update};


--гранты на выполнение

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE ${user.table}.t_cache TO ${user.update};
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE ${user.table}.t_session TO ${user.update};
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE ${user.table}.t_user TO ${user.update};
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE ${user.table}.t_cache TO ${user.connect};
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE ${user.table}.t_session TO ${user.connect};
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE ${user.table}.t_user TO ${user.connect};
