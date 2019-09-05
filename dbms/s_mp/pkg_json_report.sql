--liquibase formatted sql
--changeset artemov_i:pkg_json_report dbms:postgresql runOnChange:true splitStatements:false stripComments:false
DROP SCHEMA IF EXISTS pkg_json_report cascade;

CREATE SCHEMA pkg_json_report
    AUTHORIZATION s_mp;


ALTER SCHEMA pkg_json_report OWNER TO s_mp;

CREATE OR REPLACE FUNCTION pkg_json_report.f_modify_dynamic_report(
	pv_user character varying,
	pk_session character varying,
	pc_json jsonb)
    RETURNS character varying
    LANGUAGE 'plpgsql'
    SECURITY DEFINER 
    SET search_path=pkg, public, pkg_json_report
AS $BODY$
declare
  -- переменные пакета
  gv_error sessvarstr;

  -- переменные функции
  pot_query s_mt.t_query;
  pot_dynamic_report s_mt.t_dynamic_report;
 
  vv_action varchar(1);
  vk_main   varchar(32);
begin
  -- инициализация/получение переменных пакета
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');

  --обнулим глобальные переменные с перечнем ошибок/предупреждений/информационных сообщений
  perform pkg.p_reset_response();
  --JSON -> rowtype
  pot_query.ck_id = nullif(trim(pc_json#>>'{data,ck_id}'), '');
  pot_query.cr_type = 'report';
  pot_query.cc_query = pc_json#>>'{data,cc_query}';
  pot_query.ck_provider = nullif(trim(pc_json#>>'{data,ck_provider}'), '');
  pot_query.cr_access = 'session';
  pot_query.cn_action = nullif(trim(pc_json#>>'{data,cn_action}'), '')::bigint;
  pot_query.cv_description = nullif(trim(pc_json#>>'{data,cv_description}'), '');
 
  pot_dynamic_report.ck_query = pot_query.ck_id;
  pot_dynamic_report.ck_page = nullif(trim(pc_json#>>'{data,ck_page}'), '');
  
  pot_dynamic_report.ck_user = pv_user;
  pot_dynamic_report.ct_change = CURRENT_TIMESTAMP;
  pot_query.ck_user = pv_user;
  pot_query.ct_change = CURRENT_TIMESTAMP;
  vv_action = (pc_json#>>'{service,cv_action}');

  --проверка прав доступа
  perform pkg_access.p_check_access(pv_user, vk_main);
  if nullif(gv_error::varchar, '') is not null then
    return '{"ck_id":"","cv_error":' || pkg.p_form_response() || '}'; --ошибка прав доступа.
  end if;
  --проверяем и сохраняем данные
  pot_query := pkg_report.p_modify_dynamic_report(vv_action, pot_dynamic_report, pot_query);
  --логируем данные
  perform pkg_log.p_save(pv_user, pk_session, pc_json, 't_query', pot_query.ck_id::varchar, vv_action);
  perform pkg_log.p_save(pv_user, pk_session, pc_json, 't_dynamic_report', pot_dynamic_report.ck_query::varchar, vv_action);
  return '{"ck_id":"' || coalesce(pot_query.ck_id, '') || '","cv_error":' || pkg.p_form_response() || '}';
END;
$BODY$;

ALTER FUNCTION pkg_json_report.f_modify_dynamic_report(character varying, character varying, jsonb)
    OWNER TO s_mp;

COMMENT ON FUNCTION pkg_json_report.f_modify_dynamic_report(character varying, character varying, jsonb)
    IS 'Преобработка json для универсальной печати ';

