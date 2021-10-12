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

--гранты на выполнение

GRANT SELECT ON TABLE public.dual TO s_mc;

GRANT ALL ON SEQUENCE public.seq_log TO s_mp;

GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE public.dual TO s_mp;

SELECT pkg_patcher.p_change_role_connect_user('${user.connect}', '${user.table}');

SELECT pkg_patcher.p_change_role_update_user('${user.update}', '${user.table}');

--на update
GRANT SELECT, UPDATE ON TABLE s_mt.t_notification TO s_mc;
