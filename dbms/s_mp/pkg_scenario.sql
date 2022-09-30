--liquibase formatted sql
--changeset artemov_i:pkg_scenario dbms:postgresql runOnChange:true splitStatements:false stripComments:false
DROP SCHEMA IF EXISTS pkg_scenario cascade;

CREATE SCHEMA pkg_scenario
    AUTHORIZATION ${user.update};


ALTER SCHEMA pkg_scenario OWNER TO ${user.update};

CREATE FUNCTION pkg_scenario.p_modify_action(pv_action character varying, INOUT pot_action s_mt.t_action) RETURNS s_mt.t_action
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_scenario', 'public'
    AS $$
declare
  -- переменные пакета
  i sessvarstr;
  u sessvarstr;
  d sessvarstr;
  gv_error sessvarstr;

  -- переменные функции
  vcur_check record;
begin
  -- инициализация/получение переменных пакета
  i = sessvarstr_declare('pkg', 'i', 'I');
  u = sessvarstr_declare('pkg', 'u', 'U');
  d = sessvarstr_declare('pkg', 'd', 'D');
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');

  -- код функции
  if pv_action = d::varchar then
    delete from s_mt.t_action where ck_id = pot_action.ck_id;
  else
    /* Блок "Проверка переданных данных" */
    -- Шаг + номер действия = должно быть уникально
    for vcur_check in (select 1
                         from s_mt.t_action t
                        where t.ck_step = pot_action.ck_step
                          and t.cn_order = pot_action.cn_order
                          and ((ck_id != pot_action.ck_id and pv_action = u::varchar) or
                              (pot_action.ck_id is null and pv_action = i::varchar))) loop
      perform pkg.p_set_error(52);
    end loop;
    --
    if pv_action = i::varchar and nullif(gv_error::varchar, '') is null then
      pot_action.ck_id := sys_guid();
      insert into s_mt.t_action values (pot_action.*);
    elsif pv_action = u::varchar and nullif(gv_error::varchar, '') is null then
      update s_mt.t_action set (ck_id, ck_step, cn_order, cv_key, cv_value, cv_description, ck_user, ct_change) = row(pot_action.*)
      where ck_id = pot_action.ck_id;

      if not found then
        perform pkg.p_set_error(504);
      end if;
    end if;
  end if;
end;
$$;


ALTER FUNCTION pkg_scenario.p_modify_action(pv_action character varying, INOUT pot_action s_mt.t_action) OWNER TO ${user.update};

CREATE FUNCTION pkg_scenario.p_modify_scenario(pv_action character varying, INOUT pot_scenario s_mt.t_scenario) RETURNS s_mt.t_scenario
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_scenario', 'public'
    AS $$
declare
  -- переменные пакета
  i sessvarstr;
  u sessvarstr;
  d sessvarstr;
  gv_error sessvarstr;

  -- переменные функции
  vcur_check record;
begin
  -- инициализация/получение переменных пакета
  i = sessvarstr_declare('pkg', 'i', 'I');
  u = sessvarstr_declare('pkg', 'u', 'U');
  d = sessvarstr_declare('pkg', 'd', 'D');
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');

  -- код функции
  if pv_action = d::varchar then
    /*Удаление*/
    begin
      delete from s_mt.t_scenario where ck_id = pot_scenario.ck_id;
    exception
      when integrity_constraint_violation then
        perform pkg.p_set_error(48);
    end;
  else
    /* Блок "Проверка переданных данных" */
    for vcur_check in (select 1
                         from s_mt.t_scenario t
                        where t.cn_order = pot_scenario.cn_order
                          and ((ck_id != pot_scenario.ck_id and pv_action = u::varchar) or
                              (pot_scenario.ck_id is null and pv_action = i::varchar))) loop
      perform pkg.p_set_error(53);
    end loop;
    if pot_scenario.cv_name is null then
      perform pkg.p_set_error(2);
    end if;
    if pot_scenario.cn_order is null then
      perform pkg.p_set_error(8);
    end if;
    if pv_action = i::varchar and nullif(gv_error::varchar, '') is null then
      pot_scenario.ck_id := sys_guid();
      insert into s_mt.t_scenario values (pot_scenario.*);
    elsif pv_action = u::varchar and nullif(gv_error::varchar, '') is null then
      update s_mt.t_scenario set (ck_id, cn_order, cv_name, cl_valid, cv_description, ck_user, ct_change) = row(pot_scenario.*)
      where ck_id = pot_scenario.ck_id;

      if not found then
        perform pkg.p_set_error(504);
      end if;
    end if;
    null;
  end if;
