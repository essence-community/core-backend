--liquibase formatted sql
--changeset artemov_i:pkg_patcher dbms:postgresql runOnChange:true splitStatements:false stripComments:false
DROP SCHEMA IF EXISTS pkg_patcher cascade;

CREATE SCHEMA pkg_patcher AUTHORIZATION ${user.update};

CREATE OR REPLACE FUNCTION pkg_patcher.p_clear_attr(pv_class character varying, pj_json jsonb)
 RETURNS void
 LANGUAGE plpgsql

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

 SET search_path TO 'public', 'pkg', 'pkg_patcher', 's_mt'
AS $function$
declare
  -- переменные пакета
  gv_error sessvarstr;

  rec record;
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
  begin
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
  exception
    when others then
      RAISE NOTICE 'SQLSTATE: %', SQLSTATE;
      if SQLSTATE = '23505' then
        if nullif(pk_parent, '') is not null and pn_order is not null then
          for rec in (
              select ck_id from s_mt.t_object where ck_parent = pk_parent and cn_order = pn_order and ck_id <> pk_id
            ) loop
              raise exception 'The updated ("%") object has the same cn_order as the ("%") object. To continue you should change the cn_order or remove the old object and restart update.', pk_id, rec.ck_id;
          end loop;
        end if;
        raise;
      else
       raise;
      end if;
  end;
END;
$function$
;

COMMENT ON FUNCTION pkg_patcher.p_merge_object(pk_id character varying, pk_class character varying, pk_parent character varying, pv_name character varying, pn_order bigint, pk_query character varying, pv_description character varying, pv_displayed character varying, pv_modify character varying, pk_provider character varying, pk_user character varying, pt_change timestamp with time zone) IS 'Обновление объектов';

CREATE OR REPLACE FUNCTION pkg_patcher.p_merge_object_attr(pk_id character varying, pk_object character varying, pk_class_attr character varying, pv_value character varying, pk_user character varying, pt_change timestamp with time zone, pv_attr character varying DEFAULT NULL::character varying)
 RETURNS void
 LANGUAGE plpgsql

 SET search_path TO 'public', 'pkg', 'pkg_patcher', 's_mt'
AS $function$
declare
  -- переменные пакета
  gv_error sessvarstr;
  vv_class_id varchar := pk_class_attr;
  vv_value varchar := pv_value;
