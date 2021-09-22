--liquibase formatted sql
--changeset artemov_i:pkg_meta dbms:postgresql runOnChange:true splitStatements:false stripComments:false
DROP SCHEMA IF EXISTS pkg_meta cascade;

CREATE SCHEMA pkg_meta
   AUTHORIZATION s_mp;


ALTER SCHEMA pkg_meta OWNER TO s_mp;

CREATE FUNCTION pkg_meta.p_check_separator(pv_action character varying, pot_page_object_attr s_mt.t_page_object_attr, pot_object_attr s_mt.t_object_attr, pot_class_attr s_mt.t_class_attr) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_meta', 'public'
    AS $$
declare
  -- переменные пакета
  d sessvarstr;
  -- переменные функции
  vcur record;
begin
  -- инициализация/получение переменных пакета
  d = sessvarstr_declare('pkg', 'd', 'D');

  -- код функции
      for vcur in (with t_separator as
                    (select ca.ck_class,
                           coalesce(o.ck_id, '0') as ck_object,
                           coalesce(po.ck_id, '0') as ck_page_object,
                           ca1.cv_value as class_value,
                           coalesce(ba.cv_value, ca1.cv_value) as object_value,
                           coalesce(pba.cv_value, ba.cv_value, ca1.cv_value) as page_value
                      from s_mt.t_class_attr ca
                      join s_mt.t_class_attr ca1 on ca1.ck_class = ca.ck_class
                                           and ca1.ck_attr = case
                                                 when ca.ck_attr = 'decimalseparator' then
                                                  'thousandseparator'
                                                 when ca.ck_attr = 'thousandseparator' then
                                                  'decimalseparator'
                                                 else
                                                  null
                                               end
                      join s_mt.t_class c on c.ck_id = ca1.ck_class
                      left join s_mt.t_object o on o.ck_class = ca1.ck_class
                      left join s_mt.t_object_attr ba on ba.ck_object = o.ck_id
                                                and ba.ck_class_attr = ca1.ck_id
                      left join s_mt.t_page_object po on po.ck_object = o.ck_id
                      left join s_mt.t_page_object_attr pba on pba.ck_page_object = po.ck_id
                                                      and pba.ck_class_attr = ca1.ck_id
                     where ca.ck_id = coalesce(pot_page_object_attr.ck_class_attr,
                                               pot_object_attr.ck_class_attr,
                                               pot_class_attr.ck_id)
                       and c.cv_name in ('Column Numeric', 'Field Numeric')),
                   t_parameter as
                    (select ca.ck_class,
                           coalesce(o.ck_id, '0') as ck_object,
                           coalesce(po.ck_id, '0') as ck_page_object,
                           coalesce(pot_class_attr.cv_value, ca.cv_value) as class_value,
                           coalesce(case
                                      when pot_object_attr.ck_id is null then
                                       coalesce(pot_object_attr.cv_value, ba.cv_value)
                                      else
                                       case
                                         when pv_action = d::varchar then
                                          null
                                         else
                                          pot_object_attr.cv_value
                                       end
                                    end,
                                    coalesce(pot_class_attr.cv_value, ca.cv_value)) as object_value,
                           coalesce(case
                                      when pot_page_object_attr.ck_id is null then
                                       coalesce(pot_page_object_attr.cv_value, pba.cv_value)
                                      else
                                       case
                                         when pv_action = d::varchar then
                                          null
                                         else
                                          pot_page_object_attr.cv_value
                                       end
                                    end,
                                    coalesce(case
                                              when pot_object_attr.ck_id is null then
                                               coalesce(pot_object_attr.cv_value, ba.cv_value)
                                              else
                                               case
                                                 when pv_action = d::varchar then
                                                  null
                                                 else
                                                  pot_object_attr.cv_value
                                               end
                                            end,
                                            coalesce(pot_class_attr.cv_value, ca.cv_value))) as page_value

                      from s_mt.t_class_attr ca
                      join s_mt.t_class c on c.ck_id = ca.ck_class
                      left join s_mt.t_object o on o.ck_class = ca.ck_class
                      left join s_mt.t_object_attr ba on ba.ck_object = o.ck_id
                                                and ba.ck_class_attr = ca.ck_id
                      left join s_mt.t_page_object po on po.ck_object = o.ck_id
                      left join s_mt.t_page_object_attr pba on pba.ck_page_object = po.ck_id
                                                      and pba.ck_class_attr = ca.ck_id
                     where ca.ck_id = coalesce(pot_page_object_attr.ck_class_attr,
                                               pot_object_attr.ck_class_attr,
                                               pot_class_attr.ck_id)
                       and c.cv_name in ('Column Numeric', 'Field Numeric')
                       and o.ck_id = coalesce(pot_object_attr.ck_object, o.ck_id)
                       and po.ck_id = coalesce(pot_page_object_attr.ck_page_object, po.ck_id)
                       and coalesce(ba.ck_id, '0') = coalesce(pot_object_attr.ck_id, ba.ck_id, '0')
                       and coalesce(pba.ck_id, '0') = coalesce(pot_page_object_attr.ck_id, pba.ck_id, '0'))
                   select 1
                     from t_parameter p
                     join t_separator s on p.ck_class = s.ck_class
                                       and p.ck_object = s.ck_object
                                       and p.ck_page_object = s.ck_page_object
                    where 1 = case
                            when p.page_value = s.page_value then
                             1
                            when p.object_value = s.object_value then
                             1
                            when p.class_value = s.class_value then
                             1
                            else
                             0
                          end) loop
      perform pkg.p_set_error(64);
      exit;
    end loop;
end;
$$;


ALTER FUNCTION pkg_meta.p_check_separator(pv_action character varying, pot_page_object_attr s_mt.t_page_object_attr, pot_object_attr s_mt.t_object_attr, pot_class_attr s_mt.t_class_attr) OWNER TO s_mp;

COMMENT ON FUNCTION pkg_meta.p_check_separator(pv_action character varying, pot_page_object_attr s_mt.t_page_object_attr, pot_object_attr s_mt.t_object_attr, pot_class_attr s_mt.t_class_attr) IS 'Значения атрибутов  decimalseparator и thousandseparator в классах Column Numeric и Field Numeric не могут совпадать';

/* Создание/обновление/удаление объекта t_object */
CREATE FUNCTION pkg_meta.p_copy_object(pk_id character varying, pk_parent character varying DEFAULT NULL::character varying) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_meta', 'public'
    AS $$
declare
  -- переменные пакета
  gv_error sessvarstr;

  -- переменные функции
  vct_copy_object public.ot_copy_object[];
  vn_user bigint; /* не забудь проверить, как в pkg_json_* вызван pkg.p_reset_response; */
  pcur_check record;
begin
  begin
    -- инициализация/получение переменных пакета
    gv_error = sessvarstr_declare('pkg', 'gv_error', '');

    -- код функции
    vn_user = sessvari_declare('pkg', 'gn_user', -1)::bigint;
    /* 0. Проверим возможность копирования */
    if pk_parent is not null then
      /* проверим с т.з. иерархии классов */
      for pcur_check in (
        select 1
        from dual
        where not exists (
          select 1
          from s_mt.t_class_hierarchy ch
          where ch.ck_class_child = (select ck_class from s_mt.t_object where ck_id = pk_id)
           and ch.ck_class_parent = (select ck_class from s_mt.t_object where ck_id = pk_parent))
      ) loop
        perform pkg.p_set_error(13);
      end loop;
    end if;

    if nullif(gv_error::varchar, '') is null then
      /* 1. Создадим коллекцию, содержащую все необходимые данные по объекту (включая дочерние объекты всех уровней) */
      select
        array_agg(
          row(
            ck_id_origin,
            ck_id_new,
            ck_class,
            ck_parent,
            cv_name,
            cn_order,
            ck_query,
            cv_description,
            cv_displayed,
            cv_modify,
            ck_provider,
            cn_level
          )::ot_copy_object
        )
      into
        vct_copy_object
      from(
        with recursive
          t(ck_id_origin, ck_id_new, ck_class, ck_parent,
            cv_name, cn_order, ck_query, cv_description,
            cv_displayed, cv_modify, ck_provider, cn_level
          )as(
            select
              a.ck_id as ck_id_origin,
              sys_guid() as ck_id_new,
              a.ck_class,
              pk_parent as ck_parent_new, -- при null parent, копируем в root
              a.cv_name,
              a.cn_order,
              a.ck_query,
              a.cv_description,
              a.cv_displayed,
              a.cv_modify,
              a.ck_provider,
              1 as cn_level
            from s_mt.t_object a
            where a.ck_id = pk_id

            union all

            select
              b.ck_id as ck_id_origin,
              sys_guid() as ck_id_new,
              b.ck_class,
              cast(t.ck_id_new as varchar(32)) as ck_parent_new,
              b.cv_name,
              b.cn_order,
              b.ck_query,
              b.cv_description,
              b.cv_displayed,
              b.cv_modify,
              b.ck_provider,
              t.cn_level + 1
            from s_mt.t_object b
            inner join t
              on b.ck_parent = t.ck_id_origin
          )

          select t.*
          from t
          order by t.cn_level, t.cv_name
      ) as q;

      /* 2. Создадим новые объекты */
      insert into s_mt.t_object(
        ck_id,
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
        ct_change
      )
      select
        t.ck_id_new,
        t.ck_class,
        t.ck_parent,
        'COPY of ' || t.cv_name,
        -- При копировании под текущей парент, добавляем к cn_order 100, если под новый парент, то оставляем cn_order как есть
        coalesce((select max(cn_order)+100 from s_mt.t_object where ck_parent = t.ck_parent), t.cn_order) as cn_order,
        t.ck_query,
        t.cv_description,
        t.cv_displayed,
        t.cv_modify,
        t.ck_provider,
        vn_user,
        CURRENT_TIMESTAMP
      from unnest(vct_copy_object) as t;
      /* 3. Скопируем переопределенные атрибуты с исходных объектов */
      insert into s_mt.t_object_attr(ck_id, ck_object, ck_class_attr, cv_value, ck_user, ct_change)
      select /*+ CARDINALITY(t 20) */
        sys_guid(),
        t.ck_id_new,
        oa.ck_class_attr,
        oa.cv_value,
        vn_user,
        CURRENT_TIMESTAMP
        from s_mt.t_object_attr oa
        join unnest(vct_copy_object) as t
          on t.ck_id_origin = oa.ck_object;
      --
    end if;
  end;
  exception
    when string_data_right_truncation then
       perform pkg.p_set_error(32);
end;
$$;


ALTER FUNCTION pkg_meta.p_copy_object(pk_id character varying, pk_parent character varying) OWNER TO s_mp;

COMMENT ON FUNCTION pkg_meta.p_copy_object(pk_id character varying, pk_parent character varying) IS 'Копирование объектов';

CREATE FUNCTION pkg_meta.p_modify_attr(pv_action character varying, INOUT pot_attr s_mt.t_attr) RETURNS s_mt.t_attr
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_meta', 'public'
    AS $$
declare
  -- переменные пакета
  i sessvarstr;
  u sessvarstr;
  d sessvarstr;
  gv_error sessvarstr;

  -- переменные функции
  pcur_type record;
  pcur_class_attr record;
begin
  -- инициализация/получение переменных пакета
  i = sessvarstr_declare('pkg', 'i', 'I');
  u = sessvarstr_declare('pkg', 'u', 'U');
  d = sessvarstr_declare('pkg', 'd', 'D');
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');

  -- код функции
  if pv_action = d::varchar then
    /*Проверки на удаление*/
    for pcur_class_attr in (select string_agg(cl.cv_name, ', ') as cv_name
                        from s_mt.t_class_attr cattr
                        join s_mt.t_class cl
                         on cattr.ck_class = cl.ck_id
                       where cattr.ck_attr = pot_attr.ck_id) loop
      if nullif(pcur_class_attr.cv_name, '') is not null then
      	perform pkg.p_set_error(51, 'Атрибут используется в ' || pcur_class_attr.cv_name);
     	return;
      end if;
    end loop;
    /*Удаление*/
    delete from s_mt.t_attr where ck_id = pot_attr.ck_id;
  else
    /* Блок "Проверка переданных данных" */
    if pot_attr.ck_id is null then
      perform pkg.p_set_error(2);
    end if;
    if pot_attr.cv_description is null then
      perform pkg.p_set_error(26);
    end if;
    if pot_attr.ck_attr_type is null then
      perform pkg.p_set_error(30);
    end if;
    for pcur_type in (select 1
                        from s_mt.t_attr_type att
                       where att.ck_id = pot_attr.ck_attr_type
                      having count(att.ck_id) = 0) loop
      perform pkg.p_set_error(37, 'meta:1938adda682e4c60a26b8eccfa7daff5'); /* Недопустимый тип атрибута, см. С_Тип атрибута */
    end loop;
    for pcur_type in (select 1
                        from s_mt.t_d_attr_data_type adt
                       where adt.ck_id = pot_attr.ck_d_data_type
                      having count(adt.ck_id) = 0) loop
      perform pkg.p_set_error(37, 'meta:fc586c6328d047cf92fb85c145d307a9'); /* Недопустимый тип атрибута, см. С_Тип атрибута */
    end loop;
    pot_attr.cv_data_type_extra := pkg_meta.p_decode_data_type_extra(pot_attr.cv_data_type_extra, pot_attr.ck_d_data_type);
    /* Наименование атрибута должно быть уникально */
    if pv_action = i::varchar then
      for pcur_type in (select 1
                        from s_mt.t_attr att
                       where att.ck_id = pot_attr.ck_id) loop
        perform pkg.p_set_error(68);
      end loop;
    end if;
    if nullif(gv_error::varchar, '') is not null then
       return;
    end if;
    /**/
    if pv_action = i::varchar then
      insert into s_mt.t_attr values (pot_attr.*);
    elsif pv_action = u::varchar then
      update s_mt.t_attr set
        (cv_description, ck_attr_type, ck_d_data_type, cv_data_type_extra, ck_user, ct_change) = 
        (pot_attr.cv_description, pot_attr.ck_attr_type, pot_attr.ck_d_data_type, pot_attr.cv_data_type_extra, pot_attr.ck_user, pot_attr.ct_change)
      where ck_id = pot_attr.ck_id;
      if not found then
        perform pkg.p_set_error(504);
      end if;
    end if;
  end if;
end;
$$;

ALTER FUNCTION pkg_meta.p_modify_attr(pv_action character varying, INOUT pot_attr s_mt.t_attr) OWNER TO s_mp;

COMMENT ON FUNCTION pkg_meta.p_modify_attr(pv_action character varying, INOUT pot_attr s_mt.t_attr) IS 'Создание/обновление/удаление атрибутов  t_attr';

CREATE FUNCTION pkg_meta.p_decode_data_type_extra(pv_value text, vk_data_type varchar, vl_class_attr smallint DEFAULT 0::smallint) RETURNS text
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 's_mt', 'pkg_meta', 'public'
    AS $$
declare

  -- переменные функции
  vv_value text;
  vl_extra smallint;
  v_rec record;
begin
  vv_value := pv_value;

  select cl_extra
    into strict vl_extra
  from s_mt.t_d_attr_data_type where ck_id = vk_data_type;

  if vl_extra <> 1 then
    RETURN NULL::text;
  end if;

  if vk_data_type = 'enum' then
      vv_value := nullif(nullif(trim(vv_value), ''), '[]');
      if vv_value is not null and vv_value like '%cv_data_type_extra_value%' then
        select (json_agg(value->>'cv_data_type_extra_value'))::text
        into vv_value
        from jsonb_array_elements(vv_value::jsonb);
      end if;
      if vl_class_attr = 0 and (vv_value is null or vv_value not like '[%]') then 
        perform pkg.p_set_error(37, 'meta:d22e05d47f7c42909a6c0086c11d4a5f');
        return vv_value;
      elsif vl_class_attr = 1 and vv_value is not null and vv_value not like '[%]' then
        return NULL::text;
      end if;
      return vv_value;
  end if;
  
  return vv_value;
end;
$$;

ALTER FUNCTION pkg_meta.p_decode_data_type_extra(text, varchar, smallint) OWNER TO s_mp;

COMMENT ON FUNCTION pkg_meta.p_decode_data_type_extra(text, varchar, smallint) IS 'Преобразование и проверка дополнительного типа';