end;
$$;


ALTER FUNCTION pkg_scenario.p_modify_scenario(pv_action character varying, INOUT pot_scenario s_mt.t_scenario) OWNER TO ${user.update};

CREATE FUNCTION pkg_scenario.p_modify_step(pv_action character varying, INOUT pot_step s_mt.t_step) RETURNS s_mt.t_step
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_scenario', 'public'
    AS $$
declare
  -- переменные пакета
  i sessvarstr;
  u sessvarstr;
  d sessvarstr;
  gv_error sessvarstr;

  -- переменные функции
  vcur_check record;
begin
  -- инициализация/получение переменных пакета
  i = sessvarstr_declare('pkg', 'i', 'I');
  u = sessvarstr_declare('pkg', 'u', 'U');
  d = sessvarstr_declare('pkg', 'd', 'D');
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');

  -- код функции
  if pv_action = d::varchar then
    delete from s_mt.t_action where ck_step = pot_step.ck_id;
    delete from s_mt.t_step where ck_id = pot_step.ck_id;
  else
    /* Блок "Проверка переданных данных" */
    -- сценарий + номер шага = должно быть уникально
    for vcur_check in (select 1
                         from s_mt.t_step t
                        where t.ck_scenario = pot_step.ck_scenario
                          and t.cn_order = pot_step.cn_order
                          and ((ck_id != pot_step.ck_id and pv_action = u::varchar) or
                              (pot_step.ck_id is null and pv_action = i::varchar))) loop
      perform pkg.p_set_error(49);
    end loop;
    --
    if pv_action = i::varchar and nullif(gv_error::varchar, '') is null then
      pot_step.ck_id := sys_guid();
      insert into s_mt.t_step values (pot_step.*);
    elsif pv_action = u::varchar and nullif(gv_error::varchar, '') is null then
      update s_mt.t_step set (ck_id, ck_scenario, cn_order, cv_name, ck_user, ct_change) = row(pot_step.*)
       where ck_id = pot_step.ck_id;

      if not found then
        perform pkg.p_set_error(504);
      end if;
    end if;
  end if;
end;
$$;


ALTER FUNCTION pkg_scenario.p_modify_step(pv_action character varying, INOUT pot_step s_mt.t_step) OWNER TO ${user.update};

CREATE FUNCTION pkg_scenario.p_lock_scenario(pk_id character varying) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 's_mt', 'pkg_scenario', 'public'
    AS $$
declare
  vn_lock bigint;
begin
  if pk_id is not null then
    select 1 into vn_lock from s_mt.t_scenario where ck_id = pk_id for update nowait;
  end if;
end;
$$;


ALTER FUNCTION pkg_scenario.p_lock_scenario(pk_id character varying) OWNER TO ${user.update};

CREATE FUNCTION pkg_scenario.p_lock_step(pk_id character varying) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 's_mt', 'pkg_scenario', 'public'
    AS $$
declare
  vn_lock bigint;
begin
  if pk_id is not null then
    select 1 into vn_lock from s_mt.t_step where ck_id = pk_id for update nowait;
  end if;
end;
$$;


ALTER FUNCTION pkg_scenario.p_lock_step(pk_id character varying) OWNER TO ${user.update};
