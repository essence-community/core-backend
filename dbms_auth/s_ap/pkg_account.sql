--liquibase formatted sql
--changeset artemov_i:pkg_access dbms:postgresql runOnChange:true splitStatements:false stripComments:false
DROP SCHEMA IF EXISTS pkg_account cascade;

CREATE SCHEMA pkg_account
    AUTHORIZATION s_ap;

CREATE OR REPLACE FUNCTION pkg_account.f_create_hash(
	pv_salt character varying,
	pv_password character varying)
    RETURNS character varying
    LANGUAGE 'plpgsql'
    SECURITY DEFINER 
    SET search_path=public, pkg_account, s_at
AS $BODY$
declare
    -- количество хэширования
    vn_count integer := 2;
    vv_result varchar;
    vv_global_salt varchar := '9bce015f2e20cbe98';
begin
    vv_result := encode(digest(vv_global_salt || pv_password || pv_salt, 'sha256'), 'hex');
    while vn_count > 0 loop
        vn_count := vn_count - 1;
        vv_result := encode(digest(vv_result, 'sha256'), 'hex');
    end loop;
    return vv_result;
end;
$BODY$;

ALTER FUNCTION pkg_account.f_create_hash(character varying, character varying)
    OWNER TO s_ap;

COMMENT ON FUNCTION pkg_account.f_create_hash(character varying, character varying)
    IS 'Создание hash пароля';

CREATE OR REPLACE FUNCTION pkg_account.p_lock_account(
	pk_id character varying)
    RETURNS void
    LANGUAGE 'plpgsql'
    SECURITY DEFINER 
    SET search_path=public, pkg, pkg_account, s_at
AS $BODY$
declare
  vn_lock bigint;
begin
  if pk_id is not null then
    select 1 into vn_lock from s_at.t_account where ck_id = pk_id::uuid for update nowait;
  end if;
end;
$BODY$;

ALTER FUNCTION pkg_account.p_lock_account(character varying)
    OWNER TO s_ap;

CREATE OR REPLACE FUNCTION pkg_account.p_lock_action(
	pk_id character varying)
    RETURNS void
    LANGUAGE 'plpgsql'
    SECURITY DEFINER 
    SET search_path=public, pkg, pkg_account, s_at
AS $BODY$
declare
  vn_lock bigint;
begin
  if pk_id is not null then
    select 1 into vn_lock from s_at.t_action where ck_id = pk_id::bigint for update nowait;
  end if;
end;
$BODY$;

ALTER FUNCTION pkg_account.p_lock_action(character varying)
    OWNER TO s_ap;

CREATE OR REPLACE FUNCTION pkg_account.p_lock_d_info(
	pk_id character varying)
    RETURNS void
    LANGUAGE 'plpgsql'
    SECURITY DEFINER 
    SET search_path=public, pkg, pkg_account, s_at
AS $BODY$
declare
  vn_lock bigint;
begin
  if pk_id is not null then
    select 1 into vn_lock from s_at.t_d_info where ck_id = pk_id for update nowait;
  end if;
end;
$BODY$;

ALTER FUNCTION pkg_account.p_lock_d_info(character varying)
    OWNER TO s_ap;

CREATE OR REPLACE FUNCTION pkg_account.p_lock_role(
	pk_id character varying)
    RETURNS void
    LANGUAGE 'plpgsql'
    SECURITY DEFINER 
    SET search_path=public, pkg, pkg_account, s_at
AS $BODY$
declare
  vn_lock bigint;
begin
  if pk_id is not null then
    select 1 into vn_lock from s_at.t_role where ck_id = pk_id::uuid for update nowait;
  end if;
end;
$BODY$;

ALTER FUNCTION pkg_account.p_lock_role(character varying)
    OWNER TO s_ap;

CREATE OR REPLACE FUNCTION pkg_account.p_modify_account(
	pv_action character varying,
	INOUT pot_account s_at.t_account,
	pct_account_info jsonb DEFAULT NULL::jsonb)
    RETURNS s_at.t_account
    LANGUAGE 'plpgsql'
    SECURITY DEFINER 
    SET search_path=public, pkg, pkg_account, s_at
AS $BODY$
declare
  -- переменные пакета
  i sessvarstr;
  u sessvarstr;
  d sessvarstr;
  gv_error sessvarstr;
  -- переменные функции
  vcur_account record;
  vcur_d_info record;
