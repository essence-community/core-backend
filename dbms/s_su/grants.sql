--liquibase formatted sql
--changeset artemov_i:grants dbms:postgresql runOnChange:true runAlways:true splitStatements:false stripComments:false
--гранты на использование

GRANT USAGE ON SCHEMA pkg_json_user TO ${user.connect};

GRANT USAGE ON SCHEMA pkg_json TO ${user.connect};

GRANT USAGE ON SCHEMA pkg_json_semaphore TO ${user.connect};

GRANT USAGE ON SCHEMA pkg_json_meta TO ${user.connect};

GRANT USAGE ON SCHEMA pkg_json_notification TO ${user.connect};

GRANT USAGE ON SCHEMA pkg_json_scenario TO ${user.connect};

GRANT USAGE ON SCHEMA pkg_json_util TO ${user.connect};

GRANT USAGE ON SCHEMA pkg_json_report TO ${user.connect};

GRANT USAGE ON SCHEMA pkg_json_localization TO ${user.connect};

GRANT USAGE ON SCHEMA pkg_json_patcher TO ${user.connect};

GRANT USAGE ON SCHEMA s_mt TO ${user.connect};

GRANT USAGE ON SCHEMA public TO ${user.connect};

GRANT USAGE ON SCHEMA public TO ${user.update};

GRANT USAGE ON SCHEMA s_mt TO ${user.update};

--гранты на выполнение

GRANT SELECT ON TABLE public.dual TO ${user.connect};

GRANT ALL ON SEQUENCE public.seq_log TO ${user.update};

GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE public.dual TO ${user.update};

SELECT pkg_patcher.p_change_role_connect_user('${user.connect}', '${user.table}');

SELECT pkg_patcher.p_change_role_update_user('${user.update}', '${user.table}');

--на update
GRANT SELECT, UPDATE ON TABLE s_mt.t_notification TO ${user.connect};
