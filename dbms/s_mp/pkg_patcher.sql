--liquibase formatted sql
--changeset artemov_i:pkg_patcher dbms:postgresql runOnChange:true splitStatements:false stripComments:false
DROP SCHEMA IF EXISTS pkg_patcher cascade;

CREATE SCHEMA pkg_patcher AUTHORIZATION s_mp;

CREATE OR REPLACE FUNCTION pkg_patcher.p_clear_attr(pv_class character varying, pj_json jsonb)
 RETURNS void
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'pkg_patcher', 's_mt', 'public'
AS $function$
declare
  vot_class_attr record;
begin
  for vot_class_attr in (select attr.ck_id, a.ck_attr_type
                           from s_mt.t_class_attr attr
                           join s_mt.t_attr a
                             on attr.ck_attr = a.ck_id
                          where attr.ck_class = pv_class and attr.ck_attr not in
                                (select value
                                   from jsonb_array_elements_text(pj_json))) loop
    if vot_class_attr.ck_attr_type = 'basic' then
      delete from s_mt.t_page_object_attr pa
       where pa.ck_class_attr = vot_class_attr.ck_id;
      delete from s_mt.t_object_attr oa
       where oa.ck_class_attr = vot_class_attr.ck_id;
      delete from s_mt.t_class_attr ca
       where ca.ck_id = vot_class_attr.ck_id;
    end if;
    if vot_class_attr.ck_attr_type = 'system' then
      delete from s_mt.t_class_attr ca
       where ca.ck_id = vot_class_attr.ck_id;
    end if;
    if vot_class_attr.ck_attr_type = 'placement' then
      delete from s_mt.t_class_hierarchy ch
       where ch.ck_class_attr = vot_class_attr.ck_id;
      delete from s_mt.t_class_attr ca
       where ca.ck_id = vot_class_attr.ck_id;
    end if;
    if vot_class_attr.ck_attr_type = 'behavior' then
      delete from s_mt.t_page_object_attr pa
       where pa.ck_class_attr = vot_class_attr.ck_id;
      delete from s_mt.t_class_attr ca
       where ca.ck_id = vot_class_attr.ck_id;
    end if;
  end loop;
end;
$function$
;

COMMENT ON FUNCTION pkg_patcher.p_clear_attr(pv_class character varying, pj_json jsonb) IS 'Очищаем от удаленных атрибутов';

CREATE OR REPLACE FUNCTION pkg_patcher.p_merge_object(pk_id character varying, pk_class character varying, pk_parent character varying, pv_name character varying, pn_order bigint, pk_query character varying, pv_description character varying, pv_displayed character varying, pv_modify character varying, pk_provider character varying, pk_user character varying, pt_change timestamp with time zone)
 RETURNS void
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'pkg', 'pkg_patcher', 's_mt'
AS $function$
declare
  -- переменные пакета
  gv_error sessvarstr;
begin
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');
  perform pkg.p_reset_response();
  update s_mt.t_object
     set (ck_class,
          ck_parent,
          cv_name,
          cn_order,
          ck_query,
          cv_description,
          cv_displayed,
          cv_modify,
          ck_provider,
          ck_user,
          ct_change) =
         (pk_class, pk_parent, pv_name, pn_order, pk_query, pv_description,
          pv_displayed, pv_modify, pk_provider, pk_user, pt_change)
   where ck_id = pk_id;
  if found then
    return;
  end if;
  --begin
    insert into s_mt.t_object
      (ck_id,
       ck_class,
       ck_parent,
       cv_name,
       cn_order,
       ck_query,
       cv_description,
       cv_displayed,
       cv_modify,
       ck_provider,
       ck_user,
       ct_change)
    values
      (pk_id,
       pk_class,
       pk_parent,
       pv_name,
       pn_order,
       pk_query,
       pv_description,
       pv_displayed,
       pv_modify,
       pk_provider,
       pk_user,
       pt_change) on conflict
      (ck_id) do update set ck_class = excluded.ck_class, ck_parent = excluded.ck_parent, cv_name = excluded.cv_name, cn_order = excluded.cn_order, ck_query = excluded.ck_query, cv_description = excluded.cv_description, cv_displayed = excluded.cv_displayed, cv_modify = excluded.cv_modify, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
  /*exception
    when others then
      perform pkg.p_set_error(1000, SQLERRM);
      perform pkg_log.p_save('-11',
                             null::varchar,
                             jsonb_build_object('ck_id',
                                                pk_id,
                                                'ck_class',
                                                pk_class,
                                                'ck_parent',
                                                pk_parent,
                                                'cv_name',
                                                pv_name,
                                                'cn_order',
                                                pn_order,
                                                'ck_query',
                                                pk_query,
                                                'cv_description',
                                                pv_description,
                                                'cv_displayed',
                                                pv_displayed,
                                                'cv_modify',
                                                pv_modify,
                                                'ck_provider',
                                                pk_provider,
                                                'ck_user',
                                                pk_user,
                                                'ct_change',
                                                pt_change),
                             't_object',
                             pk_id,
                             'u');
  end;*/
END;
$function$
;

COMMENT ON FUNCTION pkg_patcher.p_merge_object(pk_id character varying, pk_class character varying, pk_parent character varying, pv_name character varying, pn_order bigint, pk_query character varying, pv_description character varying, pv_displayed character varying, pv_modify character varying, pk_provider character varying, pk_user character varying, pt_change timestamp with time zone) IS 'Обновление объектов';

CREATE OR REPLACE FUNCTION pkg_patcher.p_merge_object_attr(pk_id character varying, pk_object character varying, pk_class_attr character varying, pv_value character varying, pk_user character varying, pt_change timestamp with time zone)
 RETURNS void
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'pkg', 'pkg_patcher', 's_mt'
AS $function$
declare
  -- переменные пакета
  gv_error sessvarstr;
begin
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');
  perform pkg.p_reset_response();
  UPDATE s_mt.t_object_attr
     SET (ck_object, ck_class_attr, cv_value, ck_user, ct_change) =
         (pk_object, pk_class_attr, pv_value, pk_user, pt_change)
   where ck_id = pk_id or (ck_object = pk_object and ck_class_attr = pk_class_attr);
  if found then
    return;
  end if;
  begin
    INSERT INTO s_mt.t_object_attr
      (ck_id, ck_object, ck_class_attr, cv_value, ck_user, ct_change)
      VALUES (pk_id, pk_object, pk_class_attr, pv_value, pk_user, pt_change)
    ON CONFLICT ON CONSTRAINT cin_c_object_attr_1 do update set ck_object = excluded.ck_object, ck_class_attr = excluded.ck_class_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
  exception
    when others then
      perform pkg.p_set_error(51, SQLERRM);
      perform pkg_log.p_save('-11',
                             null::varchar,
                             jsonb_build_object('ck_id', pk_id, 'ck_object', pk_object, 'ck_class_attr', pk_class_attr, 'cv_value', pv_value, 'ck_user', pk_user, 'ct_change', pt_change),
                             't_object_attr',
                             pk_id,
                             'u');
  end;
END;
$function$
;

COMMENT ON FUNCTION pkg_patcher.p_merge_object_attr(varchar,varchar,varchar,varchar,varchar,timestamptz) IS 'Обновление атрибутов объекта';