begin
  -- инициализация/получение переменных пакета
  i = sessvarstr_declare('pkg', 'i', 'I');
  u = sessvarstr_declare('pkg', 'u', 'U');
  d = sessvarstr_declare('pkg', 'd', 'D');
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');

  -- код функции
  if pv_action = d::varchar then
  	-- delete from s_at.t_account_info where ck_account = pot_account.ck_id;
    -- delete from s_at.t_account_role where ck_account = pot_account.ck_id;
    -- delete from s_at.t_account where ck_id = pot_account.ck_id;
    update s_at.t_account
     set (cl_deleted,ck_user,ct_change) = 
     (1::smalint,pot_account.ck_user,pot_account.ct_change)
     where ck_id = pot_account.ck_id;
    if not found then
      perform pkg.p_set_error(504);
    end if;
    return;
  end if;
  if pot_account.cv_login is null then
    perform pkg.p_set_error(200, 'meta:060a6513dc574996853d045276217394');
  end if;
  if pot_account.cv_name is null then
    perform pkg.p_set_error(200, 'meta:002ec63ccef84e759841e7a7e25e27f1');
  end if;
  if pot_account.cv_surname is null then
    perform pkg.p_set_error(200, 'meta:1e66498e8a4e48549fd83ff4b6f34af5');
  end if;
  if pv_action = i::varchar then
    for vcur_account in (
      select 1
      from s_at.t_account
      where upper(cv_login) = upper(pot_account.cv_login)
      ) loop
        perform pkg.p_set_error(203);
      end loop;
    if pct_account_info is not null then
      for vcur_d_info in (
      select inf.*
      from s_at.t_d_info inf
      join jsonb_to_recordset(pct_account_info) as t(ck_d_info varchar, cv_value varchar)
      	on inf.ck_id = t.ck_d_info
      where inf.cl_required = 1 and nullif(trim(t.cv_value), '') is null
      ) loop
        perform pkg.p_set_error(200, vcur_d_info.cv_description);
      end loop;
    elseif pct_account_info is null then
      for vcur_d_info in (
        select inf.*
        from s_at.t_d_info inf
        where inf.cl_required = 1
      ) loop
        perform pkg.p_set_error(200, vcur_d_info.cv_description);
      end loop;
    end if;
 
    if pot_account.cv_hash_password is null then
    	perform pkg.p_set_error(200, 'meta:e59a81c8ac1846679714fad756f39649');
  	end if;
    if nullif(gv_error::varchar, '') is not null then
   	  return;
    end if;
  	pot_account.ck_id := public.uuid_generate_v4();
    pot_account.cv_salt := substring(encode(digest(pot_account.cv_login || pot_account.ct_change::varchar, 'sha256'), 'hex'), 0, 11);
    pot_account.cv_hash_password := pkg_account.f_create_hash(pot_account.cv_salt, pot_account.cv_hash_password);
    insert into s_at.t_account values (pot_account.*);
    if pct_account_info is not null then
      insert into s_at.t_account_info(ck_account, ck_d_info, cv_value, ck_user, ct_change)
      select pot_account.ck_id, t.ck_d_info, t.cv_value, pot_account.ck_user, pot_account.ct_change 
      from jsonb_to_recordset(pct_account_info) as t(ck_d_info varchar, cv_value varchar);
    end if;
   return;
  end if;
  if nullif(gv_error::varchar, '') is not null then
   	  return;
  end if;
  if pot_account.cv_hash_password is null then
     update s_at.t_account
     set (cv_login,cv_name,cv_surname,cv_patronymic,cv_email,cv_timezone,cl_deleted,ck_user,ct_change) = 
     (pot_account.cv_login,pot_account.cv_name,pot_account.cv_surname,pot_account.cv_patronymic,pot_account.cv_email,pot_account.cv_timezone,pot_account.cl_deleted,pot_account.ck_user,pot_account.ct_change)
     where ck_id = pot_account.ck_id;
  else
 	   pot_account.cv_salt := substring(encode(digest(pot_account.cv_login || pot_account.ct_change::varchar, 'sha256'), 'hex'), 0, 11);
     pot_account.cv_hash_password := pkg_account.f_create_hash(pot_account.cv_salt, pot_account.cv_hash_password);
     update s_at.t_account
     set (cv_login,cv_salt,cv_hash_password,cv_name,cv_surname,cv_patronymic,cv_email,cv_timezone,cl_deleted,ck_user,ct_change) = 
     (pot_account.cv_login,pot_account.cv_salt,pot_account.cv_hash_password,pot_account.cv_name,pot_account.cv_surname,pot_account.cv_patronymic,pot_account.cv_email,pot_account.cv_timezone,pot_account.cl_deleted,pot_account.ck_user,pot_account.ct_change)
     where ck_id = pot_account.ck_id;
  end if;

  if pct_account_info is not null then
      insert into s_at.t_account (ck_account, ck_d_info, cv_value, cl_deleted, ck_user, ct_change)
      select pot_account.ck_id, t.ck_d_info, t.cv_value, pot_account.ck_user, pot_account.cl_deleted, pot_account.ct_change 
      from jsonb_to_recordset(pct_account_info) as t(ck_d_info varchar, cv_value varchar)
      on conflict(ck_account,ck_d_info) 
      DO UPDATE SET ck_account = EXCLUDED.ck_account, cv_value = EXCLUDED.cv_value, cl_deleted = EXCLUDED.cl_deleted, ck_user = EXCLUDED.ck_user, ct_change = EXCLUDED.ct_change;
  end if;