CREATE FUNCTION pkg_meta.p_modify_class(pv_action character varying, INOUT pot_class s_mt.t_class, pl_new_id smallint DEFAULT 1::smallint) RETURNS s_mt.t_class
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_meta', 'public'
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

  -- код функции
  if pv_action = d::varchar then
    /*Проверки на удаление*/
    /*Удаление*/
    begin
      delete from s_mt.t_class_attr where ck_class = pot_class.ck_id;
      delete from s_mt.t_class_hierarchy where ck_class_child = pot_class.ck_id or ck_class_parent = pot_class.ck_id;
      delete from s_mt.t_class where ck_id = pot_class.ck_id;
    exception
      when integrity_constraint_violation then
        perform pkg.p_set_error(17);
    end;
  else
    /* Блок "Проверка переданных данных" */
    if pot_class.cv_name is null then
      perform pkg.p_set_error(2);
    end if;
    if pot_class.cl_final is null or pot_class.cl_final not in (0, 1) then
      perform pkg.p_set_error(18);
    end if;
    if pot_class.cl_dataset is null or pot_class.cl_dataset not in (0, 1) then
      perform pkg.p_set_error(19);
    end if;

    if pv_action = i::varchar and nullif(gv_error::varchar, '') is null then
      if pl_new_id = 1 then
        pot_class.ck_id := sys_guid();
      end if;
      insert into s_mt.t_class values (pot_class.*);
    elsif pv_action = u::varchar and nullif(gv_error::varchar, '') is null then

      if pot_class.cv_manual_documentation is not null then
        update s_mt.t_class set cv_manual_documentation = pot_class.cv_manual_documentation where ck_id = pot_class.ck_id;
      elsif pot_class.cv_auto_documentation is not null then
        update s_mt.t_class set cv_auto_documentation = pot_class.cv_auto_documentation where ck_id = pot_class.ck_id;
      else
        update s_mt.t_class set
          (cv_name, cv_description, cl_final, cl_dataset, ck_user, ct_change) = (pot_class.cv_name, pot_class.cv_description, pot_class.cl_final, pot_class.cl_dataset, pot_class.ck_user, pot_class.ct_change)
        where ck_id = pot_class.ck_id;
      end if;

      if not found then
        perform pkg.p_set_error(504);
      end if;
    end if;
    null;
  end if;
end;
$$;


ALTER FUNCTION pkg_meta.p_modify_class(pv_action character varying, INOUT pot_class s_mt.t_class, pl_new_id smallint) OWNER TO s_mp;

COMMENT ON FUNCTION pkg_meta.p_modify_class(pv_action character varying, INOUT pot_class s_mt.t_class, pl_new_id smallint) IS 'Создание/обновление/удаление классов t_class';

CREATE FUNCTION pkg_meta.p_modify_class_attr(pv_action character varying, INOUT pot_class_attr s_mt.t_class_attr) RETURNS s_mt.t_class_attr
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_meta', 'public'
    AS $$
declare
  -- переменные пакета
  i sessvarstr;
  u sessvarstr;
  d sessvarstr;
  gv_error sessvarstr;

  -- переменные функции
  vk_d_data_type VARCHAR;
  rec record;
begin
   -- инициализация/получение переменных пакета
  i = sessvarstr_declare('pkg', 'i', 'I');
  u = sessvarstr_declare('pkg', 'u', 'U');
  d = sessvarstr_declare('pkg', 'd', 'D');
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');

  -- код функции
  if pv_action = d::varchar then
    /*Проверки на удаление*/
    /*Удаление*/
    delete from s_mt.t_class_attr where ck_id = pot_class_attr.ck_id;
  else
    /* Блок "Проверка переданных данных" */
    if pot_class_attr.ck_attr is null then
      perform pkg.p_set_error(2);
    end if;
    if pot_class_attr.cl_required is null or pot_class_attr.cl_required not in (0, 1) then
      perform pkg.p_set_error(38);
    end if;
    if pot_class_attr.ck_attr in ('width', 'columnwidth', 'contentwidth') and nullif(trim(pot_class_attr.cv_value), '') is not null and 
       pkg_util.f_check_string_is_percentage(pot_class_attr.cv_value) = 0 then
      perform pkg.p_set_error(55);
    end if;
    
    select ck_d_data_type
      into vk_d_data_type
    from s_mt.t_attr where ck_id = pot_class_attr.ck_attr;
    
    pot_class_attr.cv_data_type_extra := pkg_meta.p_decode_data_type_extra(pot_class_attr.cv_data_type_extra, vk_d_data_type, 1::smallint);

    for rec in (
      select 1 
      from s_mt.t_attr 
      where ck_id = pot_class_attr.ck_attr and cv_data_type_extra = pot_class_attr.cv_data_type_extra
      ) loop
      pot_class_attr.cv_data_type_extra = NULL::text;
    end loop;

    /* значения атрибутов  decimalseparator и thousandseparator в классах Column Numeric и Field Numeric не могут совпадать */
    perform pkg_meta.p_check_separator(pv_action, null, null, pot_class_attr);    /* Сохранение/обновление данных */

    if nullif(gv_error::varchar, '') is not null then
       return;
    end if;

    if pv_action = i::varchar then
      pot_class_attr.ck_id := sys_guid();
      insert into s_mt.t_class_attr values (pot_class_attr.*);
    elsif pv_action = u::varchar then
      update s_mt.t_class_attr set
        (ck_class, ck_attr, cv_data_type_extra, cv_value, ck_user, ct_change, cl_required, cl_empty) = 
        (pot_class_attr.ck_class, pot_class_attr.ck_attr, pot_class_attr.cv_data_type_extra, pot_class_attr.cv_value, pot_class_attr.ck_user, pot_class_attr.ct_change, pot_class_attr.cl_required, pot_class_attr.cl_empty)
      where ck_id = pot_class_attr.ck_id;
      if not found then
        perform pkg.p_set_error(504);
      end if;
    end if;
    null;
  end if;
end;
$$;


ALTER FUNCTION pkg_meta.p_modify_class_attr(pv_action character varying, INOUT pot_class_attr s_mt.t_class_attr) OWNER TO s_mp;

COMMENT ON FUNCTION pkg_meta.p_modify_class_attr(pv_action character varying, INOUT pot_class_attr s_mt.t_class_attr) IS 'Создание/обновление/удаление настроек класса объекта  t_class_attr';

CREATE FUNCTION pkg_meta.p_modify_class_hierarchy(pv_action character varying, INOUT pot_class_hierarchy s_mt.t_class_hierarchy) RETURNS s_mt.t_class_hierarchy
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_meta', 'public'
    AS $$
declare
  -- переменные пакета
  i sessvarstr;
  u sessvarstr;
  d sessvarstr;
  gv_error sessvarstr;

  -- переменные функции
  pcur_check record;
  pcur_check_attr record;
begin
  -- инициализация/получение переменных пакета
  i = sessvarstr_declare('pkg', 'i', 'I');
  u = sessvarstr_declare('pkg', 'u', 'U');
  d = sessvarstr_declare('pkg', 'd', 'D');
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');

  -- код функции
  if pv_action = d::varchar then
    /*Проверки на удаление*/
    /*Удаление*/
    delete from s_mt.t_class_hierarchy where ck_id = pot_class_hierarchy.ck_id;
  else
    /* Проверка на принадлежность атрибута родительскому классу */
    for pcur_check in (
      select 1
      from dual
      where not exists (
        select 1
        from s_mt.t_class_attr a
        where a.ck_class = pot_class_hierarchy.ck_class_parent
         and a.ck_id = pot_class_hierarchy.ck_class_attr
      )
    )loop
      perform pkg.p_set_error(20);
    end loop;

    /* Проверка, что атрибут имеет тип "placement" */
    for pcur_check_attr in (select 1
                              from s_mt.t_class_attr ca
                              join s_mt.t_attr a on a.ck_id = ca.ck_attr
                             where ca.ck_class = pot_class_hierarchy.ck_class_parent
                               and ca.ck_id = pot_class_hierarchy.ck_class_attr
                               and a.ck_attr_type <> 'placement') loop
      perform pkg.p_set_error(66);
    end loop;

    if pv_action = i::varchar and nullif(gv_error::varchar, '') is null then
      pot_class_hierarchy.ck_id := sys_guid();
      insert into s_mt.t_class_hierarchy values (pot_class_hierarchy.*);
    elsif pv_action = u::varchar and nullif(gv_error::varchar, '') is null then
      update s_mt.t_class_hierarchy set
        (ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change) = row(pot_class_hierarchy.*)
      where ck_id = pot_class_hierarchy.ck_id;
      if not found then
        perform pkg.p_set_error(504);
      end if;
    end if;
    null;
  end if;
end;
$$;


ALTER FUNCTION pkg_meta.p_modify_class_hierarchy(pv_action character varying, INOUT pot_class_hierarchy s_mt.t_class_hierarchy) OWNER TO s_mp;

COMMENT ON FUNCTION pkg_meta.p_modify_class_hierarchy(pv_action character varying, INOUT pot_class_hierarchy s_mt.t_class_hierarchy) IS 'Создание/обновление/удаление дерева зависимостей класса объектов t_class_hierarchy';

CREATE FUNCTION pkg_meta.p_modify_module(pv_action character varying, INOUT pot_module s_mt.t_module) RETURNS s_mt.t_module
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_meta', 'public'
    AS $$
declare
  -- переменные пакета
  i sessvarstr;
  u sessvarstr;
  d sessvarstr;
  gv_error sessvarstr;
  -- переменные функции
  vct_attr            public.ot_attr[];
  vot_class_hierarchy s_mt.t_class_hierarchy;
  vot_class_attr      s_mt.t_class_attr;
  vot_class           s_mt.t_class;
  vot_attr            s_mt.t_attr;
  vv_id varchar(32);
  vcur record;
  vcur1 record;
  vcur_class record;
  vcheck_class record;
  vc record;
  vn_count bigint := 0;
  vl_new_id smallint := 0;
  va_module_class VARCHAR[] := ARRAY[]::VARCHAR[];

