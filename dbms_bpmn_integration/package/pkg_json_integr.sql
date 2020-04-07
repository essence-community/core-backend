--liquibase formatted sql
--changeset artemov_i:pkg_json_integr dbms:postgresql runOnChange:true splitStatements:false stripComments:false
DROP SCHEMA IF EXISTS pkg_json_integr cascade;

CREATE SCHEMA pkg_json_integr
    AUTHORIZATION ${user.update};

ALTER SCHEMA pkg_json_integr OWNER TO ${user.update};

CREATE FUNCTION pkg_json_integr.f_modify_d_provider(pv_user character varying, pk_session character varying, pc_json jsonb) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO '${user.table}', 'pkg_json_integr', 'pkg_integr', 'public'
    AS $$
declare
  -- переменные пакета
  gv_error sessvarstr;

  -- переменные функции
  pot_d_provider  ${user.table}.t_d_provider;
  vv_action varchar(1);
begin
  -- инициализация/получение переменных пакета
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');

  -- код функции
  --обнулим глобальные переменные с перечнем ошибок/предупреждений/информационных сообщений
  perform pkg.p_reset_response();
  --JSON -> rowtype

  pot_d_provider.ck_id = (nullif(trim(pc_json#>>'{data,ck_id}'), ''));
  pot_d_provider.cv_description = nullif(trim(pc_json#>>'{data,cv_description}'), '');
  pot_d_provider.ck_user = pv_user;
  pot_d_provider.ct_change = CURRENT_TIMESTAMP;
  vv_action = (pc_json#>>'{service,cv_action}');

  --проверка прав доступа
  perform pkg_access.p_check_access(pv_user);
  
  if nullif(gv_error::varchar, '') is not null then
    return '{"ck_id":"","cv_error":' || pkg.p_form_response() || '}'; --ошибка прав доступа.
  end if;
  --блочим основную таблицу
  perform pkg_integr.p_lock_d_provider(pot_d_provider.ck_id);
  --проверяем и сохраняем данные
  pot_d_provider := pkg_integr.p_modify_d_provider(vv_action, pot_d_provider);
  --логируем данные
  perform pkg_log.p_save(pv_user, pk_session, pc_json, 'pkg_json_integr.f_modify_d_provider', pot_d_provider.ck_id::varchar, vv_action);
  return '{"ck_id":"' || coalesce(pot_d_provider.ck_id::varchar, '') || '","cv_error":' || pkg.p_form_response() || '}';
end;
$$;

ALTER FUNCTION pkg_json_integr.f_modify_d_provider(character varying, character varying, jsonb) OWNER TO ${user.update};

CREATE FUNCTION pkg_json_integr.f_modify_d_interface(pv_user character varying, pk_session character varying, pc_json jsonb) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO '${user.table}', 'pkg_json_integr', 'pkg_integr', 'public'
    AS $$
declare
  -- переменные пакета
  gv_error sessvarstr;

  -- переменные функции
  pot_d_interface  ${user.table}.t_d_interface;
  vv_action varchar(1);
begin
  -- инициализация/получение переменных пакета
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');

  -- код функции
  --обнулим глобальные переменные с перечнем ошибок/предупреждений/информационных сообщений
  perform pkg.p_reset_response();
  --JSON -> rowtype

  pot_d_interface.ck_id = (nullif(trim(pc_json#>>'{data,ck_id}'), ''));
  pot_d_interface.cv_description = nullif(trim(pc_json#>>'{data,cv_description}'), '');
  pot_d_interface.ck_user = pv_user;
  pot_d_interface.ct_change = CURRENT_TIMESTAMP;
  vv_action = (pc_json#>>'{service,cv_action}');

  --проверка прав доступа
  perform pkg_access.p_check_access(pv_user);
  
  if nullif(gv_error::varchar, '') is not null then
    return '{"ck_id":"","cv_error":' || pkg.p_form_response() || '}'; --ошибка прав доступа.
  end if;
  --блочим основную таблицу
  perform pkg_integr.p_lock_d_interface(pot_d_interface.ck_id);
  --проверяем и сохраняем данные
  pot_d_interface := pkg_integr.p_modify_d_interface(vv_action, pot_d_interface);
  --логируем данные
  perform pkg_log.p_save(pv_user, pk_session, pc_json, 'pkg_json_integr.f_modify_d_interface', pot_d_interface.ck_id::varchar, vv_action);
  return '{"ck_id":"' || coalesce(pot_d_interface.ck_id::varchar, '') || '","cv_error":' || pkg.p_form_response() || '}';
end;
$$;

ALTER FUNCTION pkg_json_integr.f_modify_d_interface(character varying, character varying, jsonb) OWNER TO ${user.update};

CREATE FUNCTION pkg_json_integr.f_modify_interface(pv_user character varying, pk_session character varying, pc_json jsonb) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO '${user.table}', 'pkg_json_integr', 'pkg_integr', 'public'
    AS $$
declare
  -- переменные пакета
  gv_error sessvarstr;

  -- переменные функции
  pot_interface  ${user.table}.t_interface;
  vv_action varchar(1);
begin
  -- инициализация/получение переменных пакета
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');

  -- код функции
  --обнулим глобальные переменные с перечнем ошибок/предупреждений/информационных сообщений
  perform pkg.p_reset_response();
  --JSON -> rowtype

  pot_interface.ck_id = (nullif(trim(pc_json#>>'{data,ck_id}'), ''));
  pot_interface.cc_query = nullif(trim(pc_json#>>'{data,cc_query}'), '');
  pot_interface.ck_d_interface = nullif(trim(pc_json#>>'{data,ck_d_interface}'), '');
  pot_interface.ck_d_provider = nullif(trim(pc_json#>>'{data,ck_d_provider}'), '');
  pot_interface.cv_description = nullif(trim(pc_json#>>'{data,cv_description}'), '');
  pot_interface.ck_user = pv_user;
  pot_interface.ct_change = CURRENT_TIMESTAMP;
  vv_action = (pc_json#>>'{service,cv_action}');

  --проверка прав доступа
  perform pkg_access.p_check_access(pv_user);
  
  if nullif(gv_error::varchar, '') is not null then
    return '{"ck_id":"","cv_error":' || pkg.p_form_response() || '}'; --ошибка прав доступа.
  end if;
  --блочим основную таблицу
  perform pkg_integr.p_lock_interface(pot_interface.ck_id);
  --проверяем и сохраняем данные
  pot_interface := pkg_integr.p_modify_interface(vv_action, pot_interface);
  --логируем данные
  perform pkg_log.p_save(pv_user, pk_session, pc_json, 'pkg_json_integr.f_modify_interface', pot_interface.ck_id::varchar, vv_action);
  return '{"ck_id":"' || coalesce(pot_interface.ck_id::varchar, '') || '","cv_error":' || pkg.p_form_response() || '}';
end;
$$;

ALTER FUNCTION pkg_json_integr.f_modify_interface(character varying, character varying, jsonb) OWNER TO ${user.update};

CREATE FUNCTION pkg_json_integr.f_modify_scenario(pv_user character varying, pk_session character varying, pc_json jsonb) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO '${user.table}', 'pkg_json_integr', 'pkg_integr', 'public'
    AS $$
declare
  -- переменные пакета
  gv_error sessvarstr;

  -- переменные функции
  pot_scenario ${user.table}.t_scenario;
  vv_action varchar(1);
begin
  -- инициализация/получение переменных пакета
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');

  -- код функции
  --обнулим глобальные переменные с перечнем ошибок/предупреждений/информационных сообщений
  perform pkg.p_reset_response();
  --JSON -> rowtype

  pot_scenario.ck_id = nullif(trim(pc_json#>>'{data,ck_id}'), '');
  pot_scenario.cc_scenario = (nullif(trim(pc_json#>>'{data,cc_scenario}'), ''))::jsonb;
  pot_scenario.cn_action = (nullif(trim(pc_json#>>'{data,cn_action}'), ''))::bigint;
  pot_scenario.cv_description = nullif(trim(pc_json#>>'{data,cv_description}'), '');
  pot_scenario.ck_user = pv_user;
  pot_scenario.ct_change = CURRENT_TIMESTAMP;
  vv_action = (pc_json#>>'{service,cv_action}');

  --проверка прав доступа
  perform pkg_access.p_check_access(pv_user);
  
  if nullif(gv_error::varchar, '') is not null then
    return '{"ck_id":"","cv_error":' || pkg.p_form_response() || '}'; --ошибка прав доступа.
  end if;
  --блочим основную таблицу
  perform pkg_integr.p_lock_scenario(pot_scenario.ck_id);
  --проверяем и сохраняем данные
  pot_scenario := pkg_integr.p_modify_scenario(vv_action, pot_scenario);
  --логируем данные
  perform pkg_log.p_save(pv_user, pk_session, pc_json, 'pkg_json_integr.f_modify_scenario', pot_scenario.ck_id::varchar, vv_action);
  return '{"ck_id":"' || coalesce(pot_scenario.ck_id::varchar, '') || '","cv_error":' || pkg.p_form_response() || '}';
end;
$$;

ALTER FUNCTION pkg_json_integr.f_modify_scenario(character varying, character varying, jsonb) OWNER TO ${user.update};
