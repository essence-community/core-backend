--liquibase formatted sql
--changeset artemov_i:pkg_access dbms:oracle runOnChange:true endDelimiter:/ splitStatements:true stripComments:false
create or replace package ${user.update}.pkg_access is
  --Версия пакета (Редактируется АВТОМАТИЧЕСКИ, НЕ ПРАВИТЬ руками!)
  /*---------------------------------------------------------------------------------*/
  function f_get_ver return varchar2;
  /*---------------------------------------------------------------------------------*/
  procedure p_check_access(pn_user in number,
                           pk_main in varchar2 default null);
  /*---------------------------------------------------------------------------------*/
end pkg_access;
/
create or replace package body ${user.update}.pkg_access is

  --Версия пакета (Редактируется АВТОМАТИЧЕСКИ, НЕ ПРАВИТЬ руками!)
  function f_get_ver return varchar2 is
  begin
    return '$revision:f691415a7ccb5e613453aee9c30463f837bbbbd5$ modified $revdate:31.01.2018 16:13:44$ by $author:gladyshev aleksey$';
  end f_get_ver;
  /*---------------------------------------------------------------------------------*/
  procedure p_check_access(pn_user in number,
                           pk_main in varchar2 default null) is
  begin
    null; -- pkg.p_set_error();
  end p_check_access;
  /*---------------------------------------------------------------------------------*/
end pkg_access;
/