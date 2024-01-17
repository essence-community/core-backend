--liquibase formatted sql
--changeset artemov_i:pkg_access dbms:postgresql runOnChange:true splitStatements:false stripComments:false
DROP SCHEMA IF EXISTS pkg_json_account cascade;

CREATE SCHEMA pkg_json_account
    AUTHORIZATION ${user.update};

CREATE OR REPLACE FUNCTION pkg_json_account.f_get_field_info(
	pv_master character varying DEFAULT NULL::character varying,
	pk_d_info character varying DEFAULT NULL::character varying,
	pv_column character varying DEFAULT NULL::character varying)
    RETURNS text
    LANGUAGE 'plpgsql'
    SECURITY DEFINER 
    SET search_path=public, pkg, pkg_account, ${user.table}
AS $BODY$
declare
  -- переменные пакета
  gv_error sessvarstr;
  
  vv_res jsonb := '[]'::jsonb;
  vot_rec record;
  vot_d_info ${user.table}.t_d_info;
  vv_required varchar := 'false';
  vv_value text := '';
begin
  -- инициализация/получение переменных пакета
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');

  -- код функции
  --обнулим глобальные переменные с перечнем ошибок/предупреждений/информационных сообщений, выставим пользователя
  perform pkg.p_reset_response();--(pn_user);
  --JSON -> rowtype
  if pk_d_info is null then
  	for vot_rec in (select ck_id from ${user.table}.t_d_info) loop
  		vv_res := vv_res || (pkg_json_account.f_get_field_info(pv_master, vot_rec.ck_id))::jsonb;
    end loop;
    return vv_res::text;
  end if;
  if pv_master is not null then
  	select cv_value
  	into vv_value
  	from ${user.table}.t_account_info where ck_account = pv_master::uuid;
  end if;
  select 
  	t.*
  	into strict vot_d_info
  from ${user.table}.t_d_info t
  	where t.ck_id = pk_d_info;
  if vot_d_info.cl_required = 1 then
    vv_required := 'true';
  end if;
  
  if vot_d_info.cr_type = 'text' then
  	return json_build_array(json_build_object(
  		'type', 'IFIELD',
		'cv_name', vot_d_info.cv_description,
		'column', coalesce(pv_column, vot_d_info.ck_id),
		'datatype', 'text',
		'cl_dataset', 0,
		'cv_displayed', vot_d_info.ck_id,
    'info', vot_d_info.cv_description,
		'ck_page_object', sys_guid(),
		'required', vv_required,
		'defaultvalue', vv_value
  	));
  end if;
  if vot_d_info.cr_type = 'textarea' then
  	return json_build_array(json_build_object(
  		'type', 'IFIELD',
		'cv_name', vot_d_info.cv_description,
		'column', coalesce(pv_column, vot_d_info.ck_id),
		'datatype', 'textarea',
		'cl_dataset', 0,
		'cv_displayed', vot_d_info.ck_id,
    'info', vot_d_info.cv_description,
		'ck_page_object', sys_guid(),
		'required', vv_required,
		'defaultvalue', vv_value
  	));
  end if;
  if vot_d_info.cr_type = 'json' then
  	return json_build_array(json_build_object(
  		'type', 'IFIELD',
		'cv_name', vot_d_info.cv_description,
		'column', coalesce(pv_column, vot_d_info.ck_id),
		'datatype', 'textarea',
		'cl_dataset', 0,
		'cv_displayed', vot_d_info.ck_id,
    'info', vot_d_info.cv_description,
		'ck_page_object', sys_guid(),
		'required', vv_required,
		'defaultvalue', vv_value
  	));
  end if;
  if vot_d_info.cr_type = 'array' then
  	return json_build_array(json_build_object(
  		'type', 'IFIELD',
		'cv_name', vot_d_info.cv_description,
		'column', coalesce(pv_column, vot_d_info.ck_id),
		'datatype', 'textarea',
		'cl_dataset', 0,
		'cv_displayed', vot_d_info.ck_id,
    'info', vot_d_info.cv_description,
		'ck_page_object', sys_guid(),
		'required', vv_required,
		'defaultvalue', vv_value
  	));
  end if;
  if vot_d_info.cr_type = 'object' then
  	return json_build_array(json_build_object(
  		'type', 'IFIELD',
		'cv_name', vot_d_info.cv_description,
		'column', coalesce(pv_column, vot_d_info.ck_id),
		'datatype', 'textarea',
		'cl_dataset', 0,
		'cv_displayed', vot_d_info.ck_id,
    'info', vot_d_info.cv_description,
		'ck_page_object', sys_guid(),
		'required', vv_required,
		'defaultvalue', vv_value
  	));
  end if;
  if vot_d_info.cr_type = 'integer' then
  	return json_build_array(json_build_object(
  		'type', 'IFIELD',
		'cv_name', vot_d_info.cv_description,
		'column', coalesce(pv_column, vot_d_info.ck_id),
		'datatype', 'integer',
		'cl_dataset', 0,
		'cv_displayed', vot_d_info.ck_id,
    'info', vot_d_info.cv_description,
		'ck_page_object', sys_guid(),
		'required', vv_required,
		'defaultvalue', vv_value
  	));
  end if;
  if vot_d_info.cr_type = 'numeric' then
  	return json_build_array(json_build_object(
  		'type', 'IFIELD',
		'cv_name', vot_d_info.cv_description,
		'column', coalesce(pv_column, vot_d_info.ck_id),
		'datatype', 'numeric',
		'cl_dataset', 0,
		'cv_displayed', vot_d_info.ck_id,
    'info', vot_d_info.cv_description,
		'ck_page_object', sys_guid(),
		'defaultvalue', vv_value,
		'required', vv_required,
		'decimalseparator', ',',
		'thousandseparator', '.'
  	));
  end if;
  if vot_d_info.cr_type = 'date' then
  	return json_build_array(json_build_object(
  		'type', 'IFIELD',
		'cv_name', vot_d_info.cv_description,
		'column', coalesce(pv_column, vot_d_info.ck_id),
		'datatype', 'date',
		'format', '3',
		'cl_dataset', 0,
		'cv_displayed', vot_d_info.ck_id,
    'info', vot_d_info.cv_description,
		'required', vv_required,
		'ck_page_object', sys_guid(),
		'defaultvalue', vv_value
  	));
  end if;
  if vot_d_info.cr_type = 'boolean' then
  	return json_build_array(json_build_object(
  		'type', 'IFIELD',
		'cv_name', vot_d_info.cv_description,
		'column', coalesce(pv_column, vot_d_info.ck_id),
		'datatype', 'checkbox',
		'cl_dataset', 0,
		'cv_displayed', vot_d_info.ck_id,
    'info', vot_d_info.cv_description,
		'required', vv_required,
		'ck_page_object', sys_guid(),
		'defaultvalue', vv_value
  	));
  end if;
