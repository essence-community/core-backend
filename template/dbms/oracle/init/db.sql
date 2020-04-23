--liquibase formatted sql
--changeset artemov_i:init_#user.connect# dbms:oracle splitStatements:false stripComments:false
create user ${user.connect} identified by ${user.connect}
  default tablespace USERS
  temporary tablespace TEMP
  profile DEFAULT
--changeset artemov_i:init_grant_#user.connect# dbms:oracle splitStatements:true stripComments:false
grant create session to ${user.connect};
grant debug connect session to ${user.connect};
--changeset artemov_i:init_#user.update# dbms:oracle splitStatements:false stripComments:false
create user ${user.update} identified by ${user.update}
  default tablespace USERS
  temporary tablespace TEMP
  profile DEFAULT
  password expire
--changeset artemov_i:init_#user.table# dbms:oracle splitStatements:false stripComments:false
create user ${user.table} identified by ${user.table}
  default tablespace USERS
  temporary tablespace TEMP
  profile DEFAULT
  password expire
--changeset artemov_i:init_grant_#user.table# dbms:oracle splitStatements:true stripComments:false
grant unlimited tablespace to ${user.table};