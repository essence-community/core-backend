--liquibase formatted sql
--changeset artemov_i:pkg_json_util dbms:postgresql runOnChange:true splitStatements:false stripComments:false
DROP SCHEMA IF EXISTS pkg_json_util cascade;

CREATE SCHEMA pkg_json_util
    AUTHORIZATION s_mp;


ALTER SCHEMA pkg_json_util OWNER TO s_mp;

CREATE FUNCTION pkg_json_util.f_check_string_is_percentage(pv_string character varying) RETURNS integer
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO pkg, pkg_json_util, public
    AS $$
declare
  vn_res integer;
begin
  vn_res = pkg_util.f_check_string_is_percentage(pv_string);
  return vn_res;
end;
$$;


ALTER FUNCTION pkg_json_util.f_check_string_is_percentage(pv_string character varying) OWNER TO s_mp;

CREATE FUNCTION pkg_json_util.f_string_to_rows(pv_string character varying) RETURNS public.ct_varchar
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pkg, pkg_json_util
    AS $$
declare
  vv_str ct_varchar;
begin
  vv_str = pkg_util.f_string_to_rows(pv_string);
  return vv_str;
end;
$$;


ALTER FUNCTION pkg_json_util.f_string_to_rows(pv_string character varying) OWNER TO s_mp;
