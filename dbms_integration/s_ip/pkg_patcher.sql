--liquibase formatted sql
--changeset artemov_i:pkg_patcher dbms:postgresql runOnChange:true splitStatements:false stripComments:false
DROP SCHEMA IF EXISTS pkg_patcher cascade;

CREATE SCHEMA pkg_patcher AUTHORIZATION s_ip;

CREATE FUNCTION pkg_patcher.p_modify_patch(pv_action character varying, INOUT pot_create_patch s_it.t_create_patch) RETURNS s_it.t_create_patch
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_patcher', 's_it', 'public'
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

    if pv_action = d::varchar then
        delete from s_it.t_create_patch where ck_id = pot_create_patch.ck_id;
        return;
    end if;
    if nullif(gv_error::varchar, '') is not null then
   	    return;
    end if;
    if pv_action = i::varchar then
      if pot_create_patch.ck_id is null then
        pot_create_patch.ck_id := uuid_generate_v4();
      end if;
      insert into s_it.t_create_patch values (pot_create_patch.*);
    elsif pv_action = u::varchar then
      update s_it.t_create_patch set
        (cv_file_name, ck_user, ct_change) = (pot_create_patch.cv_file_name, pot_create_patch.ck_user, pot_create_patch.ct_change)
      where ck_id = pot_create_patch.ck_id;
      if not found then
        perform pkg.p_set_error(504);
      end if;
    end if;
end;
$$;

ALTER FUNCTION pkg_patcher.p_modify_patch(pv_action character varying, INOUT pot_create_patch s_it.t_create_patch) OWNER TO s_ip;

CREATE FUNCTION pkg_patcher.p_lock_patch(pk_id uuid) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 's_it', 'pkg_patcher', 'public'
    AS $$
declare
  vn_lock bigint;
begin
  if pk_id is not null then
    select 1 into vn_lock from s_it.t_create_patch where ck_id = pk_id for update nowait;
  end if;
end;
$$;


ALTER FUNCTION pkg_patcher.p_lock_patch(pk_id uuid) OWNER TO s_ip;