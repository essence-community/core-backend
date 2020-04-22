--liquibase formatted sql
--changeset artemov_i:pkg dbms:oracle runOnChange:true endDelimiter:/ splitStatements:true stripComments:false
CREATE OR REPLACE package ${user.update}.pkg is

  -- Author  : VYSKREBENTSEV
  -- Created : 28.08.2017
  -- Purpose : Глобальные константы Метаданных, формирование пула ошибок и сообщений, единая обработка исключений, другие "фундаментальные" вещи

  /*----------------------------------*/
  /* Блок констант для разбора action */
  /*----------------------------------*/
  i constant varchar2(1) := 'I';
  u constant varchar2(1) := 'U';
  d constant varchar2(1) := 'D';
  
  /*----------------------------------------------*/
  /* Блок для формирования ответа с бэка на фронт */
  /*----------------------------------------------*/
  /* К какому типа относится сообщение, определяется по t_message.cv_type */
  gv_error   varchar2(10000); -- ошибки
  gv_warning varchar2(10000); -- предупреждения
  gv_info    varchar2(10000); -- информационные сообщения
  
  gt_msg_macro ct_msg_macro; -- коллекция с сообщениями и макросами к ним
  gk_msg_macro number; /* ct_msg_macro.ck_id */ -- синтетический ИД ошибки, не имеет никакого отношения к t_message.ck_id; 
                                                -- служит ключом в коллекции ошибок (код самой ошибки может повторяться), используется вместо сиквенса при установке ошибки
  gt_varchar2  ct_varchar2; -- коллекция с макросами по конкретному сообщению
  
  gn_user number; /* ИД пользователя */
  
  gl_warning number(1); -- Признак согласия пользоватедя с предупреждениями. По умолчанию 0. Выполняем все проверки с типом warning. 
                        -- Если 1 пользователь подтверждает операцию модификации, игнорируем на backend проверки с типом warning. 

  /*----------------------------*/
  /* Блок для разбора Exception */
  /*----------------------------*/
  gex_parentkey exception;
  pragma exception_init(gex_parentkey, -2291);    /* ORA-02291: integrity constraint violated-parent key not found */
  gex_childrecords exception;
  pragma exception_init(gex_childrecords, -2292); /* ORA-02292 Constraint violation - child records found */
  gex_nowait exception;
  pragma exception_init(gex_nowait, -54);         /* ORA-00054: указан занятый ресурс и его получение с опцией NOWAIT */
  gex_connectbyloop exception;
  pragma exception_init(gex_nowait, -1436);       /* ORA-01436: CONNECT BY loop in user data */
  gex_longField exception;
  pragma exception_init(gex_longField, -12899);   /* ORA-12899: value too large for column */
  gex_job_exists exception;
  pragma exception_init(gex_job_exists, -27477); /*ORA-27477: "JOB.NAME" already exists*/
  
  /*-----------------------------------------------------------------------------------------------------------------------------------*/

  /* Версия пакета (Редактируется АВТОМАТИЧЕСКИ, НЕ ПРАВИТЬ руками!) */
  function f_get_ver return varchar2;
  
  /* Сброс глобальных переменных gv_error, gv_warning, gv_info + коллекции с макросами; + установка ИД юзера 
     Необходимо вызывать в начале любой функции в pkg_json_* */
  procedure p_reset_response(pn_user number default null);
  
  /* Добавление ошибки/предупреждения/информации в соответствующую глобальную переменную (+ можно указывать макросы) */
  procedure p_set_error(pk_id number,
                        pv_macro_1 varchar2 default null,
                        pv_macro_2 varchar2 default null,
                        pv_macro_3 varchar2 default null,
                        pv_macro_4 varchar2 default null,
                        pv_macro_5 varchar2 default null);
  procedure p_set_warning(pk_id number,
                          pv_macro_1 varchar2 default null,
                          pv_macro_2 varchar2 default null,
                          pv_macro_3 varchar2 default null,
                          pv_macro_4 varchar2 default null,
                          pv_macro_5 varchar2 default null);
  procedure p_set_info(pk_id number,
                       pv_macro_1 varchar2 default null,
                       pv_macro_2 varchar2 default null,
                       pv_macro_3 varchar2 default null,
                       pv_macro_4 varchar2 default null,
                       pv_macro_5 varchar2 default null);
  
  /* Сбор глобальных переменных gv_error, gv_warning, gv_info в JSON для выдачи на фронт
     Используется практически по всех функцциях пакетов pkg_json_* */
  function p_form_response return varchar2;
  
  /*-- for debug goals only
  function f_get_gt_msg_macro return ct_msg_macro;*/

end pkg;
/
create or replace package body ${user.update}.pkg is

  --Версия пакета (Редактируется АВТОМАТИЧЕСКИ, НЕ ПРАВИТЬ руками!)
  function f_get_ver return varchar2 is
  begin
    return '$Revision:571eee93600cc304bd450607e9bb9b95d34830db$ modified $RevDate:16.04.2018 10:42:17$ by 
