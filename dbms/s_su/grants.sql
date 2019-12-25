--liquibase formatted sql
--changeset artemov_i:grants dbms:postgresql runOnChange:true runAlways:true splitStatements:false stripComments:false
--гранты на использование

GRANT USAGE ON SCHEMA pkg_json_user TO s_mc;

GRANT USAGE ON SCHEMA pkg_json TO s_mc;

GRANT USAGE ON SCHEMA pkg_json_semaphore TO s_mc;

GRANT USAGE ON SCHEMA pkg_json_meta TO s_mc;

GRANT USAGE ON SCHEMA pkg_json_notification TO s_mc;

GRANT USAGE ON SCHEMA pkg_json_scenario TO s_mc;

GRANT USAGE ON SCHEMA pkg_json_util TO s_mc;

GRANT USAGE ON SCHEMA pkg_json_report TO s_mc;

GRANT USAGE ON SCHEMA pkg_json_localization TO s_mc;

GRANT USAGE ON SCHEMA pkg_json_patcher TO s_mc;

GRANT USAGE ON SCHEMA s_mt TO s_mc;

GRANT USAGE ON SCHEMA public TO s_mc;

GRANT USAGE ON SCHEMA public TO s_mp;

GRANT USAGE ON SCHEMA s_mt TO s_mp;

--на update
GRANT SELECT, UPDATE ON TABLE s_mt.t_notification TO s_mc;

--гранты на выполнение
GRANT EXECUTE ON FUNCTION pkg_json.f_get_object(pk_start character varying) TO s_mc;

GRANT EXECUTE ON FUNCTION pkg_json_meta.f_copy_object(pv_user character varying, pv_session character varying, pc_json jsonb) TO s_mc;

GRANT EXECUTE ON FUNCTION pkg_json_meta.f_modify_attr(pv_user character varying, pk_session character varying, pc_json jsonb) TO s_mc;

GRANT EXECUTE ON FUNCTION pkg_json_meta.f_modify_class(pv_user character varying, pk_session character varying, pc_json jsonb) TO s_mc;

GRANT EXECUTE ON FUNCTION pkg_json_meta.f_modify_class_attr(pv_user character varying, pk_session character varying, pc_json jsonb) TO s_mc;

GRANT EXECUTE ON FUNCTION pkg_json_meta.f_modify_class_hierarchy(pv_user character varying, pk_session character varying, pc_json jsonb) TO s_mc;

GRANT EXECUTE ON FUNCTION pkg_json_meta.f_modify_object(pv_user character varying, pk_session character varying, pc_json jsonb) TO s_mc;

GRANT EXECUTE ON FUNCTION pkg_json_meta.f_modify_object_attr(pv_user character varying, pk_session character varying, pc_json jsonb) TO s_mc;

GRANT EXECUTE ON FUNCTION pkg_json_meta.f_modify_page(pv_user character varying, pk_session character varying, pc_json jsonb) TO s_mc;

GRANT EXECUTE ON FUNCTION pkg_json_meta.f_modify_page_object(pv_user character varying, pk_session character varying, pc_json jsonb) TO s_mc;

GRANT EXECUTE ON FUNCTION pkg_json_meta.f_modify_page_object_attr(pv_user character varying, pk_session character varying, pc_json jsonb) TO s_mc;

GRANT EXECUTE ON FUNCTION pkg_json_meta.f_modify_page_variable(pv_user character varying, pv_session character varying, pc_json jsonb) TO s_mc;

GRANT EXECUTE ON FUNCTION pkg_json_meta.f_refresh_page_object(pv_user character varying, pv_session character varying, pc_json jsonb) TO s_mc;

GRANT EXECUTE ON FUNCTION pkg_json_meta.f_modify_provider(pv_user character varying, pv_session character varying, pc_json jsonb) TO s_mc;

GRANT EXECUTE ON FUNCTION pkg_json_meta.f_modify_sys_setting(pv_user character varying, pv_session character varying, pc_json jsonb) TO s_mc;

GRANT EXECUTE ON FUNCTION pkg_json_meta.f_modify_module(pv_user character varying, pk_session character varying, pc_json jsonb) TO s_mc;

GRANT EXECUTE ON FUNCTION pkg_json_semaphore.f_modify_semaphore(pv_user character varying, pv_session character varying, pc_json jsonb) TO s_mc;

GRANT EXECUTE ON FUNCTION pkg_json_user.f_get_context(pv_attribute character varying) TO s_mc;

GRANT EXECUTE ON FUNCTION pkg_json_user.f_modify_user(pc_json jsonb, pv_hash character varying) TO s_mc;

GRANT EXECUTE ON FUNCTION pkg_json_user.f_modify_user_action(pc_json jsonb, pv_hash character varying) TO s_mc;

GRANT EXECUTE ON FUNCTION pkg_json_user.f_modify_user_department(pc_json jsonb, pv_hash character varying) TO s_mc;

