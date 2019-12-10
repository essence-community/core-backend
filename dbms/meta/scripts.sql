--liquibase formatted sql
--changeset artemov_i:CORE-601 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
select pkg_patcher.p_update_localization();