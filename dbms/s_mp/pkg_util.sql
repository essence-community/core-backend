--liquibase formatted sql
--changeset artemov_i:pkg_util dbms:postgresql runOnChange:true splitStatements:false stripComments:false
DROP SCHEMA IF EXISTS pkg_util cascade;

CREATE SCHEMA pkg_util
    AUTHORIZATION s_mp;


ALTER SCHEMA pkg_util OWNER TO s_mp;

CREATE FUNCTION pkg_util.f_check_string_is_percentage(pv_string character varying) RETURNS integer
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_util', 'public'
    AS $$
begin
    if right(pv_string, 1) = '%' /* has a percentage sign */
       and cast(substring(pv_string from 1 for (char_length(pv_string) - 1)) as numeric) between 1 and 100 /* within right range */
       and trunc(cast(substring(pv_string from 1 for (char_length(pv_string) - 1)) as numeric)) = cast(substring(pv_string from 1 for (char_length(pv_string) - 1)) as numeric) /* integer */
     then 
     return 1;
    end if;
    return 0;
  exception
    when others then
      return 0;
end;
$$;


ALTER FUNCTION pkg_util.f_check_string_is_percentage(pv_string character varying) OWNER TO s_mp;

CREATE FUNCTION pkg_util.f_get_global_from_string(pv_string character varying DEFAULT NULL::character varying, pv_attr character varying DEFAULT NULL::character varying) RETURNS public.ct_varchar
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$declare
  res ct_varchar;
begin
  res := '{}'::ct_varchar;
  if pv_string is not null then
    begin
      select array_agg(coalesce(t.res[1], t.res[2])) as global
        into strict res
        from (select 1 as lvl,
                     regexp_matches(pv_string,
                                    '(?!\w|").([g][A-z_0-9]+)|^([g][A-z_0-9]+)',
                                    'gi') as res) as t;
    exception
    	when others then
    		return res;
    end;
  end if;
  return res;
end;$$;


ALTER FUNCTION pkg_util.f_get_global_from_string(pv_string character varying, pv_attr character varying) OWNER TO s_mp;

CREATE FUNCTION pkg_util.f_string_to_rows(pv_string character varying, pv_delimeter character varying DEFAULT ','::character varying) RETURNS public.ct_varchar
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_util', 'public'
    AS $$
begin
  return regexp_split_to_array(pv_string, pv_delimeter)::ct_varchar;
end;
$$;


ALTER FUNCTION pkg_util.f_string_to_rows(pv_string character varying, pv_delimeter character varying) OWNER TO s_mp;
