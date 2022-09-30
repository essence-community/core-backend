--liquibase formatted sql
--changeset artemov_i:pkg_json_semaphore dbms:postgresql runOnChange:true splitStatements:false stripComments:false
DROP SCHEMA IF EXISTS pkg_json_semaphore cascade;

CREATE SCHEMA pkg_json_semaphore
    AUTHORIZATION ${user.update};


ALTER SCHEMA pkg_json_semaphore OWNER TO ${user.update};

CREATE FUNCTION pkg_json_semaphore.f_modify_semaphore(pv_user character varying DEFAULT NULL::bigint, pv_session character varying DEFAULT NULL::character varying, pc_json jsonb DEFAULT NULL::jsonb) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_json_semaphore', 'public'
    AS $$
declare
  vk_semaphore varchar;
  vv_action    varchar(3); /* only values "inc" / "dec" w/o quotes */
begin
  -- Обнулим глобальные переменные с перечнем ошибок/предупреждений/информационных сообщений
  perform pkg.p_reset_response();
  -- JSON -> rowtype

  vk_semaphore = trim(pc_json#>>'{data,ck_id}');
  vv_action = trim(pc_json#>>'{service,cv_action}');

  -- Вызов основной функции, где происходит инкремент/декремент
  if vv_action = 'inc' then
    perform pkg_semaphore.p_inc(vk_semaphore);
  elsif vv_action = 'dec' then
    perform pkg_semaphore.p_dec(vk_semaphore);
  else
    perform pkg.p_set_error(517);
  end if;
  -- Логируем данные
  perform pkg_log.p_save(coalesce(pv_user,'-11'), pv_session, pc_json, 'pkg_json_semaphore.f_modify_semaphore', vk_semaphore, vv_action);
  return '{"ck_id":"' || vk_semaphore || '","cv_error":' || pkg.p_form_response() || '}';
end;
$$;


ALTER FUNCTION pkg_json_semaphore.f_modify_semaphore(pv_user character varying, pv_session character varying, pc_json jsonb) OWNER TO ${user.update};