begin
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');
  perform pkg.p_reset_response();

  if pv_attr = 'orderproperty' then
    vv_value := jsonb_build_array(jsonb_build_object('property', pv_value, 'direction', 'ASC'))::text;
    select ca.ck_id 
      into vv_class_id
      from s_mt.t_class_attr ca
     where ca.ck_class in (select to2.ck_class from s_mt.t_object to2 where to2.ck_id = pk_object)
       and ca.ck_attr = 'order';
  end if;
 
  if pv_attr = 'orderdirection' then
    select ca.ck_id 
      into vv_class_id
      from s_mt.t_class_attr ca
     where ca.ck_class in (select to2.ck_class from s_mt.t_object to2 where to2.ck_id = pk_object)
       and ca.ck_attr = 'order';
      
    select jsonb_build_array(jsonb_build_object('property', cv_value::jsonb#>>'{0,property}', 'direction', pv_value))::text
      into vv_value
      from s_mt.t_object_attr oa
     where oa.ck_object  = pk_object
       and oa.ck_class_attr = vv_class_id;
  end if;

  UPDATE s_mt.t_object_attr
     SET (ck_object, ck_class_attr, cv_value, ck_user, ct_change) =
         (pk_object, vv_class_id, vv_value, pk_user, pt_change)
   where ck_id = pk_id;
  
  if found then
    return;
  end if;

  select ck_id 
    into vv_class_id
  from s_mt.t_class_attr where ck_id = vv_class_id;

  if vv_class_id is null and pv_attr is not null then
    select ck_id 
      into vv_class_id
    from s_mt.t_class_attr where ck_class in (select ck_class from s_mt.t_object where ck_id = pk_object) and ck_attr = pv_attr;
  
    UPDATE s_mt.t_object_attr
      SET (ck_object, cv_value, ck_user, ct_change) =
          (pk_object, vv_value, pk_user, pt_change)
    where ck_class_attr = vv_class_id;
  
    if found then
      return;
    end if;
  elsif vv_class_id is null and pv_attr is null then
    perform pkg.p_set_error(51, 'Not found attr');
    perform pkg_log.p_save('-11',
                             null::varchar,
                             jsonb_build_object('ck_id', pk_id, 'ck_object', pk_object, 'ck_class_attr', pk_class_attr, 'cv_value', pv_value, 'ck_user', pk_user, 'ct_change', pt_change, 'ck_attr', pv_attr),
                             't_object_attr',
                             pk_id,
                             'u');
    return;
  end if;

  
  begin
    INSERT INTO s_mt.t_object_attr
      (ck_id, ck_object, ck_class_attr, cv_value, ck_user, ct_change)
      VALUES (pk_id, pk_object, vv_class_id, vv_value, pk_user, pt_change)
    ON CONFLICT ON CONSTRAINT cin_c_object_attr_1 do update set ck_object = excluded.ck_object, ck_class_attr = excluded.ck_class_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
  exception
    when others then
      perform pkg.p_set_error(51, SQLERRM);
      perform pkg_log.p_save('-11',
                             null::varchar,
                             jsonb_build_object('ck_id', pk_id, 'ck_object', pk_object, 'ck_class_attr', pk_class_attr, 'cv_value', pv_value, 'ck_user', pk_user, 'ct_change', pt_change, 'ck_attr', pv_attr),
                             't_object_attr',
                             pk_id,
                             'u');
  end;
END;
$function$
;

COMMENT ON FUNCTION pkg_patcher.p_merge_object_attr(varchar,varchar,varchar,varchar,varchar,timestamptz,varchar) IS 'Обновление атрибутов объекта';

CREATE OR REPLACE FUNCTION pkg_patcher.p_merge_page_object_attr(pk_id character varying, pk_page_object character varying, pk_class_attr character varying, pv_value character varying, pk_user character varying, pt_change timestamp with time zone, pv_attr character varying DEFAULT NULL::character varying)
 RETURNS void
 LANGUAGE plpgsql

 SET search_path TO 'public', 'pkg', 'pkg_patcher', 's_mt'
AS $function$
declare
  -- переменные пакета
  gv_error sessvarstr;
  vv_class_id varchar := pk_class_attr;
  vv_value varchar := pv_value;
begin
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');
  perform pkg.p_reset_response();

  if pv_attr = 'orderproperty' then
    vv_value := jsonb_build_array(jsonb_build_object('property', pv_value, 'direction', 'ASC'))::text;
    select ca.ck_id 
      into vv_class_id
      from s_mt.t_class_attr ca
     where ca.ck_class in (select to2.ck_class from s_mt.t_object to2 where to2.ck_id in (select tpo2.ck_object from s_mt.t_page_object tpo2 where tpo2.ck_id = pk_page_object))
       and ca.ck_attr = 'order';
  end if;
 
  if pv_attr = 'orderdirection' then
    select ca.ck_id 
      into vv_class_id
      from s_mt.t_class_attr ca
     where ca.ck_class in (select to2.ck_class from s_mt.t_object to2 where to2.ck_id in (select tpo2.ck_object from s_mt.t_page_object tpo2 where tpo2.ck_id = pk_page_object))
       and ca.ck_attr = 'order';
      
    select jsonb_build_array(jsonb_build_object('property', cv_value::jsonb#>>'{0,property}', 'direction', pv_value))::text
      into vv_value
      from s_mt.t_object_attr oa
     where oa.ck_object  = pk_object
       and oa.ck_class_attr = vv_class_id;
  end if;

  UPDATE s_mt.t_page_object_attr
     SET (ck_page_object, ck_class_attr, cv_value, ck_user, ct_change) =
         (vv_class_id, pk_class_attr, vv_value, pk_user, pt_change)
   where ck_id = pk_id;
  
  if found then
    return;
  end if;

  select ck_id 
    into vv_class_id
  from s_mt.t_class_attr where ck_id = pk_class_attr;


  if vv_class_id is null and pv_attr is not null then
    select ck_id 
      into vv_class_id
    from s_mt.t_class_attr 
    where (ck_class in (
      select ob.ck_class 
      from s_mt.t_page_object p_ob
      join s_mt.t_object ob
      on p_ob.ck_object = ob.ck_id
    where p_ob.ck_id = pk_page_object) and ck_attr = pv_attr);

    UPDATE s_mt.t_page_object_attr
      SET (ck_page_object, cv_value, ck_user, ct_change) =
          (pk_page_object, vv_value, pk_user, pt_change)
    where ck_class_attr = vv_class_id;
  
    if found then
      return;
    end if;
  elsif vv_class_id is null and pv_attr is null then
    perform pkg.p_set_error(51, 'Not found attr');
    perform pkg_log.p_save('-11',
                             null::varchar,
                             jsonb_build_object('ck_id', pk_id, 'ck_page_object', pk_page_object, 'ck_class_attr', pk_class_attr, 'cv_value', pv_value, 'ck_user', pk_user, 'ct_change', pt_change, 'ck_attr', pv_attr),
                             't_page_object_attr',
                             pk_id,
                             'u');
    return;
  end if;

  
  begin
    INSERT INTO s_mt.t_page_object_attr
      (ck_id, ck_page_object, ck_class_attr, cv_value, ck_user, ct_change)
      VALUES (pk_id, pk_page_object, vv_class_id, vv_value, pk_user, pt_change)
    ON CONFLICT ON CONSTRAINT cin_c_page_object_attr_1 do update set ck_page_object = excluded.ck_page_object, ck_class_attr = excluded.ck_class_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
  exception
    when others then
      perform pkg.p_set_error(51, SQLERRM);
      perform pkg_log.p_save('-11',
                             null::varchar,
                             jsonb_build_object('ck_id', pk_id, 'ck_page_object', pk_page_object, 'ck_class_attr', pk_class_attr, 'cv_value', pv_value, 'ck_user', pk_user, 'ct_change', pt_change, 'ck_attr', pv_attr),
                             't_page_object_attr',
                             pk_id,
                             'u');
  end;
END;
$function$
;

COMMENT ON FUNCTION pkg_patcher.p_merge_page_object_attr(varchar,varchar,varchar,varchar,varchar,timestamptz,varchar) IS 'Обновление атрибутов page объекта';

CREATE OR REPLACE FUNCTION pkg_patcher.p_update_localization()
 RETURNS void
 LANGUAGE plpgsql

 SET search_path TO 'pkg_patcher', 's_mt', 'public'
AS $function$
declare
  vot_rec record;
  pot_localization s_mt.t_localization;
begin
  select ck_id
    into pot_localization.ck_d_lang
  from t_d_lang where cl_default = 1;
  -- Локализация t_message
  for vot_rec in (select m.ck_id, m.cv_text, array_agg(l2.ck_id) as ck_local
                           from s_mt.t_message m
                           full outer join s_mt.t_localization l
                             on m.cv_text = l.ck_id
                           left join s_mt.t_localization l2
                             on m.cv_text = l2.cv_value and l2.cr_namespace = 'message'
                           where l.ck_id is null and nullif(m.cv_text, '') is not null
                           group by m.ck_id, m.cv_text
                          ) loop
    if vot_rec.ck_local is null or cardinality(vot_rec.ck_local) = 0 or vot_rec.ck_local[1] is null then
      pot_localization.cr_namespace = 'message';
      pot_localization.cv_value = vot_rec.cv_text;
      pot_localization.ck_user = '-11';
      pot_localization.ct_change = CURRENT_TIMESTAMP;
      pot_localization.ck_id = null;
      pot_localization := pkg_localization.p_modify_localization('I', pot_localization);
    else 
      pot_localization.ck_id := vot_rec.ck_local[1];
    end if;
    UPDATE s_mt.t_message
    set cv_text = pot_localization.ck_id
    where ck_id = vot_rec.ck_id;
  end loop;
  -- Локализация object attr
  for vot_rec in (select attr.ck_id, attr.cv_value, array_agg(l2.ck_id) as ck_local
                    from (select ck_id, cv_value from s_mt.t_object_attr where ck_class_attr in (select att.ck_id from s_mt.t_class_attr att where att.ck_attr in ('confirmquestion', 'info', 'tipmsg'))) as attr
                    full outer join s_mt.t_localization l
                    on attr.cv_value = l.ck_id
                    left join s_mt.t_localization l2
                    on attr.cv_value = l2.cv_value and l2.cr_namespace = 'meta'
                    where l.ck_id is null and nullif(attr.cv_value, '') is not null
                    group by attr.ck_id, attr.cv_value
                    ) loop
    if vot_rec.ck_local is null or cardinality(vot_rec.ck_local) = 0 or vot_rec.ck_local[1] is null then
      pot_localization.cr_namespace = 'meta';
      pot_localization.cv_value = vot_rec.cv_value;
      pot_localization.ck_user = '-11';
      pot_localization.ct_change = CURRENT_TIMESTAMP;
      pot_localization.ck_id = null;
      pot_localization := pkg_localization.p_modify_localization('I', pot_localization);
    else 
      pot_localization.ck_id := vot_rec.ck_local[1];
    end if;
    UPDATE s_mt.t_object_attr
    set cv_value = pot_localization.ck_id
    where ck_id = vot_rec.ck_id;
  end loop;
  -- Локализация page object attr
  for vot_rec in (select attr.ck_id, attr.cv_value, array_agg(l2.ck_id) as ck_local
                    from (select ck_id, cv_value from s_mt.t_page_object_attr where ck_class_attr in (select att.ck_id from s_mt.t_class_attr att where att.ck_attr in ('confirmquestion', 'info', 'tipmsg'))) as attr
                    full outer join s_mt.t_localization l
                    on attr.cv_value = l.ck_id
                    left join s_mt.t_localization l2
                    on attr.cv_value = l2.cv_value and l2.cr_namespace = 'meta'
                    where l.ck_id is null and nullif(attr.cv_value, '') is not null
                    group by attr.ck_id, attr.cv_value
                    ) loop
    if vot_rec.ck_local is null or cardinality(vot_rec.ck_local) = 0 or vot_rec.ck_local[1] is null then
      pot_localization.cr_namespace = 'meta';
      pot_localization.cv_value = vot_rec.cv_value;
      pot_localization.ck_user = '-11';
      pot_localization.ct_change = CURRENT_TIMESTAMP;
      pot_localization.ck_id = null;
      pot_localization := pkg_localization.p_modify_localization('I', pot_localization);
    else 
      pot_localization.ck_id := vot_rec.ck_local[1];
    end if;
    UPDATE s_mt.t_page_object_attr
    set cv_value = pot_localization.ck_id
    where ck_id = vot_rec.ck_id;
  end loop;
  -- Локализация class attr
  for vot_rec in (select attr.ck_id, attr.cv_value, array_agg(l2.ck_id) as ck_local
                    from (select att.ck_id, att.cv_value from s_mt.t_class_attr att where att.ck_attr in ('confirmquestion', 'info', 'tipmsg')) as attr
                    full outer join s_mt.t_localization l
                    on attr.cv_value = l.ck_id
                    left join s_mt.t_localization l2
                    on attr.cv_value = l2.cv_value and l2.cr_namespace = 'meta'
                    where l.ck_id is null and nullif(attr.cv_value, '') is not null
                    group by attr.ck_id, attr.cv_value
                    ) loop
    if vot_rec.ck_local is null or cardinality(vot_rec.ck_local) = 0 or vot_rec.ck_local[1] is null then
      pot_localization.cr_namespace = 'meta';
      pot_localization.cv_value = vot_rec.cv_value;
      pot_localization.ck_user = '-11';
      pot_localization.ct_change = CURRENT_TIMESTAMP;
      pot_localization.ck_id = null;
      pot_localization := pkg_localization.p_modify_localization('I', pot_localization);
    else 
      pot_localization.ck_id := vot_rec.ck_local[1];
    end if;
    UPDATE s_mt.t_class_attr
    set cv_value = pot_localization.ck_id
    where ck_id = vot_rec.ck_id;
  end loop;
   -- Локализация cv_displayed
  for vot_rec in (select o.ck_id, o.cv_displayed, array_agg(l2.ck_id) as ck_local
                    from s_mt.t_object o
                    full outer join s_mt.t_localization l
                    on o.cv_displayed = l.ck_id
                    left join s_mt.t_localization l2
                    on o.cv_displayed = l2.cv_value and l2.cr_namespace = 'meta'
                    where l.ck_id is null and nullif(o.cv_displayed, '') is not null
                    group by o.ck_id, o.cv_displayed
                    ) loop
    if vot_rec.ck_local is null or cardinality(vot_rec.ck_local) = 0 or vot_rec.ck_local[1] is null then
      pot_localization.cr_namespace = 'meta';
      pot_localization.cv_value = vot_rec.cv_displayed;
      pot_localization.ck_user = '-11';
      pot_localization.ct_change = CURRENT_TIMESTAMP;
      pot_localization.ck_id = null;
      pot_localization := pkg_localization.p_modify_localization('I', pot_localization);
    else 
      pot_localization.ck_id := vot_rec.ck_local[1];
    end if;
    UPDATE s_mt.t_object
    set cv_displayed = pot_localization.ck_id
    where ck_id = vot_rec.ck_id;
  end loop;
  -- Локализация page cv_name
  for vot_rec in (select p.ck_id, p.cv_name, array_agg(l2.ck_id) as ck_local
                    from s_mt.t_page p
                    full outer join s_mt.t_localization l
                    on p.cv_name = l.ck_id
                    left join s_mt.t_localization l2
                    on p.cv_name = l2.cv_value and l2.cr_namespace = 'meta'
                    where l.ck_id is null and nullif(p.cv_name, '') is not null
                    group by p.ck_id, p.cv_name
                    ) loop
    if vot_rec.ck_local is null or cardinality(vot_rec.ck_local) = 0 or vot_rec.ck_local[1] is null then
      pot_localization.cr_namespace = 'meta';
      pot_localization.cv_value = vot_rec.cv_name;
      pot_localization.ck_user = '-11';
      pot_localization.ct_change = CURRENT_TIMESTAMP;
      pot_localization.ck_id = null;
      pot_localization := pkg_localization.p_modify_localization('I', pot_localization);
    else 
      pot_localization.ck_id := vot_rec.ck_local[1];
    end if;
    UPDATE s_mt.t_page
    set cv_name = pot_localization.ck_id
    where ck_id = vot_rec.ck_id;
  end loop;
end;
$function$
;

COMMENT ON FUNCTION pkg_patcher.p_update_localization() IS 'Перевод атрибутов и параметров в локализыцию';

CREATE OR REPLACE FUNCTION pkg_patcher.p_remove_page(pk_page character varying)
 RETURNS void
 LANGUAGE plpgsql

 SET search_path TO 'public', 'pkg', 'pkg_patcher', 's_mt'
AS $function$
declare
  -- переменные пакета
  ot_page record;

  ot_page_object record;

  rec record;

  vv_clean VARCHAR := 'false';
begin
  SELECT cv_value
    into vv_clean
  from s_mt.t_sys_setting
    where ck_id = 'clearing_object_during_update';

  for ot_page in (
    with recursive page as (
      select
        ck_id,
        1 as lvl
      from
        s_mt.t_page
      where
        ck_id = pk_page
      union all
      select
        p.ck_id,
        rp.lvl + 1 as lvl
      from
        s_mt.t_page p
      join page rp on
        p.ck_parent = rp.ck_id )
    select ck_id from page order by lvl desc
  ) loop

    -- Removing t_page_object
    for ot_page_object in (
        with recursive page_object as (
          select
            ck_id,
            ck_object,
            1 as lvl
          from
            s_mt.t_page_object
          where
            ck_page = ot_page.ck_id and ck_parent is null
          union all
          select
            p.ck_id,
            p.ck_object,
            rp.lvl + 1 as lvl
          from
            s_mt.t_page_object p
          join page_object rp on
            p.ck_parent = rp.ck_id )
        select ck_id, ck_object from page_object order by lvl desc
    ) loop
      update s_mt.t_page_object set ck_master = null where ck_master = ot_page_object.ck_id;
      delete from s_mt.t_page_object_attr where ck_page_object = ot_page_object.ck_id;
      delete from s_mt.t_page_object where ck_id = ot_page_object.ck_id;

      if vv_clean = 'true' THEN
        -- check use object
        for rec in (
          select
              1
          from
              dual
           where
              not exists (
                select
                  ck_id
                from
                  s_mt.t_page_object
                where
                  ck_object in (with recursive ot_object as (
                  select
                    ck_id,
                    1 as lvl
                  from
                    s_mt.t_object
                  where
                    ck_id = ot_page_object.ck_object
                union all
                  select
                    o.ck_id,
                    ro.lvl + 1 as lvl
                  from
                    s_mt.t_object o
                  join ot_object ro on
                    o.ck_parent = ro.ck_id )
                  select
                    ck_id
                  from
                    ot_object
                  order by
                    lvl asc) 
              )
        ) loop
          delete from s_mt.t_object_attr where ck_object in (
            with recursive ot_object as (
                select
                  ck_id,
                  1 as lvl
                from
                  s_mt.t_object
                where
                  ck_id = ot_page_object.ck_object
              union all
                select
                  o.ck_id,
                  ro.lvl + 1 as lvl
                from
                  s_mt.t_object o
                join ot_object ro on
                  o.ck_parent = ro.ck_id )
            select
              ck_id
            from
              ot_object
             order by
                lvl desc
          );
          delete from s_mt.t_object where ck_id in (
            with recursive ot_object as (
                select
                  ck_id,
                  1 as lvl
                from
                  s_mt.t_object
                where
                  ck_id = ot_page_object.ck_object
              union all
                select
                  o.ck_id,
                  ro.lvl + 1 as lvl
                from
                  s_mt.t_object o
                join ot_object ro on
                  o.ck_parent = ro.ck_id )
            select
              ck_id
            from
              ot_object
            order by
              lvl desc
          );
        end loop;
      end if;
    end loop;

    -- Clearing page action 
    delete
    from
      s_mt.t_page_action ap
    where ap.ck_page = ot_page.ck_id 
    and not exists (select 1 
              from jsonb_array_elements_text(coalesce(nullif((select cv_value 
                  from s_mt.t_sys_setting 
                  where ck_id = 'skip_update_action_page'), ''), '[]')::jsonb) as t 
                where t.value = ot_page.ck_id);

    -- Clearing page variable

    delete
    from
      s_mt.t_page_variable ap
    where ap.ck_page = ot_page.ck_id;

    -- Remove attr page
    delete from s_mt.t_page_attr where ck_page = ot_page.ck_id;

    -- Removing page

    delete 
    from 
      s_mt.t_page
    where ck_id = ot_page.ck_id
    and not exists (select 1 
              from jsonb_array_elements_text(coalesce(nullif((select cv_value 
                  from s_mt.t_sys_setting 
                  where ck_id = 'skip_update_action_page'), ''), '[]')::jsonb) as t 
                where t.value = ot_page.ck_id);
    
  end loop;

  -- Added info history update
  INSERT INTO s_mt.t_page_update_history (ck_id, ct_change)
  VALUES(pk_page, CURRENT_TIMESTAMP);
END;
$function$
;

COMMENT ON FUNCTION pkg_patcher.p_remove_page(varchar) IS 'Удаляем страницу/модуль/каталог и все привязки';

CREATE OR REPLACE FUNCTION pkg_patcher.p_remove_only_page(pk_page character varying)
 RETURNS void
 LANGUAGE plpgsql

 SET search_path TO 'public', 'pkg', 'pkg_patcher', 's_mt'
AS $function$
declare
  -- переменные пакета
  ot_page_object record;

  rec record;

  vv_clean VARCHAR := 'false';
begin
  SELECT cv_value
    into vv_clean
  from s_mt.t_sys_setting
    where ck_id = 'clearing_object_during_update';

  -- Removing t_page_object
  for ot_page_object in (
      with recursive page_object as (
        select
          ck_id,
          ck_object,
          1 as lvl
        from
          s_mt.t_page_object
        where
          ck_page = pk_page and ck_parent is null
        union all
        select
          p.ck_id,
          p.ck_object,
          rp.lvl + 1 as lvl
        from
          s_mt.t_page_object p
        join page_object rp on
          p.ck_parent = rp.ck_id )
      select ck_id, ck_object from page_object order by lvl desc
  ) loop
    update s_mt.t_page_object set ck_master = null where ck_master = ot_page_object.ck_id;
    delete from s_mt.t_page_object_attr where ck_page_object = ot_page_object.ck_id;
    delete from s_mt.t_page_object where ck_id = ot_page_object.ck_id;

    if vv_clean = 'true' THEN
      -- check use object
      for rec in (
        select
            1
        from
            dual
          where
            not exists (
              select
                ck_id
              from
                s_mt.t_page_object
              where
                ck_object in (with recursive ot_object as (
                select
                  ck_id,
                  1 as lvl
                from
                  s_mt.t_object
                where
                  ck_id = ot_page_object.ck_object
              union all
                select
                  o.ck_id,
                  ro.lvl + 1 as lvl
                from
                  s_mt.t_object o
                join ot_object ro on
                  o.ck_parent = ro.ck_id )
                select
                  ck_id
                from
                  ot_object
                order by
                  lvl asc) 
            )
      ) loop
        delete from s_mt.t_object_attr where ck_object in (
          with recursive ot_object as (
              select
                ck_id,
                1 as lvl
              from
                s_mt.t_object
              where
                ck_id = ot_page_object.ck_object
            union all
              select
                o.ck_id,
                ro.lvl + 1 as lvl
              from
                s_mt.t_object o
              join ot_object ro on
                o.ck_parent = ro.ck_id )
          select
            ck_id
          from
            ot_object
            order by
              lvl desc
        );
        delete from s_mt.t_object where ck_id in (
          with recursive ot_object as (
              select
                ck_id,
                1 as lvl
              from
                s_mt.t_object
              where
                ck_id = ot_page_object.ck_object
            union all
              select
                o.ck_id,
                ro.lvl + 1 as lvl
              from
                s_mt.t_object o
              join ot_object ro on
                o.ck_parent = ro.ck_id )
          select
            ck_id
          from
            ot_object
          order by
            lvl desc
        );
      end loop;
    end if;
  end loop;

  -- Clearing page action 
  delete
  from
    s_mt.t_page_action ap
  where ap.ck_page = pk_page 
  and not exists (select 1 
            from jsonb_array_elements_text(coalesce(nullif((select cv_value 
                from s_mt.t_sys_setting 
                where ck_id = 'skip_update_action_page'), ''), '[]')::jsonb) as t 
              where t.value = pk_page);

  -- Clearing page variable

  delete
  from
    s_mt.t_page_variable ap
  where ap.ck_page = pk_page;

  -- Remove attr page
  delete from s_mt.t_page_attr where ck_page = pk_page;

  -- Removing page

  delete 
  from 
    s_mt.t_page p
  where p.ck_id = pk_page
  and not exists (select 1 
            from jsonb_array_elements_text(coalesce(nullif((select cv_value 
                from s_mt.t_sys_setting 
                where ck_id = 'skip_update_action_page'), ''), '[]')::jsonb) as t 
              where t.value = p.ck_id)
  and not exists (select 1 
                    s_mt.t_page tp
                  where tp.ck_parent = p.ck_id);

  -- Added info history update
  INSERT INTO s_mt.t_page_update_history (ck_id, ct_change)
  VALUES(pk_page, CURRENT_TIMESTAMP);
END;
$function$
;

COMMENT ON FUNCTION pkg_patcher.p_remove_only_page(varchar) IS 'Удаляем страницу/модуль/каталог и все привязки';

CREATE OR REPLACE FUNCTION pkg_patcher.p_delete_dup_localization()
 RETURNS void
 LANGUAGE plpgsql
 SET search_path TO 'pkg_patcher', 's_mt', 'public'
AS $function$
declare
  vot_loc record;
  vv_id varchar;
  pot_localization s_mt.t_localization;
begin
  for vot_loc in (select
                    cv_value,
                    ck_d_lang
                  from
                    s_mt.t_localization tl
                  join s_mt.t_d_lang tdl on
                    tl.ck_d_lang = tdl.ck_id
                  where
                    tdl.cl_default = 1 and tl.cr_namespace = 'meta'
                  group by
                    cv_value,
                    ck_d_lang
                  having
                    count(*)>1
                    ) loop
    -- First create uniq
    select 
      t.ck_id
    into strict vv_id
      from (
        select 
          ck_id,
          row_number() over (order by(ct_change) asc) as cn_rn
        from s_mt.t_localization
        where cv_value = vot_loc.cv_value and ck_d_lang = vot_loc.ck_d_lang and cr_namespace = 'meta'
      ) t
    where t.cn_rn = 1;
    
    for pot_localization in (
      select * from s_mt.t_localization
        where cv_value = vot_loc.cv_value and ck_d_lang = vot_loc.ck_d_lang and cr_namespace = 'meta' and ck_id <> vv_id
    ) loop
      -- page object attr
      UPDATE s_mt.t_page_object_attr
        set cv_value = vv_id
      where cv_value = pot_localization.ck_id;
      -- object attr
      UPDATE s_mt.t_object_attr
        set cv_value = vv_id
      where cv_value = pot_localization.ck_id;
      -- class attr
      UPDATE s_mt.t_class_attr
        set cv_value = vv_id
      where cv_value = pot_localization.ck_id;
      -- cv_displayed
      UPDATE s_mt.t_object
        set cv_displayed = vv_id
      where cv_displayed = pot_localization.ck_id;
      -- page cv_name
      UPDATE s_mt.t_page
        set cv_name = vv_id
      where cv_name = pot_localization.ck_id;
      -- Remove dup
      delete 
        from s_mt.t_localization 
      where ck_id = pot_localization.ck_id;
    end loop;
  end loop;
end;
$function$
;

COMMENT ON FUNCTION pkg_patcher.p_delete_dup_localization() IS 'Очищаем от дублей';

CREATE FUNCTION pkg_patcher.p_modify_patch(pv_action character varying, INOUT pot_create_patch s_mt.t_create_patch) RETURNS s_mt.t_create_patch
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_patcher', 's_mt', 'public'
    AS $$
declare
  -- переменные пакета
  i sessvarstr;
  u sessvarstr;
  d sessvarstr;

  gv_error sessvarstr;

  -- переменные функции
begin
    -- инициализация/получение переменных пакета
    i = sessvarstr_declare('pkg', 'i', 'I');
    u = sessvarstr_declare('pkg', 'u', 'U');
    d = sessvarstr_declare('pkg', 'd', 'D');
    gv_error = sessvarstr_declare('pkg', 'gv_error', '');

    if pv_action = d::varchar then
        delete from s_mt.t_create_patch where ck_id = pot_create_patch.ck_id;
        return;
    end if;
    if nullif(gv_error::varchar, '') is not null then
   	    return;
    end if;
    if pv_action = i::varchar then
      if pot_create_patch.ck_id is null then
        pot_create_patch.ck_id := uuid_generate_v4();
      end if;
      insert into s_mt.t_create_patch values (pot_create_patch.*);
    elsif pv_action = u::varchar then
      update s_mt.t_create_patch set
        (cv_file_name, ck_user, ct_change) = (pot_create_patch.cv_file_name, pot_create_patch.ck_user, pot_create_patch.ct_change)
      where ck_id = pot_create_patch.ck_id;
      if not found then
        perform pkg.p_set_error(504);
      end if;
    end if;
end;
$$;

ALTER FUNCTION pkg_patcher.p_modify_patch(pv_action character varying, INOUT pot_create_patch s_mt.t_create_patch) OWNER TO ${user.update};

CREATE FUNCTION pkg_patcher.p_lock_patch(pk_id uuid) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 's_mt', 'pkg_patcher', 'public'
    AS $$
declare
  vn_lock bigint;
begin
  if pk_id is not null then
    select 1 into vn_lock from s_mt.t_create_patch where ck_id = pk_id for update nowait;
  end if;
end;
$$;

ALTER FUNCTION pkg_patcher.p_lock_patch(pk_id uuid) OWNER TO ${user.update};

CREATE OR REPLACE FUNCTION pkg_patcher.p_find_static_in_meta_localization()
 RETURNS void
 LANGUAGE plpgsql
 SET search_path TO 'pkg_patcher', 's_mt', 'public'
AS $function$
declare
  vv_id varchar;
  pot_localization s_mt.t_localization;
begin  
  for pot_localization in (
      select 
          distinct tl.*
      from
        s_mt.t_localization tl
      left join s_mt.t_page p on
        tl.ck_id = p.cv_name
      left join s_mt.t_object o on
        tl.ck_id = o.cv_displayed
      left join s_mt.t_page_object_attr poa on
        tl.ck_id = poa.cv_value
      left join s_mt.t_object_attr oa on
        tl.ck_id = oa.cv_value
      left join s_mt.t_class_attr ca on
        tl.ck_id = ca.cv_value
      where
        tl.cr_namespace = 'static'
        and (p.cv_name is not null
        or o.cv_displayed is not null
        or poa.cv_value is not null
        or oa.cv_value is not null
        or ca.cv_value is not null)
  ) loop
      vv_id := lower(sys_guid());
      -- page object attr
      UPDATE s_mt.t_page_object_attr
        set cv_value = vv_id
      where cv_value = pot_localization.ck_id;
      -- object attr
      UPDATE s_mt.t_object_attr
        set cv_value = vv_id
      where cv_value = pot_localization.ck_id;
      -- class attr
      UPDATE s_mt.t_class_attr
        set cv_value = vv_id
      where cv_value = pot_localization.ck_id;
      -- cv_displayed
      UPDATE s_mt.t_object
        set cv_displayed = vv_id
      where cv_displayed = pot_localization.ck_id;
      -- page cv_name
      UPDATE s_mt.t_page
        set cv_name = vv_id
      where cv_name = pot_localization.ck_id;
      -- New string
      INSERT INTO s_mt.t_localization
        (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)
      VALUES (vv_id, pot_localization.ck_d_lang, 'meta', pot_localization.cv_value, pot_localization.ck_user, CURRENT_TIMESTAMP);
  end loop;
end;
$function$
;

COMMENT ON FUNCTION pkg_patcher.p_find_static_in_meta_localization() IS 'Разделяем статичные атрибуты с meta';

CREATE OR REPLACE FUNCTION pkg_patcher.p_merge_page_action(pk_id character varying, pk_page character varying, pr_type character varying, pn_action bigint, pk_user character varying, pt_change timestamp with time zone)
 RETURNS void
 LANGUAGE plpgsql
 SET search_path TO 'public', 'pkg', 'pkg_patcher', 's_mt'
AS $function$
declare
  -- переменные пакета
  gv_error sessvarstr;

  rec record;
begin
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');
  perform pkg.p_reset_response();
  for rec in ( select 1 
              from jsonb_array_elements_text(coalesce(nullif((select cv_value 
                  from s_mt.t_sys_setting 
                  where ck_id = 'skip_update_action_page'), ''), '[]')::jsonb) as t 
                where t.value = pk_page
              ) loop
    return;
  end loop;
  update s_mt.t_page_action
     set (ck_page, cr_type, cn_action, ck_user, ct_change) =
         (pk_page, pr_type, pn_action, pk_user, pt_change)
   where ck_id = pk_id;
  if found then
    return;
  end if;
  update s_mt.t_page_action
     set (ck_id, cn_action, ck_user, ct_change) =
         (ck_id, pn_action, pk_user, pt_change)
   where ck_page = pk_page and cr_type = pr_type;
  if found then
    return;
  end if;
  begin
    insert into s_mt.t_page_action
      (ck_id, ck_page, cr_type, cn_action, ck_user, ct_change)
    values
      (pk_id, pk_page, pr_type, pn_action, pk_user, pt_change) on conflict
      (ck_id) do update set ck_page = excluded.ck_page, cr_type = excluded.cr_type, cn_action = excluded.cn_action, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
  exception
    when others then
      perform pkg.p_set_error(51, SQLERRM);
      perform pkg_log.p_save('-11',
                             null::varchar,
                             jsonb_build_object('ck_id', pk_id, 'ck_page', pk_page, 'cr_type', pr_type, 'cn_action', pn_action, 'ck_user', pk_user, 'ct_change', pt_change),
                             'pkg_patcher.p_merge_page_action',
                             pk_id,
                             'I');
  end;
END;
$function$
;

COMMENT ON FUNCTION pkg_patcher.p_merge_page_action(pk_id character varying, pk_page character varying, pr_type character varying, pn_action bigint, pk_user character varying, pt_change timestamp with time zone) IS 'Обновление доступов страницы';


CREATE FUNCTION pkg_patcher.p_change_role_connect_user(pv_connect_user VARCHAR, pv_table_schema VARCHAR) RETURNS void
    LANGUAGE plpgsql
    SET search_path TO '${user.table}', 'pkg_patcher', 'public'
    AS $$
declare
  rec record;
begin
  for rec in (select 'GRANT USAGE ON SCHEMA ' || nspname || ' TO ' || pv_connect_user || ';' as alter_cmd 
    from pg_catalog.pg_namespace 
    where lower(nspname) like 'pkg_json_%') loop
    EXECUTE rec.alter_cmd;
  end loop;
  
  EXECUTE format('GRANT USAGE ON SCHEMA %s TO %s', pv_table_schema, pv_connect_user);

  for rec in (select
    'GRANT SELECT ON TABLE ' || schemaname || '.' || tablename || ' TO ' || pv_connect_user || ';' as alter_cmd 
    from
        pg_catalog.pg_tables
    where
    lower(schemaname) = lower(pv_table_schema)) loop
    EXECUTE rec.alter_cmd;
  end loop;

  for rec in (select
    'GRANT EXECUTE ON FUNCTION ' || nsp.nspname || '.' || p.proname || '(' || pg_get_function_identity_arguments(p.oid)|| ') TO ' || pv_connect_user || ';' as alter_cmd 
    from
        pg_proc p
    join pg_namespace nsp on
        p.pronamespace = nsp.oid
    where
        lower(nsp.nspname) like 'pkg_json_%') loop
    EXECUTE rec.alter_cmd;
  end loop;
end;
$$;

CREATE FUNCTION pkg_patcher.p_change_role_update_user(pv_update_user VARCHAR, pv_table_schema VARCHAR) RETURNS void
    LANGUAGE plpgsql
    SET search_path TO '${user.table}', 'pkg_patcher', 'public'
    AS $$
declare
  rec record;
begin
  for rec in (select 'ALTER SCHEMA ' || nspname || ' OWNER TO ' || pv_update_user || ';' as alter_cmd 
    from pg_catalog.pg_namespace 
    where lower(nspname) like 'pkg_%') loop
    EXECUTE rec.alter_cmd;
  end loop;

  EXECUTE format('GRANT USAGE ON SCHEMA %s TO %s', pv_table_schema, pv_update_user);

  for rec in (select
    'GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE ' || schemaname || '.' || tablename || ' TO ' || pv_update_user || ';' as alter_cmd 
    from
        pg_catalog.pg_tables
    where
    lower(schemaname) = lower(pv_table_schema)) loop
    EXECUTE rec.alter_cmd;
  end loop;

  for rec in (select
    'ALTER FUNCTION ' || nsp.nspname || '.' || p.proname || '(' || pg_get_function_identity_arguments(p.oid)|| ') OWNER TO ' || pv_update_user || ';'  as alter_cmd
    from
        pg_proc p
    join pg_namespace nsp on
        p.pronamespace = nsp.oid
    where
        lower(nsp.nspname) like 'pkg_%') loop
    EXECUTE rec.alter_cmd;
  end loop;
end;
$$;