--liquibase formatted sql
--changeset artemov_i:pkg_json_localization dbms:postgresql runOnChange:true splitStatements:false stripComments:false
DROP SCHEMA IF EXISTS pkg_json_localization cascade;

CREATE SCHEMA pkg_json_localization
    AUTHORIZATION s_mp;


ALTER SCHEMA pkg_json_localization OWNER TO s_mp;

CREATE FUNCTION pkg_json_localization.f_modify_lang(pv_user character varying, pk_session character varying, pc_json jsonb) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 's_mt', 'pkg_json_localization', 'pkg_localization', 'public'
    AS $$
declare
  -- переменные пакета
  gv_error sessvarstr;
  gl_warning sessvari;
  u sessvarstr;

  -- переменные функции
  pot_d_lang  s_mt.t_d_lang;
  vv_action varchar(1);
begin
  -- инициализация/получение переменных пакета
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');
  gl_warning = sessvari_declare('pkg', 'gl_warning', 0);
  u = sessvarstr_declare('pkg', 'u', 'U');

  -- код функции
  --обнулим глобальные переменные с перечнем ошибок/предупреждений/информационных сообщений
  perform pkg.p_reset_response();
  --JSON -> rowtype

  pot_d_lang.ck_id = nullif(trim(pc_json#>>'{data,ck_id}'), '');
  pot_d_lang.cv_name = nullif(trim(pc_json#>>'{data,cv_name}'), '');
  pot_d_lang.cl_default = (nullif(trim(pc_json#>>'{data,cl_default}'), ''))::smallint;
  pot_d_lang.ck_user = pv_user;
  pot_d_lang.ct_change = CURRENT_TIMESTAMP;
  vv_action = (pc_json#>>'{service,cv_action}');
  perform gl_warning == (pc_json#>>'{service,cl_warning}')::bigint;

  --проверка прав доступа
  perform pkg_access.p_check_access(pv_user);
  if nullif(gv_error::varchar, '') is not null then
    return '{"ck_id":"","cv_error":' || pkg.p_form_response() || '}'; --ошибка прав доступа.
  end if;
  --блочим основную таблицу
  if vv_action = u::varchar then
    perform pkg_localization.p_lock_d_lang(pot_d_lang.ck_id);
  end if;
  --проверяем и сохраняем данные
  pot_d_lang := pkg_localization.p_modify_lang(vv_action, pot_d_lang);
  --логируем данные
  perform pkg_log.p_save(pv_user, pk_session, pc_json, 'pkg_json_localization.f_modify_lang', pot_d_lang.ck_id, vv_action);
  return '{"ck_id":"' || coalesce(pot_d_lang.ck_id, '') || '","cv_error":' || pkg.p_form_response() || '}';
end;
$$;

ALTER FUNCTION pkg_json_localization.f_modify_lang(character varying, character varying, jsonb) OWNER TO s_mp;

CREATE FUNCTION pkg_json_localization.f_modify_default_localization(pv_user character varying, pk_session character varying, pc_json jsonb) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 's_mt', 'pkg_json_localization', 'pkg_localization', 'public'
    AS $$
declare
  -- переменные пакета
  gv_error sessvarstr;
  gl_warning sessvari;
  u sessvarstr;

  -- переменные функции
  pot_localization s_mt.t_localization;
  vv_action varchar(1);
begin
  -- инициализация/получение переменных пакета
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');
  gl_warning = sessvari_declare('pkg', 'gl_warning', 0);
  u = sessvarstr_declare('pkg', 'u', 'U');

  -- код функции
  --обнулим глобальные переменные с перечнем ошибок/предупреждений/информационных сообщений
  perform pkg.p_reset_response();
  --JSON -> rowtype

  pot_localization.ck_id = nullif(trim(pc_json#>>'{data,ck_id}'), '');
  select ck_id
    into pot_localization.ck_d_lang
  from t_d_lang where cl_default = 1;
  pot_localization.cr_namespace = nullif(trim(pc_json#>>'{data,cr_namespace}'), '');
  pot_localization.cv_value = nullif(trim(pc_json#>>'{data,cv_value}'), '');
  pot_localization.ck_user = pv_user;
  pot_localization.ct_change = CURRENT_TIMESTAMP;
  vv_action = (pc_json#>>'{service,cv_action}');
  perform gl_warning == (pc_json#>>'{service,cl_warning}')::bigint;

  --проверка прав доступа
  perform pkg_access.p_check_access(pv_user);
  if nullif(gv_error::varchar, '') is not null then
    return '{"ck_id":"","cv_error":' || pkg.p_form_response() || '}'; --ошибка прав доступа.
  end if;
  --блочим основную таблицу
  if vv_action = u::varchar then
    perform pkg_localization.p_lock_localization(pot_localization.ck_id, pot_localization.ck_d_lang);
  end if;
  --проверяем и сохраняем данные
  pot_localization := pkg_localization.p_modify_localization(vv_action, pot_localization);
  --логируем данные
  perform pkg_log.p_save(pv_user, pk_session, pc_json, 'pkg_json_localization.f_modify_default_localization', pot_localization.ck_id, vv_action);
  return '{"ck_id":"' || coalesce(pot_localization.ck_id, '') || '","cv_error":' || pkg.p_form_response() || '}';
end;
$$;

ALTER FUNCTION pkg_json_localization.f_modify_default_localization(character varying, character varying, jsonb) OWNER TO s_mp;

CREATE FUNCTION pkg_json_localization.f_modify_localization(pv_user character varying, pk_session character varying, pc_json jsonb) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 's_mt', 'pkg_json_localization', 'pkg_localization', 'public'
    AS $$
declare
  -- переменные пакета
  gv_error sessvarstr;
  gl_warning sessvari;
  u sessvarstr;

  -- переменные функции
  pot_localization s_mt.t_localization;
  vv_action varchar(1);
  vk_main   varchar(32);
begin
  -- инициализация/получение переменных пакета
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');
  gl_warning = sessvari_declare('pkg', 'gl_warning', 0);
  u = sessvarstr_declare('pkg', 'u', 'U');

  -- код функции
  --обнулим глобальные переменные с перечнем ошибок/предупреждений/информационных сообщений
  perform pkg.p_reset_response();
  --JSON -> rowtype

  pot_localization.ck_d_lang = nullif(trim(pc_json#>>'{data,ck_d_lang}'), '');
  pot_localization.cv_value = nullif(trim(pc_json#>>'{data,cv_value}'), '');
  pot_localization.ck_user = pv_user;
  pot_localization.ct_change = CURRENT_TIMESTAMP;
  vv_action = (pc_json#>>'{service,cv_action}');
  vk_main = (pc_json#>>'{service,ck_main}');
  perform gl_warning == (pc_json#>>'{service,cl_warning}')::bigint;
  
  select ck_id, cr_namespace
    into pot_localization.ck_id, pot_localization.cr_namespace
  from t_localization where ck_id = vk_main;

  --проверка прав доступа
  perform pkg_access.p_check_access(pv_user);
  if nullif(gv_error::varchar, '') is not null then
    return '{"ck_id":"","cv_error":' || pkg.p_form_response() || '}'; --ошибка прав доступа.
  end if;
  --блочим основную таблицу
  if vv_action = u::varchar then
    perform pkg_localization.p_lock_localization(pot_localization.ck_id, pot_localization.ck_d_lang);
  end if;
  --проверяем и сохраняем данные
  pot_localization := pkg_localization.p_modify_localization(vv_action, pot_localization);
  --логируем данные
  perform pkg_log.p_save(pv_user, pk_session, pc_json, 'pkg_json_localization.f_modify_localization', pot_localization.ck_id, vv_action);
  return '{"ck_id":"' || coalesce(pot_localization.ck_id, '') || ':' || coalesce(pot_localization.ck_d_lang, '') || '","cv_error":' || pkg.p_form_response() || '}';
end;
$$;

ALTER FUNCTION pkg_json_localization.f_modify_localization(character varying, character varying, jsonb) OWNER TO s_mp;
