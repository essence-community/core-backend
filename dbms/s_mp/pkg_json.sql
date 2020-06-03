--liquibase formatted sql
--changeset artemov_i:pkg_json dbms:postgresql runOnChange:true splitStatements:false stripComments:false
DROP SCHEMA IF EXISTS pkg_json cascade;

CREATE SCHEMA pkg_json
    AUTHORIZATION s_mp;


ALTER SCHEMA pkg_json OWNER TO s_mp;

CREATE FUNCTION pkg_json.f_get_object(pk_start character varying) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER PARALLEL SAFE
    SET search_path TO 'pkg_json', 'public'
    AS $$
begin
  /*Добавление статичных объектов*/
  return (select jsonb_build_object('ck_page_object', po.ck_id,
                                    'ck_object', o.ck_id,
                                    'cl_dataset', c.cl_dataset,
                                    'cv_name', o.cv_name,
                                    'cv_displayed', o.cv_displayed,
                                    'cv_description', o.cv_description,
                                    'ck_master', po.ck_master,
                                    'ck_page', po.ck_page,
                                    'ck_parent', po.ck_parent,
                                    'cn_order', po.cn_order
      ) ||
      coalesce((select '{"cl_is_master": 1}'::jsonb 
        where exists (select 1 from s_mt.t_page_object po_master 
        where po_master.ck_master = po.ck_id)), '{}'::jsonb)
      ||
      case when c.cl_dataset::int = 1 then jsonb_build_object('ck_query', o.ck_query,
                                                              'ck_modify', 'modify',
                                                              'cv_helper_color',
                              case when o.ck_query is null and o.cv_modify is null then 'red'
                                   when o.ck_query is null or o.cv_modify is null then 'yellow'
                                   else 'blue'
                               end
        )
        else '{}'::jsonb
      end
      /*Добавление динамических атрибутов из класса и обьекта*/
      || coalesce((select jsonb_object_agg(t.ck_attr,
                                 pkg_json.f_decode_attr(t.cv_value, t.ck_d_data_type)) as attr_po
           from
           (select ca2.ck_attr,
                   a2.ck_d_data_type,
                   coalesce(poa.cv_value, oa.cv_value, ca2.cv_value) as cv_value
              from s_mt.t_class_attr ca2
              join s_mt.t_attr a2 on a2.ck_id = ca2.ck_attr
              left join s_mt.t_object_attr oa on o.ck_id = oa.ck_object and ca2.ck_id = oa.ck_class_attr
              left join s_mt.t_page_object_attr poa on poa.ck_page_object = po.ck_id and poa.ck_class_attr = ca2.ck_id
             where ca2.ck_class = c.ck_id and ca2.ck_id not in 
             (select ck_class_attr from s_mt.t_class_hierarchy ch where ch.ck_class_attr in 
             (select ck_id from s_mt.t_class_attr where ck_class = c.ck_id))) as t where t.cv_value is not null), '{}'::jsonb)
        /*Сборка атрибутов дочерних объектов*/
      || coalesce((select pkg_json.f_agg_merge_jsonb(pca.ck_attr, (pkg_json.f_get_object(po3.ck_id))::jsonb  order by po3.cn_order)
              from s_mt.t_page_object po3 
              join s_mt.t_object o2 on o2.ck_id = po3.ck_object
              join s_mt.t_class c2 on c2.ck_id = o2.ck_class
              join s_mt.t_class_hierarchy ch on c2.ck_id = ch.ck_class_child
              join s_mt.t_class_attr pca on pca.ck_id = ch.ck_class_attr
             where po3.ck_parent = po.ck_id and pca.ck_class = c.ck_id
             ), '{}'::jsonb)
    from s_mt.t_page_object po 
    join s_mt.t_object o on o.ck_id = po.ck_object
    join s_mt.t_class c on o.ck_class = c.ck_id
   where po.ck_id = pk_start
  )::varchar;
end;
$$;


ALTER FUNCTION pkg_json.f_get_object(pk_start character varying) OWNER TO s_mp;


CREATE FUNCTION pkg_json.f_decode_attr(pv_value varchar, pk_data_type varchar) RETURNS jsonb
    LANGUAGE plpgsql SECURITY DEFINER PARALLEL SAFE
    SET search_path TO 'pkg_json', 'public'
    AS $$
begin

  if pk_data_type = 'localization' or pk_data_type = 'enum' or pk_data_type = 'date' or pk_data_type = 'text' then
    return to_jsonb(pv_value);
  end if;
  
  if pk_data_type = 'integer' then
    return to_jsonb(pv_value::bigint);
  end if;

  if pk_data_type = 'numeric' then
    return to_jsonb(pv_value::decimal);
  end if;
  
  if pk_data_type = 'boolean' then
    if pv_value is null then 
      return to_jsonb(false);
    end if;
    return to_jsonb(pv_value::bool);
  end if;
  
  if pk_data_type = 'array' or pk_data_type = 'object' then 
    return pv_value::jsonb;
  end if;

  return to_jsonb(pv_value);
end;
$$;

ALTER FUNCTION pkg_json.f_decode_attr(pv_value varchar, pk_data_type varchar) OWNER TO s_mp;

CREATE FUNCTION pkg_json.f_merge_jsonb(res jsonb, keyValue varchar, val jsonb) RETURNS jsonb
    LANGUAGE sql SECURITY DEFINER PARALLEL SAFE
    SET search_path TO 'pkg_json', 'public'
    AS $$
    select coalesce(res, '{}'::jsonb) || jsonb_build_object(keyValue, coalesce(res->keyValue,'[]'::jsonb) || val)
$$;
ALTER FUNCTION pkg_json.f_merge_jsonb(res jsonb, keyValue varchar, val jsonb) OWNER TO s_mp;

CREATE AGGREGATE pkg_json.f_agg_merge_jsonb (varchar, jsonb)
(
    sfunc = pkg_json.f_merge_jsonb,
    stype = jsonb
);
ALTER AGGREGATE pkg_json.f_agg_merge_jsonb(varchar, jsonb) OWNER TO s_mp;
