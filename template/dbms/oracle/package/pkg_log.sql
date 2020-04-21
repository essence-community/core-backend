--liquibase formatted sql
--changeset artemov_i:pkg_log dbms:oracle runOnChange:true endDelimiter:/ splitStatements:true stripComments:false
create or replace package ${user.update}.pkg_log is

  -- Author  : VYSKREBENTSEV
  -- Created : 28.08.2017
  -- Purpose : Логирование - БФЛ ЖКХ
  /*---------------------------------------------------------------------------------*/
  /* Версия пакета (Редактируется АВТОМАТИЧЕСКИ, НЕ ПРАВИТЬ руками!) */
  function get_ver return varchar2;
  /*---------------------------------------------------------------------------------*/
  procedure p_save(pv_user    in varchar2,
                   pv_session in varchar2,
                   pc_json    in clob,
                   pv_table  in varchar2,
                   pv_id      in varchar2,
                   pv_action  in varchar2);
  /*---------------------------------------------------------------------------------*/
end pkg_log;
/
create or replace package body ${user.update}.pkg_log is
  /*---------------------------------------------------------------------------------*/
  --Версия пакета (Редактируется АВТОМАТИЧЕСКИ, НЕ ПРАВИТЬ руками!)
  function get_ver return varchar2 is
  begin
    return '$Revision:ce00e28fd6a6df625757f662e5e93951b1e5c2f2$ modified $RevDate:02.04.2018 16:14:36$ by $Author:Roshupkin$';
  end get_ver;
  /*---------------------------------------------------------------------------------*/
  procedure p_save(pv_user    in varchar2,
                   pv_session in varchar2,
                   pc_json    in clob,
                   pv_table  in varchar2,
                   pv_id      in varchar2,
                   pv_action  in varchar2) is
    pragma autonomous_transaction;
    vv_error varchar2(10000) := pkg.gv_error;
  begin
    insert into t_log
      (ck_id, cv_session, cc_json, cv_table, cv_id, cv_action, cv_error, ck_user, ct_change)
    values
      (seq_log.nextval, pv_session, pc_json, pv_table, pv_id, pv_action, vv_error, pv_user, systimestamp);
    commit;
  end p_save;
  /*---------------------------------------------------------------------------------*/
end pkg_log;
/