begin
  -- инициализация/получение переменных пакета
  i = sessvarstr_declare('pkg', 'i', 'I');
  u = sessvarstr_declare('pkg', 'u', 'U');
  d = sessvarstr_declare('pkg', 'd', 'D');
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');
  -- код функции
  if pv_action = d::varchar then
    -- если есть модули с данным именем еще то удаляем только его
    for vcur in (select 1 from s_mt.t_module where ck_id <> pot_module.ck_id and trim(lower(cv_name)) = trim(lower(pot_module.cv_name))) loop
      delete from s_mt.t_module_class where ck_module = pot_module.ck_id; 
      delete from s_mt.t_module where ck_id = pot_module.ck_id and ck_view = pot_module.ck_view;
      return;
    end loop;
    -- Удаляем связанные данные по таблице иерархии
    for vcur in (select ch.ck_id,
                        ch.ck_class_parent,
                        ch.ck_class_child,
                        ch.ck_class_attr
                   from s_mt.t_module m
                  inner join s_mt.t_module_class mc on mc.ck_module = m.ck_id
                  inner join s_mt.t_class c on mc.ck_class = c.ck_id
                  inner join s_mt.t_class_hierarchy ch on c.ck_id in (ch.ck_class_child, ch.ck_class_parent)
                  where m.ck_id = pot_module.ck_id and m.ck_view = pot_module.ck_view) loop
      vot_class_hierarchy.ck_id := vcur.ck_id;
      vot_class_hierarchy.ck_class_parent := vcur.ck_class_parent;
      vot_class_hierarchy.ck_class_child := vcur.ck_class_child;
      vot_class_hierarchy.ck_class_attr := vcur.ck_class_attr;
      vot_class_hierarchy := pkg_meta.p_modify_class_hierarchy(d::varchar, vot_class_hierarchy);
    end loop;

    -- Выбираем атрибуты которые есть в этом классе и которых нет в других классах
    select array_agg(row(t.ck_id, t.cv_description, t.ck_attr_type)::public.ot_attr)
      into vct_attr
      from
      (select distinct a.ck_id,
                       a.cv_description,
                       a.ck_attr_type
         from s_mt.t_module m
        inner join s_mt.t_module_class mc on mc.ck_module = m.ck_id
        inner join s_mt.t_class c on mc.ck_class = c.ck_id
        inner join s_mt.t_class_attr ca on c.ck_id = ca.ck_class
        inner join s_mt.t_attr a on ca.ck_attr = a.ck_id
        where m.ck_id = pot_module.ck_id and m.ck_view = pot_module.ck_view
          and not exists (select 1
                            from s_mt.t_class_attr ca1
                           where a.ck_id = ca1.ck_attr
                             and ca1.ck_class <> ca.ck_class)) t;
                             
     -- Удаляем связанные данные по таблице атрибутов
    for vcur in (select ca.ck_id,
                        ca.ck_class,
                        ca.ck_attr,
                        ca.cv_value,
                        ca.cl_required
                   from s_mt.t_module m
                  inner join s_mt.t_module_class mc on mc.ck_module = m.ck_id
                  inner join s_mt.t_class c on mc.ck_class = c.ck_id
                  inner join s_mt.t_class_attr ca on c.ck_id = ca.ck_class
                  where m.ck_id = pot_module.ck_id and m.ck_view = pot_module.ck_view) loop
      vot_class_attr.ck_id := vcur.ck_id;
      vot_class_attr.ck_class := vcur.ck_class;
      vot_class_attr.ck_attr := vcur.ck_attr;
      vot_class_attr.cv_value := vcur.cv_value;
      vot_class_attr.cl_required := vcur.cl_required;
      vot_class_attr := pkg_meta.p_modify_class_attr(d::varchar, vot_class_attr);
    end loop;
   
    -- Удаляем атрибуты которые есть в этом классе и нет в других
    for vc in (select t.ck_id, 
                     t.cv_description, 
                     t.ck_attr_type 
                from unnest(vct_attr) t) loop
      vot_attr.ck_id := vc.ck_id;
      vot_attr.cv_description :=vc.cv_description;
      vot_attr.ck_attr_type := vc.ck_attr_type;
      vot_attr := pkg_meta.p_modify_attr(d::varchar, vot_attr);
    end loop;

    -- Получаем связанный класс
    for vc in (select c.ck_id,
                     c.cv_name,
                     c.cv_description,
                     c.cl_final,
                     c.cl_dataset
                from s_mt.t_module m
               inner join s_mt.t_module_class mc on mc.ck_module = m.ck_id
               inner join s_mt.t_class c on mc.ck_class = c.ck_id
               where m.ck_id = pot_module.ck_id and m.ck_view = pot_module.ck_view) loop
      vot_class.ck_id := vc.ck_id;
      vot_class.cv_name := vc.cv_name;
      vot_class.cv_description := vc.cv_description;
      vot_class.cl_final := vc.cl_final;
      vot_class.cl_dataset := vc.cl_dataset;
      -- Удаляем связанный класс
      if vot_class.ck_id is not null then
        delete from s_mt.t_module_class where ck_class = vot_class.ck_id and ck_module = pot_module.ck_id; 
        perform pkg_meta.p_modify_class(d::varchar, vot_class);
      end if;
    end loop;

    if nullif(gv_error::varchar, '') is null then
      -- Удаление
      delete from s_mt.t_module where ck_id = pot_module.ck_id and ck_view = pot_module.ck_view;    
    end if;
  else
    if pot_module.cv_name is null then
      perform pkg.p_set_error(57);
    end if;
  
    if pot_module.cv_version is null then
      perform pkg.p_set_error(58);
    end if;
    
    if pot_module.cl_available is null then
      perform pkg.p_set_error(59);
    end if;
    
    if pv_action = i::varchar then
      pot_module.ck_id := sys_guid();
      --если есть такой модуль раннее установленый то сохраняем id последнего
      select t.ck_id
      into vv_id
      from (select m.ck_id,
           row_number() over (order by(m.cv_version) desc ) as cn_rn
        from s_mt.t_module m 
        where trim(lower(m.cv_name)) = trim(lower(pot_module.cv_name))
        and m.ck_view = pot_module.ck_view
        ) as t
        where t.cn_rn = 1;    
      -- Проверяем, что модуля такого нет в базе
      for vcur in (select 1 from s_mt.t_module
                   where trim(lower(cv_name)) = trim(lower(pot_module.cv_name))
                        and ck_view = pot_module.ck_view
                        and cv_version = pot_module.cv_version
                        and cv_version_api = pot_module.cv_version_api) loop
        perform pkg.p_set_error(63);
      end loop;
    end if;

    -- Если выключаем доступность модуля, то проверяем, что он нигде не используется
    for vcur in (with w_module as
                    (select c.cv_name as cv_class, c.ck_id as ck_class, m.cl_available
                      from s_mt.t_module m
                     inner join s_mt.t_module_class mc on mc.ck_module = m.ck_id
                     inner join s_mt.t_class c on mc.ck_class = c.ck_id
                     where m.ck_id = pot_module.ck_id
                       and m.ck_view = pot_module.ck_view
                       and m.cl_available = 1
                       and pot_module.cl_available = 0)
                   select '"' || string_agg(t.cv_class, '","' order by t.cv_class) || '"' as cv_class
                     from (select wm.cv_class
                             from w_module wm
                            inner join s_mt.t_object o on wm.ck_class = o.ck_class
                           union
                           -- Проверяем дочернии классы, что там нет связанного класса который используется в объекте
                           select c.cv_name
                            from w_module wm2
                            inner join s_mt.t_class_hierarchy ch on wm2.ck_class = ch.ck_class_parent
                            inner join s_mt.t_class c on ch.ck_class_child = c.ck_id
                            inner join s_mt.t_object o on c.ck_id = o.ck_class
                            inner join s_mt.t_module_class mc on mc.ck_module = c.ck_id
                            inner join s_mt.t_module m on m.ck_id = mc.ck_module
                            where wm2.cl_available = 1) t) loop
      if vcur.cv_class <> '""' then
        perform pkg.p_set_error(60, vcur.cv_class);
      end if;
      exit;
    end loop;

    -- Если включаем доступность модуля, то проверяем, что связанный классы верхнего уровня тоже активны
    for vcur in (with w_module as
                    (select c.cv_name as cv_class, c.ck_id as ck_class, m.cl_available
                      from s_mt.t_module m
                     inner join s_mt.t_module_class mc on mc.ck_module = m.ck_id
                     inner join s_mt.t_class c on mc.ck_class = c.ck_id
                     where m.ck_id = pot_module.ck_id
                       and m.ck_view = pot_module.ck_view
                       and m.cl_available = 0
                       and pot_module.cl_available = 1)
                   select '"' || string_agg(t.cv_class, '","' order by t.cv_class) || '"' as cv_class
                     from (
                           -- Проверяем родительские классы, что там нет связанного класса модуль которого отключен
                           select c.cv_name as cv_class,
                                  wm.cl_available,
                                  count(m.cl_available) over() cn_available
                             from w_module wm
                            inner join s_mt.t_class_hierarchy ch on wm.ck_class = ch.ck_class_child
                            inner join s_mt.t_class c on ch.ck_class_parent = c.ck_id
                            inner join s_mt.t_module_class mc on mc.ck_class = c.ck_id
                            inner join s_mt.t_module m on m.ck_id = mc.ck_module
                            where m.ck_id <> pot_module.ck_id and trim(lower(m.cv_name)) <> trim(lower(pot_module.cv_name))
                            ) t
                    where (t.cn_available <> 1 and t.cl_available = 0 or t.cl_available = 0)) loop
      if vcur.cv_class <> '""' then
        perform pkg.p_set_error(61, vcur.cv_class);
      end if;
      exit;
    end loop;

    if nullif(gv_error::varchar, '') is not null then
      return;
    end if;
    if pot_module.cl_available = 1 or vv_id is null then
      --распаковываем манифест
      for vcur_class in (select value as cj_class from jsonb_array_elements(pot_module.cc_manifest::jsonb)) loop
          -- Добавляем/Изменяем класс модуля
          for vcur in (select jt.ck_class_id,
                              jt.cv_datatype_type,
                              jt.cl_dataset,
                              jt.cl_final,
                              jt.cv_description,
                              jt.cv_manual_documentation,
                              jt.cv_auto_documentation,
                              jt.cv_name,
                              jt.cv_type,
                              wmc.ck_class,
                              wmc.ck_class_attr,
                              case
                                when wmc.ck_class is not null then
                                'U'
                                else
                                'I'
                              end as cv_action,
                              case
                                when wmc.ck_class_attr is not null then
                                'U'
                                else
                                'I'
                              end as cv_action_class_attr
                        from (select  (vcur_class.cj_class#>>'{class,ck_id}') as ck_class_id,
                                      (vcur_class.cj_class#>>'{class,cl_dataset}') as cl_dataset,
                                      (vcur_class.cj_class#>>'{class,cl_final}') as cl_final,
                                      (vcur_class.cj_class#>>'{class,cv_description}') as cv_description,
                                      nullif(trim(vcur_class.cj_class#>>'{class,cv_manual_documentation}'), '') as cv_manual_documentation,
                                      nullif(trim(vcur_class.cj_class#>>'{class,cv_auto_documentation}'), '') as cv_auto_documentation,
                                      (vcur_class.cj_class#>>'{class,cv_name}') as cv_name,
                                      (vcur_class.cj_class#>>'{class,cv_type}') as cv_type,
                                      (select (t.dt->>'cv_value') as cv_value
                                        from jsonb_array_elements(vcur_class.cj_class->'class_attributes') as t(dt)
                                        where (t.dt->>'ck_attr') = 'datatype') as cv_datatype_type) jt
                        left join (select c.ck_id as ck_class, ca.ck_id as ck_class_attr, m.ck_id as ck_module, m.ck_view as ck_view_module, ca.cv_value from s_mt.t_module m
                             join s_mt.t_module_class mc on m.ck_id = mc.ck_module
                             join s_mt.t_class c on mc.ck_class = c.ck_id
                             left join s_mt.t_class_attr ca on c.ck_id = ca.ck_class and ca.ck_attr = 'type') as wmc
                          on ((pv_action = u::varchar and wmc.ck_module = pot_module.ck_id and wmc.ck_view_module = pot_module.ck_view)
                           or (pv_action = i::varchar and (vv_id is null or (wmc.ck_module = vv_id and wmc.ck_view_module = pot_module.ck_view)))) and 
                           (jt.ck_class_id is null and ((jt.cv_datatype_type is null and lower(wmc.ck_class) = lower(pot_module.ck_view || ':' || jt.cv_type)) or (jt.cv_datatype_type is not null and lower(wmc.ck_class) = lower(pot_module.ck_view || ':' || jt.cv_type || ':' || jt.cv_datatype_type))) 
                           or (jt.ck_class_id is not null and jt.ck_class_id = wmc.ck_class))
                        ) loop
            vot_class.ck_id          := coalesce(vcur.ck_class, vcur.ck_class_id, lower(pot_module.ck_view || ':' || vcur.cv_type));
            vot_class.ck_view        := pot_module.ck_view;
            vot_class.cv_name        := vcur.cv_name;
            vot_class.cl_final       := vcur.cl_final::smallint;
            vot_class.cl_dataset     := vcur.cl_dataset::smallint;
            vot_class.ck_user        := pot_module.ck_user;
            vot_class.ct_change      := CURRENT_TIMESTAMP;
            vot_class.cv_description := vcur.cv_description;
            if vcur.cv_action = 'I' then
              vot_class.cv_manual_documentation := vcur.cv_manual_documentation;
              vot_class.cv_auto_documentation := vcur.cv_auto_documentation;
            end if;
            if vcur.cv_action = 'I' then
              for vcheck_class in (select 1 from s_mt.t_class where ck_id = vot_class.ck_id) loop
                vl_new_id := 1;
              end loop;
              if vcur.ck_class_id is null and vcur.cv_datatype_type is not null then
                vot_class.ck_id = lower(pot_module.ck_view || ':' || vcur.cv_type || ':' || vcur.cv_datatype_type);
              end if;
              vot_class := pkg_meta.p_modify_class(vcur.cv_action, vot_class, vl_new_id);
            else
              vot_class := pkg_meta.p_modify_class(vcur.cv_action, vot_class);
            end if;
            if vcur.cv_action = 'U' and vcur.cv_manual_documentation is not null then
              vot_class.cv_manual_documentation := vcur.cv_manual_documentation;
              vot_class := pkg_meta.p_modify_class(vcur.cv_action, vot_class);
            end if;
            if vcur.cv_action = 'U' and vcur.cv_auto_documentation is not null then
              vot_class.cv_manual_documentation := null;
              vot_class.cv_auto_documentation := vcur.cv_auto_documentation;
              vot_class := pkg_meta.p_modify_class(vcur.cv_action, vot_class);
            end if;
            -- Добавляем базовый тип
            vot_class_attr.ck_id       := vcur.ck_class_attr;
            vot_class_attr.ck_class    := vot_class.ck_id;
            vot_class_attr.ck_user     := vot_class.ck_user;
            vot_class_attr.ct_change   := CURRENT_TIMESTAMP;
            vot_class_attr.cl_required := 1;
            vot_class_attr.ck_attr     := 'type';
            vot_class_attr.cl_empty    := 0;
            vot_class_attr.cv_value    := vcur.cv_type;
          
            vot_class_attr := pkg_meta.p_modify_class_attr(vcur.cv_action_class_attr, vot_class_attr);
          end loop;
        
          if nullif(gv_error::varchar, '') is not null then
            return;
          end if;

          -- Добавляем/Изменяем атрибуты
          for vcur in (select coalesce(jt.ck_attr_type, atr.ck_attr_type) as ck_attr_type,
                              coalesce(jt.cv_description, atr.cv_description) as cv_description,
                              coalesce(jt.ck_id, atr.ck_id) as ck_id,
                              coalesce(jt.ck_d_data_type, atr.ck_d_data_type) as ck_d_data_type,
                              coalesce(jt.cv_data_type_extra, atr.cv_data_type_extra) as cv_data_type_extra,
                              case
                                when jt.ck_id is not null and atr.ck_id is null then
                                'I'
                                when jt.ck_id is null then
                                null
                                else
                                'U'
                              end as cv_action
                        from (select (t.dt->>'ck_attr') as ck_id, 
                                      (t.dt->>'ck_attr_type') as ck_attr_type, 
                                      (t.dt->>'cv_description') as cv_description, 
                                      (t.dt->>'ck_d_data_type') as ck_d_data_type,
                                      (t.dt->>'cv_data_type_extra') as cv_data_type_extra
                                from jsonb_array_elements(vcur_class.cj_class->'attributes') as t(dt)) jt
                        left join s_mt.t_attr atr on atr.ck_id = jt.ck_id) loop
            vot_attr.ck_id          := vcur.ck_id;
            vot_attr.ck_attr_type   := coalesce(nullif(vcur.ck_attr_type, ''), 'basic');
            vot_attr.cv_description := vcur.cv_description;
            vot_attr.cv_data_type_extra := nullif(trim(vcur.cv_data_type_extra), '');
            vot_attr.ck_d_data_type := coalesce(nullif(vcur.ck_d_data_type, ''), 'text');
            vot_attr.ck_user        := pot_module.ck_user;
            vot_attr.ct_change      := CURRENT_TIMESTAMP;
          
            if vcur.cv_action is not null and nullif(gv_error::varchar, '') is null then
              vot_attr := pkg_meta.p_modify_attr(vcur.cv_action, vot_attr);
            end if;
          end loop;
        
          if nullif(gv_error::varchar, '') is not null then
            return;
          end if;

          -- Добавляем атрибуты класса
          for vcur in (select jt.*,
                              ca.ck_id as ck_id,
                              case
                                when ca.ck_attr is null then
                                'I'
                                when jt.ck_attr is null and ca.ck_attr is not null then
                                'D'
                                else
                                'U'
                              end as cv_action
                        from (select  (t.dt->>'ck_attr') as ck_attr, 
                                      (t.dt->>'cv_value') as cv_value, 
                                      (t.dt->>'cl_required') as cl_required, 
                                      (t.dt->>'cl_empty') as cl_empty, 
                                      (t.dt->>'cv_data_type_extra') as cv_data_type_extra 
                                from jsonb_array_elements(vcur_class.cj_class->'class_attributes') as t(dt)) jt
                        full join (select ca.ck_id, ca.ck_attr
                                    from s_mt.t_class c
                                    inner join s_mt.t_class_attr ca on c.ck_id = ca.ck_class
                                    where c.ck_id = vot_class.ck_id
                                      and ca.ck_attr <> 'type') ca on jt.ck_attr = ca.ck_attr
                        where jt.ck_attr is not null
                          or ca.ck_attr is not null) loop
            vot_class_attr.ck_id       := vcur.ck_id;
            vot_class_attr.ck_class    := vot_class.ck_id;
            vot_class_attr.ck_user     := vot_class.ck_user;
            vot_class_attr.ct_change   := CURRENT_TIMESTAMP;
            vot_class_attr.cv_data_type_extra := nullif(trim(vcur.cv_data_type_extra), '');
            vot_class_attr.cl_required := coalesce(nullif(vcur.cl_required, '')::bigint, 0);
            vot_class_attr.cl_empty    := coalesce(nullif(vcur.cl_empty, '')::bigint, 0);
            vot_class_attr.ck_attr     := vcur.ck_attr;
            vot_class_attr.cv_value    := nullif(vcur.cv_value, '');
            vot_class_attr := pkg_meta.p_modify_class_attr(vcur.cv_action, vot_class_attr);
          end loop;

          --добавляем класс в массив
          va_module_class := array_append(va_module_class, vot_class.ck_id);
          
          if nullif(gv_error::varchar, '') is not null then
            return;
          end if;
      end loop;

      for vcur_class in (select value as cj_class from jsonb_array_elements(pot_module.cc_manifest::jsonb)) loop
          --Находим класс
          select ck_id
            into vot_class.ck_id
          from s_mt.t_class c 
          join unnest(va_module_class) as t(ck_class)
            on c.ck_id = t.ck_class
          where upper(c.cv_name) = upper(vcur_class.cj_class#>>'{class,cv_name}');
          -- Выбираем данные для таблицы иерархии классов
          -- Если данные уже есть проверяем может быть их необходимо удалить, если их нет в манифесте или вставить если их не в таблице иерархии
          for vcur in (select ch.ck_id,
                              coalesce(ch.ck_class_parent, ch1.ck_class_parent) as ck_class_parent,
                              coalesce(ch.ck_class_child, ch1.ck_class_child) as ck_class_child,
                              coalesce(ch.ck_class_attr, ch1.ck_class_attr) as ck_class_attr,
                              case
                                when ch.ck_class_parent is not null and ch.ck_class_child is not null and ch1.ck_class_parent is not null and ch1.ck_class_child is not null then
                                'U'
                                when ch1.ck_class_parent is null or ch1.ck_class_child is null then
                                'D'
                                else
                                'I'
                              end as cv_action
                        from (
                              -- Выбираем все связи класса, для того чтобы удалить лишние или проверять что такое связи ещё нет и добавить её
                              select ch.ck_id, ch.ck_class_parent, ch.ck_class_child, ch.ck_class_attr
                                from s_mt.t_class c
                                inner join s_mt.t_class_hierarchy ch on c.ck_id in (ch.ck_class_parent, ch.ck_class_child)
                                where c.ck_id = vot_class.ck_id) ch
                        full join (
                                  -- Собираем идентификаторы связок, которые будет проверять и добавлять при необходимости
                                  select t.ck_class_parent, t.ck_class_child, ca.ck_id as ck_class_attr
                                    from (
                                            -- Выбираем из JSON связки, которые необходимо добавить
                                            select ck_id as ck_class_parent, vot_class.ck_id as ck_class_child, jt.ck_attr
                                              from (select coalesce(nullif(trim(t.dt->>'ck_id'), ''), cattr.ck_class) as ck_id, 
                                                           (t.dt->>'ck_attr') as ck_attr
                                                      from jsonb_array_elements(vcur_class.cj_class#>'{class_hierarchy,class_parent}') as t(dt)
                                                      left join s_mt.t_class_attr cattr 
                                                         on cattr.ck_attr = 'type' and cattr.cv_value = (t.dt->>'cv_type')) jt
                                            union all
                                            select vot_class.ck_id as ck_class_parent, ck_id as ck_class_child, jt.ck_attr
                                              from (select coalesce(nullif(trim(t.dt->>'ck_id'), ''), cattr.ck_class) as ck_id, 
                                                           (t.dt->>'ck_attr') as ck_attr
                                                      from jsonb_array_elements(vcur_class.cj_class#>'{class_hierarchy,class_child}') as t(dt)
                                                      left join s_mt.t_class_attr cattr 
                                                         on cattr.ck_attr = 'type' and cattr.cv_value = (t.dt->>'cv_type')) jt) t
                                    left join s_mt.t_class_attr ca on t.ck_class_parent = ca.ck_class
                                                                  and t.ck_attr = ca.ck_attr) ch1 on ch.ck_class_parent =
                                                                                                      ch1.ck_class_parent
                                                                                                  and ch.ck_class_child =
                                                                                                      ch1.ck_class_child
                                                                                                  and ch.ck_class_attr =
                                                                                                      ch1.ck_class_attr
                        where ch1.ck_class_parent is null
                          or ch.ck_class_parent is null) loop
            vot_class_hierarchy.ck_id           := vcur.ck_id;
            vot_class_hierarchy.ck_class_parent := vcur.ck_class_parent;
            vot_class_hierarchy.ck_class_child  := vcur.ck_class_child;
            vot_class_hierarchy.ck_class_attr   := vcur.ck_class_attr;
            vot_class_hierarchy.ck_user         := vot_class.ck_user;
            vot_class_hierarchy.ct_change       := vot_class.ct_change;
            if (vot_class_hierarchy.ck_id is not null and vcur.cv_action = 'D') or 
            (vot_class_hierarchy.ck_class_parent is not null and vot_class_hierarchy.ck_class_child is not null and vot_class_hierarchy.ck_class_attr is not null) then
                vot_class_hierarchy := pkg_meta.p_modify_class_hierarchy(vcur.cv_action, vot_class_hierarchy);
            end if;
            
          end loop;
      end loop;
      if nullif(gv_error::varchar, '') is not null then
          return;
      end if;
    elsif pv_action = i::varchar then
      select array_agg(ck_class) as va_module_class
      into va_module_class
      from s_mt.t_module_class where ck_module = vv_id;
    end if;
    pot_module.ct_change := CURRENT_TIMESTAMP;
    -- толька одна версия может быть включена
    if pot_module.cl_available = 1 then
       update s_mt.t_module set 
           cl_available = 0
       where cv_name = pot_module.cv_name;
    end if;
    if pv_action = i::varchar and nullif(gv_error::varchar, '') is null then
      -- Вставка
      insert into s_mt.t_module values (pot_module.*);
      if va_module_class is not null then
        insert into s_mt.t_module_class (ck_module, ck_class, ck_user, ct_change)
        select pot_module.ck_id, t.ck_class, pot_module.ck_user, pot_module.ct_change from unnest(va_module_class) as t(ck_class)
        on conflict on CONSTRAINT cin_u_module_class_1 do update set ck_user = excluded.ck_user, ct_change = excluded.ct_change;
      end if;
    elsif pv_action = u::varchar and nullif(gv_error::varchar, '') is null then
      
      -- Изменение
      update s_mt.t_module set 
       (cv_name, ck_view, ck_user, ct_change, cv_version, cl_available, cc_manifest, cc_config, cv_version_api) = 
       (pot_module.cv_name, pot_module.ck_view, pot_module.ck_user, pot_module.ct_change, pot_module.cv_version, pot_module.cl_available, pot_module.cc_manifest, pot_module.cc_config, pot_module.cv_version_api) 
       where ck_id = pot_module.ck_id;
     
      if not found then
        perform pkg.p_set_error(504);
      end if;
    end if;
  end if;
end;
$$;


ALTER FUNCTION pkg_meta.p_modify_module(pv_action character varying, INOUT pot_module s_mt.t_module) OWNER TO s_mp;

COMMENT ON FUNCTION pkg_meta.p_modify_module(pv_action character varying, INOUT pot_module s_mt.t_module) IS 'Создание/обновление/удаление модулей на странице t_module';

CREATE FUNCTION pkg_meta.p_modify_object(pv_action character varying, INOUT pot_object s_mt.t_object) RETURNS s_mt.t_object
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_meta', 'public'
    AS $$
declare
  -- переменные пакета
  i        sessvarstr;
  u        sessvarstr;
  d        sessvarstr;
  gv_error sessvarstr;
  gl_warning sessvari;
  gv_warning sessvarstr;

  -- переменные функции
  pcur_object record;
  vcur_object record;
  vcur        record;
  pcur_cnt    record;
begin
  -- инициализация/получение переменных пакета
  i = sessvarstr_declare('pkg', 'i', 'I');
  u = sessvarstr_declare('pkg', 'u', 'U');
  d = sessvarstr_declare('pkg', 'd', 'D');
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');
  gl_warning = sessvari_declare('pkg', 'gl_warning', 0);
  gv_warning = sessvarstr_declare('pkg', 'gv_warning', '');

  -- код функции
  if pv_action = d::varchar then
    /*Проверки на удаление */
    /*Удаление*/
    begin
      for pcur_object in (with recursive q as
                             (select 1 as level,
                                    o.ck_id,
                                    ('{' || o.ck_id || '}')::varchar[] as vl_path
                               from s_mt.t_object as o
                              where o.ck_id = pot_object.ck_id
                             
                             union all
                             
                             select q.level + 1 as level,
                                    oc.ck_id,
                                    array_append(q.vl_path, (q.ck_id || oc.ck_id)::varchar)
                               from s_mt.t_object as oc
                               join q
                                 on oc.ck_parent = q.ck_id
                                and oc.ck_id <> all(q.vl_path))
                            select q.level, q.ck_id
                              from q
                             order by q.level desc) loop
        delete from s_mt.t_object_attr oa
         where oa.ck_object = pcur_object.ck_id;
        delete from s_mt.t_object o where o.ck_id = pcur_object.ck_id;
      end loop;
    exception
      when integrity_constraint_violation then
        perform pkg.p_set_error(29);
      when foreign_key_violation then
        perform pkg.p_set_error(29);
    end;
  else
    /* Блок "Проверка переданных данных" */
    if pot_object.ck_class is null then
      perform pkg.p_set_error(1);
    end if;
    if pot_object.cv_name is null then
      perform pkg.p_set_error(2);
    end if;
    if pot_object.cn_order is null then
      perform pkg.p_set_error(3);
    end if;
    if pot_object.cv_description is null then
      perform pkg.p_set_error(4);
    end if;
    if not
        (pot_object.cv_modify is null or pot_object.ck_provider is not null) then
      perform pkg.p_set_error(33);
    end if;
    if pot_object.ck_parent is not null then
      /*уникальность cn_order в рутовых объектах не проверяем*/
      for vcur_object in (select 1
                            from s_mt.t_object o
                           where o.ck_parent || o.cn_order::varchar = pot_object.ck_parent || pot_object.cn_order::varchar
                             and ((o.ck_id <> pot_object.ck_id and
                                 pv_action = u::varchar) or
                                 (pot_object.ck_id is null and
                                 pv_action = i::varchar))) loop
        perform pkg.p_set_error(34);
        exit;
      end loop;
       /*если обьект добавляется как дочерний то он прописан в t_class_hierarchy*/
      for pcur_cnt in (select 1
                        from dual
                        where not exists
                        (select 1
                                from s_mt.t_class_hierarchy t1
                                join s_mt.t_object t2
                                  on t2.ck_class = t1.ck_class_parent
                                where t2.ck_id = pot_object.ck_parent
                                  and t1.ck_class_child = pot_object.ck_class)) loop
        perform pkg.p_set_error(13);
        exit;
      end loop;
    else
      for pcur_cnt in (
        select 1
        from s_mt.t_class cl
        where cl.ck_id = pot_object.ck_class and cl.cl_final = 0
      )loop
        perform pkg.p_set_error(51, '6cef8d4302234753bc59aa193c7fe6bb');
      end loop;
    end if;
    -- Проверяем, что модуль класса включен
    for vcur in (select m.cv_name
                   from s_mt.t_module m
                   join s_mt.t_module_class mc
                   on m.ck_id = mc.ck_class
                  where mc.ck_class = pot_object.ck_class
                    and m.cl_available = 0) loop
      perform pkg.p_set_error(62, vcur.cv_name);
      exit;
    end loop;
    /*Проверяем что нет попытки смены класса*/
    if pv_action = u::varchar then
      for vcur_object in (select 1
                            from s_mt.t_object o
                           where o.ck_id = pot_object.ck_id
                             and o.ck_class <> pot_object.ck_class) loop
        perform pkg.p_set_error(67);
        exit;
      end loop;
    end if;
    -- Проверяем на смену родителя, нельзя в дочерний 
    if pv_action = u::varchar then
      for pcur_cnt in (
        with recursive vt_object as (
              select
                  ck_id, ck_parent, 1 as lvl
              from
                  s_mt.t_object
              where
                  ck_id = pot_object.ck_id
          union all
              select
                  p.ck_id, p.ck_parent, rp.lvl + 1 as lvl
              from
                  s_mt.t_object p
              join vt_object rp on
                  p.ck_parent = rp.ck_id
          )
          select 1
          from s_mt.t_object o
          where o.ck_id = pot_object.ck_id 
          and o.ck_parent <> pot_object.ck_parent 
          and pot_object.ck_parent in (select ck_id from vt_object)
      ) loop
          perform pkg.p_set_error(51, '588e2ab956f14295a82048271de5ad5a');
      end loop;
    end if;
    -- Проверяем на смену родителя если объект был привязан к странице
    if pv_action = u::varchar and nullif(gv_error::varchar, '') is null and (gl_warning::bigint) = 0 then
      for pcur_cnt in (
          select 1
          from s_mt.t_object o
          join s_mt.t_page_object po
          on o.ck_id = po.ck_object
          where o.ck_id = pot_object.ck_id and o.ck_parent <> pot_object.ck_parent
      ) loop
          perform pkg.p_set_warning(82, '7d4bdc39e17d423595affef73f4922d4');
      end loop;
    end if;

    if nullif(gv_error::varchar, '') is not null or nullif(gv_warning::varchar, '') is not null then
   	  return;
    end if;
    if pv_action = i::varchar then
      if pot_object.ck_id is not null then
        for pcur_cnt in (
            select 1
            from s_mt.t_object o
            where o.ck_id = pot_object.ck_id
        ) loop
            pot_object.ck_id := sys_guid();
        end loop;
      else 
        pot_object.ck_id := sys_guid();
      end if;
      insert into s_mt.t_object values (pot_object.*);
    elsif pv_action = u::varchar then
      update s_mt.t_object
         set (ck_id,
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
              ct_change) = row(pot_object.*)
       where ck_id = pot_object.ck_id;
    
      if not found then
        perform pkg.p_set_error(504);
      end if;
    end if;
    null;
  end if;
end;
$$;


ALTER FUNCTION pkg_meta.p_modify_object(pv_action character varying, INOUT pot_object s_mt.t_object) OWNER TO s_mp;

COMMENT ON FUNCTION pkg_meta.p_modify_object(pv_action character varying, INOUT pot_object s_mt.t_object) IS 'Создание/обновление/удаление объекта t_object';

CREATE FUNCTION pkg_meta.p_modify_object_attr(pv_action character varying, INOUT pot_object_attr s_mt.t_object_attr) RETURNS s_mt.t_object_attr
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_meta', 'public'
    AS $$
declare
  -- переменные пакета
  i sessvarstr;
  u sessvarstr;
  d sessvarstr;
  gv_error sessvarstr;

  -- переменные функции
  vcur_check record;
begin
  -- инициализация/получение переменных пакета
  i = sessvarstr_declare('pkg', 'i', 'I');
  u = sessvarstr_declare('pkg', 'u', 'U');
  d = sessvarstr_declare('pkg', 'd', 'D');
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');

  -- код функции
  if pv_action = d::varchar then
    /*Проверки на удаление*/
    /* значения атрибутов  decimalseparator и thousandseparator в классах Column Numeric и Field Numeric не могут совпадать */
    perform pkg_meta.p_check_separator(pv_action, null, pot_object_attr, null);
    /*Удаление*/
    if nullif(gv_error::varchar, '') is null then
      delete from s_mt.t_object_attr where ck_id = pot_object_attr.ck_id;
    end if;
  else
    for vcur_check in (
      select 1 from s_mt.t_class_attr 
      where cl_empty = 0 
      and ck_id = pot_object_attr.ck_class_attr 
      and nullif(pot_object_attr.cv_value, '') is null
    ) loop
      perform pkg.p_set_error(51, 'eea00f8cc53e471bbf7b8306e3927b5a');
    end loop;
    /*Проверка на то, что обьект принадлежит тому же классу, которому принадлежит аттрибут */
    for vcur_check in (
      select 1
      from dual
      where not exists (
        select 1
        from s_mt.t_object a
        join s_mt.t_class b on
          a.ck_class = b.ck_id
        join s_mt.t_class_attr c on
          b.ck_id = c.ck_class
        where c.ck_id = pot_object_attr.ck_class_attr
        and a.ck_id = pot_object_attr.ck_object
      )
    )loop
      perform pkg.p_set_error(6);
    end loop;

    -- check percentage for "width"/"columnwidth"
    for vcur_check in (select 1
                         from s_mt.t_class_attr ca
                        where ca.ck_attr in ('width', 'columnwidth', 'contentwidth')
                          and ca.ck_id = pot_object_attr.ck_class_attr
                          and nullif(trim(pot_object_attr.cv_value), '') is not null
                          and pkg_util.f_check_string_is_percentage(pot_object_attr.cv_value) = 0) loop
      perform pkg.p_set_error(55);
    end loop;

    /* значения атрибутов  decimalseparator и thousandseparator в классах Column Numeric и Field Numeric не могут совпадать */
    perform pkg_meta.p_check_separator(pv_action, null, pot_object_attr, null);

    if pv_action = i::varchar and nullif(gv_error::varchar, '') is null then
      pot_object_attr.ck_id := sys_guid();
      insert into s_mt.t_object_attr values (pot_object_attr.*);
    elsif pv_action = u::varchar and nullif(gv_error::varchar, '') is null then
      update s_mt.t_object_attr set
        (ck_id, ck_object, ck_class_attr, cv_value, ck_user, ct_change) = row(pot_object_attr.*)
      where ck_id = pot_object_attr.ck_id;

      if not found then
        perform  pkg.p_set_error(504);
      end if;
    end if;
    null;
  end if;
end;
$$;


ALTER FUNCTION pkg_meta.p_modify_object_attr(pv_action character varying, INOUT pot_object_attr s_mt.t_object_attr) OWNER TO s_mp;

COMMENT ON FUNCTION pkg_meta.p_modify_object_attr(pv_action character varying, INOUT pot_object_attr s_mt.t_object_attr) IS 'Создание/обновление/удаление дефолтных значений аттрибутов объекта t_object_attr';

CREATE FUNCTION pkg_meta.p_modify_page(pv_action character varying, INOUT pot_page s_mt.t_page, pn_action_view bigint, pn_action_edit bigint) RETURNS s_mt.t_page
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_meta', 'public'
    AS $$
declare
  -- переменные пакета
  i sessvarstr;
  u sessvarstr;
  d sessvarstr;
  gv_error sessvarstr;
  gl_warning sessvari;
  gv_warning sessvarstr;

  -- переменные функции
  vn_action_view_old bigint;
  vn_action_view_new bigint;
  vn_action_edit_old bigint;
  vn_action_edit_new bigint;

  vcur_check_po record;
  vcur_check_page record;
  vcur_cnt record;
begin
  -- инициализация/получение переменных пакета
  i = sessvarstr_declare('pkg', 'i', 'I');
  u = sessvarstr_declare('pkg', 'u', 'U');
  d = sessvarstr_declare('pkg', 'd', 'D');
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');
  gl_warning = sessvari_declare('pkg', 'gl_warning', 0);
  gv_warning = sessvarstr_declare('pkg', 'gv_warning', '');

  -- код функции
  if pv_action = d::varchar then
    /*Проверки на удаление*/
    for vcur_check_po in (
      select 1
      from s_mt.t_page_object
      where ck_page = pot_page.ck_id
    ) loop
      perform pkg.p_set_error(40);
      exit;
    end loop;
    for vcur_check_page in (
      select 1
      from s_mt.t_page where ck_parent = pot_page.ck_id
    ) loop
      perform pkg.p_set_error(56);
      exit;
    end loop;
    /*Удаление*/
    if nullif(gv_error::varchar, '') is null then
      delete from s_mt.t_page_action where ck_page = pot_page.ck_id;
      delete from s_mt.t_page_variable where ck_page = pot_page.ck_id;
      delete from s_mt.t_page where ck_id = pot_page.ck_id;
    end if;
  else
    /* Блок "Проверка переданных данных" */
    if pot_page.cv_name is null then
      perform pkg.p_set_error(2);
    end if;
    if pot_page.cl_static is null and pot_page.cr_type <> 3 then
      perform pkg.p_set_error(7);
    end if;
    if pot_page.cr_type = 3 then
      pot_page.cl_static := 1;
      pot_page.cl_menu := 0;
    end if;
    if pot_page.cn_order is null then
      perform pkg.p_set_error(8);
    end if;
    if pot_page.cr_type is null or pot_page.cr_type not in (0, 1, 2, 3) then
      perform pkg.p_set_error(9);
    end if;
    if pot_page.ck_parent is not null and pot_page.cr_type = 0 then
      for vcur_cnt in (
            select 1
            from s_mt.t_page p
              where p.ck_id = pot_page.ck_parent and p.cr_type <> 3
          ) loop
            perform pkg.p_set_error(10);
      end loop;
    end if;
    if (pot_page.ck_parent is null and pot_page.cr_type <> 3) or 
       (pot_page.ck_parent is not null and pot_page.cr_type = 3) then
        perform pkg.p_set_error(11);
    end if;
    if pot_page.cr_type <> 3 then
      for vcur_cnt in (
            select ck_view
            from s_mt.t_page p
              where p.ck_id = pot_page.ck_parent
          ) loop
            pot_page.ck_view := vcur_cnt.ck_view;
      end loop;
    end if;
    if pot_page.ck_view is null then
        perform pkg.p_set_error(51, 'message:f9139ac6cf8046d59660b7a5a8340416');
    end if;
    -- Проверяем ссылку
    if pot_page.cl_static is not null and pot_page.cl_static = 1::smallint then
      if pot_page.cv_url is null then
        perform pkg.p_set_error(200, 'meta:39aed4270cb64b6a843a2a334f440b48');
      else
        if upper(pot_page.cv_url) !~ '^[A-Z0-9_-]+$' or pot_page.cv_url ~ '(__|--|-_|_-)' then 
          perform pkg.p_set_error(78, 'meta:39aed4270cb64b6a843a2a334f440b48');
        end if;
        for vcur_cnt in (
          select 1
          from s_mt.t_page a
            where (pot_page.ck_id is not null and a.ck_id <> pot_page.ck_id or pot_page.ck_id is null) 
              and upper(a.cv_url) = upper(pot_page.cv_url)
        ) loop
          perform pkg.p_set_error(201, 'meta:39aed4270cb64b6a843a2a334f440b48');
        end loop;
      end if;
    end if;
    
    if pot_page.cr_type = 2 then /* проверки 35 и 36 актуальны только для страниц */
      if pn_action_view is null and (gl_warning::bigint) = 0 then
        perform pkg.p_set_warning(35);
      end if;
      if pn_action_edit is null and (gl_warning::bigint) = 0 then
        perform pkg.p_set_warning(36);
      end if;
    end if;

    for vcur_cnt in (
      select 1
      from s_mt.t_page a
      where a.ck_id = pot_page.ck_parent and
        a.cr_type = 2
    )loop
      perform pkg.p_set_error(12);
    end loop;

    for vcur_cnt in (
      select 1
      from s_mt.t_page a
      where a.ck_id = pot_page.ck_id and
        (a.cr_type <> pot_page.cr_type) and
        pv_action = u::varchar
    ) loop
      perform pkg.p_set_error(21);
    end loop;
    -- Проверяем на смену родителя, нельзя в дочерний 
    if pv_action = u::varchar then
      for vcur_cnt in (
        with recursive vt_page as (
              select
                  ck_id, ck_parent, 1 as lvl
              from
                  s_mt.t_page
              where
                  ck_id = pot_page.ck_id
          union all
              select
                  p.ck_id, p.ck_parent, rp.lvl + 1 as lvl
              from
                  s_mt.t_page p
              join vt_page rp on
                  p.ck_parent = rp.ck_id
          )
          select 1
          from s_mt.t_page p
          where p.ck_id = pot_page.ck_id 
          and p.ck_parent <> pot_page.ck_parent 
          and pot_page.ck_parent in (select ck_id from vt_page)
      ) loop
          perform pkg.p_set_error(51, '588e2ab956f14295a82048271de5ad5a');
      end loop;
    end if;
   if nullif(gv_error::varchar, '') is not null or nullif(gv_warning::varchar, '') is not null then
   	return;
   end if;

    /* Вставка/обновление */
      if pv_action = i::varchar then
        pot_page.ck_id := sys_guid();
        insert into s_mt.t_page values (pot_page.*);
      elsif pv_action = u::varchar then
        update s_mt.t_page set
          (ck_id, ck_parent, cr_type, cv_name, cn_order, cl_menu, cl_static, cv_url, ck_icon, ck_view, ck_user, ct_change) = 
          (pot_page.ck_id, pot_page.ck_parent, pot_page.cr_type, pot_page.cv_name, pot_page.cn_order, pot_page.cl_menu, pot_page.cl_static, pot_page.cv_url, pot_page.ck_icon, pot_page.ck_view, pot_page.ck_user, pot_page.ct_change)
        where ck_id = pot_page.ck_id;

        if not found then
          perform pkg.p_set_error(504);
          return;
        end if;
      end if;


      /************************/
      /* Работа с page_action */
      /************************/

      /* view */
      /* 1. Получим существующее значение */
      if pv_action = u::varchar then
        select
          p.cn_action
        into
          vn_action_view_old
        from s_mt.t_page_action p
        where p.ck_page = pot_page.ck_id and
          p.cr_type = 'view';

        vn_action_view_old = coalesce(vn_action_view_old, - 1);
      else
        vn_action_view_old := -1;
      end if;
      /* 2. Преобразуем новое значение для удобства сравнений */
      vn_action_view_new := coalesce(pn_action_view,-1);
      /* 3. Проверим, изменилось ли значение */
      if vn_action_view_new <> vn_action_view_old then /* если что-то изменилось */
        if vn_action_view_old = -1 then
        /* если раньше записи не было, а сейчас должна появиться */
          insert into s_mt.t_page_action(ck_id, ck_page, cr_type, cn_action, ck_user, ct_change)
          values (sys_guid(), pot_page.ck_id, 'view', vn_action_view_new, pot_page.ck_user, pot_page.ct_change);
        else /* если раньше была запись */
          if vn_action_view_new = -1 then /* а сейчас удаляется */
            delete from s_mt.t_page_action where ck_page = pot_page.ck_id and cr_type = 'view';
          else /* и сейчас остается, но значение меняется */
            update s_mt.t_page_action
               set cn_action = vn_action_view_new,
                   ck_user = pot_page.ck_user,
                   ct_change = pot_page.ct_change
             where ck_page = pot_page.ck_id
               and cr_type = 'view';
          end if;
        end if;
      end if;

      /* edit - практически аналогично предыдущему */
      /* 1. Получим существующее значение */
      if pv_action = u::varchar then
        select p.cn_action
        into vn_action_edit_old
        from s_mt.t_page_action p
        where p.ck_page = pot_page.ck_id
         and p.cr_type = 'edit';

        vn_action_edit_old = coalesce(vn_action_edit_old, -1);
      else
        vn_action_edit_old := -1;
      end if;
      /* 2. Преобразуем новое значение для удобства сравнений */
      vn_action_edit_new := coalesce(pn_action_edit,-1);
      /* 3. Проверим, изменилось ли значение */
      if vn_action_edit_new <> vn_action_edit_old then /* если что-то изменилось */
        if vn_action_edit_old = -1 then
        /* если раньше записи не было, а сейчас должна появиться */
          insert into s_mt.t_page_action(ck_id, ck_page, cr_type, cn_action, ck_user, ct_change)
          values (sys_guid(), pot_page.ck_id, 'edit', vn_action_edit_new, pot_page.ck_user, pot_page.ct_change);
        else /* если раньше была запись */
          if vn_action_edit_new = -1 then /* а сейчас удаляется */
            delete from s_mt.t_page_action where ck_page = pot_page.ck_id and cr_type = 'edit';
          else /* и сейчас остается, но значение меняется */
            update s_mt.t_page_action
               set cn_action = vn_action_edit_new,
                   ck_user = pot_page.ck_user,
                   ct_change = pot_page.ct_change
             where ck_page = pot_page.ck_id
               and cr_type = 'edit';
          end if;
        end if;
      end if;
  end if;
end;
$$;


ALTER FUNCTION pkg_meta.p_modify_page(pv_action character varying, INOUT pot_page s_mt.t_page, pn_action_view bigint, pn_action_edit bigint) OWNER TO s_mp;

COMMENT ON FUNCTION pkg_meta.p_modify_page(pv_action character varying, INOUT pot_page s_mt.t_page, pn_action_view bigint, pn_action_edit bigint) IS 'Создание/обновление/удаление Страниц t_page, вместе с t_page_action';

CREATE FUNCTION pkg_meta.p_modify_page_attr(pv_action character varying, INOUT pot_page_attr s_mt.t_page_attr) RETURNS s_mt.t_page_attr
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 's_mt', 'pkg_meta', 'public'
    AS $$
declare
  -- переменные пакета
  i sessvarstr;
  u sessvarstr;
  d sessvarstr;
  gv_error sessvarstr;

  -- переменные функции
  vk_d_data_type VARCHAR;
  rec record;
begin
   -- инициализация/получение переменных пакета
  i = sessvarstr_declare('pkg', 'i', 'I');
  u = sessvarstr_declare('pkg', 'u', 'U');
  d = sessvarstr_declare('pkg', 'd', 'D');
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');

  -- код функции
  if pv_action = d::varchar then
    /*Проверки на удаление*/
    /*Удаление*/
    delete from s_mt.t_page_attr where ck_id = pot_page_attr.ck_id;
  else
    /* Блок "Проверка переданных данных" */
    if pot_page_attr.ck_attr is null then
      perform pkg.p_set_error(2);
    end if;

    if nullif(gv_error::varchar, '') is not null then
       return;
    end if;

    if pv_action = i::varchar then
      pot_page_attr.ck_id := sys_guid();
      insert into s_mt.t_page_attr values (pot_page_attr.*);
    elsif pv_action = u::varchar then
      update s_mt.t_page_attr set
        (ck_attr, cv_value, ck_user, ct_change) = 
        (pot_page_attr.ck_attr, pot_page_attr.cv_value, pot_page_attr.ck_user, pot_page_attr.ct_change)
      where ck_id = pot_page_attr.ck_id;
      if not found then
        perform pkg.p_set_error(504);
      end if;
    end if;
    null;
  end if;
end;
$$;


ALTER FUNCTION pkg_meta.p_modify_page_attr(pv_action character varying, INOUT pot_page_attr s_mt.t_page_attr) OWNER TO s_mp;

COMMENT ON FUNCTION pkg_meta.p_modify_page_attr(pv_action character varying, INOUT pot_page_attr s_mt.t_page_attr) IS 'Создание/обновление/удаление настроек страницы';

CREATE FUNCTION pkg_meta.p_modify_page_object(pv_action character varying, INOUT pot_page_object s_mt.t_page_object) RETURNS s_mt.t_page_object
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_meta', 'public'
    AS $$
declare
  -- переменные пакета
  i sessvarstr;
  u sessvarstr;
  d sessvarstr;
  gv_error sessvarstr;

  -- переменные функции
  vv_texterror varchar(4000);
  vcur_hierarchy record;
  vcur_object record;
  vcur_page record;
  vcur_check record;
begin
  -- инициализация/получение переменных пакета
  i = sessvarstr_declare('pkg', 'i', 'I');
  u = sessvarstr_declare('pkg', 'u', 'U');
  d = sessvarstr_declare('pkg', 'd', 'D');
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');

  -- код функции
  if pv_action = d::varchar then
    /*Проверки на удаление*/
    /*Удаление обьекта и всех связанных с ним нижележащих объектов; ошибка возникнет при связи по ck_master */
    begin
      delete from s_mt.t_page_object_attr
      where ck_page_object in (
        with recursive
          q as (
            select
              r.ck_id
            from s_mt.t_page_object r
            where r.ck_id = pot_page_object.ck_id

            union all

            select
              a.ck_id
            from s_mt.t_page_object a
            join q on
              a.ck_parent = q.ck_id
          )

          select
            q.ck_id
          from q
      );

      delete from s_mt.t_page_object
      where ck_id in (
        with recursive
          q as (
            select
              r.ck_id
            from s_mt.t_page_object r
            where r.ck_id = pot_page_object.ck_id

            union all

            select
              a.ck_id
            from s_mt.t_page_object a
            join q on
              a.ck_parent = q.ck_id
          )

          select
            q.ck_id
          from q
      );

    exception
      when foreign_key_violation then
        select
          string_agg(tj.cv_name, ', ' order by tj.cv_name)
        into vv_texterror
        from s_mt.t_object tj
        where tj.ck_id in (
          select tpo.ck_object
          from s_mt.t_page_object tpo
          where tpo.ck_master in (
            with recursive
              q as (
                select
                  r.ck_id
                from s_mt.t_page_object r
                where r.ck_id = pot_page_object.ck_id

                union all

                select
                  a.ck_id
                from s_mt.t_page_object a
                join q on
                  a.ck_parent = q.ck_id
              )

              select
                q.ck_id
              from q
          )
        );
        perform pkg.p_set_error(14, vv_texterror);
       when integrity_constraint_violation then
        perform pkg.p_set_error(14);
    end;
  else
    for vcur_object in (
        select 1
        from s_mt.t_page_object o
        where ((pot_page_object.ck_parent is not null and o.ck_parent = pot_page_object.ck_parent)
         or (pot_page_object.ck_parent is null and o.ck_parent is null))
         and o.ck_page = pot_page_object.ck_page
         and o.cn_order = pot_page_object.cn_order
         and ((pot_page_object.ck_id is not null and o.ck_id <> pot_page_object.ck_id) or pot_page_object.ck_id is null))

    loop
        perform  pkg.p_set_error(34);
    end loop;

    if pot_page_object.ck_page is null then 
      perform  pkg.p_set_error(42);  
    end if;
   
    for vcur_page in (select 1 from s_mt.t_page p where p.ck_id = pot_page_object.ck_page and p.cr_type <> 2) loop
      perform  pkg.p_set_error(205);
    end loop;

    if nullif(pot_page_object.ck_parent, '') is not null then
      /*Проверим иерархию классов*/
      for vcur_hierarchy in (
        select
          count(ch.ck_id)
        from s_mt.t_class_hierarchy ch
        where ch.ck_class_child = (
          select ck_class
          from s_mt.t_object
          where ck_id = pot_page_object.ck_object
        ) and ch.ck_class_parent = (
          select o.ck_class
          from s_mt.t_page_object po
          join s_mt.t_object o on o.ck_id = po.ck_object
          where po.ck_id = pot_page_object.ck_parent
        )
        having count(ch.ck_id) = 0
        /* добавляем не под рут */
        and pot_page_object.ck_parent is not null
      )loop
        perform pkg.p_set_error(13);
      end loop;
    else
      for vcur_hierarchy in (
        select 1
        from s_mt.t_class cl
        where cl.ck_id = (
          select ck_class
          from s_mt.t_object
          where ck_id = pot_page_object.ck_object
        ) and cl.cl_final = 0
      )loop
        perform pkg.p_set_error(51, '6cef8d4302234753bc59aa193c7fe6bb');
      end loop;
    end if;

    -- Проверяем на смену родителя, нельзя в дочерний 
    if pv_action = u::varchar then
      for vcur_object in (
        with recursive vt_page_object as (
              select
                  ck_id, ck_parent, 1 as lvl
              from
                  s_mt.t_page_object
              where
                  ck_id = pot_page_object.ck_id
          union all
              select
                  p.ck_id, p.ck_parent, rp.lvl + 1 as lvl
              from
                  s_mt.t_page_object p
              join vt_page_object rp on
                  p.ck_parent = rp.ck_id
          )
          select 1
          from s_mt.t_page_object po
          where po.ck_id = pot_page_object.ck_id 
          and po.ck_parent <> pot_page_object.ck_parent 
          and pot_page_object.ck_parent in (select ck_id from vt_page_object)
      ) loop
          perform pkg.p_set_error(51, '588e2ab956f14295a82048271de5ad5a');
      end loop;
    end if;
    
    if nullif(gv_error::varchar, '') is not null then
   	  return;
    end if;

    if pv_action = i::varchar then
        /*При вставке записи берем все дочерние элементы и вставляем в той же иерархии, что и в объекте.*/
        if pot_page_object.ck_id is not null then
          for vcur_object in ( select 1 from s_mt.t_page_object where ck_id = pot_page_object.ck_id) loop
            pot_page_object.ck_id := sys_guid();
          end loop;
        else
          pot_page_object.ck_id := sys_guid();
        end if;
        insert into s_mt.t_page_object(ck_id, ck_parent, ck_master, ck_object, ck_page, cn_order, ck_user, ct_change)
        (
          select
            ck_id,
            ck_parent,
            ck_master,
            ck_object,
            ck_page,
            cn_order,
            ck_user,
            ct_change
          from (
            with recursive
              t(ck_id, ck_parent, ck_object, ck_object_parent, cn_level, cn_order) as (
                select
                  pot_page_object.ck_id,
                  pot_page_object.ck_parent,
                  a.ck_id,
                  a.ck_parent,
                  1,
                  a.cn_order
                from s_mt.t_object a
                where a.ck_id =
                    pot_page_object.ck_object
                union all
                select
                  cast(sys_guid() as varchar(32)),
                  t.ck_id,
                  b.ck_id,
                  b.ck_parent,
                  t.cn_level + 1,
                  b.cn_order
                from s_mt.t_object b
                inner join t
                 on b.ck_parent =
                    t.ck_object
              )
              select
                t.ck_id,
                t.ck_parent,
                case /* Мастер прописывается только обьекту первого уровня*/
                 when t.cn_level = 1 then
                  pot_page_object.ck_master
                end ck_master,
                t.ck_object,
                pot_page_object.ck_page,
                /* Для элемента верхнего уровня ставим сортировку, пришедшую с клиента,
                  а для дочерних элементов берем сортировку из обьекта */
                case
                 when t.cn_level = 1 then
                   pot_page_object.cn_order
                 else
                   t.cn_order
                end cn_order,
                pot_page_object.ck_user,
                pot_page_object.ct_change
              from t
              order by t.cn_level
          ) as q
        );
    elsif pv_action = u::varchar then
        for vcur_check in (
          select 1
          from s_mt.t_page_object po
          where po.ck_id = pot_page_object.ck_id and po.ck_parent <> pot_page_object.ck_parent
        ) loop
          perform pkg.p_set_info(83, '52b1e236fa264ac9ab19e1cd44d18376');
        end loop;
      /* Мы можем изменить только порядок и идентификатор мастер-обьекта и родителя */
      update s_mt.t_page_object
         set cn_order  = pot_page_object.cn_order,
             ck_master = pot_page_object.ck_master,
             ck_parent = pot_page_object.ck_parent,
             ck_user   = pot_page_object.ck_user,
             ct_change = pot_page_object.ct_change
       where ck_id = pot_page_object.ck_id;
      if not found then
        perform pkg.p_set_error(504);
        RETURN;
      end if;
    end if;
  end if;
end;
$$;


ALTER FUNCTION pkg_meta.p_modify_page_object(pv_action character varying, INOUT pot_page_object s_mt.t_page_object) OWNER TO s_mp;

COMMENT ON FUNCTION pkg_meta.p_modify_page_object(pv_action character varying, INOUT pot_page_object s_mt.t_page_object) IS 'Создание/обновление/удаление обьектов на странице t_page_object';

CREATE FUNCTION pkg_meta.p_modify_page_object_attr(pv_action character varying, INOUT pot_page_object_attr s_mt.t_page_object_attr) RETURNS s_mt.t_page_object_attr
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_meta', 'public'
    AS $$
declare
  -- переменные пакета
  i sessvarstr;
  u sessvarstr;
  d sessvarstr;
  gv_error sessvarstr;
  gv_warning sessvarstr;
  gl_warning sessvari;

  -- переменные функции
  vcur_check record;
  vcur_pre_check record;
begin
  -- инициализация/получение переменных пакета
  i = sessvarstr_declare('pkg', 'i', 'I');
  u = sessvarstr_declare('pkg', 'u', 'U');
  d = sessvarstr_declare('pkg', 'd', 'D');
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');
  gv_warning = sessvarstr_declare('pkg', 'gv_warning', '');
  gl_warning = sessvari_declare('pkg', 'gl_warning', 0);

  -- код функции
  if pv_action = d::varchar then
    /* значения атрибутов  decimalseparator и thousandseparator в классах Column Numeric и Field Numeric не могут совпадать */
    perform pkg_meta.p_check_separator(pv_action, pot_page_object_attr, null, null);
    if nullif(gv_error::varchar, '') is null then
      delete from s_mt.t_page_object_attr where ck_id = pot_page_object_attr.ck_id;
    end if;
  else
    for vcur_pre_check in (
      select 1 from s_mt.t_class_attr 
      where cl_empty = 0 
      and ck_id = pot_page_object_attr.ck_class_attr 
      and nullif(pot_page_object_attr.cv_value, '') is null
    ) loop
      perform pkg.p_set_error(51, 'eea00f8cc53e471bbf7b8306e3927b5a');
    end loop;
    -- проверка на то, что переменная заведена в t_page_variable
    for vcur_check in (
      with
        t_variable as/*распарсим данные по переменной*/(
          select
            (select ck_page from s_mt.t_page_object where ck_id = pot_page_object_attr.ck_page_object) as ck_page,
            (select ck_attr from s_mt.t_class_attr where ck_id = pot_page_object_attr.ck_class_attr) as ck_attr,
            pot_page_object_attr.cv_value as cv_value
          from dual
        )
        select
          count(v.cv_variable) as cn_cnt_pot/*кол-во глобалок, по которым сейчас делается работа*/,
          count(pv.cv_name) as cn_cnt_page_variable/*кол-во из них, которые есть в t_page_variable*/
        from (
          /* получим в cv_variable имена глобальных переменных */
          select ck_page,
                 t.cv_variable
          from t_variable
          cross join unnest(pkg_util.f_get_global_from_string(t_variable.cv_value, ck_attr)) as t(cv_variable)
          where ck_attr in ('activerules', 'disabledrules', 'hiddenrules', 'getglobaltostore', 'getglobal', 'readonlyrules', 'setrecordtoglobal', 'setglobal', 'columnsfilter')
          and upper(t.cv_variable) not ilike 'G_SYS%' and upper(t.cv_variable) not ilike 'G_SESS%'
        )v
        left join s_mt.t_page_variable pv on pv.ck_page = v.ck_page
         and pv.cv_name = v.cv_variable
        having count(v.cv_variable) <> count(pv.cv_name)
    ) loop
      perform pkg.p_set_error(45);
    end loop;
    -- задаем сеттер для переменной?
    for vcur_pre_check in (
      select 1
      from s_mt.t_class_attr ca
      where ca.ck_id = pot_page_object_attr.ck_class_attr and
        ca.ck_attr in ('setrecordtoglobal', 'setglobal')
    ) loop
      -- проверка на то, что одна и та же переменная не сетится несколько раз из разных мест
      for vcur_check in (
        with
          t_variable as( /*значения POA по странице, могущие быть страничными (глобальными) переменными*/
            select distinct
              ca.ck_attr,
              replace(replace(poa.cv_value, '||', ','), '&&', ',') /*заменим логические операторы на запятые*/ as cv_value
            from s_mt.t_page p
            join s_mt.t_page_object po
             on po.ck_page = p.ck_id
            join s_mt.t_page_object_attr poa
             on poa.ck_page_object = po.ck_id
            join s_mt.t_class_attr ca
             on ca.ck_id = poa.ck_class_attr
            where ca.ck_attr in ('setglobal', 'setrecordtoglobal')
                /* в рамках страницы, на которой мы работаем с переменной */
            and p.ck_id = (select ck_page from s_mt.t_page_object where ck_id = pot_page_object_attr.ck_page_object)
                /* при апдейте не будем учитывать текущий объект */
            and (pv_action = i::varchar or
                 (pv_action = u::varchar and po.ck_id <> pot_page_object_attr.ck_page_object))
          )
          -------------
          select
            t3.cv_variable,
            (
              select /* соберем путь до объекта, двойной слэш нужен для экранирования */
                string_agg(
                  (
                    with recursive
                      q as(
                        select o2.cv_name as cv_name,
                           1 as lvl,
                           po2.ck_parent
                      from s_mt.t_page_object po2
                      join s_mt.t_object o2
                        on o2.ck_id = po2.ck_object
                     where po2.ck_id = poa.ck_page_object

                     union all

                    select o2.cv_name as cv_name,
                           q.lvl + 1 as lvl,
                           po2.ck_parent
                     from s_mt.t_page_object po2
                     join s_mt.t_object o2
                       on o2.ck_id = po2.ck_object
                     join q
                       on po2.ck_id = q.ck_parent
                      )

                      select
                        string_agg(q.cv_name, E'\\' order by q.lvl desc)
                      from q
                  ),
                  '; '
                  order by poa.ck_id
                )
              from s_mt.t_page_object_attr poa
              join s_mt.t_page_object po
               on po.ck_id = poa.ck_page_object
              join s_mt.t_class_attr ca
               on ca.ck_id = poa.ck_class_attr
              join s_mt.t_object o
               on o.ck_id = po.ck_object
              where ca.ck_attr in ('setglobal', 'setrecordtoglobal', 'columnsfilter')
                  /* в рамках страницы, на которой мы работаем с переменной */
              and po.ck_page = (select ck_page from s_mt.t_page_object where ck_id = pot_page_object_attr.ck_page_object)
                  /* при апдейте не будем учитывать текущий объект */
              and (pv_action = i::varchar or (pv_action = u::varchar and po.ck_id <> pot_page_object_attr.ck_page_object))
                  /* там, где используется переменная с этим именем */
              and poa.cv_value like '%' || t3.cv_variable || '%'
            ) as cv_path_set
          from(
            /*если задано несколько переменных через запятую - разложим на строки*/
            /* получим пересечение переменных, уже указанных на странице, и тех, которые сейчас задаем;
              (т.е. по сути ищем, есть ли уже установка переменной с таким же именем, с которым мы задаем установку в настоящий момент */
            select
              cv_variable
            from (/* получим в cv_variable имена глобальных переменных */
              select gl.cv_variable
          		from t_variable
          		cross join unnest(pkg_util.f_get_global_from_string(t_variable.cv_value)) as gl(cv_variable)
            ) v
            intersect
            select pgl.cv_variable
          		from unnest(pkg_util.f_get_global_from_string(pot_page_object_attr.cv_value)) as pgl(cv_variable)
          )t3
      )loop
        if (gl_warning::bigint) = 0 then
          perform pkg.p_set_warning(46, vcur_check.cv_variable, vcur_check.cv_path_set);
        end if;
      end loop;
    end loop;
    -- check percentage for "width"/"columnwidth"
    for vcur_check in (select 1
                         from s_mt.t_class_attr ca
                        where ca.ck_attr in ('width', 'columnwidth', 'contentwidth')
                          and ca.ck_id = pot_page_object_attr.ck_class_attr
                          and nullif(trim(pot_page_object_attr.cv_value), '') is not null
                          and pkg_util.f_check_string_is_percentage(pot_page_object_attr.cv_value) = 0) loop
     perform pkg.p_set_error(55);
    end loop;
    /* значения атрибутов  decimalseparator и thousandseparator в классах Column Numeric и Field Numeric не могут совпадать */
    perform p_check_separator(pv_action, pot_page_object_attr, null, null);
    /* добавление/модификация */
    if nullif(gv_error::varchar, '') is not null or nullif(gv_warning::varchar, '') is not null then
   	  return;
    end if;
    if pv_action = i::varchar then
      pot_page_object_attr.ck_id := sys_guid();
      insert into s_mt.t_page_object_attr values(pot_page_object_attr.*);
    elsif pv_action = u::varchar then
      update s_mt.t_page_object_attr set
        (ck_id, ck_page_object, ck_class_attr, cv_value, ck_user, ct_change) = row(pot_page_object_attr.*)
      where ck_id = pot_page_object_attr.ck_id;
      if not found then
        perform pkg.p_set_error(504);
      end if;
    end if;
  end if;
end;
$$;


ALTER FUNCTION pkg_meta.p_modify_page_object_attr(pv_action character varying, INOUT pot_page_object_attr s_mt.t_page_object_attr) OWNER TO s_mp;

COMMENT ON FUNCTION pkg_meta.p_modify_page_object_attr(pv_action character varying, INOUT pot_page_object_attr s_mt.t_page_object_attr) IS 'Создание/обновление/удаление настроек объекта на странице t_page_object_attr';

CREATE FUNCTION pkg_meta.p_modify_page_variable(pv_action character varying, INOUT pot_page_variable s_mt.t_page_variable) RETURNS s_mt.t_page_variable
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_meta', 'public'
    AS $$
declare
  -- переменные пакета
  i sessvarstr;
  u sessvarstr;
  d sessvarstr;
  gv_error sessvarstr;
  -- переменные функции
  vcur_check record;
  vcur_ak record;
begin
  -- инициализация/получение переменных пакета
  i = sessvarstr_declare('pkg', 'i', 'I');
  u = sessvarstr_declare('pkg', 'u', 'U');
  d = sessvarstr_declare('pkg', 'd', 'D');
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');

  -- код функции
  if pv_action = d::varchar then
    /*Проверки на удаление*/
    for vcur_check in (
      with
        t_variable/*значения POA по странице, могущие быть страничными (глобальными) переменными*/ as(
          select distinct
			      ob.cv_name,
            poa.cv_value
          from s_mt.t_page p
          join s_mt.t_page_object po on po.ck_page = p.ck_id
		      join s_mt.t_object ob on ob.ck_id = po.ck_object
          join s_mt.t_page_object_attr poa on poa.ck_page_object = po.ck_id
          join s_mt.t_class_attr ca on ca.ck_id = poa.ck_class_attr
          where p.ck_id = pot_page_variable.ck_page
           and ca.ck_attr in (
              'setglobal',
              'getglobal',
              'activerules', 
              'setrecordtoglobal',
              'getglobaltostore',
              'hiddenrules',
              'disabledrules',
              'columnsfilter',
              'readonlyrules'
            )
        )
        select string_agg(v.cv_name, ', ') as cv_name
        from (
          /* получим в cv_variable имена глобальных переменных */
          select t.cv_variable, v.cv_name
          from t_variable v
          cross join unnest(pkg_util.f_get_global_from_string(v.cv_value)) as t(cv_variable)
        )v
        where v.cv_variable = pot_page_variable.cv_name
    ) loop
      if vcur_check.cv_name is not null then
          perform pkg.p_set_error(44, vcur_check.cv_name);
      end if;
    end loop;
    /*Удаление*/
    if nullif(gv_error::varchar, '') is null then
      delete from s_mt.t_page_variable where ck_id = pot_page_variable.ck_id;
    end if;
  else
    /* Блок "Проверка переданных данных" */
    if pot_page_variable.cv_name is null then
      perform pkg.p_set_error(2);
    end if;
    if upper(pot_page_variable.cv_name) like 'G_SESS%' or upper(pot_page_variable.cv_name) like 'G_SYS%' then
      perform pkg.p_set_error(77);
    end if;
    if pot_page_variable.cv_description is null then
      perform pkg.p_set_error(26);
    end if;
    if pot_page_variable.ck_page is null then
      perform pkg.p_set_error(42);
    end if;
    /* Проверка Alternative Key */
    for vcur_ak in (
      select 1
      from s_mt.t_page_variable v
      where v.ck_page = pot_page_variable.ck_page
       and v.cv_name = pot_page_variable.cv_name
       and ((v.ck_id <> pot_page_variable.ck_id and pv_action = u::varchar) or
           (pot_page_variable.ck_id is null and pv_action = i::varchar))
    ) loop
      perform pkg.p_set_error(43);
    end loop;
    /* создание/модификация */
    if pv_action = i::varchar and nullif(gv_error::varchar, '') is null then
      pot_page_variable.ck_id := sys_guid();
      insert into s_mt.t_page_variable values (pot_page_variable.*);
    elsif pv_action = u::varchar and nullif(gv_error::varchar, '') is null then
      update s_mt.t_page_variable set
        (ck_page, cv_name, cv_value, cv_description, ck_user, ct_change) = 
        (pot_page_variable.ck_page, pot_page_variable.cv_name, pot_page_variable.cv_value, pot_page_variable.cv_description, pot_page_variable.ck_user, pot_page_variable.ct_change)
      where ck_id = pot_page_variable.ck_id;

      if not found then
        perform pkg.p_set_error(504);
      end if;
    end if;
  end if;
end;
$$;


ALTER FUNCTION pkg_meta.p_modify_page_variable(pv_action character varying, INOUT pot_page_variable s_mt.t_page_variable) OWNER TO s_mp;

COMMENT ON FUNCTION pkg_meta.p_modify_page_variable(pv_action character varying, INOUT pot_page_variable s_mt.t_page_variable) IS 'Создание/обновление/удаление глобальных переменных на странице t_page_variable';

CREATE FUNCTION pkg_meta.p_modify_provider(pv_action character varying, INOUT pot_provider s_mt.t_provider) RETURNS s_mt.t_provider
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_meta', 'public'
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
  -- код функции
  if pv_action = d::varchar then
      /*Проверки на удаление*/
      /*Удаление*/
      delete from s_mt.t_provider where ck_id = pot_provider.ck_id;
  else
    /* Блок "Проверка переданных данных" */
    if pot_provider.cv_name is null then
      perform pkg.p_set_error(2);
    end if;
    if nullif(gv_error::varchar, '') is not null then
      return;
    end if;
    /**/
    if pv_action = i::varchar then
      insert into s_mt.t_provider values (pot_provider.*);
    elsif pv_action = u::varchar then
      update s_mt.t_provider set
        (ck_id, cv_name, ck_user, ct_change) = row(pot_provider.*)
       where ck_id = pot_provider.ck_id;
      if not found then
        perform pkg.p_set_error(519);
      end if;
    end if;
  end if;  
end;
$$;


ALTER FUNCTION pkg_meta.p_modify_provider(pv_action character varying, INOUT pot_provider s_mt.t_provider) OWNER TO s_mp;

COMMENT ON FUNCTION pkg_meta.p_modify_provider(pv_action character varying, INOUT pot_provider s_mt.t_provider) IS 'Создание/обновление/удаление провайдеров данных t_provider';

CREATE FUNCTION pkg_meta.p_modify_sys_setting(pv_action character varying, INOUT pot_sys_setting s_mt.t_sys_setting) RETURNS s_mt.t_sys_setting
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_meta', 'public'
    AS $$
declare
  -- переменные пакета
  i sessvarstr;
  u sessvarstr;
  d sessvarstr;
  gv_error sessvarstr;
  gl_warning sessvari;

  -- переменные функции
begin
  -- инициализация/получение переменных пакета
  i = sessvarstr_declare('pkg', 'i', 'I');
  u = sessvarstr_declare('pkg', 'u', 'U');
  d = sessvarstr_declare('pkg', 'd', 'D');
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');
  gl_warning = sessvari_declare('pkg', 'gl_warning', 0);
  -- код функции
  if (gl_warning::bigint) = 0 then
    if pv_action = u::varchar then
      perform pkg.p_set_warning(54);
    end if;
  else
    /* gl_warning = 1 */
    if pv_action = i::varchar and nullif(gv_error::varchar, '') is null then
      insert into s_mt.t_sys_setting values (pot_sys_setting.*);
    elsif pv_action = u::varchar and nullif(gv_error::varchar, '') is null then
      update s_mt.t_sys_setting
         set cv_value       = pot_sys_setting.cv_value,
             cv_description = pot_sys_setting.cv_description,
             ck_user        = pot_sys_setting.ck_user,
             ct_change      = pot_sys_setting.ct_change
       where ck_id = pot_sys_setting.ck_id;
      if not found then
        perform pkg.p_set_error(504);
      end if;
    end if;
  end if;
end;
$$;


ALTER FUNCTION pkg_meta.p_modify_sys_setting(pv_action character varying, INOUT pot_sys_setting s_mt.t_sys_setting) OWNER TO s_mp;

COMMENT ON FUNCTION pkg_meta.p_modify_sys_setting(pv_action character varying, INOUT pot_sys_setting s_mt.t_sys_setting) IS 'Создание/обновление/удаление глобальных настроек приложения t_sys_setting';

CREATE FUNCTION pkg_meta.p_decode_attr_variable(pv_value varchar, pk_class varchar, pc_json jsonb, pk_attr varchar DEFAULT null::varchar, pv_user varchar DEFAULT '-1'::varchar) RETURNS varchar
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 's_mt', 'pkg_localization', 'pkg_meta', 'public'
    AS $$
declare
  -- переменные пакета
  gv_error sessvarstr;
  d sessvarstr;

  -- переменные функции
  vv_rec record;
  vv_action varchar(1);
  vv_value varchar := pv_value;
  vk_data_type varchar; 
  vv_data_type_extra varchar;
  vot_localization s_mt.t_localization;
begin
  -- инициализация/получение переменных пакета
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');
  d = sessvarstr_declare('pkg', 'd', 'D');

  vv_action = (pc_json#>>'{service,cv_action}');

  if vv_action = d::varchar then
    return vv_value;
  end if;

  if pk_class is not null then
    select a.ck_d_data_type, coalesce(ca.cv_data_type_extra, a.cv_data_type_extra, '[]') as cv_data_type_extra
      into strict vk_data_type, vv_data_type_extra
    from s_mt.t_class_attr ca 
    join s_mt.t_attr a on ca.ck_attr = a.ck_id 
    where ca.ck_id = pk_class;
  elsif pk_attr is not null then
    select a.ck_d_data_type, coalesce(a.cv_data_type_extra, '[]') as cv_data_type_extra
      into strict vk_data_type, vv_data_type_extra
    from s_mt.t_attr a
    where a.ck_id = pk_attr;
  end if;
  

  if vk_data_type = 'text' then
    if vv_value is not null 
      and substr(vv_value, 0, 5) = 'new:'
      and length(vv_value) > 4 then
      vv_value := substr(vv_value, 5);
    end if;
    return vv_value;
  end if;
  
  vv_value := nullif(trim(pv_value), '');

  if vk_data_type = 'localization' then
    if vv_value is not null 
      and substr(vv_value, 0, 5) = 'new:'
      and length(vv_value) > 4 then 
        vot_localization.ck_d_lang = nullif(trim(pc_json#>>'{data,g_sys_lang}'), '');
        vot_localization.cr_namespace = 'meta';
        vot_localization.cv_value = substr(vv_value, 5);
        vot_localization.ck_user = pv_user;
        vot_localization.ct_change = CURRENT_TIMESTAMP;

        vot_localization := pkg_localization.p_add_new_localization(vot_localization);

        vv_value := coalesce(vot_localization.ck_id, '');
    end if;
    if vv_value is not null then
      for vv_rec in (select 1 
        where not exists (select 1 from s_mt.t_localization where ck_id = vv_value)) loop
        perform pkg.p_set_error(81, vk_data_type);
      end loop;
    end if;
    return vv_value;
  end if;
  
  if vk_data_type = 'date' or vk_data_type = 'integer' or vk_data_type = 'numeric' then
    if pk_attr is not null and vv_value is null then 
      perform pkg.p_set_error(80);
    end if;
    return vv_value;
  end if;
  
  if vk_data_type = 'boolean' then
    if vv_value = 'true' or vv_value = '1' then 
      vv_value := 'true';
    else 
      vv_value := 'false';
    end if;
    return vv_value;
  end if;
  
  if vk_data_type = 'enum' then
    for vv_rec in (select 1 
       where not exists (select value from jsonb_array_elements_text(vv_data_type_extra::jsonb) where vv_value is not null and value = vv_value)) loop
       perform pkg.p_set_error(80);
    end loop;
    return vv_value;
  end if;

  if vk_data_type = 'array' or vk_data_type = 'object' or vk_data_type = 'global' or vk_data_type = 'order' then
    if pk_attr is not null and vv_value is null then 
      perform pkg.p_set_error(80);
    end if; 
    begin 
      perform pv_value::jsonb;
    exception
      when others then
        perform pkg.p_set_error(81, vk_data_type);
    end;
    return vv_value;
  end if;

  -- TODO need to validate cssmeasure for consistent value: number + px/%

  return vv_value;
end;
$$;


ALTER FUNCTION pkg_meta.p_decode_attr_variable(varchar,varchar,jsonb,varchar,varchar) OWNER TO s_mp;

COMMENT ON FUNCTION pkg_meta.p_decode_attr_variable(varchar,varchar,jsonb,varchar,varchar) IS 'Преобразование cv_value в varchar';

CREATE FUNCTION pkg_meta.p_refresh_page_object(pk_page character varying) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_meta', 'public'
    AS $$
declare
  vot_page_object  s_mt.t_page_object;
  vct_relation     public.ot_relation[]; -- коллекция для хранения зависимостей между объектами по ck_master
  vct_save_poa     public.ot_save_poa[]; -- коллекция для хранения данных из s_mt.t_page_object_attr
  vct_save_actions public.ot_po_and_path[]; -- to reset PO ID's in t_action (autotesting)
  vk_page_object   varchar(4000);
  vk_po_master     varchar(4000);
  vn_user          bigint; /* не забудь проверить, как в pkg_json_* вызван pkg.p_reset_response; */
  rec record;
  vcur_master record;
  vcur_attr public.ot_save_poa;
  d sessvarstr;
  i sessvarstr;
  gv_error sessvarstr;
begin
  vn_user = sessvari_declare('pkg', 'gn_user', -1)::bigint;
  d = sessvarstr_declare('pkg', 'd', 'D');
  i = sessvarstr_declare('pkg', 'i', 'I');
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');
  /* 1. Запишем привязки к мастер-объектам в коллекцию */
  /* Собираем уникальные пути slave и master объектов,
  при этом идем по иерархии s_mt.t_page_object, но ИД берем самих объектов (s_mt.t_object.ck_id).
  Пути записываем как ИД объектов через запятую, начиная с корня */
  select
    array_agg(row(cv_path, cv_path_master)::public.ot_relation)
  into
    vct_relation
  from(
    with recursive
      t as (
        select
          tp.ck_id,
          tp.ck_parent,
          tp.ck_object,
          tp.ck_master,
          1 as lvl,
          (tp.ck_object || '')::varchar as cv_path,
          tp.ck_page
        from s_mt.t_page_object tp
        where tp.ck_parent is null and
          tp.ck_page = pk_page

        union all

        select
          tp.ck_id,
          tp.ck_parent,
          tp.ck_object,
          tp.ck_master,
          t.lvl + 1 as lvl,
          t.cv_path || ',' || tp.ck_object as cv_path,
          tp.ck_page
        from s_mt.t_page_object tp
        join t on
          tp.ck_parent = t.ck_id and
          tp.ck_page = t.ck_page
      )
      select
        t1.cv_path,
        t2.cv_path as cv_path_master
      from t t1, t t2
      where t1.ck_master = t2.ck_id
  ) as q; /*и складываем эти пути в одну строку соответствий*/

  /* 2. Очистим привязки к мастер-объектам */
  update s_mt.t_page_object
     set ck_master = null
   where ck_page = pk_page
     and ck_master is not null;

  /* 3. Сохраним данные из t_page_object_attr (включая аудит) */
  with recursive
    t as(
      select po.ck_id,
        1 as lvl,
        (po.ck_object || '')::varchar as cv_path,
        po.ck_page
      from s_mt.t_page_object po
      where po.ck_parent is null
        and po.ck_page = pk_page

      union all

      select po.ck_id,
        t.lvl + 1 as lvl,
        t.cv_path || ',' || po.ck_object as cv_path,
        po.ck_page
      from s_mt.t_page_object po
      join t on
        po.ck_parent = t.ck_id and
        po.ck_page = t.ck_page
    )
    select
      array_agg(row(t.cv_path, poa.ck_class_attr, poa.cv_value, poa.ck_user, poa.ct_change)::public.ot_save_poa)
    into
      vct_save_poa
    from t
    join s_mt.t_page_object_attr poa
      on poa.ck_page_object = t.ck_id;

  /* 4. Get a couple "CK_PO" + "path from point of view of Objects" for
        those CK_PO, that are mentioned in t_action (in the range of the refreshed page).
        Save the couples into a collection of ct_po_and_path */
  with recursive
    t_po_with_path as(
      /* this subquery @t_po_with_path should be the same
      with the sibling from step #8 of this create or replace function pkg_meta.*/
      select
        po.ck_id as ck_page_object,
        (po.ck_object || '')::varchar as cv_path,
        po.ck_page
      from s_mt.t_page_object po
      where po.ck_parent is null and
        po.ck_page = pk_page

      union all

      select
        po.ck_id as ck_page_object,
        t.cv_path || ',' || po.ck_object as cv_path,
        po.ck_page
      from s_mt.t_page_object po
      join t_po_with_path as t on
        po.ck_parent = t.ck_page_object and
        po.ck_page = t.ck_page
    )
  --
    select
      array_agg(row(t.ck_page_object, t.cv_path)::ot_po_and_path)
    into vct_save_actions
    from t_po_with_path t
    where t.ck_page_object in /* "IN" used instead of "JOIN" as
                                  there are duplicates in t_action.cv_key;
                                Also I couldn't just use "distinct" as it caused
                                "ORA-22950: cannot ORDER objects without MAP or ORDER method" */
                             (select /*+ push_subq no_unnest */
                                     a.cv_key
                                from s_mt.t_action a);

  /* 5. Перепривяжем к странице объекты, которые уже были привязаны.
  Дочерняя иерархия объектов обновится автоматически. */
  for rec in (
    select
      po.ck_id,
      po.ck_object,
      po.ck_page,
      po.cn_order,
      case
       when po.ck_parent is not null and o.ck_parent is null then 1
       else 0
      end as cl_reusable_obj,
      po_parent.ck_object as ck_parent_object,
      po.ck_user,
      po.ct_change
    from s_mt.t_page_object po
    join s_mt.t_object o
      on o.ck_id = po.ck_object
    left join s_mt.t_page_object po_parent
      on po_parent.ck_id = po.ck_parent
    where po.ck_page = pk_page
        /* возьмем только объекты верхнего уровня + Reusable objects */
     and (po.ck_parent is null or o.ck_parent is null)
    order by cl_reusable_obj asc,
            po.cn_order desc
  ) loop
    /* 5.1. Заполним запись, чтобы дальше использовать эти данные при вызове p_modify_page_object */
    vot_page_object.ck_id := rec.ck_id;
    vot_page_object.ck_parent := null;
    vot_page_object.ck_object := rec.ck_object;
    vot_page_object.ck_master := null;
    vot_page_object.ck_page   := rec.ck_page;
    vot_page_object.cn_order  := rec.cn_order;
    vot_page_object.ck_user   := rec.ck_user; /* аудит родительского объекта будет пропагирован на дочерние */
    vot_page_object.ct_change := rec.ct_change;
    /* 5.1.1. Если это Reusable object, тогда привяжем его к тому же объекту,
    к которому он был привязан раньше. */
    if rec.cl_reusable_obj = 1 then
      begin
        select
          po3.ck_id
        into strict
          vot_page_object.ck_parent
        from s_mt.t_page_object po3
        where po3.ck_page = pk_page
           and po3.ck_object = rec.ck_parent_object
        limit 1;
      exception
        when others then
          
          perform pkg.p_set_error(24);
          return;
      end;
    end if;
    /* 5.2. Удалим привязку объекта к странице */
    /* Reusable objects отвязываются по связи через po.ck_parent при отвязке основных объектов */
    if rec.cl_reusable_obj = 0 then
      perform p_modify_page_object(d::varchar, vot_page_object);
    end if;
    if nullif(gv_error::varchar, '') is not null then
        return;
    end if;
    /* 5.3. Привяжем объект заново */
    perform p_modify_page_object(i::varchar, vot_page_object);
    if nullif(gv_error::varchar, '') is not null then
      return;
    end if;
  end loop;
  if nullif(gv_error::varchar, '') is not null then
      return;
  end if;
  /* 6. Восстановим связи по ck_master */
  begin
    /* В свежепостроенной иерархии в s_mt.t_page_object находим нужные записи,
    сравнивая иерархии объектов с коллекцией vt_relation, заполненной на первом шаге. */
    for vcur_master in (
      select *
      from unnest(vct_relation) as r
    ) loop
      /* Запросы внутри цикла аналогичны запросу на шаге №1 */
      /* Находим slave */
        with recursive
          q as (
            select
              tp.ck_id,
              tp.ck_page,
              (tp.ck_object || '')::varchar as cv_path
            from s_mt.t_page_object tp
            where tp.ck_parent is null and
              tp.ck_page = pk_page

            union all

            select
              tp.ck_id,
              tp.ck_page,
              q.cv_path || ',' ||  tp.ck_object as cv_path
            from s_mt.t_page_object tp
            join q on
              tp.ck_parent = q.ck_id and
              tp.ck_page = q.ck_page
        )

        select
            ck_id
        into
            vk_page_object
        from q
        where cv_path = vcur_master.cv_path_id;
      /* Находим master */
        with recursive
          q as(
            select
              tp.ck_id,
              tp.ck_page,
              (tp.ck_object || '')::varchar as cv_path
            from s_mt.t_page_object tp
            where tp.ck_parent is null and
              tp.ck_page = pk_page

            union all

            select
              tp.ck_id,
              tp.ck_page,
              q.cv_path || ',' || tp.ck_object as cv_path
            from s_mt.t_page_object tp
            join q on
              tp.ck_parent = q.ck_id and
              tp.ck_page = q.ck_page
          )

        select
            ck_id
        into
            vk_po_master
        from q
        where cv_path = vcur_master.cv_path_master_id;
      if vk_po_master is not null and vk_page_object is not null then
      /* Выставляем мастера */
      update s_mt.t_page_object
         set ck_master = vk_po_master
       where ck_id = vk_page_object;
      end if;
    end loop;
  exception
    when others then
      perform pkg.p_set_error(28);
  end;
  if nullif(gv_error::varchar, '') is not null then
      return;
  end if;
  /* 7. Восстановим s_mt.t_page_object_attr */
  begin
    for vcur_attr in (
      select *
      from unnest(vct_save_poa) as r
    ) loop
      with recursive
          q as (
            select
              tp.ck_id,
              (tp.ck_object || '')::varchar as cv_path,
              tp.ck_page
            from s_mt.t_page_object tp
            where tp.ck_parent is null and
              tp.ck_page = pk_page

            union all

            select
              tp.ck_id,
              q.cv_path || ',' || tp.ck_object as cv_path,
              tp.ck_page
            from s_mt.t_page_object tp
            join q on
              tp.ck_parent = q.ck_id and
              tp.ck_page = q.ck_page
          )

          select ck_id
          into vk_page_object
          from q
          where cv_path = vcur_attr.cv_path;
      if vk_page_object is not null then
      insert into s_mt.t_page_object_attr(ck_id, ck_page_object, ck_class_attr, cv_value, ck_user, ct_change)
      values
        (sys_guid(),
         vk_page_object,
         vcur_attr.ck_class_attr,
         vcur_attr.cv_value,
         vcur_attr.ck_user,
         vcur_attr.ct_change
      );
     end if;
    end loop;

  exception
    when others then
    perform pkg.p_set_error(31);
    return;
  end;
  if nullif(gv_error::varchar, '') is not null then
      return;
  end if;
  /* 8. Reset PO ID's in s_mt.t_action */
  insert into s_mt.t_action
  select *
  from(
    select /*+ CARDINALITY(t 500) */
          a.ck_id,
          po_actual.ck_page_object as cv_key
     from s_mt.t_action a
     /* the collection contains old CK_PO and pathes,
        so we are getting the object-pathes by old ID's of PO */
     join unnest(vct_save_actions) t on t.ck_page_object = a.cv_key
     /* match the pathes and get new CK_POs */
    join (
      with recursive
        t_po_with_path as(
           /* this subquery @t_po_with_path should be the same
              with the sibling from step #4 of this create or replace function pkg_meta.*/
          select
            po.ck_id as ck_page_object,
            (po.ck_object || '')::varchar as cv_path,
            po.ck_page
          from s_mt.t_page_object po
          where po.ck_parent is null and
            po.ck_page = pk_page

          union all

          select
            po.ck_id as ck_page_object,
            q.cv_path ||  ',' || po.ck_object as cv_path,
            po.ck_page
          from s_mt.t_page_object po
          join t_po_with_path as q on
            po.ck_parent = q.ck_page_object and
            po.ck_page = q.ck_page
        )
           --
      select
        t.ck_page_object,
        t.cv_path
      from t_po_with_path t
    )po_actual on po_actual.cv_path = t.cv_path
  )x
  on conflict(ck_id) do update set cv_key = excluded.cv_key;
  /*---*/
end;
$$;


ALTER FUNCTION pkg_meta.p_refresh_page_object(pk_page character varying) OWNER TO s_mp;

COMMENT ON FUNCTION pkg_meta.p_refresh_page_object(pk_page character varying) IS 'Перепривязка объетов страницы';

CREATE FUNCTION pkg_meta.p_modify_query(pv_action character varying, INOUT pot_query s_mt.t_query) RETURNS s_mt.t_query
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 's_mt', 'pkg_meta', 'public'
    AS $$
declare
  -- переменные пакета
  i sessvarstr;
  u sessvarstr;
  d sessvarstr;
  gv_error sessvarstr;

  -- переменные функции
  vk_d_data_type VARCHAR;
  rec record;
begin
   -- инициализация/получение переменных пакета
  i = sessvarstr_declare('pkg', 'i', 'I');
  u = sessvarstr_declare('pkg', 'u', 'U');
  d = sessvarstr_declare('pkg', 'd', 'D');
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');

  -- код функции
  if pv_action = d::varchar then
    /*Проверки на удаление*/
    /*Удаление*/
    delete from s_mt.t_query where ck_id = pot_query.ck_id;
  else
    /* Блок "Проверка переданных данных" */
    if pot_query.ck_id is null then
      perform pkg.p_set_error(2);
    end if;

    if nullif(gv_error::varchar, '') is not null then
       return;
    end if;

    if pv_action = i::varchar then
      insert into s_mt.t_query values (pot_query.*);
    elsif pv_action = u::varchar then
      update s_mt.t_query set
        (cc_query, ck_provider, cr_type, cr_access, cn_action, cv_description, ck_user, ct_change) = 
        (pot_query.cc_query, pot_query.ck_provider, pot_query.cr_type, pot_query.cr_access, pot_query.cn_action, pot_query.cv_description, pot_query.ck_user, pot_query.ct_change)
      where ck_id = pot_query.ck_id;
      if not found then
        perform pkg.p_set_error(504);
      end if;
    end if;
    null;
  end if;
end;
$$;


ALTER FUNCTION pkg_meta.p_modify_query(pv_action character varying, INOUT pot_query s_mt.t_query) OWNER TO s_mp;

COMMENT ON FUNCTION pkg_meta.p_modify_query(pv_action character varying, INOUT pot_query s_mt.t_query) IS 'Создание/обновление/удаление сервисов';

CREATE FUNCTION pkg_meta.p_lock_attr(pk_id character varying) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 's_mt', 'pkg_meta', 'public'
    AS $$
declare
  vn_lock bigint;
begin
  if pk_id is not null then
    select 1 into vn_lock from s_mt.t_attr where ck_id = pk_id for update nowait;
  end if;
end;
$$;

ALTER FUNCTION pkg_meta.p_lock_attr(pk_id character varying) OWNER TO s_mp;

CREATE FUNCTION pkg_meta.p_lock_class(pk_id character varying) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 's_mt', 'pkg_meta', 'public'
    AS $$
declare
  vn_lock bigint;
begin
  if pk_id is not null then
    select 1 into vn_lock from s_mt.t_class where ck_id = pk_id for update nowait;
  end if;
end;
$$;

ALTER FUNCTION pkg_meta.p_lock_class(pk_id character varying) OWNER TO s_mp;

CREATE FUNCTION pkg_meta.p_lock_module(pk_id character varying) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 's_mt', 'pkg_meta', 'public'
    AS $$
declare
  vn_lock bigint;
begin
  if pk_id is not null then
    select 1 into vn_lock from s_mt.t_module where ck_id = pk_id for update nowait;
  end if;
end;
$$;

ALTER FUNCTION pkg_meta.p_lock_module(pk_id character varying) OWNER TO s_mp;

CREATE FUNCTION pkg_meta.p_lock_object(pk_id character varying) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 's_mt', 'pkg_meta', 'public'
    AS $$
declare
  vn_lock bigint;
begin
  if pk_id is not null then
    select 1 into vn_lock from s_mt.t_object where ck_id = pk_id for update nowait;
  end if;
end;
$$;

ALTER FUNCTION pkg_meta.p_lock_object(pk_id character varying) OWNER TO s_mp;

CREATE FUNCTION pkg_meta.p_lock_page(pk_id character varying) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 's_mt', 'pkg_meta', 'public'
    AS $$
declare
  vn_lock bigint;
begin
  if pk_id is not null then
    select 1 into vn_lock from s_mt.t_page where ck_id = pk_id for update nowait;
  end if;
end;
$$;

ALTER FUNCTION pkg_meta.p_lock_page(pk_id character varying) OWNER TO s_mp;

CREATE FUNCTION pkg_meta.p_lock_page_object(pk_id character varying) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 's_mt', 'pkg_meta', 'public'
    AS $$
declare
  vn_lock bigint;
begin
  if pk_id is not null then
    select 1 into vn_lock from s_mt.t_page_object where ck_id = pk_id for update nowait;
  end if;
end;
$$;

ALTER FUNCTION pkg_meta.p_lock_page_object(pk_id character varying) OWNER TO s_mp;

CREATE FUNCTION pkg_meta.p_lock_provider(pk_id character varying) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 's_mt', 'pkg_meta', 'public'
    AS $$
declare
  vn_lock bigint;
begin
  if pk_id is not null then
    select 1 into vn_lock from s_mt.t_provider where ck_id = pk_id for update nowait;
  end if;
end;
$$;

ALTER FUNCTION pkg_meta.p_lock_provider(pk_id character varying) OWNER TO s_mp;

CREATE FUNCTION pkg_meta.p_lock_sys_setting(pk_id character varying) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 's_mt', 'pkg_meta', 'public'
    AS $$
declare
  vn_lock bigint;
begin
  if pk_id is not null then
    select 1 into vn_lock from s_mt.t_sys_setting where ck_id = pk_id for update nowait;
  end if;
end;
$$;

ALTER FUNCTION pkg_meta.p_lock_sys_setting(pk_id character varying) OWNER TO s_mp;

CREATE OR REPLACE FUNCTION pkg_meta.p_modify_page_all_object(pc_json jsonb, pv_action character varying, pv_user character varying, pv_parent_object character varying DEFAULT NULL::character varying) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 's_mt', 'pkg_meta', 'public'
    AS $$
declare
  -- переменные пакета
  i sessvarstr;
  u sessvarstr;
  d sessvarstr;
  gv_error sessvarstr;
  gl_warning sessvari;
  gv_warning sessvarstr;

  -- переменные функции
  vot_page_object_attr s_mt.t_page_object_attr;
  vot_object_attr s_mt.t_object_attr;
  vot_object s_mt.t_object;
  vot_page_object s_mt.t_page_object;
  rec record;
  rec2 record;
  rec3 record;
begin
  -- инициализация/получение переменных пакета
  i = sessvarstr_declare('pkg', 'i', 'I');
  u = sessvarstr_declare('pkg', 'u', 'U');
  d = sessvarstr_declare('pkg', 'd', 'D');
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');
  gl_warning = sessvari_declare('pkg', 'gl_warning', 0);
  gv_warning = sessvarstr_declare('pkg', 'gv_warning', '');

  -- код функции
  if pv_action = d::varchar then
    if nullif(trim(pc_json#>>'{ck_page_object}'), '') is not null then
      vot_page_object.ck_id = nullif(trim(pc_json#>>'{ck_page_object}'), '');  
      perform pkg_meta.p_modify_page_object(d::varchar, vot_page_object);
    end if;
    if nullif(trim(pc_json#>>'{ck_object}'), '') is not null then
      for rec in (
        select
              1
          where
              not exists (
                  select
                      1
                  from
                      s_mt.t_object tob
                  join s_mt.t_page_object tpo on
                      tpo.ck_object = tob.ck_id
                      and tpo.ck_id <> nullif(trim(pc_json#>>'{ck_page_object}'), '')
                  where
                      tob.ck_id = nullif(trim(pc_json#>>'{ck_object}'), '')
              ) 
      ) loop
        vot_object.ck_id = nullif(trim(pc_json#>>'{ck_object}'), '');
        perform pkg_meta.p_modify_object(d::varchar, vot_object);
      end loop;
    end if;
    
    RETURN;
  end if;
  /*
  ck_id varchar(32) NOT NULL,
	ck_class varchar(32) NOT NULL,
	ck_parent varchar(32) NULL,
	cv_name varchar(50) NOT NULL,
	cn_order int8 NOT NULL,
	ck_query varchar(255) NULL,
	cv_description varchar(2000) NOT NULL,
	cv_displayed varchar(255) NULL DEFAULT ' '::character varying,
	cv_modify text NULL,
	ck_provider varchar(32) NULL,
	ck_user varchar(150) NOT NULL,
	ct_change timestamptz NOT NULL,
  */
  for rec in (
    select
        ta.ck_id as ck_id,
        case
          when ta.ck_id is not null then
            'U'
          else
            'I'
        end as cv_action,
        (
            coalesce(ja.ck_class, ta.ck_class, tco.ck_id)
        ) as ck_class,
        (
            coalesce(ta.ck_parent, pv_parent_object)
        ) as ck_parent,
        (
            coalesce(ja.cv_name, ta.cv_name)
        ) as cv_name,
        (
            coalesce(ja.cn_order, ta.cn_order::text)
        ) as cn_order,
        (
            coalesce(ja.ck_query, ta.ck_query)
        ) as ck_query,
        (
            coalesce(ja.cv_description, ta.cv_description)
        ) as cv_description,
        (
            coalesce(ja.cv_displayed, ta.cv_displayed)
        ) as cv_displayed,
        (
            coalesce(ja.cv_modify, ta.cv_modify)
        ) as cv_modify,
        (
            coalesce(ja.ck_provider, ta.ck_provider)
        ) as ck_provider
    from
        jsonb_to_record(pc_json) as 
        ja(ck_object text,
           ck_parent text,
           cv_name text,
           ck_class text,
           cn_order text,
           ck_query text,
           cv_description text,
           cv_displayed text,
           cv_modify text,
           ck_provider text,
           type text,
           datatype text
        )
    left join s_mt.t_object ta on
        ja.ck_object = ta.ck_id
    left join s_mt.t_object tpa on
        tpa.ck_id = ta.ck_parent
    join (select
        tc.*,
        tca.cv_value as cv_type,
        tca2.cv_value as cv_datatype
    from
        s_mt.t_class tc
    join s_mt.t_class_attr tca on
        tc.ck_id = tca.ck_class
        and tca.ck_attr = 'type'
    left join s_mt.t_class_attr tca2 on
        tc.ck_id = tca2.ck_class
        and tca2.ck_attr = 'datatype'
        ) tco on
        ta.ck_class = tco.ck_id or (ta.ck_class is null and ja.ck_class = tco.ck_id) or (ta.ck_class is null and ja.ck_class is null and ja.datatype is null and tco.cv_datatype is null and ja.type = tco.cv_type)
        or (ta.ck_class is null and ja.ck_class is null and ja.datatype is not null and tco.cv_datatype is not null and ja.datatype = tco.cv_datatype and ja.type = tco.cv_type)
  ) loop
    vot_object.ck_id = rec.ck_id;
    vot_object.ck_class = rec.ck_class;
    vot_object.ck_parent = rec.ck_parent;
    vot_object.cv_name = rec.cv_name;
    vot_object.cn_order = rec.cn_order::bigint;
    vot_object.ck_query = rec.ck_query;
    vot_object.cv_description = rec.cv_description;
    vot_object.cv_displayed = rec.cv_displayed;
    vot_object.cv_modify = rec.cv_modify;
    vot_object.ck_provider = rec.ck_provider;
    vot_object.ck_user = pv_user;
    vot_object.ct_change = CURRENT_TIMESTAMP;
    vot_object := pkg_meta.p_modify_object(rec.cv_action, vot_object);
  end loop;
  if nullif(gv_error::varchar, '') is not null then
      return;
  end if;
  -- add children
  for rec in (
    select
      *
    from
        jsonb_each(pc_json)
    where
        key in (
            select
                ta.ck_id
            from
                s_mt.t_attr ta
            where
                ta.ck_attr_type = 'placement'
        ) and value is not null and jsonb_typeof(value) = 'array' and value::text <> '[]'
  ) loop
    for rec2 in (
        select
          *
        from
            jsonb_array_elements(rec.value)
      ) loop
        perform pkg_meta.p_modify_page_all_object(rec2.value, pv_action, pv_user, vot_object.ck_id);
        if nullif(gv_error::varchar, '') is not null then
          return;
        end if;
      end loop;
  end loop;

  vot_page_object.ck_page = nullif(trim(pc_json#>>'{ck_page}'), '');
  vot_page_object.ck_object = vot_object.ck_id;
  vot_page_object.ck_id = nullif(trim(pc_json#>>'{ck_page_object}'), '');
  vot_page_object.cn_order = nullif(trim(pc_json#>>'{cn_order}'), '')::bigint;
  vot_page_object.ck_master = null;
  vot_page_object.ck_parent = nullif(trim(pc_json#>>'{ck_parent}'), '');
  vot_page_object.ck_user = pv_user;
  vot_page_object.ct_change = CURRENT_TIMESTAMP;
    
  if vot_page_object.ck_parent is null then
    for rec in (
        select
          1
        from
            s_mt.t_page_object
        where ck_id = vot_page_object.ck_id
      ) loop
        perform pkg_meta.p_modify_page_object(d::varchar, vot_page_object);
    end loop;
  end if;
  if nullif(gv_error::varchar, '') is not null then
      return;
  end if;
  -- clear children
  /*
  for rec in (
    select
    ja.*
    from
        jsonb_each(pc_json) as ja
    where
        ja.key in (
            select
                ta.ck_id
            from
                s_mt.t_attr ta
            where
                ta.ck_attr_type = 'placement'
        ) and ja.value is not null and jsonb_typeof(ja.value) = 'array' and ja.value::text <> '[]'
  ) loop
    for rec2 in (
        select
          tob.ck_id,
          ja2.*
        from s_mt.t_object tob
        left join jsonb_array_elements(rec.value) as ja2 on
        ja2.value#>>'{ck_object}' = tob.ck_id
        where ja2.value is null
      ) loop
        if rec2.ck_id is not null then
          for rec3 in (
            select
                  1
              where
                  not exists (
                      select
                          1
                      from
                          s_mt.t_object tob1
                      join s_mt.t_page_object tpo1 on
                          tpo1.ck_object = tob1.ck_id
                          and tpo1.ck_page <> nullif(trim(pc_json#>>'{ck_page}'), '')
                      where
                          tob1.ck_id = rec2.ck_id
                  ) 
          ) loop
            vot_object.ck_id := rec2.ck_id;
            perform pkg_meta.p_modify_object(d::varchar, vot_object);
          end loop;
        end if;
      end loop;
  end loop;
  */
  if nullif(gv_error::varchar, '') is not null then
      return;
  end if;
  -- add attributes
  for rec in (
    select
      toa.ck_id,
      case
          when toa.ck_id is not null then
            'U'
          else
            'I'
      end as cv_action,
      tca.ck_id as ck_class_attr,
      (
        coalesce(ja.value, toa.cv_value)
      ) as cv_value
    from s_mt.t_object tobj
    join s_mt.t_class_attr tca on 
      tobj.ck_class = tca.ck_class 
    join jsonb_each_text(pc_json) as ja on
      ja.key = tca.ck_attr
    left join s_mt.t_object_attr toa on 
      toa.ck_class_attr = tca.ck_id and toa.ck_object = tobj.ck_id
    where
      tobj.ck_id = vot_object.ck_id and 
      tca.ck_attr not in (
            select
                ta.ck_id
            from
                s_mt.t_attr ta
            where
                ta.ck_attr_type in ('placement', 'system', 'behavior')
        )
  ) loop
    vot_object_attr.ck_id = rec.ck_id;
    vot_object_attr.ck_object = vot_object.ck_id;
    vot_object_attr.ck_class_attr = rec.ck_class_attr;
    vot_object_attr.cv_value = rec.cv_value;
    vot_object_attr.ck_user = pv_user;
    vot_object_attr.ct_change = CURRENT_TIMESTAMP;
    perform pkg_meta.p_modify_object_attr(rec.cv_action, vot_object_attr);
    if nullif(gv_error::varchar, '') is not null then
      perform pkg.p_set_error(51, row_to_json(vot_object)::text);
      return;
    end if;
  end loop;
  if vot_page_object.ck_parent is null then
    vot_page_object := pkg_meta.p_modify_page_object(i::varchar, vot_page_object);
  end if;
  RETURN;
end;
$$;


ALTER FUNCTION pkg_meta.p_modify_page_all_object(jsonb, varchar, varchar, varchar) OWNER TO s_mp;