$Author:Roshupkin$';
  end f_get_ver;
  
  procedure p_reset_response(pn_user number default null) is
  begin
    -- обнулим признак согласия пользователя с предупреждениями
    gl_warning := 0;
    -- обнулим переменные для формирования ответа на фронт
    gv_error   := null;
    gv_warning := null;
    gv_info    := null;
    -- очистим коллекции, нужные для формирования ошибок с макросами
    gt_varchar2.delete;
    gt_msg_macro.delete;
    -- выставим ИД пользователя
    gn_user := pn_user;
  end p_reset_response;
  
  /* Установка макросов для сообщений */
  procedure p_set_msg_macro(pk_id number,
                            pv_macro_1 varchar2 default null,
                            pv_macro_2 varchar2 default null,
                            pv_macro_3 varchar2 default null,
                            pv_macro_4 varchar2 default null,
                            pv_macro_5 varchar2 default null) is
    -- саб-метод для добавления записии в коллекцию варчаров
    procedure sp_add(spv_macro varchar2)
      is
    begin
      gt_varchar2.extend;
      gt_varchar2(gt_varchar2.last) := spv_macro;
    end;                          
  begin
    -- Очистим коллекцию варчаров
    gt_varchar2.delete;
    -- Добавим макросы в коллекцию варчаров по очереди
    if pv_macro_1 is not null then 
      sp_add(pv_macro_1);
      if pv_macro_2 is not null then
        sp_add(pv_macro_2);
        if pv_macro_3 is not null then
          sp_add(pv_macro_3);
          if pv_macro_4 is not null then
            sp_add(pv_macro_4);
            if pv_macro_5 is not null then
              sp_add(pv_macro_5);
            end if;
          end if; 
        end if;
      end if;     
    end if;
    -- Добавим запись в основную коллекцию
    gt_msg_macro.extend;
    gt_msg_macro(gt_msg_macro.last) := ot_msg_macro(gk_msg_macro, pk_id, gt_varchar2);
    gk_msg_macro := gk_msg_macro+1; -- a la sequence for gt_msg_macro.ck_id
  end;
  
  procedure p_set_error(pk_id number,
                        pv_macro_1 varchar2 default null,
                        pv_macro_2 varchar2 default null,
                        pv_macro_3 varchar2 default null,
                        pv_macro_4 varchar2 default null,
                        pv_macro_5 varchar2 default null) is
  begin
    gv_error := pk_id || ',' || gv_error;
    p_set_msg_macro(pk_id, pv_macro_1, pv_macro_2, pv_macro_3, pv_macro_4, pv_macro_5);
  end p_set_error;
  
  procedure p_set_warning(pk_id number,
                          pv_macro_1 varchar2 default null,
                          pv_macro_2 varchar2 default null,
                          pv_macro_3 varchar2 default null,
                          pv_macro_4 varchar2 default null,
                          pv_macro_5 varchar2 default null) is
  begin
    gv_warning := pk_id || ',' || gv_warning;
    p_set_msg_macro(pk_id, pv_macro_1, pv_macro_2, pv_macro_3, pv_macro_4, pv_macro_5);
  end p_set_warning;
  
  procedure p_set_info(pk_id number,
                       pv_macro_1 varchar2 default null,
                       pv_macro_2 varchar2 default null,
                       pv_macro_3 varchar2 default null,
                       pv_macro_4 varchar2 default null,
                       pv_macro_5 varchar2 default null) is
  begin
    gv_info := pk_id || ',' || gv_info;
    p_set_msg_macro(pk_id, pv_macro_1, pv_macro_2, pv_macro_3, pv_macro_4, pv_macro_5);
  end p_set_info;
  
  function p_form_response return varchar2 is
    vv_res varchar2(32767);
  begin  
   select nvl(
          json_objectagg(
          key to_char(ck_message) value json_arrayagg(cv_macro order by cn_rownum)
          )
          ,'null') as json
     into vv_res
     from (/* Коды сообщений + соответствующие макросы (если указаны) */
           select t.ck_id,
                  t.ck_message,
                  t_macro.column_value as cv_macro,
                  rownum as cn_rownum/*для сохранения исходной очередности макросов для ошибки*/
             from table(gt_msg_macro) t
             left join table (select t2.ct_macro from table(gt_msg_macro) t2 where t2.ck_id = t.ck_id) t_macro on 1=1)
     group by ck_id, ck_message/*смысловой нагрузки не несет; ck_id и так уникален*/;
    return vv_res;
  end p_form_response;
  
  
  /* -- for debug goals only
  function f_get_gt_msg_macro return ct_msg_macro
    is
  begin
    return gt_msg_macro;
  end;*/
   
begin
  gt_msg_macro := ct_msg_macro();
  gk_msg_macro := 1;
  gt_varchar2  := ct_varchar2();
end pkg;
/
