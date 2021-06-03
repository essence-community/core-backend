--liquibase formatted sql
--changeset artemov_i:pkg_json_meta dbms:postgresql runOnChange:true splitStatements:false stripComments:false
DROP SCHEMA IF EXISTS pkg_json_meta cascade;

CREATE SCHEMA pkg_json_meta
    AUTHORIZATION s_mp;


ALTER SCHEMA pkg_json_meta OWNER TO s_mp;

CREATE FUNCTION pkg_json_meta.f_copy_object(pv_user character varying, pv_session character varying, pc_json jsonb) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_json_meta', 'public'
    AS $$
declare
  -- переменные пакета
  gv_error sessvarstr;

  -- переменные функции
  vot_object s_mt.t_object;
  vv_action  varchar(1);
  vk_main    bigint;
begin
  -- инициализация/получение переменных пакета
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');

  -- код функции
  --обнулим глобальные переменные с перечнем ошибок/предупреждений/информационных сообщений, выставим пользователя
  perform pkg.p_reset_response();--(pv_user);
  --JSON -> rowtype

  vot_object.ck_id = nullif(trim(pc_json#>>'{data,ck_id}'), '');
  vot_object.ck_parent = nullif(trim(pc_json#>>'{data,ck_parent}'), '');
  vv_action = (pc_json#>>'{service,cv_action}');
  vk_main = (pc_json#>>'{service,ck_main}')::bigint;

  -- проверим права доступа
  perform pkg_access.p_check_access(pv_user, vk_main::varchar);
  if nullif(gv_error::varchar, '') is not null then
    return '{"ck_id":"","cv_error":' || pkg.p_form_response() || '}';
  end if;
  -- вызовем метод копирования объекта
  perform pkg_meta.p_copy_object(vot_object.ck_id, vot_object.ck_parent);
  -- логируем данные
  perform pkg_log.p_save(pv_user, pv_session, pc_json, 't_object', vot_object.ck_id, vv_action);
  return '{"ck_id":"' || vot_object.ck_id || '","cv_error":' || pkg.p_form_response() || '}';
end;
$$;


ALTER FUNCTION pkg_json_meta.f_copy_object(pv_user character varying, pv_session character varying, pc_json jsonb) OWNER TO s_mp;

CREATE FUNCTION pkg_json_meta.f_modify_attr(pv_user character varying, pk_session character varying, pc_json jsonb) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_json_meta', 'public'
    AS $$
declare
  -- переменные пакета
  gv_error sessvarstr;
  u sessvarstr;

  -- переменные функции
  pot_attr  s_mt.t_attr;
  vv_action varchar(1);
  vk_main   varchar(32);
begin
  -- инициализация/получение переменных пакета
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');
  u = sessvarstr_declare('pkg', 'u', 'U');

  -- код функции
  --обнулим глобальные переменные с перечнем ошибок/предупреждений/информационных сообщений
  perform pkg.p_reset_response();
  --JSON -> rowtype

  pot_attr.ck_id = nullif(trim(pc_json#>>'{data,ck_id}'), '');
  pot_attr.cv_description = nullif(trim(pc_json#>>'{data,cv_description}'), '');
  pot_attr.ck_d_data_type = nullif(trim(pc_json#>>'{data,ck_d_data_type}'), '');
  pot_attr.cv_data_type_extra = nullif(trim(pc_json#>>'{data,cv_data_type_extra}'), '');
  pot_attr.ck_attr_type = nullif(trim(pc_json#>>'{data,ck_attr_type}'), '');
  pot_attr.ck_user = pv_user;
  pot_attr.ct_change = CURRENT_TIMESTAMP;
  vv_action = (pc_json#>>'{service,cv_action}');
  vk_main = (pc_json#>>'{service,ck_main}');

  --проверка прав доступа
  perform pkg_access.p_check_access(pv_user, vk_main);
  if nullif(gv_error::varchar, '') is not null then
    return '{"ck_id":"","cv_error":' || pkg.p_form_response() || '}'; --ошибка прав доступа.
  end if;
  --блочим основную таблицу
  if vv_action = u::varchar then
    perform pkg_meta.p_lock_attr(pot_attr.ck_id);
  end if;
  --проверяем и сохраняем данные
  pot_attr := pkg_meta.p_modify_attr(vv_action, pot_attr);
  --логируем данные
  perform pkg_log.p_save(pv_user, pk_session, pc_json, 't_attr', pot_attr.ck_id, vv_action);
  return '{"ck_id":"' || coalesce(pot_attr.ck_id, '') || '","cv_error":' || pkg.p_form_response() || '}';
end;
$$;


ALTER FUNCTION pkg_json_meta.f_modify_attr(pv_user character varying, pk_session character varying, pc_json jsonb) OWNER TO s_mp;

CREATE FUNCTION pkg_json_meta.f_modify_class(pv_user character varying, pk_session character varying, pc_json jsonb) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_json_meta', 'public'
    AS $$
declare
  -- переменные пакета
  gv_error sessvarstr;

  -- переменные функции
  pot_class s_mt.t_class;
  vv_action varchar(1);
  vk_main   varchar(32);
begin
  -- инициализация/получение переменных пакета
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');

  -- код функции
  --обнулим глобальные переменные с перечнем ошибок/предупреждений/информационных сообщений
  perform pkg.p_reset_response();
  --JSON -> rowtype

  pot_class.ck_id = nullif(trim(pc_json#>>'{data,ck_id}'), '');
  pot_class.cv_name = nullif(trim(pc_json#>>'{data,cv_name}'), '');
  pot_class.cv_description = nullif(trim(pc_json#>>'{data,cv_description}'), '');
  pot_class.cv_manual_documentation = nullif(trim(pc_json#>>'{data,cv_manual_documentation}'), '');
  pot_class.cv_auto_documentation = nullif(trim(pc_json#>>'{data,cv_auto_documentation}'), '');
  pot_class.ck_view = nullif(trim(pc_json#>>'{data,ck_view}'), '');
  pot_class.cl_final = trim(pc_json#>>'{data,cl_final}')::int2;
  pot_class.cl_dataset = trim(pc_json#>>'{data,cl_dataset}')::int2;
  pot_class.ck_user = pv_user;
  pot_class.ct_change = CURRENT_TIMESTAMP;
  vv_action = (pc_json#>>'{service,cv_action}');
  vk_main = (pc_json#>>'{service,ck_main}');

  --проверка прав доступа
  perform pkg_access.p_check_access(pv_user, vk_main);
  if nullif(gv_error::varchar, '') is not null then
    return '{"ck_id":"","cv_error":' || pkg.p_form_response() || '}'; --ошибка прав доступа.
  end if;
  --блочим основную таблицу
  perform pkg_meta.p_lock_class(vk_main);
  --проверяем и сохраняем данные
  pot_class := pkg_meta.p_modify_class(vv_action, pot_class);
  --логируем данные
  perform pkg_log.p_save(pv_user, pk_session, pc_json, 't_class', pot_class.ck_id::varchar, vv_action);
  return '{"ck_id":"' || coalesce(pot_class.ck_id, '') || '","cv_error":' || pkg.p_form_response() || '}';
end;
$$;


ALTER FUNCTION pkg_json_meta.f_modify_class(pv_user character varying, pk_session character varying, pc_json jsonb) OWNER TO s_mp;

CREATE FUNCTION pkg_json_meta.f_modify_class_attr(pv_user character varying, pk_session character varying, pc_json jsonb) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 's_mt', 'pkg_json_meta', 'public'
    AS $$
declare
  -- переменные пакета
  gv_error sessvarstr;
  i sessvarstr;
  -- переменные функции
  vot_class_attr s_mt.t_class_attr;

  vv_action      varchar(1);
  vk_main        varchar(32);
begin
  -- инициализация/получение переменных пакета
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');
  i = sessvarstr_declare('pkg', 'i', 'I');
  -- код функции
  --обнулим глобальные переменные с перечнем ошибок/предупреждений/информационных сообщений
  perform pkg.p_reset_response();
  --JSON -> rowtype
  vot_class_attr.ck_id = nullif(trim(pc_json#>>'{data,ck_id}'), '');
  vot_class_attr.ck_class = nullif(trim(pc_json#>>'{service,ck_main}'), '');
  vot_class_attr.ck_attr = nullif(trim(pc_json#>>'{data,ck_attr}'), '');
  vot_class_attr.cv_data_type_extra = nullif(trim(pc_json#>>'{data,cv_data_type_extra}'), '');
  vot_class_attr.cv_value = pkg_meta.p_decode_attr_variable((pc_json#>>'{data,cv_value}'), vot_class_attr.ck_id, pc_json, vot_class_attr.ck_attr, pv_user);
  vot_class_attr.cl_required = trim(pc_json#>>'{data,cl_required}')::int2;
  vot_class_attr.cl_empty = trim(pc_json#>>'{data,cl_empty}')::int2;
  vot_class_attr.ck_user = pv_user;
  vot_class_attr.ct_change = CURRENT_TIMESTAMP;
  vv_action = (pc_json#>>'{service,cv_action}');
  vk_main = (pc_json#>>'{service,ck_main}');

  --проверка прав доступа
  perform pkg_access.p_check_access(pv_user, vk_main);
  if nullif(gv_error::varchar, '') is not null then
    return '{"ck_id":"","cv_error":' || pkg.p_form_response() || '}'; --ошибка прав доступа.
  end if;
  --блочим основную таблицу
  perform pkg_meta.p_lock_class(vk_main);
  --проверяем и сохраняем данные
  vot_class_attr := pkg_meta.p_modify_class_attr(vv_action, vot_class_attr);
  --логируем данные
  perform pkg_log.p_save(pv_user, pk_session, pc_json, 'pkg_json_meta.f_modify_class_attr', vot_class_attr.ck_id, vv_action);
  return '{"ck_id":"' || coalesce(vot_class_attr.ck_id, '') || '","cv_error":' || pkg.p_form_response() || '}';
end;
$$;


ALTER FUNCTION pkg_json_meta.f_modify_class_attr(pv_user character varying, pk_session character varying, pc_json jsonb) OWNER TO s_mp;

CREATE FUNCTION pkg_json_meta.f_modify_class_hierarchy(pv_user character varying, pk_session character varying, pc_json jsonb) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_json_meta', 'public'
    AS $$
declare
  -- переменные пакета
  gv_error sessvarstr;

  -- переменные функции
  pot_class_hierarchy s_mt.t_class_hierarchy;
  vv_action           varchar(1);
  vk_main             varchar(32);
begin
  -- инициализация/получение переменных пакета
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');

  -- код функции
  --обнулим глобальные переменные с перечнем ошибок/предупреждений/информационных сообщений
  perform pkg.p_reset_response();
  --JSON -> rowtype

  pot_class_hierarchy.ck_id = nullif(trim(pc_json#>>'{data,ck_id}'), '');
  pot_class_hierarchy.ck_class_parent = nullif(trim(pc_json#>>'{service,ck_main}'), '');
  pot_class_hierarchy.ck_class_child = nullif(trim(pc_json#>>'{data,ck_class}'), '');
  pot_class_hierarchy.ck_class_attr = nullif(trim(pc_json#>>'{data,ck_class_attr}'), '');
  pot_class_hierarchy.ck_user = pv_user;
  pot_class_hierarchy.ct_change = CURRENT_TIMESTAMP;
  vv_action = (pc_json#>>'{service,cv_action}');
  vk_main = (pc_json#>>'{service,ck_main}');

  --проверка прав доступа
  perform pkg_access.p_check_access(pv_user, vk_main);
  if nullif(gv_error::varchar, '') is not null then
    return '{"ck_id":"","cv_error":' || pkg.p_form_response() || '}'; --ошибка прав доступа.
  end if;
  --блочим основную таблицу
  perform pkg_meta.p_lock_class(vk_main);
  --проверяем и сохраняем данные
  pot_class_hierarchy := pkg_meta.p_modify_class_hierarchy(vv_action, pot_class_hierarchy);
  --логируем данные
  perform pkg_log.p_save(pv_user, pk_session, pc_json, 'pkg_json_meta.f_modify_class_hierarchy', pot_class_hierarchy.ck_id::varchar, vv_action);
  return '{"ck_id":"' || coalesce(pot_class_hierarchy.ck_id, '') || '","cv_error":' || pkg.p_form_response() || '}';
end;
$$;


ALTER FUNCTION pkg_json_meta.f_modify_class_hierarchy(pv_user character varying, pk_session character varying, pc_json jsonb) OWNER TO s_mp;

CREATE FUNCTION pkg_json_meta.f_modify_module(pv_user character varying, pk_session character varying, pc_json jsonb) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_json_meta', 'public'
    AS $$
declare
  -- переменные пакета
  gv_error sessvarstr;
  u sessvarstr;
  -- переменные функции
  vot_module s_mt.t_module;
  vv_action varchar(1);
begin
  -- инициализация/получение переменных пакета
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');
  u = sessvarstr_declare('pkg', 'u', 'U');
  -- код функции
  --обнулим глобальные переменные с перечнем ошибок/предупреждений/информационных сообщений
  perform pkg.p_reset_response();
  --JSON -> rowtype
  vot_module.ck_id = nullif(trim(pc_json#>>'{data,ck_id}'), '');
  vot_module.cv_name = nullif(trim(pc_json#>>'{data,cv_name}'), '');
  vot_module.ck_view = coalesce(nullif(trim(pc_json#>>'{data,ck_view}'), ''), nullif(trim(pc_json#>>'{data,g_ck_view}'), ''));
  vot_module.ck_user = pv_user;
  vot_module.ct_change = CURRENT_TIMESTAMP;
  vot_module.cv_version = nullif(trim(pc_json#>>'{data,cv_version}'), '');
  vot_module.cv_version_api = nullif(trim(pc_json#>>'{data,cv_version_api}'), '');
  vot_module.cl_available = (pc_json#>>'{data,cl_available}')::int2;
  vot_module.cc_manifest = trim(pc_json#>>'{data,cc_manifest}')::json;
  vot_module.cc_config = trim(pc_json#>>'{data,cc_config}')::json;
  vv_action = (pc_json#>>'{service,cv_action}');
  -- Проверим права доступа
  perform pkg_access.p_check_access(pv_user, vot_module.ck_id);
  if nullif(gv_error::varchar, '') is not null then
    return '{"ck_id":"","cv_error":' || pkg.p_form_response() || '}';
  end if;
  -- Заблокируем основную таблицу
  if vv_action = u::varchar then
    perform pkg_meta.p_lock_module(vot_module.ck_id);
  end if;
  if vv_action is null then
    perform pkg.p_set_error(500);
  end if;
  if nullif(gv_error::varchar, '') is null then
    --проверяем и сохраняем данные
    vot_module := pkg_meta.p_modify_module(vv_action, vot_module);
  end if;
  --Логируем данные
  perform pkg_log.p_save(pv_user, pk_session, pc_json, 'pkg_json_meta.f_modify_module', vot_module.ck_id, vv_action);
  return '{"ck_id":"' || coalesce(vot_module.ck_id, '') || '","cv_error":' || pkg.p_form_response() || '}';
end;
$$;


ALTER FUNCTION pkg_json_meta.f_modify_module(pv_user character varying, pk_session character varying, pc_json jsonb) OWNER TO s_mp;

CREATE FUNCTION pkg_json_meta.f_modify_object(pv_user character varying, pk_session character varying, pc_json jsonb) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 's_mt', 'pkg_json_meta', 'public'
    AS $$
declare
  -- переменные пакета
  gv_error sessvarstr;
  gl_warning sessvari;
  i sessvarstr;

  -- переменные функции
  vot_object s_mt.t_object;
  vot_localization s_mt.t_localization;
  vv_action  varchar;
  vk_main    varchar(32);
begin
  -- инициализация/получение переменных пакета
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');
  gl_warning = sessvari_declare('pkg', 'gl_warning', 0);
  i = sessvarstr_declare('pkg', 'i', 'I');

  -- код функции
  --обнулим глобальные переменные с перечнем ошибок/предупреждений/информационных сообщений
  perform pkg.p_reset_response();
  --JSON -> rowtype
  vv_action = (pc_json#>>'{service,cv_action}');
  if vv_action = 'dragdrop' then
    vv_action := 'U';
    vot_object.ck_id = nullif(trim(pc_json#>>'{data,drag,ck_id}'), '');
    vot_object.ck_class = nullif(trim(pc_json#>>'{data,drag,ck_class}'), '');
    vot_object.ck_parent = nullif(trim(pc_json#>>'{data,drop,ck_id}'), '');
    vot_object.cv_name = nullif(trim(pc_json#>>'{data,drag,cv_name}'), '');
    vot_object.cn_order = nullif(trim(pc_json#>>'{data,drag,cn_order}'), '')::bigint;
    vot_object.ck_query = nullif(trim(pc_json#>>'{data,drag,ck_query}'), '');
    vot_object.cv_description = nullif(trim(pc_json#>>'{data,drag,cv_description}'), '');
    vot_object.cv_displayed = nullif(trim(pc_json#>>'{data,drag,cv_displayed}'), '');
    vot_object.cv_modify = nullif(trim(pc_json#>>'{data,drag,cv_modify}'), '');
    vot_object.ck_provider = nullif(trim(pc_json#>>'{data,drag,ck_provider}'), '');
  else
    vot_object.ck_id = nullif(trim(pc_json#>>'{data,ck_id}'), '');
    vot_object.ck_class = nullif(trim(pc_json#>>'{data,ck_class}'), '');
    vot_object.ck_parent = nullif(trim(pc_json#>>'{data,ck_parent}'), '');
    vot_object.cv_name = nullif(trim(pc_json#>>'{data,cv_name}'), '');
    vot_object.cn_order = nullif(trim(pc_json#>>'{data,cn_order}'), '')::bigint;
    vot_object.ck_query = nullif(trim(pc_json#>>'{data,ck_query}'), '');
    vot_object.cv_description = nullif(trim(pc_json#>>'{data,cv_description}'), '');
    vot_object.cv_displayed = nullif(trim(pc_json#>>'{data,cv_displayed}'), '');
    vot_object.cv_modify = nullif(trim(pc_json#>>'{data,cv_modify}'), '');
    vot_object.ck_provider = nullif(trim(pc_json#>>'{data,ck_provider}'), '');
  end if;
  
  vot_object.ck_user = pv_user;
  vot_object.ct_change = CURRENT_TIMESTAMP;
  vk_main = (pc_json#>>'{service,ck_main}');
  perform gl_warning == (pc_json#>>'{service,cl_warning}')::bigint;

  --проверка прав доступа
  perform pkg_access.p_check_access(pv_user, vk_main);
  if nullif(gv_error::varchar, '') is not null then
    return '{"ck_id":"","cv_error":' || pkg.p_form_response() || '}'; --ошибка прав доступа.
  end if;
  --проверка на добавление нового отображаемого имени
  if nullif(trim(vot_object.cv_displayed), '') is not null 
    and substr(vot_object.cv_displayed, 0, 5) = 'new:'
    and length(vot_object.cv_displayed) > 4 then

    vot_localization.ck_d_lang = nullif(trim(pc_json#>>'{data,g_sys_lang}'), '');
    vot_localization.cr_namespace = 'meta';
    vot_localization.cv_value = substr(vot_object.cv_displayed, 5);
    vot_localization.ck_user = pv_user;
    vot_localization.ct_change = CURRENT_TIMESTAMP;

    vot_localization := pkg_localization.p_add_new_localization(vot_localization);

    if nullif(gv_error::varchar, '') is not null then
      return '{"ck_id":"","cv_error":' || pkg.p_form_response() || '}'; --ошибка прав доступа.
    end if;

    vot_object.cv_displayed := coalesce(vot_localization.ck_id, '');
  end if;
  --блочим основную таблицу
  perform pkg_meta.p_lock_object(vk_main);
  --проверяем и сохраняем данные
  vot_object := pkg_meta.p_modify_object(vv_action, vot_object);
  --Логируем данные
  perform pkg_log.p_save(pv_user, pk_session, pc_json, 't_object', vot_object.ck_id, vv_action);
  return '{"ck_id":"' || coalesce(vot_object.ck_id, '') || '","cv_error":' || pkg.p_form_response() || '}';
end;
$$;


ALTER FUNCTION pkg_json_meta.f_modify_object(pv_user character varying, pk_session character varying, pc_json jsonb) OWNER TO s_mp;

CREATE FUNCTION pkg_json_meta.f_modify_object_attr(pv_user character varying, pk_session character varying, pc_json jsonb) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 's_mt', 'pkg_json_meta', 'public'
    AS $$
declare
  -- переменные пакета
  gv_error sessvarstr;
  i sessvarstr;

  -- переменные функции
  vot_object_attr s_mt.t_object_attr;
  vv_action       varchar(1);
  vv_attr         varchar(255);
  vk_main         varchar(32);
begin
  -- инициализация/получение переменных пакета
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');
  i = sessvarstr_declare('pkg', 'i', 'I');

  -- код функции
  --обнулим глобальные переменные с перечнем ошибок/предупреждений/информационных сообщений
  perform pkg.p_reset_response();
  --JSON -> rowtype

  vot_object_attr.ck_id = nullif(trim(pc_json#>>'{data,ck_id}'), '');
  vot_object_attr.ck_object = nullif(trim(pc_json#>>'{service,ck_main}'), '');
  vot_object_attr.ck_class_attr = nullif(trim(pc_json#>>'{data,ck_class_attr}'), '');
  vot_object_attr.cv_value = pkg_meta.p_decode_attr_variable((pc_json#>>'{data,cv_value}'), vot_object_attr.ck_class_attr, pc_json, pv_user);
  vot_object_attr.ck_user = pv_user;
  vot_object_attr.ct_change = CURRENT_TIMESTAMP;
  vv_action = (pc_json#>>'{service,cv_action}');
  vv_attr = (pc_json#>>'{data,ck_attr}');
  vk_main = (pc_json#>>'{service,ck_main}');
  
  --проверка прав доступа
  perform pkg_access.p_check_access(pv_user, vk_main);
  if nullif(gv_error::varchar, '') is not null then
    return '{"ck_id":"","cv_error":' || pkg.p_form_response() || '}'; --ошибка прав доступа.
  end if;
  --блочим основную таблицу
  perform pkg_meta.p_lock_object(vk_main);
  --проверяем и сохраняем данные
  vot_object_attr := pkg_meta.p_modify_object_attr(vv_action, vot_object_attr);
  --Логируем данные
  perform pkg_log.p_save(pv_user, pk_session, pc_json, 't_object_attr', vot_object_attr.ck_id::varchar, vv_action);
  return '{"ck_id":"' || coalesce(vot_object_attr.ck_id, '') || '","cv_error":' || pkg.p_form_response() || '}';
end;
$$;


ALTER FUNCTION pkg_json_meta.f_modify_object_attr(pv_user character varying, pk_session character varying, pc_json jsonb) OWNER TO s_mp;

CREATE FUNCTION pkg_json_meta.f_modify_page(pv_user character varying, pk_session character varying, pc_json jsonb) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 's_mt', 'pkg_json_meta', 'public'
    AS $$
declare
  -- переменные пакета
  gv_error sessvarstr;
  gl_warning sessvari;
  i sessvarstr;
  -- переменные функции
  vot_page  s_mt.t_page;
  vot_localization s_mt.t_localization;
  vn_action_view s_mt.t_page_action.cn_action%type; /* Код действия просмотра */
  vn_action_edit s_mt.t_page_action.cn_action%type; /* Код действия модификации */
  vv_action varchar;
  vk_main   varchar(32);
begin
  -- инициализация/получение переменных пакета
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');
  gl_warning = sessvari_declare('pkg', 'gl_warning', 0);
  i = sessvarstr_declare('pkg', 'i', 'I');
  -- код функции
  --обнулим глобальные переменные с перечнем ошибок/предупреждений/информационных сообщений
  perform pkg.p_reset_response();
  --JSON -> rowtype
  vv_action = (pc_json#>>'{service,cv_action}');
  if vv_action = 'dragdrop' then
    vv_action := 'U';
    vot_page.ck_id = nullif(trim(pc_json#>>'{data,drag,ck_id}'), '');
    vot_page.ck_parent = nullif(trim(pc_json#>>'{data,drop,ck_id}'), '');
    vot_page.cr_type = nullif(trim(pc_json#>>'{data,drag,cr_type}'), '')::bigint;
    vot_page.cv_name = nullif(trim(pc_json#>>'{data,drag,cv_name}'), '');
    vot_page.cn_order = nullif(trim(pc_json#>>'{data,drag,cn_order}'), '')::bigint;
    vot_page.cl_menu = nullif(trim(pc_json#>>'{data,drag,cl_menu}'), '')::smallint;
    vot_page.cl_static = nullif(trim(pc_json#>>'{data,drag,cl_static}'), '')::smallint;
    vot_page.cv_url = nullif(trim(pc_json#>>'{data,drag,cv_url}'), '');
    vot_page.ck_icon = nullif(trim(pc_json#>>'{data,drag,ck_icon}'), '');
    vot_page.ck_view = nullif(trim(pc_json#>>'{data,drag,ck_view}'), '');
    vn_action_view = nullif(trim(pc_json#>>'{data,drag,cn_action_view}'), '')::bigint;
    vn_action_edit = nullif(trim(pc_json#>>'{data,drag,cn_action_edit}'), '')::bigint;
  else 
    vot_page.ck_id = nullif(trim(pc_json#>>'{data,ck_id}'), '');
    vot_page.ck_parent = nullif(trim(pc_json#>>'{data,ck_parent}'), '');
    vot_page.cr_type = nullif(trim(pc_json#>>'{data,cr_type}'), '')::bigint;
    vot_page.cv_name = nullif(trim(pc_json#>>'{data,cv_name}'), '');
    vot_page.cn_order = nullif(trim(pc_json#>>'{data,cn_order}'), '')::bigint;
    vot_page.cl_menu = nullif(trim(pc_json#>>'{data,cl_menu}'), '')::smallint;
    vot_page.cl_static = nullif(trim(pc_json#>>'{data,cl_static}'), '')::smallint;
    vot_page.cv_url = nullif(trim(pc_json#>>'{data,cv_url}'), '');
    vot_page.ck_icon = nullif(trim(pc_json#>>'{data,ck_icon}'), '');
    vot_page.ck_view = nullif(trim(pc_json#>>'{data,ck_view}'), '');
    vn_action_view = nullif(trim(pc_json#>>'{data,cn_action_view}'), '')::bigint;
    vn_action_edit = nullif(trim(pc_json#>>'{data,cn_action_edit}'), '')::bigint;
  end if;

  vot_page.ck_user = pv_user;
  vot_page.ct_change = CURRENT_TIMESTAMP;
  
  vk_main = (pc_json#>>'{service,ck_main}');
  perform gl_warning == (pc_json#>>'{service,cl_warning}')::bigint;

  --проверка прав доступа
  perform pkg_access.p_check_access(pv_user, vk_main);
  if nullif(gv_error::varchar, '') is not null then
    return '{"ck_id":"","cv_error":' || pkg.p_form_response() || '}'; --ошибка прав доступа.
  end if;
  --проверка на добавление нового отображаемого имени
  if nullif(trim(vot_page.cv_name), '') is not null 
    and substr(vot_page.cv_name, 0, 5) = 'new:'
    and length(vot_page.cv_name) > 4 then

    vot_localization.ck_d_lang := nullif(trim(pc_json#>>'{data,g_sys_lang}'), '');
    vot_localization.cr_namespace = 'meta';
    vot_localization.cv_value = substr(vot_page.cv_name, 5);
    vot_localization.ck_user = pv_user;
    vot_localization.ct_change = CURRENT_TIMESTAMP;

    vot_localization := pkg_localization.p_add_new_localization(vot_localization);

    if nullif(gv_error::varchar, '') is not null then
      return '{"ck_id":"","cv_error":' || pkg.p_form_response() || '}'; --ошибка прав доступа.
    end if;

    vot_page.cv_name := coalesce(vot_localization.ck_id, '');
  end if;
  --блочим основную таблицу
  perform pkg_meta.p_lock_page(vk_main);
  --проверяем и сохраняем данные
  vot_page := pkg_meta.p_modify_page(vv_action, vot_page, vn_action_view, vn_action_edit);
  --Логируем данные
  perform pkg_log.p_save(pv_user, pk_session, pc_json, 'pkg_json_meta.f_modify_page', vot_page.ck_id, vv_action);
  return '{"ck_id":"'|| coalesce(vot_page.ck_id, '') ||'","cv_error":' || pkg.p_form_response() || '}';
end;
$$;


ALTER FUNCTION pkg_json_meta.f_modify_page(pv_user character varying, pk_session character varying, pc_json jsonb) OWNER TO s_mp;

CREATE FUNCTION pkg_json_meta.f_modify_page_attr(pv_user character varying, pk_session character varying, pc_json jsonb) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 's_mt', 'pkg_json_meta', 'public'
    AS $$
declare
  -- переменные пакета
  gv_error sessvarstr;
  i sessvarstr;
  -- переменные функции
  vot_page_attr s_mt.t_page_attr;

  vv_action      varchar(1);
  vk_main        varchar(32);
begin
  -- инициализация/получение переменных пакета
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');
  i = sessvarstr_declare('pkg', 'i', 'I');
  -- код функции
  --обнулим глобальные переменные с перечнем ошибок/предупреждений/информационных сообщений
  perform pkg.p_reset_response();
  --JSON -> rowtype
  vot_page_attr.ck_id = nullif(trim(pc_json#>>'{data,ck_id}'), '');
  vot_page_attr.ck_page = nullif(trim(pc_json#>>'{master,ck_id}'), '');
  vot_page_attr.ck_attr = nullif(trim(pc_json#>>'{data,ck_attr}'), '');
  vot_page_attr.cv_value = pkg_meta.p_decode_attr_variable((pc_json#>>'{data,cv_value}'), null, pc_json, vot_page_attr.ck_attr, pv_user);
  vot_page_attr.ck_user = pv_user;
  vot_page_attr.ct_change = CURRENT_TIMESTAMP;
  vv_action = (pc_json#>>'{service,cv_action}');
  vk_main = (pc_json#>>'{master,ck_id}');

  --проверка прав доступа
  perform pkg_access.p_check_access(pv_user, vk_main);
  if nullif(gv_error::varchar, '') is not null then
    return '{"ck_id":"","cv_error":' || pkg.p_form_response() || '}'; --ошибка прав доступа.
  end if;
  --блочим основную таблицу
  perform pkg_meta.p_lock_page(vk_main);
  --проверяем и сохраняем данные
  vot_page_attr := pkg_meta.p_modify_page_attr(vv_action, vot_page_attr);
  --логируем данные
  perform pkg_log.p_save(pv_user, pk_session, pc_json, 'pkg_json_meta.f_modify_page_attr', vot_page_attr.ck_id, vv_action);
  return '{"ck_id":"' || coalesce(vot_page_attr.ck_id, '') || '","cv_error":' || pkg.p_form_response() || '}';
end;
$$;


ALTER FUNCTION pkg_json_meta.f_modify_page_attr(pv_user character varying, pk_session character varying, pc_json jsonb) OWNER TO s_mp;


CREATE FUNCTION pkg_json_meta.f_modify_page_object(pv_user character varying, pk_session character varying, pc_json jsonb) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_json_meta', 'public'
    AS $$
declare
  -- переменные пакета
  gv_error sessvarstr;
  -- переменные функции
  pot_page_object s_mt.t_page_object;
  vv_action       varchar;
  vk_main         varchar(32);
begin
  -- инициализация/получение переменных пакета
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');
  -- код функции
  --обнулим глобальные переменные с перечнем ошибок/предупреждений/информационных сообщений
  perform pkg.p_reset_response();
  --JSON -> rowtype
  vv_action = (pc_json#>>'{service,cv_action}');
  if vv_action = 'dragdrop' then
    vv_action := 'U';
    pot_page_object.ck_page = nullif(trim(pc_json#>>'{service,ck_main}'), '');
    pot_page_object.ck_object = nullif(trim(pc_json#>>'{data,drag,ck_object}'), '');
    pot_page_object.ck_id = nullif(trim(pc_json#>>'{data,drag,ck_id}'), '');
    pot_page_object.cn_order = nullif(trim(pc_json#>>'{data,drag,cn_order}'), '')::bigint;
    pot_page_object.ck_master = nullif(trim(pc_json#>>'{data,drag,ck_master}'), '');
    pot_page_object.ck_parent = nullif(trim(pc_json#>>'{data,drop,ck_id}'), '');
  else
    pot_page_object.ck_page = nullif(trim(pc_json#>>'{service,ck_main}'), '');
    pot_page_object.ck_object = nullif(trim(pc_json#>>'{data,ck_object}'), '');
    pot_page_object.ck_id = nullif(trim(pc_json#>>'{data,ck_id}'), '');
    pot_page_object.cn_order = nullif(trim(pc_json#>>'{data,cn_order}'), '')::bigint;
    pot_page_object.ck_master = nullif(trim(pc_json#>>'{data,ck_master}'), '');
    pot_page_object.ck_parent = nullif(trim(pc_json#>>'{data,ck_parent}'), '');
  end if;
  pot_page_object.ck_user = pv_user;
  pot_page_object.ct_change = CURRENT_TIMESTAMP;
  vk_main = (pc_json#>>'{service,ck_main}');

  --проверка прав доступа
  perform pkg_access.p_check_access(pv_user, vk_main);
  if nullif(gv_error::varchar, '') is not null then
    return '{"ck_id":"","cv_error":' || pkg.p_form_response() || '}'; --ошибка прав доступа.
  end if;
  --блочим основную таблицу
  perform pkg_meta.p_lock_page(vk_main);
  --проверяем и сохраняем данные
  pot_page_object := pkg_meta.p_modify_page_object(vv_action, pot_page_object);
  --Логируем данные
  perform pkg_log.p_save(pv_user, pk_session, pc_json, 'pkg_json_meta.f_modify_page_object', pot_page_object.ck_id, vv_action);
  return '{"ck_id":"' || coalesce(pot_page_object.ck_id, '') || '","cv_error":' || pkg.p_form_response() || '}';
end;
$$;


ALTER FUNCTION pkg_json_meta.f_modify_page_object(pv_user character varying, pk_session character varying, pc_json jsonb) OWNER TO s_mp;

CREATE FUNCTION pkg_json_meta.f_modify_page_object_attr(pv_user character varying, pk_session character varying, pc_json jsonb) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 's_mt', 'pkg_json_meta', 'public'
    AS $$
declare
  -- переменные пакета
  gv_error sessvarstr;
  gl_warning sessvari;
  i sessvarstr;

  -- переменные функции
  vot_page_object_attr s_mt.t_page_object_attr;
  vv_action            varchar(1);
  vk_main              varchar(32);
  vv_attr              varchar(255);
begin
  -- инициализация/получение переменных пакета
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');
  gl_warning = sessvari_declare('pkg', 'gl_warning', 0);
  i = sessvarstr_declare('pkg', 'i', 'I');

  -- код функции
  --обнулим глобальные переменные с перечнем ошибок/предупреждений/информационных сообщений
  perform pkg.p_reset_response();
  --JSON -> rowtype
  vot_page_object_attr.ck_id = nullif(trim(pc_json#>>'{data,ck_id}'), '');
  vot_page_object_attr.ck_page_object = nullif(trim(pc_json#>>'{service,ck_main}'), '');
  vot_page_object_attr.ck_class_attr = nullif(trim(pc_json#>>'{data,ck_class_attr}'), '');
  vot_page_object_attr.cv_value = pkg_meta.p_decode_attr_variable((pc_json#>>'{data,cv_value}'), vot_page_object_attr.ck_class_attr, pc_json, pv_user);
  vot_page_object_attr.ck_user = pv_user;
  vot_page_object_attr.ct_change = CURRENT_TIMESTAMP;
  vv_action = (pc_json#>>'{service,cv_action}');
  vv_attr = (pc_json#>>'{data,ck_attr}');
  vk_main = (pc_json#>>'{service,ck_main}');
  perform gl_warning == (pc_json#>>'{service,cl_warning}')::bigint;

  --проверка прав доступа
  perform pkg_access.p_check_access(pv_user, vk_main);
  if nullif(gv_error::varchar, '') is not null then
    return '{"ck_id":"","cv_error":' || pkg.p_form_response() || '}'; --ошибка прав доступа.
  end if;
  --блочим основную таблицу
  perform pkg_meta.p_lock_page_object(vk_main);
  --проверяем и сохраняем данные
  vot_page_object_attr := pkg_meta.p_modify_page_object_attr(vv_action, vot_page_object_attr);
  --Логируем данные
  perform pkg_log.p_save(pv_user, pk_session, pc_json, 't_object_attr', vot_page_object_attr.ck_id::varchar, vv_action);
  return '{"ck_id":"' || coalesce(vot_page_object_attr.ck_id, '') || '","cv_error":' || pkg.p_form_response() || '}';
end;
$$;


ALTER FUNCTION pkg_json_meta.f_modify_page_object_attr(pv_user character varying, pk_session character varying, pc_json jsonb) OWNER TO s_mp;

CREATE FUNCTION pkg_json_meta.f_modify_page_variable(pv_user character varying, pv_session character varying, pc_json jsonb) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_json_meta', 'public'
    AS $$
declare
  -- переменные пакета
  gv_error sessvarstr;
  -- переменные функции
  vot_page_variable s_mt.t_page_variable;
  vv_action         varchar(1);
  vk_main           varchar(100);
begin
  -- инициализация/получение переменных пакета
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');
  -- код функции
  -- Обнулим глобальные переменные с перечнем ошибок/предупреждений/информационных сообщений
  perform pkg.p_reset_response();
  -- JSON -> rowtype
  vot_page_variable.ck_id = nullif(trim(pc_json#>>'{data,ck_id}'), '');
  vot_page_variable.ck_page = nullif(trim(pc_json#>>'{service,ck_main}'), '');
  vot_page_variable.cv_name = nullif(trim(pc_json#>>'{data,cv_name}'), '');
  vot_page_variable.cv_value = nullif(pc_json#>>'{data,cv_value}', '');
  vot_page_variable.cv_description = nullif(trim(pc_json#>>'{data,cv_description}'), '');
  vot_page_variable.ck_user = pv_user;
  vot_page_variable.ct_change = CURRENT_TIMESTAMP;
  vv_action = (pc_json#>>'{service,cv_action}');
  vk_main = (pc_json#>>'{service,ck_main}');
  -- Проверим права доступа
  perform pkg_access.p_check_access(pv_user, vk_main);
  if nullif(gv_error::varchar, '') is not null then
    return '{"ck_id":"","cv_error":' || pkg.p_form_response() || '}';
  end if;
  -- Заблокируем основную таблицу
  perform pkg_meta.p_lock_page(vk_main);
  if nullif(gv_error::varchar, '') is not null then
    return '{"ck_id":"","cv_error":' || pkg.p_form_response() || '}';
  end if;
  -- Проверим и сохраним данные
  vot_page_variable := pkg_meta.p_modify_page_variable(vv_action, vot_page_variable);
  -- Логируем данные
  perform pkg_log.p_save(pv_user, pv_session, pc_json, 'pkg_json_meta.f_modify_page_variable', vot_page_variable.ck_id, vv_action);
  return '{"ck_id":"' || coalesce(vot_page_variable.ck_id, '') || '","cv_error":' || pkg.p_form_response() || '}';
end;
$$;


ALTER FUNCTION pkg_json_meta.f_modify_page_variable(pv_user character varying, pv_session character varying, pc_json jsonb) OWNER TO s_mp;

CREATE FUNCTION pkg_json_meta.f_modify_provider(pv_user character varying, pv_session character varying, pc_json jsonb) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_json_meta', 'public'
    AS $$
declare
  -- переменные пакета
  gv_error sessvarstr;
  u sessvarstr;
  -- переменные функции
  vot_provider s_mt.t_provider;
  vv_action varchar(1);
begin
  -- инициализация/получение переменных пакета
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');
  u = sessvarstr_declare('pkg', 'u', 'U');
  -- код функции
  --обнулим глобальные переменные с перечнем ошибок/предупреждений/информационных сообщений
  perform pkg.p_reset_response();
  --JSON -> rowtype
  vot_provider.ck_id = nullif(trim(pc_json#>>'{data,ck_id}'), '');
  vot_provider.cv_name = nullif(trim(pc_json#>>'{data,cv_name}'), '');
  vot_provider.ck_user = pv_user;
  vot_provider.ct_change = CURRENT_TIMESTAMP;
  vv_action = (pc_json#>>'{service,cv_action}');
  if nullif(gv_error::varchar, '') is not null then
    return '{"ck_id":"","cv_error":' || pkg.p_form_response() || '}';
  end if;
  -- Заблокируем основную таблицу
  if vv_action = u::varchar then
    perform pkg_meta.p_lock_provider(vot_provider.ck_id);
  end if;
  if nullif(gv_error::varchar, '') is not null then
    return '{"ck_id":"","cv_error":' || pkg.p_form_response() || '}';
  end if;
  --проверяем и сохраняем данные
  vot_provider := pkg_meta.p_modify_provider(vv_action, vot_provider);
  --Логируем данные
  perform pkg_log.p_save(pv_user, pv_session, pc_json, 'pkg_json_meta.f_modify_provider', vot_provider.ck_id, vv_action);
  return '{"ck_id":"' || coalesce(vot_provider.ck_id, '') || '","cv_error":' || pkg.p_form_response() || '}';
  exception
    when others then
      if SQLSTATE = '22001' then
        if length(nullif(trim(pc_json#>>'{data,ck_id}'), '')) > 32 then
          perform pkg.p_set_error(79, '32', 'meta:153d12ad65b44cfa85f5d1e88d11cc2a');
        end if;
        if length(nullif(trim(pc_json#>>'{data,cv_name}'), '')) > 255 then
          perform pkg.p_set_error(79, '255', 'meta:e0cd88534f90436da2b3b5eeae0ae340');
        end if;
        if nullif(gv_error::varchar, '') is not null then
   	      return '{"ck_id":"","cv_error":' || pkg.p_form_response() || '}';
        end if;
      end if;
      raise exception '%: %', SQLSTATE, SQLERRM;
end;
$$;


ALTER FUNCTION pkg_json_meta.f_modify_provider(pv_user character varying, pv_session character varying, pc_json jsonb) OWNER TO s_mp;

CREATE FUNCTION pkg_json_meta.f_modify_sys_setting(pv_user character varying, pv_session character varying, pc_json jsonb) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_json_meta', 'public'
    AS $$
declare
  -- переменные пакета
  gv_error sessvarstr;
  gl_warning sessvari;
  -- переменные функции
  vot_sys_setting  s_mt.t_sys_setting;
  vv_action varchar(1);
begin
  -- инициализация/получение переменных пакета
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');
  gl_warning = sessvari_declare('pkg', 'gl_warning', 0);
  -- код функции
  --обнулим глобальные переменные с перечнем ошибок/предупреждений/информационных сообщений
  perform pkg.p_reset_response();
  --JSON -> rowtype
  vot_sys_setting.ck_id = nullif(trim(pc_json#>>'{data,ck_id}'), '');
  vot_sys_setting.cv_value = nullif(trim(pc_json#>>'{data,cv_value}'), '');
  vot_sys_setting.cv_description = nullif(trim(pc_json#>>'{data,cv_description}'), '');
  vot_sys_setting.ck_user = pv_user;
  vot_sys_setting.ct_change = CURRENT_TIMESTAMP;
  vv_action = (pc_json#>>'{service,cv_action}');
  perform gl_warning == (pc_json#>>'{service,cl_warning}')::bigint;
  -- Заблокируем основную таблицу
  perform pkg_meta.p_lock_sys_setting(vot_sys_setting.ck_id);
  if nullif(gv_error::varchar, '') is not null then
    return '{"ck_id":"","cv_error":' || pkg.p_form_response() || '}';
  end if;
  --проверяем и сохраняем данные
  vot_sys_setting := pkg_meta.p_modify_sys_setting(vv_action, vot_sys_setting);
  --Логируем данные
  perform pkg_log.p_save(pv_user, pv_session, pc_json, 'pkg_json_meta.f_modify_sys_setting', vot_sys_setting.ck_id, vv_action);
  return '{"ck_id":"' || coalesce(vot_sys_setting.ck_id, '') || '","cv_error":' || pkg.p_form_response() || '}';
  exception
    when others then
      if SQLSTATE = '22001' then
        if length(nullif(trim(pc_json#>>'{data,ck_id}'), '')) > 255 then
          perform pkg.p_set_error(79, '255', 'meta:e0cd88534f90436da2b3b5eeae0ae340');
        end if;
        if length(nullif(trim(pc_json#>>'{data,cv_description}'), '')) > 2000 then
          perform pkg.p_set_error(79, '2000', 'meta:a4b1d1f3995f499a8f2bac5b57a3cbdc');
        end if;
        if nullif(gv_error::varchar, '') is not null then
   	      return '{"ck_id":"","cv_error":' || pkg.p_form_response() || '}';
        end if;
      end if;
      raise exception '%: %', SQLSTATE, SQLERRM;
end;
$$;


ALTER FUNCTION pkg_json_meta.f_modify_sys_setting(pv_user character varying, pv_session character varying, pc_json jsonb) OWNER TO s_mp;

CREATE FUNCTION pkg_json_meta.f_refresh_page_object(pv_user character varying, pv_session character varying, pc_json jsonb) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_json_meta', 'public'
    AS $$
declare
  -- переменные пакета
  gv_error sessvarstr;

  -- переменные функции
  pot_page  s_mt.t_page;
  vv_action varchar(1);
  vk_main   bigint;
begin
  -- инициализация/получение переменных пакета
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');

  -- код функции
  --обнулим глобальные переменные с перечнем ошибок/предупреждений/информационных сообщений, выставим пользователя
  perform pkg.p_reset_response();--(pv_user);
  --JSON -> rowtype

  pot_page.ck_id = nullif(trim(pc_json#>>'{data,ck_id}'), '');
  pot_page.ck_user = pv_user;
  pot_page.ct_change = CURRENT_TIMESTAMP;
  vv_action = (pc_json#>>'{service,cv_action}');
  vk_main = (pc_json#>>'{service,ck_main}')::bigint;

  -- проверим права доступа
  perform pkg_access.p_check_access(pv_user, vk_main::varchar);

  if nullif(gv_error::varchar, '') is not null then
    return '{"ck_id":"","cv_error":' || pkg.p_form_response() || '}';
  end if;
  -- вызовем метод обновления связанных со страницей page_object-ов
  perform pkg_meta.p_refresh_page_object(pot_page.ck_id);

  -- логируем данные
  perform pkg_log.p_save(pv_user, pv_session, pc_json, 't_page_object', pot_page.ck_id::varchar, vv_action);
  return '{"ck_id":"' || coalesce(pot_page.ck_id, '') || '","cv_error":' || pkg.p_form_response() || '}';
end;
$$;


ALTER FUNCTION pkg_json_meta.f_refresh_page_object(pv_user character varying, pv_session character varying, pc_json jsonb) OWNER TO s_mp;


CREATE FUNCTION pkg_json_meta.f_modify_page_all(pv_user character varying, pk_session character varying, pc_json jsonb) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 's_mt', 'pkg_json_meta', 'public'
    AS $$
declare
  -- переменные пакета
  gv_error sessvarstr;
  gl_warning sessvari;
  i sessvarstr;
  -- переменные функции
  vv_action varchar;
  vk_main   varchar(32);
  vot_page  s_mt.t_page;
  vot_localization s_mt.t_localization;
  vn_action_view s_mt.t_page_action.cn_action%type; /* Код действия просмотра */
  vn_action_edit s_mt.t_page_action.cn_action%type; /* Код действия модификации */
  vt_rec record;
  rec record;
begin
  -- инициализация/получение переменных пакета
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');
  gl_warning = sessvari_declare('pkg', 'gl_warning', 0);
  i = sessvarstr_declare('pkg', 'i', 'I');
  -- код функции
  --обнулим глобальные переменные с перечнем ошибок/предупреждений/информационных сообщений
  perform pkg.p_reset_response();
  --JSON -> rowtype
  vv_action = (pc_json#>>'{service,cv_action}');  
  perform gl_warning == (pc_json#>>'{service,cl_warning}')::bigint;

  --проверка прав доступа
  perform pkg_access.p_check_access(pv_user, vk_main);
  if nullif(gv_error::varchar, '') is not null then
    return '{"ck_id":"","cv_error":' || pkg.p_form_response() || '}'; --ошибка прав доступа.
  end if;
  for rec in (
    select
        ja.ck_id,
        (
            coalesce(ja.ck_parent, ta.ck_parent)
        ) as ck_parent,
        (
            coalesce(ja.cr_type, ta.cr_type::text, '3')
        ) as cr_type,
        (
            coalesce(ja.cv_name, ta.cv_name)
        ) as cv_name,
        (
            coalesce(ja.cn_order, ta.cn_order::text)
        ) as cn_order,
        (
            coalesce(ja.cl_menu, ta.cl_menu::text, '1')
        ) as cl_menu,
        (
            coalesce(ja.cl_static, ta.cl_static::text, '0')
        ) as cl_static,
        (
            coalesce(ja.cv_url, ta.cv_url)
        ) as cv_url,
        (
            coalesce(ja.ck_icon, ta.ck_icon)
        ) as ck_icon,
        (
            coalesce(ja.ck_view, ta.ck_view, tpa.ck_view)
        ) as ck_view,
        (
            coalesce(ja.cn_action_edit, tpea.cn_action::text, '999999')
        ) as cn_action_edit,
        (
            coalesce(ja.cn_action_view, tpva.cn_action::text, '999999')
        ) as cn_action_view
    from
        jsonb_to_record(pc_json#>'{data}') as 
        ja(ck_id text, 
          ck_parent text, 
          cr_type text, 
          cv_name text, 
          cn_order text, 
          cl_menu text, 
          cl_static text, 
          cv_url text, 
          ck_icon text, 
          ck_view text, 
          cn_action_view text, 
          cn_action_edit text)
    left join s_mt.t_page ta on
        ja.ck_id = ta.ck_id
    left join s_mt.t_page tpa on
        tpa.ck_id = ta.ck_parent
    left join s_mt.t_page_action tpea on
        ta.ck_id = tpea.ck_page and tpea.cr_type = 'edit'
    left join s_mt.t_page_action tpva on
        ta.ck_id = tpva.ck_page and tpva.cr_type = 'view'
  ) loop
    vot_page.ck_id = rec.ck_id;
    vot_page.ck_parent = rec.ck_parent;
    vot_page.cr_type = (rec.cr_type)::bigint;
    vot_page.cv_name = rec.cv_name;
    vot_page.cn_order = (rec.cn_order)::bigint;
    vot_page.cl_menu = (rec.cl_menu)::smallint;
    vot_page.cl_static = (rec.cl_static)::smallint;
    vot_page.cv_url = rec.cv_url;
    vot_page.ck_icon = rec.ck_icon;
    vot_page.ck_view = rec.ck_view;
    vn_action_view = (rec.cn_action_view)::bigint;
    vn_action_edit = (rec.cn_action_edit)::bigint;
  end loop;
  if nullif(trim(vot_page.cv_name), '') is not null 
    and substr(vot_page.cv_name, 0, 5) = 'new:'
    and length(vot_page.cv_name) > 4 then

    vot_localization.ck_d_lang = nullif(trim(pc_json#>>'{data,g_sys_lang}'), '');
    vot_localization.cr_namespace = 'meta';
    vot_localization.cv_value = substr(vot_page.cv_name, 5);
    vot_localization.ck_user = pv_user;
    vot_localization.ct_change = CURRENT_TIMESTAMP;

    vot_localization := pkg_localization.p_add_new_localization(vot_localization);

    if nullif(gv_error::varchar, '') is not null then
      return '{"ck_id":"","cv_error":' || pkg.p_form_response() || '}'; --ошибка прав доступа.
    end if;

    vot_page.cv_name := coalesce(vot_localization.ck_id, '');
  end if;
  vot_page.ck_user = pv_user;
  vot_page.ct_change = CURRENT_TIMESTAMP;
  vot_page := pkg_meta.p_modify_page(vv_action, vot_page, vn_action_view, vn_action_edit);
  --проверяем и сохраняем данные
  for vt_rec in (
    select value as json from jsonb_array_elements(pc_json#>'{data,children}')
  ) loop
      perform pkg_meta.p_modify_page_all_object(vt_rec.json, vv_action, pv_user);
  end loop;
  --Логируем данные
  perform pkg_log.p_save(pv_user, pk_session, pc_json, 'pkg_json_meta.f_modify_page_all', vot_page.ck_id, vv_action);
  return '{"ck_id":"'|| coalesce(vot_page.ck_id, '') ||'","cv_error":' || pkg.p_form_response() || '}';
end;
$$;

ALTER FUNCTION pkg_json_meta.f_modify_page_all(pv_user character varying, pv_session character varying, pc_json jsonb) OWNER TO s_mp;
