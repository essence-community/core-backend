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

CREATE OR REPLACE FUNCTION pkg_patcher.p_update_localization()
 RETURNS void
 LANGUAGE plpgsql
 SECURITY DEFINER
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
  for vot_rec in (select m.ck_id, m.cv_text, l2.ck_id as ck_local
                           from s_mt.t_message m
                           full outer join s_mt.t_localization l
                             on m.cv_text = l.ck_id
                           left join s_mt.t_localization l2
                             on m.cv_text = l2.cv_value and l2.cr_namespace = 'message'
                           where l.ck_id is null and nullif(m.cv_text, '') is not null
                          ) loop
    if vot_rec.ck_local is null then
      pot_localization.cr_namespace = 'message';
      pot_localization.cv_value = vot_rec.cv_text;
      pot_localization.ck_user = '-11';
      pot_localization.ct_change = CURRENT_TIMESTAMP;
      pot_localization.ck_id = null;
      pot_localization := pkg_localization.p_modify_localization('I', pot_localization);
    else 
      pot_localization.ck_id := vot_rec.ck_local;
    end if;
    UPDATE s_mt.t_message
    set cv_text = pot_localization.ck_id
    where ck_id = vot_rec.ck_id;
  end loop;
  select ck_id
    into pot_localization.ck_d_lang
  from t_d_lang where cl_default = 1;
  -- Локализация object attr
  for vot_rec in (select attr.ck_id, attr.cv_value, l2.ck_id as ck_local
                    from (select ck_id, cv_value from s_mt.t_object_attr where ck_class_attr in (select att.ck_id from s_mt.t_class_attr att where att.ck_attr in ('confirmquestion', 'info', 'tipmsg'))) as attr
                    full outer join s_mt.t_localization l
                    on attr.cv_value = l.ck_id
                    left join s_mt.t_localization l2
                    on attr.cv_value = l2.cv_value and l2.cr_namespace = 'meta'
                    where l.ck_id is null and nullif(attr.cv_value, '') is not null) loop
    if vot_rec.ck_local is null then
      pot_localization.cr_namespace = 'meta';
      pot_localization.cv_value = vot_rec.cv_value;
      pot_localization.ck_user = '-11';
      pot_localization.ct_change = CURRENT_TIMESTAMP;
      pot_localization.ck_id = null;
      pot_localization := pkg_localization.p_modify_localization('I', pot_localization);
    else 
      pot_localization.ck_id := vot_rec.ck_local;
    end if;
    UPDATE s_mt.t_object_attr
    set cv_value = pot_localization.ck_id
    where ck_id = vot_rec.ck_id;
  end loop;
  -- Локализация page object attr
  for vot_rec in (select attr.ck_id, attr.cv_value, l2.ck_id as ck_local
                    from (select ck_id, cv_value from s_mt.t_page_object_attr where ck_class_attr in (select att.ck_id from s_mt.t_class_attr att where att.ck_attr in ('confirmquestion', 'info', 'tipmsg'))) as attr
                    full outer join s_mt.t_localization l
                    on attr.cv_value = l.ck_id
                    left join s_mt.t_localization l2
                    on attr.cv_value = l2.cv_value and l2.cr_namespace = 'meta'
                    where l.ck_id is null and nullif(attr.cv_value, '') is not null) loop
    if vot_rec.ck_local is null then
      pot_localization.cr_namespace = 'meta';
      pot_localization.cv_value = vot_rec.cv_value;
      pot_localization.ck_user = '-11';
      pot_localization.ct_change = CURRENT_TIMESTAMP;
      pot_localization.ck_id = null;
      pot_localization := pkg_localization.p_modify_localization('I', pot_localization);
    else 
      pot_localization.ck_id := vot_rec.ck_local;
    end if;
    UPDATE s_mt.t_page_object_attr
    set cv_value = pot_localization.ck_id
    where ck_id = vot_rec.ck_id;
  end loop;
  -- Локализация class attr
  for vot_rec in (select attr.ck_id, attr.cv_value, l2.ck_id as ck_local
                    from (select att.ck_id, att.cv_value from s_mt.t_class_attr att where att.ck_attr in ('confirmquestion', 'info', 'tipmsg')) as attr
                    full outer join s_mt.t_localization l
                    on attr.cv_value = l.ck_id
                    left join s_mt.t_localization l2
                    on attr.cv_value = l2.cv_value and l2.cr_namespace = 'meta'
                    where l.ck_id is null and nullif(attr.cv_value, '') is not null) loop
    if vot_rec.ck_local is null then
      pot_localization.cr_namespace = 'meta';
      pot_localization.cv_value = vot_rec.cv_value;
      pot_localization.ck_user = '-11';
      pot_localization.ct_change = CURRENT_TIMESTAMP;
      pot_localization.ck_id = null;
      pot_localization := pkg_localization.p_modify_localization('I', pot_localization);
    else 
      pot_localization.ck_id := vot_rec.ck_local;
    end if;
    UPDATE s_mt.t_class_attr
    set cv_value = pot_localization.ck_id
    where ck_id = vot_rec.ck_id;
  end loop;
   -- Локализация cv_displayed
  for vot_rec in (select o.ck_id, o.cv_displayed, l2.ck_id as ck_local
                    from s_mt.t_object o
                    full outer join s_mt.t_localization l
                    on o.cv_displayed = l.ck_id
                    left join s_mt.t_localization l2
                    on o.cv_displayed = l2.cv_value and l2.cr_namespace = 'meta'
                    where l.ck_id is null and nullif(o.cv_displayed, '') is not null) loop
    if vot_rec.ck_local is null then
      pot_localization.cr_namespace = 'meta';
      pot_localization.cv_value = vot_rec.cv_displayed;
      pot_localization.ck_user = '-11';
      pot_localization.ct_change = CURRENT_TIMESTAMP;
      pot_localization.ck_id = null;
      pot_localization := pkg_localization.p_modify_localization('I', pot_localization);
    else 
      pot_localization.ck_id := vot_rec.ck_local;
    end if;
    UPDATE s_mt.t_object
    set cv_displayed = pot_localization.ck_id
    where ck_id = vot_rec.ck_id;
  end loop;
  -- Локализация page cv_name
  for vot_rec in (select p.ck_id, p.cv_name, l2.ck_id as ck_local
                    from s_mt.t_page p
                    full outer join s_mt.t_localization l
                    on p.cv_name = l.ck_id
                    left join s_mt.t_localization l2
                    on p.cv_name = l2.cv_value and l2.cr_namespace = 'meta'
                    where l.ck_id is null and nullif(p.cv_name, '') is not null) loop
    if vot_rec.ck_local is null then
      pot_localization.cr_namespace = 'meta';
      pot_localization.cv_value = vot_rec.cv_name;
      pot_localization.ck_user = '-11';
      pot_localization.ct_change = CURRENT_TIMESTAMP;
      pot_localization.ck_id = null;
      pot_localization := pkg_localization.p_modify_localization('I', pot_localization);
    else 
      pot_localization.ck_id := vot_rec.ck_local;
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
 SECURITY DEFINER
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
    where ap.ck_page = ot_page.ck_id;

    -- Clearing page variable

    delete
    from
      s_mt.t_page_variable ap
    where ap.ck_page = ot_page.ck_id;

    -- Removing page

    delete 
    from 
      s_mt.t_page
    where ck_id = ot_page.ck_id;
  end loop;
END;
$function$
;

COMMENT ON FUNCTION pkg_patcher.p_remove_page(varchar) IS 'Удаляем страницу/модуль/каталог и все привязки';