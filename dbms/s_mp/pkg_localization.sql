--liquibase formatted sql
--changeset artemov_i:pkg_localization dbms:postgresql runOnChange:true splitStatements:false stripComments:false
DROP SCHEMA IF EXISTS pkg_localization cascade;

CREATE SCHEMA pkg_localization
    AUTHORIZATION s_mp;

ALTER SCHEMA pkg_localization OWNER TO s_mp;

CREATE FUNCTION pkg_localization.p_modify_lang(pv_action character varying, INOUT pot_d_lang s_mt.t_d_lang) RETURNS s_mt.t_d_lang
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_localization', 's_mt', 'public'
    AS $$
declare
  -- переменные пакета
  i sessvarstr;
  u sessvarstr;
  d sessvarstr;
  gv_error sessvarstr;
  gl_warning sessvari;
  gv_warning sessvarstr;

  -- переменные функции
  rec record;
begin
  -- инициализация/получение переменных пакета
  i = sessvarstr_declare('pkg', 'i', 'I');
  u = sessvarstr_declare('pkg', 'u', 'U');
  d = sessvarstr_declare('pkg', 'd', 'D');
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');
  gl_warning = sessvari_declare('pkg', 'gl_warning', 0);
  gv_warning = sessvarstr_declare('pkg', 'gv_warning', '');

  -- код функции
    if pv_action = d::varchar then
        /*Проверки на удаление*/
        /*Удаление*/
        if (gl_warning::bigint) = 0 then
            perform pkg.p_set_warning(75);
        end if;
        if pot_d_lang.cl_default = 1 then
            perform pkg.p_set_error(74);
        end if;
        if nullif(gv_error::varchar, '') is not null or nullif(gv_warning::varchar, '') is not null then
            return;
        end if;
        delete from t_localization where ck_d_lang = pot_d_lang.ck_id;
        delete from t_d_lang where ck_id = pot_d_lang.ck_id;
        return;
    end if;
    /* Блок "Проверка переданных данных" */
    if pot_d_lang.ck_id is null then
      perform pkg.p_set_error(200, 'meta:32d1685390d44934b3d5f71dc0084ee3');
    end if;
    if pot_d_lang.cv_name is null then
      perform pkg.p_set_error(200, 'meta:3a0b8d771a0d497e8aa1c44255fa6e83');
    end if;
    if pot_d_lang.cl_default is null or pot_d_lang.cl_default not in (0, 1) then
      perform pkg.p_set_error(200, 'meta:7c47246c867740179cb1f2c7a3705d6d');
    end if;
    if pv_action = i::varchar then
        for rec in (
            select 1
            from s_mt.t_d_lang
            where ck_id = pot_d_lang.ck_id
        ) loop
            perform pkg.p_set_error(201, 'Код языка');
            exit;
        end loop;
    end if;
    if nullif(gv_error::varchar, '') is not null or nullif(gv_warning::varchar, '') is not null then
   	    return;
    end if;
    if pv_action = i::varchar then
      insert into s_mt.t_d_lang values (pot_d_lang.*);
    elsif pv_action = u::varchar then
      update s_mt.t_d_lang set
        (cv_name, cl_default, ck_user, ct_change) = (pot_d_lang.cv_name, pot_d_lang.cl_default, pot_d_lang.ck_user, pot_d_lang.ct_change)
      where ck_id = pot_d_lang.ck_id;
      if not found then
        perform pkg.p_set_error(504);
      end if;
    end if;
    if pot_d_lang.cl_default = 1 then
      insert into s_mt.t_localization
      select 
        ck_id,
        pot_d_lang.ck_id as ck_d_lang,
        cr_namespace, 
        '##Need to translate##' as cv_value,
        pot_d_lang.ck_user,
        pot_d_lang.ct_change 
      from s_mt.t_localization
      where ck_d_lang in (select ck_id from t_d_lang where cl_default = 1 and ck_id <> pot_d_lang.ck_id) 
        and ck_id not in (select ck_id from s_mt.t_localization where ck_d_lang = pot_d_lang.ck_id);

      update s_mt.t_d_lang set
        cl_default = 0
      where ck_id <> pot_d_lang.ck_id;    
    end if;
end;
$$;