end;$BODY$;

ALTER FUNCTION pkg_account.p_modify_account(character varying, s_at.t_account, jsonb)
    OWNER TO s_su;

CREATE OR REPLACE FUNCTION pkg_account.p_modify_account_info(
	pv_action character varying,
	INOUT pot_account_info s_at.t_account_info)
    RETURNS s_at.t_account_info
    LANGUAGE 'plpgsql'
    SECURITY DEFINER 
    SET search_path=public, pkg, pkg_account, s_at
AS $BODY$
declare
  -- переменные пакета
  i sessvarstr;
  u sessvarstr;
  d sessvarstr;
  gv_error sessvarstr;
 
  vot_account_info record;
 
begin
  -- инициализация/получение переменных пакета
  i = sessvarstr_declare('pkg', 'i', 'I');
  u = sessvarstr_declare('pkg', 'u', 'U');
  d = sessvarstr_declare('pkg', 'd', 'D');
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');

  -- код функции
  if pv_action = d::varchar then
    for vot_account_info in (select 1 from s_at.t_d_info where cl_required = 1 and ck_id = pot_account_info.ck_d_info) loop
      perform pkg.p_set_error(51, 'Обязательные поля нельзя удалять');
      return;
    end loop;
    delete from s_at.t_account_info where ck_id = pot_account_info.ck_id;
    return;
  end if;
  if pv_action = i::varchar then
   pot_account_info.ck_id = public.uuid_generate_v4();
   insert into s_at.t_account_info values (pot_account_info.*);
   return;
  end if;
  update s_at.t_account_info
    set (cv_value,ck_user,ct_change) = 
    (pot_account_info.cv_value,pot_account_info.ck_user,pot_account_info.ct_change)
  where ck_id = pot_account_info.ck_id;
  if not found then
    perform pkg.p_set_error(504);
  end if;
end;
$BODY$;

ALTER FUNCTION pkg_account.p_modify_account_info(character varying, s_at.t_account_info)
    OWNER TO s_ap;

COMMENT ON FUNCTION pkg_account.p_modify_account_info(character varying, s_at.t_account_info)
    IS 'Добавление/редактирование/удаление доп информации пользователя';

CREATE OR REPLACE FUNCTION pkg_account.p_modify_account_role(
	pv_action character varying,
	INOUT pot_account_role s_at.t_account_role)
    RETURNS s_at.t_account_role
    LANGUAGE 'plpgsql'
    SECURITY DEFINER 
    SET search_path=public, pkg, pkg_account, s_at
AS $BODY$
declare
  -- переменные пакета
  i sessvarstr;
  u sessvarstr;
  d sessvarstr;
  gv_error sessvarstr;
 
  vot_role record;