return vv_res::text;
end;$BODY$;

ALTER FUNCTION pkg_json_account.f_get_field_info(character varying, character varying, character varying)
    OWNER TO ${user.update};

CREATE FUNCTION pkg_json_account.f_decode_attr(pv_value varchar, pk_data_type varchar) RETURNS jsonb
    LANGUAGE plpgsql SECURITY DEFINER PARALLEL SAFE
    SET search_path TO 'pkg_json_account', 'public'
    AS $$
begin

  if pk_data_type = 'localization' or pk_data_type = 'enum' or pk_data_type = 'date' or pk_data_type = 'text' then
    return to_jsonb(pv_value);
  end if;
  
  if pk_data_type = 'integer' then
    return to_jsonb(pv_value::bigint);
  end if;

  if pk_data_type = 'numeric' then
    return to_jsonb(pv_value::decimal);
  end if;
  
  if pk_data_type = 'boolean' then
    if pv_value is null then 
      return null;
    end if;
    return  to_jsonb(pv_value::bool);
  end if;
  
  --  or pk_data_type = 'global'
  if pk_data_type = 'array' or pk_data_type = 'object' or pk_data_type = 'json' then
    if pv_value ~ '^[\[\{]' then
      return pv_value::jsonb;
    end if;
    return null;
  end if;

  return to_jsonb(pv_value);
end;
$$;

ALTER FUNCTION pkg_json_account.f_decode_attr(pv_value varchar, pk_data_type varchar) OWNER TO ${user.update};

CREATE OR REPLACE FUNCTION pkg_json_account.f_get_user(
	pv_login character varying DEFAULT NULL::character varying,
	pv_password character varying DEFAULT NULL::character varying,
	pv_token character varying DEFAULT NULL::character varying,
	pl_audit smallint DEFAULT 0)
    RETURNS character varying
    LANGUAGE 'plpgsql'
    SECURITY DEFINER 
    SET search_path=public, pkg, pkg_account, ${user.table}
AS $BODY$
declare
  -- переменные пакета
  gv_error sessvarstr;

  -- переменные функции
  vot_account ${user.table}.t_account;
  vot_auth_token ${user.table}.t_auth_token;
