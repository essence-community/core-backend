--liquibase formatted sql
--changeset artemov_i:grants dbms:postgresql runAlways:true runOnChange:true splitStatements:false stripComments:false
--гранты на использование

GRANT USAGE ON SCHEMA pkg_json_user TO ${user.connect};

GRANT USAGE ON SCHEMA pkg_json_patcher TO ${user.connect};

GRANT USAGE ON SCHEMA ${user.table} TO ${user.connect};

GRANT USAGE ON SCHEMA public TO ${user.update};

GRANT USAGE ON SCHEMA ${user.table} TO ${user.update};

--гранты на выполнение

GRANT EXECUTE ON FUNCTION pkg_json_user.f_get_context(pv_attribute character varying) TO ${user.connect};

GRANT EXECUTE ON FUNCTION pkg_json_user.f_modify_user(pc_json jsonb, pv_hash character varying) TO ${user.connect};

GRANT EXECUTE ON FUNCTION pkg_json_user.f_modify_user_action(pc_json jsonb, pv_hash character varying) TO ${user.connect};

GRANT EXECUTE ON FUNCTION pkg_json_user.f_modify_user_department(pc_json jsonb, pv_hash character varying) TO ${user.connect};

GRANT EXECUTE ON FUNCTION pkg_json_patcher.f_modify_patch(pv_user character varying, pk_session character varying, pc_json jsonb) TO ${user.connect};

GRANT ALL ON SEQUENCE public.seq_log TO ${user.update};

GRANT SELECT ON TABLE public.dual TO ${user.connect};

GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE public.dual TO ${user.update};

GRANT SELECT ON TABLE ${user.table}.t_log TO ${user.connect};

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE ${user.table}.t_log TO ${user.update};

GRANT SELECT ON TABLE ${user.table}.t_create_patch TO ${user.connect};

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE ${user.table}.t_create_patch TO ${user.update};
