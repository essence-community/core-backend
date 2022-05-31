--liquibase formatted sql
--changeset artemov_i:pkg_json_notification dbms:postgresql runOnChange:true splitStatements:false stripComments:false
DROP SCHEMA IF EXISTS pkg_json_notification cascade;

CREATE SCHEMA pkg_json_notification
    AUTHORIZATION s_mp;


ALTER SCHEMA pkg_json_notification OWNER TO s_mp;

CREATE FUNCTION pkg_json_notification.f_modify_notification(pv_user varchar DEFAULT NULL::varchar, pv_session varchar DEFAULT NULL::varchar, pc_json jsonb DEFAULT NULL::jsonb) RETURNS varchar
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
  vot_notification.ck_id = nullif(trim(pc_json#>>'{data,ck_id}'), '');
  vot_notification.cd_st = nullif(trim(pc_json#>>'{data,cd_st}'), '')::date;
  vot_notification.cd_en = nullif(trim(pc_json#>>'{data,cd_en}'), '')::date;
  vot_notification.ck_user = nullif(trim(pc_json#>>'{data,ck_user}'), '');
  vot_notification.cv_message = nullif(trim(pc_json#>>'{data,cv_message}'), '');
  vot_notification.cl_sent = nullif(trim(pc_json#>>'{data,cl_sent}'), '')::smallint;
  vv_action = nullif(trim(pc_json#>>'{service,cv_action}'), '');
  -- Заблокируем запись
  perform pkg_notification.p_lock_notification(vot_notification.ck_id);
  if nullif(gv_error::varchar, '') is not null then
    return '{"ck_id":"","cv_error":' || pkg.p_form_response() || '}';
  end if;
  -- Проверим и сохраним данные
  vot_notification := pkg_notification.p_modify_notification(vv_action, vot_notification);
  -- Логируем данные
  perform pkg_log.p_save(coalesce(pv_user, '-11'),
                         pv_session,
                         pc_json,
                         'pkg_json_notification.f_modify_notification',
                         vot_notification.ck_id::varchar,
                         vv_action);
  return '{"ck_id":"' || coalesce(vot_notification.ck_id, '') || '","cv_error":' || pkg.p_form_response() || '}';
end;
$$;


ALTER FUNCTION pkg_json_notification.f_modify_notification(pv_user varchar, pv_session varchar, pc_json jsonb) OWNER TO s_mp;


CREATE FUNCTION pkg_json_notification.add_notification(pv_user varchar DEFAULT NULL::varchar, pv_session varchar DEFAULT NULL::varchar, pv_user_message varchar DEFAULT NULL::varchar, pv_type_message varchar DEFAULT NULL::varchar, pv_message varchar DEFAULT NULL::varchar) RETURNS varchar
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_json_notification', 's_mt', 'public'
    AS $$
declare
  vot_notification s_mt.t_notification;
  vv_action        varchar(1);
  gv_error sessvarstr;
begin
  -- Обнулим глобальные переменные с перечнем ошибок/предупреждений/информационных сообщений
  perform pkg.p_reset_response();
  -- JSON -> rowtype
  vot_notification.ck_id = NULL;
  vot_notification.cd_st = NULL;
  vot_notification.cd_en = NULL;
  vot_notification.ck_user = coalesce(nullif(pv_user_message, ''), pv_user);
  select jsonb_build_object('jt_message', jsonb_build_object(pv_type_message, jsonb_build_array(jsonb_build_array(pv_message))))::varchar
  into vot_notification.cv_message;
  vot_notification.cl_sent = 0;
  vv_action = 'I';
  -- Заблокируем запись
  -- Проверим и сохраним данные
  vot_notification := pkg_notification.p_modify_notification(vv_action, vot_notification);
  -- Логируем данные
  perform pkg_log.p_save(coalesce(pv_user, '-11'),
                         pv_session,
                         vot_notification.cv_message::jsonb,
                         'pkg_json_notification.add_notification',
                         vot_notification.ck_id::varchar,
                         vv_action);
  return '{"ck_id":"' || coalesce(vot_notification.ck_id, '') || '","cv_error":' || pkg.p_form_response() || '}';
end;
$$;


ALTER FUNCTION pkg_json_notification.add_notification(pv_user varchar, pv_session varchar, pv_user_message varchar, pv_type_message varchar, pv_message varchar) OWNER TO s_mp;

CREATE OR REPLACE FUNCTION pkg_json_notification.f_get_notification(pc_json jsonb) RETURNS varchar
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_json_notification', 's_mt', 'public'
    AS $$
declare 
vv_rec t_notification;
vv_res jsonb := '[]'::jsonb;
begin
  for vv_rec in (select t.*
        from t_notification t
      where current_timestamp between t.cd_st and t.cd_en
        and t.cl_sent = 0
        and t.ck_user in
            (select ck_id from jsonb_to_recordset(pc_json) as x(ck_id text))
        for update skip locked) loop
    vv_res := vv_res || jsonb_build_array(to_jsonb(vv_rec));
    vv_rec.cl_sent = 1;
    perform pkg_notification.p_modify_notification('U', vv_rec);
  end loop;
        
  return vv_res::varchar;
end;
$$;


ALTER FUNCTION pkg_json_notification.f_get_notification(pc_json jsonb) OWNER TO s_mp;