begin
  -- инициализация/получение переменных пакета
  i = sessvarstr_declare('pkg', 'i', 'I');
  u = sessvarstr_declare('pkg', 'u', 'U');
  d = sessvarstr_declare('pkg', 'd', 'D');
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');

  -- код функции
  if pv_action = d::varchar then  
    delete from s_at.t_account_role where ck_role = pot_account_role.ck_role and ck_account = pot_account_role.ck_account;
    return;
  end if;
  if pv_action = i::varchar then
   pot_account_role.ck_id := public.uuid_generate_v4();
   insert into s_at.t_account_role values (pot_account_role.*);
   return;
  end if;
  update s_at.t_account_role
    set (ck_user,ct_change) = 
    (pot_role_action.ck_user,pot_role_action.ct_change)
  where ck_role = pot_account_role.ck_role and ck_account = pot_account_role.ck_account;
  if not found then
    perform pkg.p_set_error(504);
  end if;
end;
$BODY$;

ALTER FUNCTION pkg_account.p_modify_account_role(character varying, s_at.t_account_role)
    OWNER TO s_ap;

COMMENT ON FUNCTION pkg_account.p_modify_account_role(character varying, s_at.t_account_role)
    IS 'Добавление/редактирование/удаление связи уз с ролями';

CREATE OR REPLACE FUNCTION pkg_account.p_modify_action(
	pv_action character varying,
	INOUT pot_action s_at.t_action)
    RETURNS s_at.t_action
    LANGUAGE 'plpgsql'
    SECURITY DEFINER 
    SET search_path=public, pkg, pkg_account, s_at
AS $BODY$
declare
  -- переменные пакета
  i sessvarstr;
  u sessvarstr;
  d sessvarstr;
  gv_error sessvarstr;
 
  vot_action record;
  vot_rc record;
begin
  -- инициализация/получение переменных пакета
  i = sessvarstr_declare('pkg', 'i', 'I');
  u = sessvarstr_declare('pkg', 'u', 'U');
  d = sessvarstr_declare('pkg', 'd', 'D');
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');

  -- код функции
  if pv_action = d::varchar then
    for vot_rc in (select 1 from s_at.t_role_action where ck_action = pot_action.ck_id) loop
      perform pkg.p_set_error(204);
      return;
    end loop;
    delete from s_at.t_action where ck_id = pot_action.ck_id;
    return;
  end if;
  if pot_action.cv_name is null then
    perform pkg.p_set_error(200, 'meta:e0cd88534f90436da2b3b5eeae0ae340');
  end if;
  if nullif(gv_error::varchar, '') is not null then
    return;
  end if;
  if pv_action = i::varchar then
   if pot_action.ck_id is null then
      pot_action.ck_id = nextval('seq_action'::regclass);
   end if;
   for vot_action in (select 1 from s_at.t_action where ck_id = pot_action.ck_id) loop
  	perform pkg.p_set_error(201, 'meta:3755233db59d4305861c327dab09f8b0');
    return;
   end loop;
   insert into s_at.t_action values (pot_action.*);
   return;
  end if;
  update s_at.t_action
    set (cv_name,cv_description,ck_user,ct_change) = 
    (pot_action.cv_name,pot_action.cv_description,pot_action.ck_user,pot_action.ct_change)
  where ck_id = pot_action.ck_id;
  if not found then
    perform pkg.p_set_error(504);
  end if;
end;
$BODY$;

ALTER FUNCTION pkg_account.p_modify_action(character varying, s_at.t_action)
    OWNER TO s_ap;

COMMENT ON FUNCTION pkg_account.p_modify_action(character varying, s_at.t_action)
    IS 'Добавление/редактирование/удаление действия';

CREATE OR REPLACE FUNCTION pkg_account.p_modify_d_info(
	pv_action character varying,
	INOUT pot_d_info s_at.t_d_info)
    RETURNS s_at.t_d_info
    LANGUAGE 'plpgsql'
    SECURITY DEFINER 
    SET search_path=public, pkg, pkg_account, s_at
AS $BODY$
declare
  -- переменные пакета
  i sessvarstr;
  u sessvarstr;
  d sessvarstr;
  gv_error sessvarstr;

  vot_d_info record;
