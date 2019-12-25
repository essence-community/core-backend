--liquibase formatted sql
--changeset artemov_i:grants dbms:postgresql runAlways:true runOnChange:true splitStatements:false stripComments:false
--гранты на использование

GRANT USAGE ON SCHEMA pkg_json_user TO s_ic;

GRANT USAGE ON SCHEMA pkg_json_patcher TO s_ic;

GRANT USAGE ON SCHEMA s_it TO s_ic;

GRANT USAGE ON SCHEMA public TO s_ip;

GRANT USAGE ON SCHEMA s_it TO s_ip;

--гранты на выполнение

GRANT EXECUTE ON FUNCTION pkg_json_user.f_get_context(pv_attribute character varying) TO s_ic;

GRANT EXECUTE ON FUNCTION pkg_json_user.f_modify_user(pc_json jsonb, pv_hash character varying) TO s_ic;

GRANT EXECUTE ON FUNCTION pkg_json_user.f_modify_user_action(pc_json jsonb, pv_hash character varying) TO s_ic;

GRANT EXECUTE ON FUNCTION pkg_json_user.f_modify_user_department(pc_json jsonb, pv_hash character varying) TO s_ic;

GRANT EXECUTE ON FUNCTION pkg_json_patcher.f_modify_patch(pv_user character varying, pk_session character varying, pc_json jsonb) TO s_ic;

GRANT ALL ON SEQUENCE public.seq_log TO s_ip;

GRANT SELECT ON TABLE public.dual TO s_ic;

GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE public.dual TO s_ip;

GRANT SELECT ON TABLE s_it.t_log TO s_ic;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_it.t_log TO s_ip;

GRANT SELECT ON TABLE s_it.t_batch TO s_ic;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_it.t_batch TO s_ip;

GRANT SELECT ON TABLE s_it.t_d_interface TO s_ic;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_it.t_d_interface TO s_ip;

GRANT SELECT ON TABLE s_it.t_d_param TO s_ic;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_it.t_d_param TO s_ip;

GRANT SELECT ON TABLE s_it.t_d_provider TO s_ic;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_it.t_d_provider TO s_ip;

GRANT SELECT ON TABLE s_it.t_d_status TO s_ic;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_it.t_d_status TO s_ip;

GRANT SELECT ON TABLE s_it.t_interface TO s_ic;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_it.t_interface TO s_ip;

GRANT SELECT ON TABLE s_it.t_item TO s_ic;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_it.t_item TO s_ip;

GRANT SELECT ON TABLE s_it.t_item_result TO s_ic;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_it.t_item_result TO s_ip;

GRANT SELECT ON TABLE s_it.t_json_tmp TO s_ic;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_it.t_json_tmp TO s_ip;

GRANT SELECT ON TABLE s_it.t_param TO s_ic;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_it.t_param TO s_ip;

GRANT SELECT ON TABLE s_it.t_create_patch TO s_ic;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_it.t_create_patch TO s_ip;
