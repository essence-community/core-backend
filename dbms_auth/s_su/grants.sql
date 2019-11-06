--liquibase formatted sql
--changeset artemov_i:grants dbms:postgresql runAlways:true runOnChange:true splitStatements:false stripComments:false
--гранты на использование

GRANT USAGE ON SCHEMA pkg_json_user TO s_ac;

GRANT USAGE ON SCHEMA pkg_json_account TO s_ac;

GRANT USAGE ON SCHEMA s_at TO s_ac;

GRANT USAGE ON SCHEMA public TO s_ap;

GRANT USAGE ON SCHEMA s_at TO s_ap;

--гранты на выполнение

GRANT EXECUTE ON FUNCTION pkg_json_user.f_get_context(pv_attribute character varying) TO s_ac;

GRANT EXECUTE ON FUNCTION pkg_json_user.f_modify_user(pc_json jsonb, pv_hash character varying) TO s_ac;

GRANT EXECUTE ON FUNCTION pkg_json_user.f_modify_user_action(pc_json jsonb, pv_hash character varying) TO s_ac;

GRANT EXECUTE ON FUNCTION pkg_json_user.f_modify_user_department(pc_json jsonb, pv_hash character varying) TO s_ac;

GRANT EXECUTE ON FUNCTION pkg_json_account.f_get_field_info(pv_master character varying, pr_type character varying, pv_column character varying) TO s_ac;

GRANT EXECUTE ON FUNCTION pkg_json_account.f_get_user(pv_login character varying, pv_password character varying, pv_token character varying, pl_audit smallint) TO s_ac;

GRANT EXECUTE ON FUNCTION pkg_json_account.f_modify_account(pv_user character varying, pv_session character varying, pc_json jsonb) TO s_ac;

GRANT EXECUTE ON FUNCTION pkg_json_account.f_modify_account_info(pv_user character varying, pv_session character varying, pc_json jsonb) TO s_ac;

GRANT EXECUTE ON FUNCTION pkg_json_account.f_modify_account_role(pv_user character varying, pv_session character varying, pc_json jsonb) TO s_ac;

GRANT EXECUTE ON FUNCTION pkg_json_account.f_modify_action(pv_user character varying, pv_session character varying, pc_json jsonb) TO s_ac;

GRANT EXECUTE ON FUNCTION pkg_json_account.f_modify_action_role(pv_user character varying, pv_session character varying, pc_json jsonb) TO s_ac;

GRANT EXECUTE ON FUNCTION pkg_json_account.f_modify_d_info(pv_user character varying, pv_session character varying, pc_json jsonb) TO s_ac;

GRANT EXECUTE ON FUNCTION pkg_json_account.f_modify_role(pv_user character varying, pv_session character varying, pc_json jsonb) TO s_ac;

GRANT EXECUTE ON FUNCTION pkg_json_account.f_modify_role_account(pv_user character varying, pv_session character varying, pc_json jsonb) TO s_ac;

GRANT EXECUTE ON FUNCTION pkg_json_account.f_modify_role_action(pv_user character varying, pv_session character varying, pc_json jsonb) TO s_ac;

GRANT ALL ON SEQUENCE public.seq_log TO s_ap;

GRANT ALL ON SEQUENCE public.seq_action TO s_ap;

GRANT SELECT ON TABLE public.dual TO s_ac;

GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE public.dual TO s_ap;

GRANT SELECT ON TABLE s_at.t_account TO s_ac;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_at.t_account TO s_ap;

GRANT SELECT ON TABLE s_at.t_account_ext TO s_ac;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_at.t_account_ext TO s_ap;

GRANT SELECT ON TABLE s_at.t_account_info TO s_ac;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_at.t_account_info TO s_ap;

GRANT SELECT ON TABLE s_at.t_account_role TO s_ac;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_at.t_account_role TO s_ap;

GRANT SELECT ON TABLE s_at.t_action TO s_ac;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_at.t_action TO s_ap;

GRANT SELECT ON TABLE s_at.t_d_info TO s_ac;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_at.t_d_info TO s_ap;

GRANT SELECT ON TABLE s_at.t_log TO s_ac;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_at.t_log TO s_ap;

GRANT SELECT ON TABLE s_at.t_role TO s_ac;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_at.t_role TO s_ap;

GRANT SELECT ON TABLE s_at.t_role_action TO s_ac;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE s_at.t_role_action TO s_ap;