begin
  -- инициализация/получение переменных пакета
  i = sessvarstr_declare('pkg', 'i', 'I');
  u = sessvarstr_declare('pkg', 'u', 'U');
  d = sessvarstr_declare('pkg', 'd', 'D');
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');

  -- код функции
  if pv_action = d::varchar then
    
    delete from s_at.t_account_info where ck_d_info = pot_d_info.ck_id;
    delete from s_at.t_d_info where ck_id = pot_d_info.ck_id;
    return;
  end if;
  if pot_d_info.ck_id is null then
    perform pkg.p_set_error(200, 'meta:e0cd88534f90436da2b3b5eeae0ae340');
  end if;
  if pot_d_info.cv_description is null then
    perform pkg.p_set_error(200, 'meta:a4b1d1f3995f499a8f2bac5b57a3cbdc');
  end if;
  if pot_d_info.cr_type is null then
    perform pkg.p_set_error(200, 'meta:b5cf4acf63fd47ef9c8484f62a8efdf2');
  end if;
  if nullif(gv_error::varchar, '') is not null then
    return;
  end if;
  if pv_action = i::varchar then
   for vot_d_info in (select 1 from s_at.t_d_info where ck_id = pot_d_info.ck_id) loop
      perform pkg.p_set_error(201, 'meta:e0cd88534f90436da2b3b5eeae0ae340');
      return;
   end loop;
   insert into s_at.t_d_info values (pot_d_info.*);
   return;
  end if;
  update s_at.t_d_info
    set (cv_description,cl_required,ck_user,ct_change) = 
    (pot_d_info.cv_description,pot_d_info.cl_required,pot_d_info.ck_user,pot_d_info.ct_change)
  where ck_id = pot_d_info.ck_id;
  if not found then
    perform pkg.p_set_error(504);
  end if;
end;
$BODY$;

ALTER FUNCTION pkg_account.p_modify_d_info(character varying, s_at.t_d_info)
    OWNER TO s_ap;

COMMENT ON FUNCTION pkg_account.p_modify_d_info(character varying, s_at.t_d_info)
    IS 'Добавление/редактирование/удаление информации о дополнительных полях';

CREATE OR REPLACE FUNCTION pkg_account.p_modify_role(
	pv_action character varying,
	INOUT pot_role s_at.t_role)
    RETURNS s_at.t_role
    LANGUAGE 'plpgsql'
    SECURITY DEFINER 
    SET search_path=public, pkg, pkg_account, s_at
AS $BODY$
declare
  -- переменные пакета
  i sessvarstr;
  u sessvarstr;
  d sessvarstr;
  gv_error sessvarstr;
 
  vot_role record;
begin
  -- инициализация/получение переменных пакета
  i = sessvarstr_declare('pkg', 'i', 'I');
  u = sessvarstr_declare('pkg', 'u', 'U');
  d = sessvarstr_declare('pkg', 'd', 'D');
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');

  -- код функции
  if pv_action = d::varchar then
    for vot_role in (select 1 from s_at.t_account_role where ck_role = pot_role.ck_id) loop
      perform pkg.p_set_error(204);
      return;
    end loop;
    delete from s_at.t_role_action where ck_role = pot_role.ck_id;
    delete from s_at.t_role where ck_id = pot_role.ck_id;
    return;
  end if;
  if pot_role.cv_name is null then
    perform pkg.p_set_error(200, 'meta:e0cd88534f90436da2b3b5eeae0ae340');
  end if;
  if nullif(gv_error::varchar, '') is not null then
    return;
  end if;
  if pv_action = i::varchar then
   for vot_role in (select 1 from s_at.t_role where cv_name = pot_role.cv_name) loop
     perform pkg.p_set_error(201, 'meta:e0cd88534f90436da2b3b5eeae0ae340');
     return;
   end loop;
   pot_role.ck_id = public.uuid_generate_v4();
   insert into s_at.t_role values (pot_role.*);
   return;
  end if;
  update s_at.t_role
    set (cv_name,cv_description,ck_user,ct_change) = 
    (pot_role.cv_name,pot_role.cv_description,pot_role.ck_user,pot_role.ct_change)
  where ck_id = pot_role.ck_id;
  if not found then
    perform pkg.p_set_error(504);
  end if;
end;
$BODY$;

ALTER FUNCTION pkg_account.p_modify_role(character varying, s_at.t_role)
    OWNER TO s_ap;

COMMENT ON FUNCTION pkg_account.p_modify_role(character varying, s_at.t_role)
    IS 'Добавление/редактирование/удаление роли';

CREATE OR REPLACE FUNCTION pkg_account.p_modify_role_action(
	pv_action character varying,
	INOUT pot_role_action s_at.t_role_action)
    RETURNS s_at.t_role_action
    LANGUAGE 'plpgsql'
    SECURITY DEFINER 
    SET search_path=public, pkg, pkg_account, s_at
