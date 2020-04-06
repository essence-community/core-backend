--liquibase formatted sql
--changeset artemov_i:pkg_integr dbms:postgresql runOnChange:true splitStatements:false stripComments:false
DROP SCHEMA IF EXISTS pkg_integr cascade;

CREATE SCHEMA pkg_integr
    AUTHORIZATION ${user.update};

ALTER SCHEMA pkg_integr OWNER TO ${user.update};


CREATE FUNCTION pkg_integr.p_modify_d_provider(pv_action varchar, INOUT pot_d_provider ${user.table}.t_d_provider) RETURNS ${user.table}.t_d_provider
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_integr', '${user.table}', 'public'
    AS $$
declare
  -- переменные пакета
  i sessvarstr;
  u sessvarstr;
  d sessvarstr;

  gv_error sessvarstr;

  -- переменные функции
begin
    -- инициализация/получение переменных пакета
    i = sessvarstr_declare('pkg', 'i', 'I');
    u = sessvarstr_declare('pkg', 'u', 'U');
    d = sessvarstr_declare('pkg', 'd', 'D');
    gv_error = sessvarstr_declare('pkg', 'gv_error', '');

    if pot_d_provider.ck_id is null then
      perform pkg.p_set_error(200, 'meta:079a71832c164e49a909d1b3c385807c');
    end if;

    if nullif(gv_error::varchar, '') is not null then
   	    return;
    end if;

    if pv_action = d::varchar then
        delete from ${user.table}.t_d_provider where ck_id = pot_d_provider.ck_id;
        return;
    end if;
    if nullif(gv_error::varchar, '') is not null then
   	    return;
    end if;
    if pv_action = i::varchar then
      insert into ${user.table}.t_d_provider values (pot_d_provider.*);
    elsif pv_action = u::varchar then
      update ${user.table}.t_d_provider set
        (cv_description, ck_user, ct_change) = (pot_d_provider.cv_description, pot_d_provider.ck_user, pot_d_provider.ct_change)
      where ck_id = pot_d_provider.ck_id;
      if not found then
        perform pkg.p_set_error(504);
      end if;
    end if;
end;
$$;

ALTER FUNCTION pkg_integr.p_modify_d_provider(pv_action varchar, INOUT pot_d_provider ${user.table}.t_d_provider) OWNER TO ${user.update};

CREATE FUNCTION pkg_integr.p_lock_d_provider(pk_id varchar) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO '${user.table}', 'pkg_integr', 'public'
    AS $$
declare
  vn_lock bigint;
begin
  if pk_id is not null then
    select 1 into vn_lock from ${user.table}.t_d_provider where ck_id = pk_id for update nowait;
  end if;
end;
$$;


ALTER FUNCTION pkg_integr.p_lock_d_provider(pk_id varchar) OWNER TO ${user.update};

CREATE FUNCTION pkg_integr.p_modify_d_provider(pv_action varchar, INOUT pot_d_interface ${user.table}.t_d_interface) RETURNS ${user.table}.t_d_interface
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_integr', '${user.table}', 'public'
    AS $$
declare
  -- переменные пакета
  i sessvarstr;
  u sessvarstr;
  d sessvarstr;

  gv_error sessvarstr;

  -- переменные функции
begin
    -- инициализация/получение переменных пакета
    i = sessvarstr_declare('pkg', 'i', 'I');
    u = sessvarstr_declare('pkg', 'u', 'U');
    d = sessvarstr_declare('pkg', 'd', 'D');
    gv_error = sessvarstr_declare('pkg', 'gv_error', '');

    if pot_d_interface.ck_id is null then
      perform pkg.p_set_error(200, 'meta:079a71832c164e49a909d1b3c385807c');
    end if;

    if nullif(gv_error::varchar, '') is not null then
   	    return;
    end if;

    if pv_action = d::varchar then
        delete from ${user.table}.t_d_interface where ck_id = pot_d_interface.ck_id;
        return;
    end if;
    if nullif(gv_error::varchar, '') is not null then
   	    return;
    end if;
    if pv_action = i::varchar then
      insert into ${user.table}.t_d_interface values (pot_d_interface.*);
    elsif pv_action = u::varchar then
      update ${user.table}.t_d_interface set
        (cv_description, ck_user, ct_change) = (pot_d_interface.cv_description, pot_d_interface.ck_user, pot_d_interface.ct_change)
      where ck_id = pot_d_interface.ck_id;
      if not found then
        perform pkg.p_set_error(504);
      end if;
    end if;
end;
$$;

ALTER FUNCTION pkg_integr.p_modify_patch(pv_action varchar, INOUT pot_d_interface ${user.table}.t_d_interface) OWNER TO ${user.update};

CREATE FUNCTION pkg_integr.p_lock_d_interface(pk_id varchar) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO '${user.table}', 'pkg_integr', 'public'
    AS $$
declare
  vn_lock bigint;
begin
  if pk_id is not null then
    select 1 into vn_lock from ${user.table}.t_d_interface where ck_id = pk_id for update nowait;
  end if;
end;
$$;