GRANT EXECUTE ON FUNCTION pkg_json_notification.f_modify_notification(pv_user character varying, pv_session character varying, pc_json jsonb) TO s_mc;

GRANT EXECUTE ON FUNCTION pkg_json_scenario.f_modify_action(pv_user character varying, pv_session character varying, pc_json jsonb) TO s_mc;

GRANT EXECUTE ON FUNCTION pkg_json_scenario.f_modify_scenario(pv_user character varying, pv_session character varying, pc_json jsonb) TO s_mc;

GRANT EXECUTE ON FUNCTION pkg_json_scenario.f_modify_step(pv_user character varying, pv_session character varying, pc_json jsonb) TO s_mc;

GRANT EXECUTE ON FUNCTION pkg_json_util.f_string_to_rows(pv_string character varying) TO s_mc;

GRANT EXECUTE ON FUNCTION pkg_json_util.f_check_string_is_percentage(pv_string character varying) TO s_mc;

GRANT EXECUTE ON FUNCTION pkg_json_report.f_modify_dynamic_report(pv_user character varying, pv_session character varying, pc_json jsonb) TO s_mc;

GRANT EXECUTE ON FUNCTION pkg_json_localization.f_modify_default_localization(pv_user character varying, pk_session character varying, pc_json jsonb) TO s_mc;

GRANT EXECUTE ON FUNCTION pkg_json_localization.f_modify_lang(pv_user character varying, pk_session character varying, pc_json jsonb) TO s_mc;

GRANT EXECUTE ON FUNCTION pkg_json_localization.f_modify_localization(pv_user character varying, pk_session character varying, pc_json jsonb) TO s_mc;

GRANT EXECUTE ON FUNCTION pkg_json_patcher.f_modify_patch(pv_user character varying, pk_session character varying, pc_json jsonb) TO s_mc;

GRANT EXECUTE ON FUNCTION public.sessvarf_declare(p_pcg_name character varying, p_var_name character varying, p_init_value double precision) TO s_mc;

GRANT EXECUTE ON FUNCTION public.sessvarf_getbf(p_var sessvarf) TO s_mc;

GRANT EXECUTE ON FUNCTION public.sessvarf_setf(p_var sessvarf, p_value double precision) TO s_mc;

GRANT EXECUTE ON FUNCTION public.sessvari_declare(p_pcg_name character varying, p_var_name character varying, p_init_value bigint) TO s_mc;

GRANT EXECUTE ON FUNCTION public.sessvari_getbi(p_var sessvari) TO s_mc;

GRANT EXECUTE ON FUNCTION public.sessvari_geti(p_var sessvari) TO s_mc;

GRANT EXECUTE ON FUNCTION public.sessvari_seti(p_var sessvari, p_value bigint) TO s_mc;

GRANT EXECUTE ON FUNCTION public.sessvarstr_declare(p_pcg_name character varying, p_var_name character varying, p_init_value character varying) TO s_mc;

GRANT EXECUTE ON FUNCTION public.sessvarstr_getbstr(p_var sessvarstr) TO s_mc;

GRANT EXECUTE ON FUNCTION public.sessvarstr_setstr(p_var sessvarstr, p_value character varying) TO s_mc;

GRANT EXECUTE ON FUNCTION public.sys_guid() TO s_mc;

GRANT EXECUTE ON FUNCTION public.notify_event() TO s_mc;

GRANT EXECUTE ON FUNCTION public.sessvarf_declare(p_pcg_name character varying, p_var_name character varying, p_init_value double precision) TO s_mp;

GRANT EXECUTE ON FUNCTION public.sessvarf_getbf(p_var sessvarf) TO s_mp;

GRANT EXECUTE ON FUNCTION public.sessvarf_setf(p_var sessvarf, p_value double precision) TO s_mp;

GRANT EXECUTE ON FUNCTION public.sessvari_declare(p_pcg_name character varying, p_var_name character varying, p_init_value bigint) TO s_mp;

GRANT EXECUTE ON FUNCTION public.sessvari_getbi(p_var sessvari) TO s_mp;

GRANT EXECUTE ON FUNCTION public.sessvari_geti(p_var sessvari) TO s_mp;

GRANT EXECUTE ON FUNCTION public.sessvari_seti(p_var sessvari, p_value bigint) TO s_mp;

GRANT EXECUTE ON FUNCTION public.sessvarstr_declare(p_pcg_name character varying, p_var_name character varying, p_init_value character varying) TO s_mp;

GRANT EXECUTE ON FUNCTION public.sessvarstr_getbstr(p_var sessvarstr) TO s_mp;

GRANT EXECUTE ON FUNCTION public.sessvarstr_setstr(p_var sessvarstr, p_value character varying) TO s_mp;

GRANT EXECUTE ON FUNCTION public.sys_guid() TO s_mp;

GRANT EXECUTE ON FUNCTION public.uuid_generate_v1() TO s_mp;

