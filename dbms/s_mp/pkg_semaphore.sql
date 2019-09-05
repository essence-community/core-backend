--liquibase formatted sql
--changeset artemov_i:pkg_semaphore dbms:postgresql runOnChange:true splitStatements:false stripComments:false
DROP SCHEMA IF EXISTS pkg_semaphore cascade;

CREATE SCHEMA pkg_semaphore
    AUTHORIZATION s_mp;


ALTER SCHEMA pkg_semaphore OWNER TO s_mp;

CREATE FUNCTION pkg_semaphore.p_dec(pk_id character varying) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_semaphore', 'public'
    AS $$
declare
  -- переменные пакета
  gv_error sessvarstr;

  -- переменные функции
begin
  -- инициализация/получение переменных пакета
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');

  -- код функции
  if nullif(gv_error::varchar, '') is null then
    -- обновим значение семафора (нельзя уйти меньше 0)
    update s_mt.t_semaphore set
      cn_value = case when cn_value - 1 < 0 then 0 else cn_value - 1 end
    where ck_id = pk_id;

    if not found then
      perform pkg.p_set_error(518);
      return;
    end if;
  end if;
end;
$$;


ALTER FUNCTION pkg_semaphore.p_dec(pk_id character varying) OWNER TO s_mp;

CREATE FUNCTION pkg_semaphore.p_get(pk_id character varying) RETURNS double precision
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_semaphore', 'public'
    AS $$
declare
  vn_value float;
begin
  select s.cn_value
  into vn_value
  from s_mt.t_semaphore s
  where s.ck_id = pk_id;

  if not found then
    perform pkg.p_set_error(518);
    return null;
  end if;

  return vn_value;
end;
$$;


ALTER FUNCTION pkg_semaphore.p_get(pk_id character varying) OWNER TO s_mp;

CREATE FUNCTION pkg_semaphore.p_inc(pk_id character varying) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_semaphore', 'public'
    AS $$
declare
  -- переменные пакета
  gv_error sessvarstr;

  -- переменные функции
begin
  -- инициализация/получение переменных пакета
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');

  -- код функции
  if nullif(gv_error::varchar, '') is null then
    -- обновим значение семафора
    update s_mt.t_semaphore set
      cn_value = cn_value + 1
    where ck_id = pk_id;

    if not found then
      perform pkg.p_set_error(518);
      return;
    end if;
  end if;
end;
$$;


ALTER FUNCTION pkg_semaphore.p_inc(pk_id character varying) OWNER TO s_mp;
