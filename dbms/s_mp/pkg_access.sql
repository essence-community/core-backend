--liquibase formatted sql
--changeset artemov_i:pkg_access dbms:postgresql runOnChange:true splitStatements:false stripComments:false
DROP SCHEMA IF EXISTS pkg_access cascade;

CREATE SCHEMA pkg_access
    AUTHORIZATION s_mp;


ALTER SCHEMA pkg_access OWNER TO s_mp;

CREATE FUNCTION pkg_access.p_check_access(pv_user character varying, pk_main character varying DEFAULT NULL::character varying) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
begin
  null;
end;
$$;


ALTER FUNCTION pkg_access.p_check_access(pv_user character varying, pk_main character varying) OWNER TO s_mp;