begin
  -- инициализация/получение переменных пакета
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');

  -- код функции
  --обнулим глобальные переменные с перечнем ошибок/предупреждений/информационных сообщений, выставим пользователя
  perform pkg.p_reset_response();--(pn_user);
  
  --JSON -> rowtype
  if pv_token is not null then
    select 
      t.* 
      into vot_auth_token
    from ${user.table}.t_auth_token t 
      where t.ck_id = pv_token and CURRENT_TIMESTAMP BETWEEN t.ct_start and t.ct_expire;
    
    if vot_auth_token.ck_account is not null and vot_auth_token.cl_single = 1 then
        vot_auth_token.ck_user = vot_auth_token.ck_account::varchar;
        vot_auth_token.ct_expire = CURRENT_TIMESTAMP;
        vot_auth_token.ct_change = CURRENT_TIMESTAMP;
        vot_auth_token := pkg_account.p_modify_auth_token('U', vot_auth_token);
    end if;
  end if;

  select
    *
    into vot_account
  from ${user.table}.t_account
    where (upper(cv_login) = upper(pv_login) and cl_deleted = 0::smallint and cv_hash_password = pkg_account.f_create_hash(cv_salt, pv_password)) or (vot_auth_token.ck_account is not null and cl_deleted = 0::smallint and ck_id = vot_auth_token.ck_account);
  -- логируем данные
  if pl_audit = 1 then
     perform pkg_log.p_save('-11', '', jsonb_build_object('cv_login', pv_login, 'cv_token', pv_token), 'Login', vot_account.ck_id::varchar, 'i');
  end if;
  return vot_account.ck_id::varchar;
  end;
$BODY$;

ALTER FUNCTION pkg_json_account.f_get_user(character varying, character varying, character varying, smallint)
    OWNER TO ${user.update};

COMMENT ON FUNCTION pkg_json_account.f_get_user(character varying, character varying, character varying, smallint)
    IS 'Поиск пользователя';

CREATE OR REPLACE FUNCTION pkg_json_account.f_modify_account(
	pv_user character varying,
	pv_session character varying,
	pc_json jsonb)
    RETURNS text
    LANGUAGE 'plpgsql'
    SECURITY DEFINER 
    SET search_path=public, pkg, pkg_account, ${user.table}
AS $BODY$
declare
  i sessvarstr;
  -- переменные пакета
  gv_error sessvarstr;
  gl_warning sessvari;

  -- переменные функции
  vot_account ${user.table}.t_account;
  vl_deleted smallint;
  vct_account_info jsonb := '[]'::jsonb;
  vot_account_ext ${user.table}.t_account_ext;
  vv_action  varchar(1);
  vt_action_rec record;
  vot_account_action ${user.table}.t_account_action;