ALTER FUNCTION pkg_localization.p_modify_lang(pv_action character varying, INOUT pot_d_lang s_mt.t_d_lang) OWNER TO s_mp;

CREATE FUNCTION pkg_localization.p_modify_localization(pv_action character varying, INOUT pot_localization s_mt.t_localization) RETURNS s_mt.t_localization
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_localization', 's_mt', 'public'
    AS $$
declare
  -- переменные пакета
  i sessvarstr;
  u sessvarstr;
  d sessvarstr;
  cl_default SMALLINT := 0;
  gv_error sessvarstr;
  gl_warning sessvari;
  gv_warning sessvarstr;

  -- переменные функции
begin
  -- инициализация/получение переменных пакета
  i = sessvarstr_declare('pkg', 'i', 'I');
  u = sessvarstr_declare('pkg', 'u', 'U');
  d = sessvarstr_declare('pkg', 'd', 'D');
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');
  gl_warning = sessvari_declare('pkg', 'gl_warning', 0);
  gv_warning = sessvarstr_declare('pkg', 'gv_warning', '');

  select l.cl_default
      into cl_default
  from t_d_lang l where l.ck_id = pot_localization.ck_d_lang;

  -- код функции
    if pv_action = d::varchar then
        /*Проверки на удаление*/
        if cl_default = 1 and (gl_warning::bigint) = 0 then
            perform pkg.p_set_warning(76);
        end if;
        /*Удаление*/
        if nullif(gv_error::varchar, '') is not null or nullif(gv_warning::varchar, '') is not null then
            return;
        end if;
        delete from t_localization where ck_id = pot_localization.ck_id and ck_d_lang = pot_localization.ck_d_lang;
        if cl_default = 1 then 
            delete from t_localization where ck_id = pot_localization.ck_id;
        end if;
        return;
    end if;
    /* Блок "Проверка переданных данных" */
    if pot_localization.cr_namespace is null then
      perform pkg.p_set_error(200, 'Тип расположения');
    end if;
    if pot_localization.ck_d_lang is null then
      perform pkg.p_set_error(200, 'Язык');
    end if;
    if pot_localization.cv_value is null then
      perform pkg.p_set_error(200, 'Перевод');
    end if;
    if nullif(gv_error::varchar, '') is not null or nullif(gv_warning::varchar, '') is not null then
   	    return;
    end if;
    if pv_action = i::varchar then
      if pot_localization.ck_id is null then
        pot_localization.ck_id := lower(sys_guid());
      end if;
      insert into s_mt.t_localization values (pot_localization.*);
    elsif pv_action = u::varchar then
      update s_mt.t_localization set
        (ck_d_lang, cv_value, cr_namespace, ck_user, ct_change) = (pot_localization.ck_d_lang, pot_localization.cv_value, pot_localization.cr_namespace, pot_localization.ck_user, pot_localization.ct_change)
      where ck_id = pot_localization.ck_id and ck_d_lang = pot_localization.ck_d_lang;
      if not found then
        perform pkg.p_set_error(504);
      end if;
    end if;
end;
$$;

ALTER FUNCTION pkg_localization.p_modify_localization(pv_action character varying, INOUT pot_localization s_mt.t_localization) OWNER TO s_mp;

CREATE FUNCTION pkg_localization.p_lock_d_lang(pk_id character varying) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 's_mt', 'pkg_localization', 'public'
    AS $$
declare
  vn_lock bigint;
begin
  if pk_id is not null then
    select 1 into vn_lock from s_mt.t_d_lang where ck_id = pk_id for update nowait;
  end if;
end;
$$;


ALTER FUNCTION pkg_localization.p_lock_d_lang(pk_id character varying) OWNER TO s_mp;

CREATE FUNCTION pkg_localization.p_lock_localization(pk_id character varying, pk_d_lang character varying) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_json_meta', 'public'
    AS $$
declare
  vn_lock bigint;
begin
  if pk_id is not null and pk_d_lang is not null then
    select 1 into vn_lock from s_mt.t_localization where ck_id = pk_id and ck_d_lang = pk_d_lang for update nowait;
  end if;
end;
$$;


ALTER FUNCTION pkg_localization.p_lock_localization(character varying, character varying) OWNER TO s_mp;