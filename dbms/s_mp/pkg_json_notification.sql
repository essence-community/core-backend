--liquibase formatted sql
--changeset artemov_i:pkg_json_notification dbms:postgresql runOnChange:true splitStatements:false stripComments:false
DROP SCHEMA IF EXISTS pkg_json_notification cascade;

CREATE SCHEMA pkg_json_notification
    AUTHORIZATION s_mp;


ALTER SCHEMA pkg_json_notification OWNER TO s_mp;

CREATE FUNCTION pkg_json_notification.f_modify_notification(pv_user character varying DEFAULT NULL::bigint, pv_session character varying DEFAULT NULL::character varying, pc_json jsonb DEFAULT NULL::jsonb) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_json_notification', 'public'
    AS $$
declare
  vot_notification s_mt.t_notification;
  vv_action        varchar(1);
  gv_error sessvarstr;
begin
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');
  -- Обнулим глобальные переменные с перечнем ошибок/предупреждений/информационных сообщений
  perform pkg.p_reset_response();
  -- JSON -> rowtype
  vot_notification.ck_id = nullif(trim(pc_json->'data'->>'ck_id'), '');
  vot_notification.cd_st = nullif(trim(pc_json->'data'->>'cd_st'), '')::date;
  vot_notification.cd_en = nullif(trim(pc_json->'data'->>'cd_en'), '')::date;
  vot_notification.ck_user = nullif(trim(pc_json->'data'->>'ck_user'), '');
  vot_notification.cv_message = nullif(trim(pc_json->'data'->>'cv_message'), '');
  vot_notification.cl_sent = nullif(trim(pc_json->'data'->>'cl_sent'), '')::smallint;
  vot_notification.cv_param = nullif(trim(pc_json->'data'->>'cv_param'), '');
  vv_action = nullif(trim(pc_json#>>'{service,cv_action}'), '');
  -- Заблокируем запись
  perform pkg_json_notification.p_lock_notification(vot_notification.ck_id);
  if nullif(gv_error::varchar, '') is not null then
    return '{"ck_id":"","cv_error":' || pkg.p_form_response() || '}';
  end if;
  -- Проверим и сохраним данные
  vot_notification := pkg_notification.p_modify_notification(vv_action, vot_notification);
  -- Логируем данные
  perform pkg_log.p_save(coalesce(pv_user, "-11"),
                         pv_session,
                         pc_json,
                         'pkg_json_notification.f_modify_notification',
                         vot_notification.ck_id::varchar,
                         vv_action);
  return '{"ck_id":"' || coalesce(vot_notification.ck_id, '') || '","cv_error":' || pkg.p_form_response() || '}';
end;
$$;


ALTER FUNCTION pkg_json_notification.f_modify_notification(pv_user character varying, pv_session character varying, pc_json jsonb) OWNER TO s_mp;

CREATE FUNCTION pkg_json_notification.p_lock_notification(pk_id character varying) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_json_notification', 'public'
    AS $$
declare
  vn_lock bigint;
begin
  if pk_id is not null then
    select 1 into vn_lock from s_mt.t_notification where ck_id = pk_id for update nowait;
  end if;
end;
$$;


ALTER FUNCTION pkg_json_notification.p_lock_notification(pk_id character varying) OWNER TO s_mp;