GRANT EXECUTE ON FUNCTION public.uuid_generate_v1mc() TO s_mp;

GRANT EXECUTE ON FUNCTION public.uuid_generate_v3(namespace uuid, name text) TO s_mp;

GRANT EXECUTE ON FUNCTION public.uuid_generate_v4() TO s_mp;

GRANT EXECUTE ON FUNCTION public.uuid_generate_v5(namespace uuid, name text) TO s_mp;

GRANT EXECUTE ON FUNCTION public.uuid_nil() TO s_mp;

GRANT EXECUTE ON FUNCTION public.uuid_ns_dns() TO s_mp;

GRANT EXECUTE ON FUNCTION public.uuid_ns_oid() TO s_mp;

GRANT EXECUTE ON FUNCTION public.uuid_ns_url() TO s_mp;

GRANT EXECUTE ON FUNCTION public.uuid_ns_x500() TO s_mp;

GRANT EXECUTE ON FUNCTION public.notify_event() TO s_mp;

GRANT SELECT ON TABLE public.dual TO s_mc;

GRANT SELECT ON TABLE s_mt.t_action TO s_mc;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_mt.t_action TO s_mp;

GRANT SELECT ON TABLE s_mt.t_attr TO s_mc;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_mt.t_attr TO s_mp;

GRANT SELECT ON TABLE s_mt.t_attr_type TO s_mc;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_mt.t_attr_type TO s_mp;

GRANT SELECT ON TABLE s_mt.t_class TO s_mc;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_mt.t_class TO s_mp;

GRANT SELECT ON TABLE s_mt.t_class_attr TO s_mc;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_mt.t_class_attr TO s_mp;

GRANT SELECT ON TABLE s_mt.t_class_hierarchy TO s_mc;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_mt.t_class_hierarchy TO s_mp;

GRANT SELECT ON TABLE s_mt.t_d_action TO s_mc;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_mt.t_d_action TO s_mp;

GRANT SELECT ON TABLE s_mt.t_icon TO s_mc;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_mt.t_icon TO s_mp;

GRANT SELECT ON TABLE s_mt.t_log TO s_mc;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_mt.t_log TO s_mp;

GRANT SELECT ON TABLE s_mt.t_message TO s_mc;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_mt.t_message TO s_mp;

GRANT SELECT ON TABLE s_mt.t_module TO s_mc;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_mt.t_module TO s_mp;

GRANT SELECT ON TABLE s_mt.t_notification TO s_mc;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_mt.t_notification TO s_mp;

GRANT SELECT ON TABLE s_mt.t_object TO s_mc;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_mt.t_object TO s_mp;

GRANT SELECT ON TABLE s_mt.t_object_attr TO s_mc;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_mt.t_object_attr TO s_mp;

GRANT SELECT ON TABLE s_mt.t_page TO s_mc;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_mt.t_page TO s_mp;

GRANT SELECT ON TABLE s_mt.t_page_action TO s_mc;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_mt.t_page_action TO s_mp;

GRANT SELECT ON TABLE s_mt.t_page_object TO s_mc;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_mt.t_page_object TO s_mp;

GRANT SELECT ON TABLE s_mt.t_page_object_attr TO s_mc;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_mt.t_page_object_attr TO s_mp;

GRANT SELECT ON TABLE s_mt.t_page_variable TO s_mc;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_mt.t_page_variable TO s_mp;

GRANT SELECT ON TABLE s_mt.t_provider TO s_mc;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_mt.t_provider TO s_mp;

GRANT SELECT ON TABLE s_mt.t_query TO s_mc;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_mt.t_query TO s_mp;

GRANT SELECT ON TABLE s_mt.t_scenario TO s_mc;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_mt.t_scenario TO s_mp;

GRANT SELECT ON TABLE s_mt.t_semaphore TO s_mc;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_mt.t_semaphore TO s_mp;

GRANT SELECT ON TABLE s_mt.t_step TO s_mc;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_mt.t_step TO s_mp;

GRANT SELECT ON TABLE s_mt.t_sys_setting TO s_mc;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_mt.t_sys_setting TO s_mp;

GRANT ALL ON SEQUENCE public.seq_log TO s_mp;

GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE public.dual TO s_mp;

GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE s_mt.t_dynamic_report TO s_mp;

GRANT SELECT ON TABLE s_mt.t_dynamic_report TO s_mc;

GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE s_mt.t_module_class TO s_mp;

GRANT SELECT ON TABLE s_mt.t_module_class TO s_mc;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_mt.t_d_lang TO s_mp;

GRANT SELECT ON TABLE s_mt.t_d_lang TO s_mc;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_mt.t_localization TO s_mp;

GRANT SELECT ON TABLE s_mt.t_localization TO s_mc;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_mt.t_create_patch TO s_mp;

GRANT SELECT ON TABLE s_mt.t_create_patch TO s_mc;
