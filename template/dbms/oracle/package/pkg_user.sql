--liquibase formatted sql
--changeset artemov_i:pkg_user dbms:oracle runOnChange:true endDelimiter:/ splitStatements:true stripComments:false
create or replace package ${user.update}.pkg_user is

  -- author  : roshupkin
  -- created : 02.02.2018 13:13:37
  -- purpose : Работа с gtt с информацией по пользователям
  
  /* Структуру таблиц tt_* см. в схеме данных Метамодели */
  /* Все методы ниже работают по принципу: целиком таблицу очистить и залить всё заново */
  /* В параметр pv_hash во всех методах приходит актуальный хэш JSON-а со шлюза (в части соответствующих данных, заливаемых в tt_*  */

  --Версия пакета (Редактируется АВТОМАТИЧЕСКИ, НЕ ПРАВИТЬ руками!)
  /*---------------------------------------------------------------------------------*/
  function f_get_ver return varchar2;
  /*---------------------------------------------------------------------------------*/
  procedure p_modify_user(pct_user in ct_user,
                          pv_hash  in varchar2 default null);
  /*---------------------------------------------------------------------------------*/
  procedure p_modify_user_action(pct_user_action in ct_user_action,
                                 pv_hash         in varchar2 default null);
  /*---------------------------------------------------------------------------------*/
  procedure p_modify_user_department(pct_user_department in ct_user_department,
                                     pv_hash             in varchar2 default null);
  /*---------------------------------------------------------------------------------*/
  /* Установка контекстов, используется для выставления в сессиях актуальных хэшей */
  procedure p_set_context(pv_attribute varchar2,
                          pv_value varchar2);
  /*---------------------------------------------------------------------------------*/
  /* Получение значения нужного контекста */
  function f_get_context(pv_attribute varchar2) return varchar2 deterministic;
  /*---------------------------------------------------------------------------------*/                  

end pkg_user;
/
create or replace package body ${user.update}.pkg_user is

  C_CONTEXT_NAMESPACE constant varchar2(10) := 'ctx_m_user'; /* "m" means Metamodel */

  /*---------------------------------------------------------------------------------*/
  --Версия пакета (Редактируется АВТОМАТИЧЕСКИ, НЕ ПРАВИТЬ руками!)
  function f_get_ver return varchar2 is
  begin
    return '$Revision:6f2ea387cc98b1cc437f244c5608994c12a1cf03$ modified $RevDate:20.04.2018 16:56:23$ by $Author:Roshupkin$';
  end f_get_ver;
  /*---------------------------------------------------------------------------------*/
  /* Установка контекстов, используется для выставления в сессиях актуальных хэшей */
  procedure p_set_context(pv_attribute varchar2,
                          pv_value varchar2) is
  begin
    dbms_session.set_context(namespace => C_CONTEXT_NAMESPACE,
                             attribute => pv_attribute,
                             value => pv_value);
  end p_set_context;
  /*---------------------------------------------------------------------------------*/
  procedure p_modify_user(pct_user in ct_user,
                          pv_hash  in varchar2 default null) is
  begin
    /* очистим таблицу и связанные с ней */
    begin
      delete tt_user_action;
      delete tt_user_department;
      delete tt_user;
      p_set_context('hash_user', null);
    exception
      when pkg.gex_parentkey then
        pkg.p_set_error(29);
      when pkg.gex_childrecords then
        pkg.p_set_error(29);
    end;
    /* зальем новые данные */
    if pkg.gv_error is null then
      insert into tt_user
      select t.* from table(pct_user)t;
      commit;
      /* выставим контекст */
      for vcur_cnt in (select count(1) from tt_user group by 1) loop
        p_set_context('hash_user', pv_hash);
      end loop;
    end if;
  end p_modify_user;
  /*---------------------------------------------------------------------------------*/
  procedure p_modify_user_action(pct_user_action in ct_user_action,
                                 pv_hash         in varchar2 default null) is
  begin
    /* очистим таблицу */
    delete tt_user_action;
    p_set_context('hash_user_action', null);
    /* зальем новые данные */
    insert into tt_user_action
    select t.* from table(pct_user_action)t;
    commit;
    /* выставим контекст */
    for vcur_cnt in (select count(1) from tt_user_action group by 1) loop
      p_set_context('hash_user_action', pv_hash);
    end loop;
  end p_modify_user_action;
  /*---------------------------------------------------------------------------------*/
  procedure p_modify_user_department(pct_user_department in ct_user_department,
                                     pv_hash             in varchar2 default null) is
  begin
    /* очистим таблицу */
    delete tt_user_department;
    p_set_context('hash_user_department', null);
    /* зальем новые данные */
    insert into tt_user_department
    select t.* from table(pct_user_department)t;
    commit;
    /* выставим контекст */
    for vcur_cnt in (select count(1) from tt_user_department group by 1) loop
      p_set_context('hash_user_department', pv_hash);
    end loop;  
  end p_modify_user_department;
  /*---------------------------------------------------------------------------------*/ 
  function f_get_context(pv_attribute varchar2) return varchar2 deterministic
    is
  begin
    return sys_context(C_CONTEXT_NAMESPACE, pv_attribute);
  end f_get_context;
  /*---------------------------------------------------------------------------------*/
end pkg_user;
/