ALTER FUNCTION pkg_integr.p_lock_d_interface(pk_id varchar) OWNER TO ${user.update};

CREATE FUNCTION pkg_integr.p_modify_interface(pv_action varchar, INOUT pot_interface ${user.table}.t_interface) RETURNS ${user.table}.t_interface
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_integr', '${user.table}', 'public'
    AS $$
declare
  -- переменные пакета
  i sessvarstr;
  u sessvarstr;
  d sessvarstr;

  gv_error sessvarstr;

  -- переменные функции
begin
    -- инициализация/получение переменных пакета
    i = sessvarstr_declare('pkg', 'i', 'I');
    u = sessvarstr_declare('pkg', 'u', 'U');
    d = sessvarstr_declare('pkg', 'd', 'D');
    gv_error = sessvarstr_declare('pkg', 'gv_error', '');

    if pot_interface.ck_id is null then
      perform pkg.p_set_error(200, 'meta:079a71832c164e49a909d1b3c385807c');
    end if;
    
    if pot_interface.ck_d_interface is null then
      perform pkg.p_set_error(200, 'meta:4d8d29a47fe24d9381329c0510c05942');
    end if;

    if pot_interface.ck_d_provider is null then
      perform pkg.p_set_error(200, 'meta:aaf9025cde674df68d6f07e7fbfe6ee1');
    end if;

    if nullif(gv_error::varchar, '') is not null then
   	    return;
    end if;


    if pv_action = d::varchar then
        delete from ${user.table}.t_interface where ck_id = pot_interface.ck_id;
        return;
    end if;
    if nullif(gv_error::varchar, '') is not null then
   	    return;
    end if;
    if pv_action = i::varchar then
      insert into ${user.table}.t_interface values (pot_interface.*);
    elsif pv_action = u::varchar then
      update ${user.table}.t_interface set
        (ck_d_interface, ck_d_provider, cv_description, ck_user, ct_change) = (pot_interface.ck_d_interface, pot_interface.ck_d_provider, pot_interface.cv_description, pot_interface.ck_user, pot_interface.ct_change)
      where ck_id = pot_interface.ck_id;
      if not found then
        perform pkg.p_set_error(504);
      end if;
    end if;
end;
$$;

ALTER FUNCTION pkg_integr.p_modify_interface(pv_action varchar, INOUT pot_interface ${user.table}.t_interface) OWNER TO ${user.update};

CREATE FUNCTION pkg_integr.p_lock_interface(pk_id varchar) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO '${user.table}', 'pkg_integr', 'public'
    AS $$
declare
  vn_lock bigint;
begin
  if pk_id is not null then
    select 1 into vn_lock from ${user.table}.t_interface where ck_id = pk_id for update nowait;
  end if;
end;
$$;

ALTER FUNCTION pkg_integr.p_lock_interface(pk_id varchar) OWNER TO ${user.update};

CREATE FUNCTION pkg_integr.p_modify_scenario(pv_action varchar, INOUT pot_interface ${user.table}.t_scenario) RETURNS ${user.table}.t_scenario
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_integr', '${user.table}', 'public'
    AS $$
declare
  -- переменные пакета
  i sessvarstr;
  u sessvarstr;
  d sessvarstr;

  gv_error sessvarstr;

  -- переменные функции
begin
    -- инициализация/получение переменных пакета
    i = sessvarstr_declare('pkg', 'i', 'I');
    u = sessvarstr_declare('pkg', 'u', 'U');
    d = sessvarstr_declare('pkg', 'd', 'D');
    gv_error = sessvarstr_declare('pkg', 'gv_error', '');

    if pot_scenario.ck_id is null then
      perform pkg.p_set_error(200, 'meta:079a71832c164e49a909d1b3c385807c');
    end if;
    
    if nullif(gv_error::varchar, '') is not null then
   	    return;
    end if;

    if pv_action = d::varchar then
        delete from ${user.table}.t_scenario where ck_id = pot_scenario.ck_id;
        return;
    end if;
    
    if pv_action = i::varchar then
      insert into ${user.table}.t_scenario values (pot_scenario.*);
    elsif pv_action = u::varchar then
      update ${user.table}.t_scenario set
        (cn_action, cv_description, ck_user, ct_change) = (pot_scenario.cn_action, pot_scenario.cv_description, pot_scenario.ck_user, pot_scenario.ct_change)
      where ck_id = pot_scenario.ck_id;
      if not found then
        perform pkg.p_set_error(504);
      end if;
    end if;
end;
$$;

ALTER FUNCTION pkg_integr.p_modify_scenario(pv_action varchar, INOUT pot_scenario ${user.table}.t_scenario) OWNER TO ${user.update};

CREATE FUNCTION pkg_integr.p_lock_scenario(pk_id varchar) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO '${user.table}', 'pkg_integr', 'public'
    AS $$
declare
  vn_lock bigint;
begin
  if pk_id is not null then
    select 1 into vn_lock from ${user.table}.t_scenario where ck_id = pk_id for update nowait;
  end if;
end;
$$;

ALTER FUNCTION pkg_integr.p_lock_scenario(pk_id varchar) OWNER TO ${user.update};