begin
  i = sessvarstr_declare('pkg', 'i', 'I');
  -- инициализация/получение переменных пакета
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');
  gl_warning = sessvari_declare('pkg', 'gl_warning', 0);


  -- код функции
  --обнулим глобальные переменные с перечнем ошибок/предупреждений/информационных сообщений, выставим пользователя
  perform pkg.p_reset_response();--(pn_user);
  --JSON -> rowtype

  vot_account.ck_id = nullif(trim(pc_json#>>'{data,ck_id}'), '')::uuid;
  select ac.cl_deleted
   into vl_deleted
   from ${user.table}.t_account ac where vot_account.ck_id is not null and ac.ck_id = vot_account.ck_id;
  vot_account.cv_login = nullif(trim(pc_json#>>'{data,cv_login}'), '');
  vot_account.cv_name = nullif(trim(pc_json#>>'{data,cv_name}'), '');
  vot_account.cv_hash_password = nullif(trim(pc_json#>>'{data,cv_hash_password}'), '');
  vot_account.cv_surname = nullif(trim(pc_json#>>'{data,cv_surname}'), '');
  vot_account.cv_email = nullif(trim(pc_json#>>'{data,cv_email}'), '');
  vot_account.cv_patronymic = nullif(trim(pc_json#>>'{data,cv_patronymic}'), '');
  vot_account.cv_timezone = coalesce(nullif(trim(pc_json#>>'{data,cv_timezone}'), ''), '+03:00');
  vot_account.cl_deleted = coalesce(nullif(trim(pc_json#>>'{data,cl_deleted}'), ''), vl_deleted::text, '0')::smallint;
  vot_account.ck_user = pv_user;
  vot_account.ct_change = CURRENT_TIMESTAMP;
  vv_action = trim(pc_json#>>'{service,cv_action}');
  perform gl_warning == (pc_json#>>'{service,cl_warning}')::bigint;
  select
    jsonb_agg(jt.*)
  into
    vct_account_info
  from (
    select 
    	inf.ck_id as ck_d_info,
    	jr.value as cv_value
    from ${user.table}.t_d_info as inf
  	join jsonb_each(pc_json->'data') as jr
  	on inf.ck_id = jr.key
  ) as jt;
  -- лочим пользователя
  perform pkg_account.p_lock_account(vot_account.ck_id::varchar);
  -- вызовем метод создание пользователя
  vot_account := pkg_account.p_modify_account(vv_action, vot_account, vct_account_info);
  if nullif(trim(pc_json#>>'{data,ck_account_ext}'), '') is not null and vv_action = i::varchar then
    vot_account_ext.ck_user = pv_user;
    vot_account_ext.ct_change = CURRENT_TIMESTAMP;
    vot_account_ext.ck_account_int = vot_account.ck_id;
    vot_account_ext.ck_account_ext = nullif(trim(pc_json#>>'{data,ck_account_ext}'), '');
    vot_account_ext.ck_provider = nullif(trim(pc_json#>>'{data,ck_provider_ext}'), '');
    perform pkg_account.p_modify_account_ext(vv_action, vot_account_ext);
  end if;
  vot_account_action.ck_account = vot_account.ck_id;
  vot_account_action.ck_user = pv_user;
  vot_account_action.ct_change = CURRENT_TIMESTAMP;

  for vt_action_rec in (
    select t.res::bigint as ck_action
    from jsonb_array_elements_text(pc_json#>'{data,ca_actions}') as t(res)
    join ${user.table}.t_action ta 
    on ta.ck_id = t.res::bigint
    where not EXISTS (
      select 1 from ${user.table}.t_account_action taa where taa.ck_account = vot_account.ck_id and taa.ck_action = ta.ck_id
    )
  ) loop 
	  vot_account_action.ck_action = vt_action_rec.ck_action;
  	perform pkg_account.p_modify_account_action('I', vot_account_action);
  end loop;

  -- логируем данные
  perform pkg_log.p_save(pv_user, pv_session, pc_json, 'pkg_json_account.f_modify_account', vot_account.ck_id::varchar, vv_action);
  return '{"ck_id":"' || coalesce(vot_account.ck_id::varchar, '') || '","cv_error":' || pkg.p_form_response() || '}';
  end;$BODY$;

ALTER FUNCTION pkg_json_account.f_modify_account(character varying, character varying, jsonb)
    OWNER TO ${user.update};

COMMENT ON FUNCTION pkg_json_account.f_modify_account(character varying, character varying, jsonb)
    IS 'добавление/редактирование/удаление пользователя';

CREATE OR REPLACE FUNCTION pkg_json_account.f_modify_account_info(
	pv_user character varying,
	pv_session character varying,
	pc_json jsonb)
    RETURNS text
    LANGUAGE 'plpgsql'
    SECURITY DEFINER 
    SET search_path=public, pkg, pkg_account, ${user.table}
AS $BODY$
declare
  -- переменные пакета
  gv_error sessvarstr;

  -- переменные функции
  vot_account_info ${user.table}.t_account_info;
  vv_action  varchar(1);
begin
  -- инициализация/получение переменных пакета
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');

  -- код функции
  --обнулим глобальные переменные с перечнем ошибок/предупреждений/информационных сообщений, выставим пользователя
  perform pkg.p_reset_response();--(pn_user);
  --JSON -> rowtype

  vot_account_info.ck_id = nullif(trim(pc_json#>>'{data,ck_id}'), '')::uuid;
  vot_account_info.ck_account = nullif(trim(pc_json#>>'{service,ck_main}'), '')::uuid;
  vot_account_info.ck_d_info = nullif(trim(pc_json#>>'{data,ck_d_info}'), '');
  vot_account_info.cv_value = nullif(trim(pc_json#>>'{data,cv_value}'), '');
  vot_account_info.ck_user = pv_user;
  vot_account_info.ct_change = CURRENT_TIMESTAMP;
  vv_action = trim(pc_json#>>'{service,cv_action}');
  -- лочим пользователя
  perform pkg_account.p_lock_account(vot_account_info.ck_account::varchar);
  -- вызовем метод создание пользователя
  vot_account_info := pkg_account.p_modify_account_info(vv_action, vot_account_info);
  -- логируем данные
  perform pkg_log.p_save(pv_user, pv_session, pc_json, 'pkg_json_account.f_modify_account_info', vot_account_info.ck_id::varchar, vv_action);
  return '{"ck_id":"' || coalesce(vot_account_info.ck_id::varchar, '') || '","cv_error":' || pkg.p_form_response() || '}';
  end;$BODY$;

ALTER FUNCTION pkg_json_account.f_modify_account_info(character varying, character varying, jsonb)
    OWNER TO ${user.update};

COMMENT ON FUNCTION pkg_json_account.f_modify_account_info(character varying, character varying, jsonb)
    IS 'добавление/редактирование/удаление доп атрибуты пользователя';

CREATE OR REPLACE FUNCTION pkg_json_account.f_modify_account_role(
	pv_user character varying,
	pv_session character varying,
	pc_json jsonb)
    RETURNS text
    LANGUAGE 'plpgsql'
    SECURITY DEFINER 
    SET search_path=public, pkg, pkg_account, ${user.table}
AS $BODY$
declare
  -- переменные пакета
  gv_error sessvarstr;

  -- переменные функции
  vot_account_role ${user.table}.t_account_role;
  vot_account_role_r record;
  vv_action  varchar(1);
begin
  -- инициализация/получение переменных пакета
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');

  -- код функции
  --обнулим глобальные переменные с перечнем ошибок/предупреждений/информационных сообщений, выставим пользователя
  perform pkg.p_reset_response();--(pn_user);
  --JSON -> rowtype
  vv_action = trim(pc_json#>>'{service,cv_action}');
  vot_account_role.ck_account = nullif(trim(pc_json#>>'{service,ck_main}'), '')::uuid;
  vot_account_role.ck_user = pv_user;
  vot_account_role.ct_change = CURRENT_TIMESTAMP;
  -- лочим пользователя
  perform pkg_account.p_lock_account(vot_account_role.ck_account::varchar);
  for vot_account_role_r in (
    select
      nullif(trim(r.res->>'ck_role'), '') as ck_role
    from jsonb_array_elements(pc_json->'data') as r(res)
  ) loop 
	vot_account_role.ck_role = vot_account_role_r.ck_role;
  	perform pkg_account.p_modify_account_role(vv_action, vot_account_role);
  end loop;
  -- логируем данные
  perform pkg_log.p_save(pv_user, pv_session, pc_json, 'pkg_json_account.f_modify_account_role', vot_account_role.ck_role::varchar, vv_action);
  return '{"ck_id":"' || coalesce(vot_account_role.ck_role::varchar, '') || '","cv_error":' || pkg.p_form_response() || '}';
end;
$BODY$;

ALTER FUNCTION pkg_json_account.f_modify_account_role(character varying, character varying, jsonb)
    OWNER TO ${user.update};

COMMENT ON FUNCTION pkg_json_account.f_modify_account_role(character varying, character varying, jsonb)
    IS 'добавление/редактирование/удаление роли пользователя';

CREATE OR REPLACE FUNCTION pkg_json_account.f_modify_action(
	pv_user character varying,
	pv_session character varying,
	pc_json jsonb)
    RETURNS text
    LANGUAGE 'plpgsql'
    SECURITY DEFINER 
    SET search_path=public, pkg_account, ${user.table}
AS $BODY$
declare
  -- переменные пакета
  gv_error sessvarstr;

  -- переменные функции
  vot_action ${user.table}.t_action;
  vv_action  varchar(1);
begin
  -- инициализация/получение переменных пакета
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');

  -- код функции
  --обнулим глобальные переменные с перечнем ошибок/предупреждений/информационных сообщений, выставим пользователя
  perform pkg.p_reset_response();--(pn_user);
  --JSON -> rowtype

  vot_action.ck_id = nullif(trim(pc_json#>>'{data,ck_id}'), '')::bigint;
  vot_action.cv_name = nullif(trim(pc_json#>>'{data,cv_name}'), '');
  vot_action.cv_description = nullif(trim(pc_json#>>'{data,cv_description}'), '');
  vot_action.ck_user = pv_user;
  vot_action.ct_change = CURRENT_TIMESTAMP;
  vv_action = trim(pc_json#>>'{service,cv_action}');
  -- лочим действие
  perform pkg_account.p_lock_action(vot_action.ck_id::varchar);
  -- вызовем метод измения действия
  vot_action := pkg_account.p_modify_action(vv_action, vot_action);
  -- логируем данные
  perform pkg_log.p_save(pv_user, pv_session, pc_json, 'pkg_json_account.f_modify_action', vot_action.ck_id::varchar, vv_action);
  return '{"ck_id":"' || coalesce(vot_action.ck_id::varchar, '') || '","cv_error":' || pkg.p_form_response() || '}';
  end;$BODY$;

ALTER FUNCTION pkg_json_account.f_modify_action(character varying, character varying, jsonb)
    OWNER TO ${user.update};

COMMENT ON FUNCTION pkg_json_account.f_modify_action(character varying, character varying, jsonb)
    IS 'добавление/редактирование/удаление действий';

CREATE OR REPLACE FUNCTION pkg_json_account.f_modify_action_role(
	pv_user character varying,
	pv_session character varying,
	pc_json jsonb)
    RETURNS text
    LANGUAGE 'plpgsql'
    SECURITY DEFINER 
    SET search_path=public, pkg, pkg_account, ${user.table}
AS $BODY$
declare
  -- переменные пакета
  gv_error sessvarstr;

  -- переменные функции
  vot_role_action ${user.table}.t_role_action;
  vot_role_action_r record;
  vv_action  varchar(1);
begin
  -- инициализация/получение переменных пакета
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');

  -- код функции
  --обнулим глобальные переменные с перечнем ошибок/предупреждений/информационных сообщений, выставим пользователя
  perform pkg.p_reset_response();--(pn_user);
  --JSON -> rowtype
  vv_action = trim(pc_json#>>'{service,cv_action}');
  vot_role_action.ck_action = nullif(trim(pc_json#>>'{service,ck_main}'), '')::bigint;
  vot_role_action.ck_user = pv_user;
  vot_role_action.ct_change = CURRENT_TIMESTAMP;
  -- лочим действие
  perform pkg_account.p_lock_action(vot_role_action.ck_action::varchar);
  for vot_role_action_r in (
    select
      nullif(trim(r.res->>'ck_role'), '') as ck_role
    from jsonb_array_elements(pc_json->'data') as r(res)
  ) loop 
	vot_role_action.ck_role = vot_role_action_r.ck_role;
  	perform pkg_account.p_modify_role_action(vv_action, vot_role_action);
  end loop;
  -- логируем данные
  perform pkg_log.p_save(pv_user, pv_session, pc_json, 'pkg_json_account.f_modify_action_role', vot_role_action.ck_role::varchar, vv_action);
  return '{"ck_id":"' || coalesce(vot_role_action.ck_role::varchar, '') || '","cv_error":' || pkg.p_form_response() || '}';
end;
$BODY$;

ALTER FUNCTION pkg_json_account.f_modify_action_role(character varying, character varying, jsonb)
    OWNER TO ${user.update};

COMMENT ON FUNCTION pkg_json_account.f_modify_action_role(character varying, character varying, jsonb)
    IS 'добавление/редактирование/удаление связи экшенов с ролями';

CREATE OR REPLACE FUNCTION pkg_json_account.f_modify_d_info(
	pv_user character varying,
	pv_session character varying,
	pc_json jsonb)
    RETURNS text
    LANGUAGE 'plpgsql'
    SECURITY DEFINER 
    SET search_path=public, pkg_account, ${user.table}
AS $BODY$
declare
  -- переменные пакета
  gv_error sessvarstr;

  -- переменные функции
  vot_d_info ${user.table}.t_d_info;
  vv_action  varchar(1);
begin
  -- инициализация/получение переменных пакета
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');

  -- код функции
  --обнулим глобальные переменные с перечнем ошибок/предупреждений/информационных сообщений, выставим пользователя
  perform pkg.p_reset_response();--(pn_user);
  --JSON -> rowtype

  vot_d_info.ck_id = nullif(trim(pc_json#>>'{data,ck_id}'), '');
  vot_d_info.cv_description = nullif(trim(pc_json#>>'{data,cv_description}'), '');
  vot_d_info.cl_required = nullif(trim(pc_json#>>'{data,cl_required}'), '')::smallint;
  vot_d_info.cr_type = nullif(trim(pc_json#>>'{data,cr_type}'), '');
  vot_d_info.ck_user = pv_user;
  vot_d_info.ct_change = CURRENT_TIMESTAMP;
  vv_action = trim(pc_json#>>'{service,cv_action}');
  -- лочим дополнительное поле
  perform pkg_account.p_lock_d_info(vot_d_info.ck_id::varchar);
  -- вызовем метод изменения
  vot_d_info := pkg_account.p_modify_d_info(vv_action, vot_d_info);
  -- логируем данные
  perform pkg_log.p_save(pv_user, pv_session, pc_json, 'pkg_json_account.f_modify_d_info', vot_d_info.ck_id, vv_action);
  return '{"ck_id":"' || coalesce(vot_d_info.ck_id, '') || '","cv_error":' || pkg.p_form_response() || '}';
  end;
$BODY$;

ALTER FUNCTION pkg_json_account.f_modify_d_info(character varying, character varying, jsonb)
    OWNER TO ${user.update};

COMMENT ON FUNCTION pkg_json_account.f_modify_d_info(character varying, character varying, jsonb)
    IS 'добавление/редактирование/удаление дополнительных полей';

CREATE OR REPLACE FUNCTION pkg_json_account.f_modify_role(
	pv_user character varying,
	pv_session character varying,
	pc_json jsonb)
    RETURNS text
    LANGUAGE 'plpgsql'
    SECURITY DEFINER 
    SET search_path=public, pkg, pkg_account, ${user.table}
AS $BODY$
declare
  -- переменные пакета
  gv_error sessvarstr;

  -- переменные функции
  vot_role ${user.table}.t_role;
  vv_action  varchar(1);
begin
  -- инициализация/получение переменных пакета
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');

  -- код функции
  --обнулим глобальные переменные с перечнем ошибок/предупреждений/информационных сообщений, выставим пользователя
  perform pkg.p_reset_response();--(pn_user);
  --JSON -> rowtype

  vot_role.ck_id = nullif(trim(pc_json#>>'{data,ck_id}'), '')::uuid;
  vot_role.cv_name = nullif(trim(pc_json#>>'{data,cv_name}'), '');
  vot_role.cv_description = nullif(trim(pc_json#>>'{data,cv_description}'), '');
  vot_role.ck_user = pv_user;
  vot_role.ct_change = CURRENT_TIMESTAMP;
  vv_action = trim(pc_json#>>'{service,cv_action}');
  -- лочим действие
  perform pkg_account.p_lock_role(vot_role.ck_id::varchar);
  -- вызовем метод измения роли
  vot_role := pkg_account.p_modify_role(vv_action, vot_role);
  -- логируем данные
  perform pkg_log.p_save(pv_user, pv_session, pc_json, 'pkg_json_account.f_modify_role', vot_role.ck_id::varchar, vv_action);
  return '{"ck_id":"' || coalesce(vot_role.ck_id::varchar, '') || '","cv_error":' || pkg.p_form_response() || '}';
end;
$BODY$;

ALTER FUNCTION pkg_json_account.f_modify_role(character varying, character varying, jsonb)
    OWNER TO ${user.update};

COMMENT ON FUNCTION pkg_json_account.f_modify_role(character varying, character varying, jsonb)
    IS 'добавление/редактирование/удаление роли';

CREATE OR REPLACE FUNCTION pkg_json_account.f_modify_role_account(
	pv_user character varying,
	pv_session character varying,
	pc_json jsonb)
    RETURNS text
    LANGUAGE 'plpgsql'
    SECURITY DEFINER 
    SET search_path=public, pkg, pkg_account, ${user.table}
AS $BODY$
declare
  -- переменные пакета
  gv_error sessvarstr;

  -- переменные функции
  vot_account_role ${user.table}.t_account_role;
  vot_account_role_r record;
  vv_action  varchar(1);
begin
  -- инициализация/получение переменных пакета
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');

  -- код функции
  --обнулим глобальные переменные с перечнем ошибок/предупреждений/информационных сообщений, выставим пользователя
  perform pkg.p_reset_response();--(pn_user);
  --JSON -> rowtype
  vv_action = trim(pc_json#>>'{service,cv_action}');
  vot_account_role.ck_role = nullif(trim(pc_json#>>'{service,ck_main}'), '')::uuid;
  vot_account_role.ck_user = pv_user;
  vot_account_role.ct_change = CURRENT_TIMESTAMP;
  -- лочим пользователя и роль
  perform pkg_account.p_lock_role(vot_account_role.ck_role::varchar);
  for vot_account_role_r in (
    select
      nullif(trim(r.res->>'ck_account'), '') as ck_account
    from jsonb_array_elements(pc_json->'data') as r(res)
  ) loop 
	vot_account_role.ck_account = vot_account_role_r.ck_account;
  	perform pkg_account.p_modify_account_role(vv_action, vot_account_role);
  end loop;
  -- логируем данные
  perform pkg_log.p_save(pv_user, pv_session, pc_json, 'pkg_json_account.f_modify_role_account', vot_account_role.ck_role::varchar, vv_action);
  return '{"ck_id":"' || coalesce(vot_account_role.ck_role::varchar, '') || '","cv_error":' || pkg.p_form_response() || '}';
end;
$BODY$;

ALTER FUNCTION pkg_json_account.f_modify_role_account(character varying, character varying, jsonb)
    OWNER TO ${user.update};

COMMENT ON FUNCTION pkg_json_account.f_modify_role_account(character varying, character varying, jsonb)
    IS 'добавление/редактирование/удаление роли у пользователей';

CREATE OR REPLACE FUNCTION pkg_json_account.f_modify_role_action(
	pv_user character varying,
	pv_session character varying,
	pc_json jsonb)
    RETURNS text
    LANGUAGE 'plpgsql'
    SECURITY DEFINER 
    SET search_path=public, pkg_account, ${user.table}
AS $BODY$
declare
  -- переменные пакета
  gv_error sessvarstr;

  -- переменные функции
  vot_role_action ${user.table}.t_role_action;
  vot_role_action_r record;
  vv_action  varchar(1);
begin
  -- инициализация/получение переменных пакета
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');

  -- код функции
  --обнулим глобальные переменные с перечнем ошибок/предупреждений/информационных сообщений, выставим пользователя
  perform pkg.p_reset_response();--(pn_user);
  --JSON -> rowtype
  vv_action = trim(pc_json#>>'{service,cv_action}');
  vot_role_action.ck_role = nullif(trim(pc_json#>>'{service,ck_main}'), '')::uuid;
  vot_role_action.ck_user = pv_user;
  vot_role_action.ct_change = CURRENT_TIMESTAMP;
 -- лочим действие и роль
  perform pkg_account.p_lock_role(vot_role_action.ck_role::varchar);
  for vot_role_action_r in (
    select
      nullif(trim(r.res->>'ck_action'), '') as ck_action
    from jsonb_array_elements(pc_json->'data') as r(res)
  ) loop 
	vot_role_action.ck_action = vot_role_action_r.ck_action;
  	perform pkg_account.p_modify_role_action(vv_action, vot_role_action);
  end loop;
  -- логируем данные
  perform pkg_log.p_save(pv_user, pv_session, pc_json, 'pkg_json_account.f_modify_role_action', vot_role_action.ck_action::varchar, vv_action);
  return '{"ck_id":"' || coalesce(vot_role_action.ck_action::varchar, '') || '","cv_error":' || pkg.p_form_response() || '}';
end;
$BODY$;

ALTER FUNCTION pkg_json_account.f_modify_role_action(character varying, character varying, jsonb)
    OWNER TO ${user.update};

COMMENT ON FUNCTION pkg_json_account.f_modify_role_action(character varying, character varying, jsonb)
    IS 'добавление/редактирование/удаление связи ролей и действий';

CREATE OR REPLACE FUNCTION pkg_json_account.f_modify_account_action(
	pv_user character varying,
	pv_session character varying,
	pc_json jsonb)
    RETURNS text
    LANGUAGE 'plpgsql'
    SECURITY DEFINER 
    SET search_path=public, pkg_account, ${user.table}
AS $BODY$
declare
  -- переменные пакета
  gv_error sessvarstr;

  -- переменные функции
  vot_account_action ${user.table}.t_account_action;
  vot_account_action_r record;
  vv_action  varchar(1);
begin
  -- инициализация/получение переменных пакета
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');

  -- код функции
  --обнулим глобальные переменные с перечнем ошибок/предупреждений/информационных сообщений, выставим пользователя
  perform pkg.p_reset_response();--(pn_user);
  --JSON -> rowtype
  vv_action = trim(pc_json#>>'{service,cv_action}');
  vot_account_action.ck_account = nullif(trim(pc_json#>>'{service,ck_main}'), '')::uuid;
  vot_account_action.ck_user = pv_user;
  vot_account_action.ct_change = CURRENT_TIMESTAMP;
 -- лочим действие и роль
  perform pkg_account.p_lock_account(vot_account_action.ck_account::varchar);
  for vot_account_action_r in (
    select
      nullif(trim(r.res->>'ck_action'), '') as ck_action
    from jsonb_array_elements(pc_json->'data') as r(res)
  ) loop 
	  vot_account_action.ck_action = vot_account_action_r.ck_action;
  	perform pkg_account.p_modify_account_action(vv_action, vot_account_action);
  end loop;
  -- логируем данные
  perform pkg_log.p_save(pv_user, pv_session, pc_json, 'pkg_json_account.f_modify_account_action', vot_account_action.ck_action::varchar, vv_action);
  return '{"ck_id":"' || coalesce(vot_account_action.ck_action::varchar, '') || '","cv_error":' || pkg.p_form_response() || '}';
end;
$BODY$;

ALTER FUNCTION pkg_json_account.f_modify_account_action(character varying, character varying, jsonb)
    OWNER TO ${user.update};

COMMENT ON FUNCTION pkg_json_account.f_modify_account_action(character varying, character varying, jsonb)
    IS 'добавление/редактирование/удаление связи пользователей и действий';

CREATE OR REPLACE FUNCTION pkg_json_account.f_modify_auth_token(
	pv_user character varying,
	pv_session character varying,
	pc_json jsonb)
    RETURNS text
    LANGUAGE 'plpgsql'
    SECURITY DEFINER 
    SET search_path=public, pkg_account, ${user.table}
AS $BODY$
declare
  -- переменные пакета
  gv_error sessvarstr;

  -- переменные функции
  vot_auth_token ${user.table}.t_auth_token;
  vv_action  varchar(1);
begin
  -- инициализация/получение переменных пакета
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');

  -- код функции
  --обнулим глобальные переменные с перечнем ошибок/предупреждений/информационных сообщений, выставим пользователя
  perform pkg.p_reset_response();--(pn_user);
  --JSON -> rowtype
  vv_action = trim(pc_json#>>'{service,cv_action}');
  vot_auth_token.ck_id = nullif(trim(pc_json#>>'{data,ck_id}'), '');
  vot_auth_token.ct_start = COALESCE(nullif(trim(pc_json#>>'{data,ct_start}'), ''), CURRENT_TIMESTAMP::varchar)::timestamp;
  vot_auth_token.ct_expire = COALESCE(nullif(trim(pc_json#>>'{data,ct_expire}'), ''), (CURRENT_TIMESTAMP + interval '2 minute')::varchar)::timestamp;
  vot_auth_token.ck_account = nullif(trim(pc_json#>>'{data,ck_account}'), '');
  vot_auth_token.cl_single = (COALESCE(nullif(trim(pc_json#>>'{data,cl_single}'), ''), '1'))::smallint;
  vot_auth_token.ck_user = pv_user;
  vot_auth_token.ct_change = CURRENT_TIMESTAMP;
  -- лочим действие и роль
  
  perform pkg_account.p_lock_auth_token(vot_auth_token.ck_id);
	vot_auth_token := pkg_account.p_modify_auth_token(vv_action, vot_auth_token);
  -- логируем данные
  perform pkg_log.p_save(pv_user, pv_session, pc_json, 'pkg_json_account.f_modify_auth_token', vot_auth_token.ck_id::varchar, vv_action);
  return '{"ck_id":"' || coalesce(vot_auth_token.ck_id::varchar, '') || '","cv_error":' || pkg.p_form_response() || '}';
end;
$BODY$;

ALTER FUNCTION pkg_json_account.f_modify_auth_token(character varying, character varying, jsonb)
    OWNER TO ${user.update};

COMMENT ON FUNCTION pkg_json_account.f_modify_auth_token(character varying, character varying, jsonb)
    IS 'добавление/редактирование/удаление токенов';
