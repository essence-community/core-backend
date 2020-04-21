--liquibase formatted sql
--changeset artemov_i:pkg_json_user dbms:oracle runOnChange:true endDelimiter:/ splitStatements:true stripComments:false
create or replace package ${user.update}.pkg_json_user is

  -- author  : roshupkin
  -- created : 02.02.2018 13:12:46
  -- purpose : Работа с gtt с информацией по пользователям

  /* В параметр pv_hash во всех методах приходит актуальный хэш JSON-а со шлюза (в части соответствующих данных, заливаемых в tt_* */

  /*---------------------------------------------------------------------------------*/
  function f_get_ver return varchar2;
  /*---------------------------------------------------------------------------------*/
  function f_modify_user(pc_json in clob,
                         pv_hash in varchar2) return varchar2;
  /*---------------------------------------------------------------------------------*/
  function f_modify_user_action(pc_json in clob,
                                pv_hash in varchar2) return varchar2;
  /*---------------------------------------------------------------------------------*/
  function f_modify_user_department(pc_json in clob,
                                    pv_hash in varchar2) return varchar2;
  /*---------------------------------------------------------------------------------*/
  /* Получение значения нужного контекста */
  function f_get_context(pv_attribute varchar2) return varchar2 deterministic;
  /*---------------------------------------------------------------------------------*/

end pkg_json_user;
/
create or replace package body ${user.update}.pkg_json_user is

  /*---------------------------------------------------------------------------------*/
  --Версия пакета (Редактируется АВТОМАТИЧЕСКИ, НЕ ПРАВИТЬ руками!)
  function f_get_ver return varchar2 is
  begin
    return '$Revision:571eee93600cc304bd450607e9bb9b95d34830db$ modified $RevDate:16.04.2018 10:42:17$ by $Author:Roshupkin$';
  end f_get_ver;

  function f_modify_user(pc_json in clob,
                         pv_hash in varchar2) return varchar2 is
    vct_user ct_user;
  begin
    -- Обнулим глобальные переменные с перечнем ошибок/предупреждений/информационных сообщений
    pkg.p_reset_response;
    -- JSON -> collection
    select ot_user(
           trim(jt.ck_id),
           jt.cct_data,
           trim(jt.cv_login),
           trim(jt.cv_surname),
           trim(jt.cv_name),
           trim(jt.cv_patronymic),
           trim(jt.cv_email)
           )
      bulk collect
      into vct_user
      from json_table(pc_json,
                      '$[*]' columns
                      ck_id varchar2(4000 char) path '$.ck_id',
                      cct_data clob FORMAT JSON path '$' error on error,
                      cv_login varchar2(4000 char) path '$.cv_login' error on error,
                      cv_surname varchar2(4000 char) path '$.cv_surname' error on error,
                      cv_name varchar2(4000 char) path '$.cv_name' error on error,
                      cv_patronymic varchar2(4000 char) path '$.cv_patronymic' error on error,
                      cv_email varchar2(4000 char) path '$.cv_email' error on error) jt;
    -- Проверим и сохраним данные
    pkg_user.p_modify_user(vct_user, pv_hash);
    return '{"ck_id":null,"cv_error":' || pkg.p_form_response || '}';
  end f_modify_user;
  /*---------------------------------------------------------------------------------*/
  function f_modify_user_action(pc_json in clob,
                                pv_hash in varchar2) return varchar2 is
    vct_user_action ct_user_action;
  begin
    -- Обнулим глобальные переменные с перечнем ошибок/предупреждений/информационных сообщений
    pkg.p_reset_response;
    -- JSON -> collection
    select ot_user_action(
           trim(jt.ck_user),
           trim(jt.cn_action)
           )
      bulk collect
      into vct_user_action
      from json_table(pc_json,
                      '$[*]' columns
                      ck_user varchar2(4000 char) path '$.ck_user',
                      cn_action varchar2(4000 char) path '$.cn_action') jt;
    -- Проверим и сохраним данные
    pkg_user.p_modify_user_action(vct_user_action, pv_hash);
    return '{"ck_user":null,"cv_error":' || pkg.p_form_response || '}';
  end f_modify_user_action;
  /*---------------------------------------------------------------------------------*/
  function f_modify_user_department(pc_json in clob,
                                    pv_hash in varchar2) return varchar2 is
    vct_user_department ct_user_department;
  begin
    -- Обнулим глобальные переменные с перечнем ошибок/предупреждений/информационных сообщений
    pkg.p_reset_response;
    -- JSON -> collection
    select ot_user_department(
           trim(jt.ck_user),
           trim(jt.ck_department)
           )
      bulk collect
      into vct_user_department
      from json_table(pc_json,
                      '$[*]' columns
                      ck_user varchar2(4000 char) path '$.ck_user',
                      ck_department varchar2(4000 char) path '$.ck_department') jt;
    -- Проверим и сохраним данные
    pkg_user.p_modify_user_department(vct_user_department, pv_hash);
    return '{"ck_user":null,"cv_error":' || pkg.p_form_response || '}';
  end f_modify_user_department;
  /*---------------------------------------------------------------------------------*/
  function f_get_context(pv_attribute varchar2) return varchar2 deterministic
    is
  begin
    return pkg_user.f_get_context(pv_attribute);
  end;
  /*---------------------------------------------------------------------------------*/

end pkg_json_user;
/
