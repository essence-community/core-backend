--liquibase formatted sql
--changeset artemov_i:pkg_json_scenario dbms:postgresql runOnChange:true splitStatements:false stripComments:false
DROP SCHEMA IF EXISTS pkg_json_scenario cascade;

CREATE SCHEMA pkg_json_scenario
    AUTHORIZATION ${user.update};


ALTER SCHEMA pkg_json_scenario OWNER TO ${user.update};

CREATE FUNCTION pkg_json_scenario.f_modify_action(pv_user character varying, pv_session character varying, pc_json jsonb) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_json_scenario', 'public'
    AS $$
declare
  -- переменные пакета
  gv_error sessvarstr;
  i sessvarstr;
  u sessvarstr;
  -- переменные функции
  vot_action     s_mt.t_action;
  vk_page        s_mt.t_page.ck_id%type;
  vk_page_object s_mt.t_page_object.ck_id%type;
  vv_action      varchar(1);
  vk_main        varchar;
begin
  -- инициализация/получение переменных пакета
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');
  i = sessvarstr_declare('pkg', 'i', 'I');
  u = sessvarstr_declare('pkg', 'u', 'U');
  -- код функции
  -- Обнулим глобальные переменные с перечнем ошибок/предупреждений/информационных сообщений
  perform pkg.p_reset_response();
  -- JSON -> rowtype
  vot_action.ck_id = trim(pc_json#>>'{data,ck_id}')::varchar;
  vot_action.ck_step = trim(pc_json#>>'{service,ck_main}')::varchar;
  vot_action.cn_order = trim(pc_json#>>'{data,cn_order}')::bigint;
  vk_page = trim(pc_json#>>'{data,ck_page}');
  vk_page_object = trim(pc_json#>>'{data,ck_page_object}');
  vot_action.cv_value = trim(pc_json#>>'{data,cv_value}');
  vot_action.cv_description = trim(pc_json#>>'{data,cv_description}');
  vot_action.ck_d_action = trim(pc_json#>>'{data,ck_d_action}');
  vot_action.cl_expected = trim(pc_json#>>'{data,cl_expected}')::smallint;
  vot_action.ck_user = pv_user;
  vot_action.ct_change = CURRENT_TIMESTAMP;
  vv_action = (pc_json#>>'{service,cv_action}');
  vk_main = (pc_json#>>'{service,ck_main}')::varchar;

  -- определим, какого типа эта запись - работа с объектом или смена страницы
  if vv_action in (i::varchar, u::varchar) then
    if vk_page_object is not null then
      vot_action.cv_key := vk_page_object;
    elsif vk_page is not null then
      vot_action.cv_key := 'ck_page';
      vot_action.cv_value := vk_page;
      vot_action.ck_d_action := 'open';
      vot_action.cl_expected := 1; /* i.e. "true" */
    else
      return '{"ck_id":"' || vot_action.ck_id || '","cv_error":{"512":[]}}';
    end if;
  end if;
  -- Проверим права доступа
  perform pkg_access.p_check_access(pv_user, vk_main);
  if nullif(gv_error::varchar, '') is not null then
    return '{"ck_id":"","cv_error":' || pkg.p_form_response() || '}';
  end if;
  -- Заблокируем родительскую таблицу
  perform pkg_scenario.p_lock_step(vk_main);
  if nullif(gv_error::varchar, '') is not null then
    return '{"ck_id":"","cv_error":' || pkg.p_form_response() || '}';
  end if;
  -- Проверим и сохраним данные
  perform pkg_scenario.p_modify_action(vv_action, vot_action);
  -- Логируем данные
  perform pkg_log.p_save(pv_user, pv_session, pc_json, 'pkg_json_scenario.f_modify_action', vot_action.ck_id, vv_action);
  return '{"ck_id":"' || vot_action.ck_id || '","cv_error":' || pkg.p_form_response() || '}';
end;
$$;


ALTER FUNCTION pkg_json_scenario.f_modify_action(pv_user character varying, pv_session character varying, pc_json jsonb) OWNER TO ${user.update};

CREATE FUNCTION pkg_json_scenario.f_modify_scenario(pv_user character varying, pv_session character varying, pc_json jsonb) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_json_scenario', 'public'
    AS $$
declare
  -- переменные пакета
  gv_error sessvarstr;
  -- переменные функции
  vot_scenario s_mt.t_scenario;
  vv_action varchar(1);
begin
  -- инициализация/получение переменных пакета
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');
  -- код функции
  -- Обнулим глобальные переменные с перечнем ошибок/предупреждений/информационных сообщений
  perform pkg.p_reset_response();
  -- JSON -> rowtype
  vot_scenario.ck_id = trim(pc_json#>>'{data,ck_id}')::varchar;
  vot_scenario.cn_order = trim(pc_json#>>'{data,cn_order}')::bigint;
  vot_scenario.cv_name = trim(pc_json#>>'{data,cv_name}');
  vot_scenario.cl_valid = trim(pc_json#>>'{data,cl_valid}')::smallint;
  vot_scenario.cv_description = trim(pc_json#>>'{data,cv_description}');
  vot_scenario.ck_user = pv_user;
  vot_scenario.ct_change = CURRENT_TIMESTAMP;
  vv_action = (pc_json#>>'{service,cv_action}');

  -- Проверим права доступа
  perform pkg_access.p_check_access(pv_user, vot_scenario.ck_id);
  if nullif(gv_error::varchar, '') is not null then
    return '{"ck_id":"","cv_error":' || pkg.p_form_response() || '}';
  end if;
  -- Заблокируем основную таблицу
  perform pkg_scenario.p_lock_scenario(vot_scenario.ck_id);
  if nullif(gv_error::varchar, '') is not null then
    return '{"ck_id":"","cv_error":' || pkg.p_form_response() || '}';
  end if;
  -- Проверим и сохраним данные
  perform pkg_scenario.p_modify_scenario(vv_action, vot_scenario);
  -- Логируем данные
  perform pkg_log.p_save(pv_user, pv_session, pc_json, 'pkg_json_scenario.f_modify_scenario', vot_scenario.ck_id, vv_action);
  return '{"ck_id":"' || vot_scenario.ck_id || '","cv_error":' || pkg.p_form_response() || '}';
end;
$$;


ALTER FUNCTION pkg_json_scenario.f_modify_scenario(pv_user character varying, pv_session character varying, pc_json jsonb) OWNER TO ${user.update};

CREATE FUNCTION pkg_json_scenario.f_modify_step(pv_user character varying, pv_session character varying, pc_json jsonb) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_json_scenario', 'public'
    AS $$
declare
  -- переменные пакета
  gv_error sessvarstr;
  -- переменные функции
  vot_step  s_mt.t_step;
  vv_action varchar(1);
  vk_main varchar(100);
begin
  -- инициализация/получение переменных пакета
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');
  -- код функции
  -- Обнулим глобальные переменные с перечнем ошибок/предупреждений/информационных сообщений
  perform pkg.p_reset_response();
  -- JSON -> rowtype
  vot_step.ck_id = trim(pc_json#>>'{data,ck_id}')::varchar;
  vot_step.ck_scenario = trim(pc_json#>>'{service,ck_main}')::varchar;
  vot_step.cn_order = trim(pc_json#>>'{data,cn_order}')::bigint;
  vot_step.cv_name = trim(pc_json#>>'{data,cv_name}');
  vot_step.ck_user = pv_user;
  vot_step.ct_change = CURRENT_TIMESTAMP;
  vv_action = (pc_json#>>'{service,cv_action}');
  vk_main = (pc_json#>>'{service,ck_main}')::varchar;

  -- Проверим права доступа
  perform pkg_access.p_check_access(pv_user, vk_main);
  if nullif(gv_error::varchar, '') is not null then
    return '{"ck_id":"","cv_error":' || pkg.p_form_response() || '}';
  end if;
  -- Заблокируем основную таблицу
  perform pkg_scenario.p_lock_scenario(vk_main);
  if nullif(gv_error::varchar, '') is not null then
    return '{"ck_id":"","cv_error":' || pkg.p_form_response() || '}';
  end if;
  -- Проверим и сохраним данные
  perform pkg_scenario.p_modify_step(vv_action, vot_step);
  -- Логируем данные
  perform pkg_log.p_save(pv_user, pv_session, pc_json, 'pkg_json_scenario.f_modify_step', vot_step.ck_id, vv_action);
  return '{"ck_id":"' || vot_step.ck_id || '","cv_error":' || pkg.p_form_response() || '}';
end;
$$;


ALTER FUNCTION pkg_json_scenario.f_modify_step(pv_user character varying, pv_session character varying, pc_json jsonb) OWNER TO ${user.update};