AS $BODY$
declare
  -- переменные пакета
  i sessvarstr;
  u sessvarstr;
  d sessvarstr;
  gv_error sessvarstr;
 
  vot_role record;
begin
  -- инициализация/получение переменных пакета
  i = sessvarstr_declare('pkg', 'i', 'I');
  u = sessvarstr_declare('pkg', 'u', 'U');
  d = sessvarstr_declare('pkg', 'd', 'D');
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');

  -- код функции
  if pv_action = d::varchar then  
    delete from s_at.t_role_action where ck_role = pot_role_action.ck_role and ck_action = pot_role_action.ck_action;
    return;
  end if;
  if pv_action = i::varchar then
   pot_role_action.ck_id = public.uuid_generate_v4();
   insert into s_at.t_role_action values (pot_role_action.*);
   return;
  end if;
  update s_at.t_role_action
    set (ck_user,ct_change) = 
    (pot_role_action.ck_user,pot_role_action.ct_change)
  where ck_role = pot_role_action.ck_role and ck_action = pot_role_action.ck_action;
  if not found then
    perform pkg.p_set_error(504);
  end if;
end;
$BODY$;

ALTER FUNCTION pkg_account.p_modify_role_action(character varying, s_at.t_role_action)
    OWNER TO s_ap;

COMMENT ON FUNCTION pkg_account.p_modify_role_action(character varying, s_at.t_role_action)
    IS 'Добавлени/редактирование/удаление связи ролей и экшенов';

CREATE OR REPLACE FUNCTION pkg_account.p_lock_auth_token(
	pk_id character varying)
    RETURNS void
    LANGUAGE 'plpgsql'
    SECURITY DEFINER 
    SET search_path=public, pkg, pkg_account, s_at
AS $BODY$
declare
  vn_lock bigint;
begin
  if pk_id is not null then
    select 1 into vn_lock from s_at.t_auth_token where ck_id = pk_id for update nowait;
  end if;
end;
$BODY$;

ALTER FUNCTION pkg_account.p_lock_auth_token(character varying)
    OWNER TO s_ap;

CREATE OR REPLACE FUNCTION pkg_account.p_modify_auth_token(
	pv_action character varying,
	INOUT pot_auth_token s_at.t_auth_token)
    RETURNS s_at.t_auth_token
    LANGUAGE 'plpgsql'
    SECURITY DEFINER 
    SET search_path=public, pkg, pkg_account, s_at
AS $BODY$
declare
  -- переменные пакета
  i sessvarstr;
  u sessvarstr;
  d sessvarstr;
  gv_error sessvarstr;
 
  vv_salt varchar;
begin
  -- инициализация/получение переменных пакета
  i = sessvarstr_declare('pkg', 'i', 'I');
  u = sessvarstr_declare('pkg', 'u', 'U');
  d = sessvarstr_declare('pkg', 'd', 'D');
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');

  -- код функции
  if pv_action = d::varchar then  
    delete from s_at.t_auth_token where ck_id = pot_auth_token.ck_id;
    return;
  end if;
  if pv_action = i::varchar then
    if pot_auth_token.ck_account is null then
      perform pkg.p_set_error(200, 'meta:9cbe9222069f462795ce3fc6e6c32de5');
    end if;
    if nullif(gv_error::varchar, '') is not null then
      return;
    end if;
    vv_salt := encode(digest(pot_auth_token.ck_account::varchar || pot_auth_token.ct_start::varchar, 'sha256'), 'hex');
    pot_auth_token.ck_id = substring(pkg_account.f_create_hash(vv_salt, public.sys_guid()),0,50);
    insert into s_at.t_auth_token values (pot_auth_token.*);
   return;
  end if;
  update s_at.t_auth_token
    set (ct_expire,ck_user,ct_change) = 
    (pot_auth_token.ct_expire,pot_auth_token.ck_user,pot_auth_token.ct_change)
  where ck_id = pot_auth_token.ck_id;
  if not found then
    perform pkg.p_set_error(504);
  end if;
end;
$BODY$;

ALTER FUNCTION pkg_account.p_modify_auth_token(character varying, s_at.t_auth_token)
    OWNER TO s_ap;

COMMENT ON FUNCTION pkg_account.p_modify_auth_token(character varying, s_at.t_auth_token)
    IS 'Добавлени/редактирование/удаление токенов';