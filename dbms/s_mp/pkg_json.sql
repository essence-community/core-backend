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
      case when t_master_list.cl_is_master::int = 1 then '{"cl_is_master": 1}'::jsonb
           else '{}'::jsonb
       end ||
      case when c.cl_dataset::int = 1 then jsonb_build_object('ck_query', o.ck_query,
                                                              'ck_modify', 'modify',
                                                              'cv_helper_color',
                              case when o.ck_query is null and o.cv_modify is null then 'red'
                                   when o.ck_query is null or o.cv_modify is null then 'yellow'
                                   else 'blue'
                               end
        )
        else '{}'::jsonb
        /*Добавление динамических атрибутов из класса и обьекта*/
      end || coalesce((select jsonb_object_agg(t.ck_attr,
                                 pkg_json.f_decode_attr(t.cv_value, t.ck_d_data_type)) as attr_po
           from
           (select ca.ck_attr,
                   a.ck_d_data_type,
                   coalesce(poa.cv_value, oa.cv_value, ca.cv_value) as cv_value
              from s_mt.t_object o2
              join s_mt.t_page_object po2 on o2.ck_id = po2.ck_object
              join s_mt.t_class c on c.ck_id = o2.ck_class
              join s_mt.t_class_attr ca on c.ck_id = ca.ck_class
              join s_mt.t_attr a on a.ck_id = ca.ck_attr
              left join s_mt.t_object_attr oa on o2.ck_id = oa.ck_object and ca.ck_id = oa.ck_class_attr
              left join s_mt.t_page_object_attr poa on poa.ck_page_object = po2.ck_id and poa.ck_class_attr = ca.ck_id
              left join s_mt.t_class_hierarchy ch on ca.ck_id = ch.ck_class_attr 
             where po2.ck_id = po.ck_id and ch.ck_id is null) as t where t.cv_value is not null), '{}'::jsonb)
        /*Сборка атрибутов дочерних объектов*/
      || coalesce((select jsonb_object_agg(t.ck_attr, t.json_attr_ch_po::jsonb) as attr_ch_po
           from
           (select pca.ck_attr,
                   '[' || string_agg(pkg_json.f_get_object(po3.ck_id) order by po3.cn_order ) || ']' as json_attr_ch_po
              from s_mt.t_page_object po3 
              join s_mt.t_object o2 on o2.ck_id = po3.ck_object
              join s_mt.t_class c2 on c2.ck_id = o2.ck_class
              join s_mt.t_class_hierarchy ch on c2.ck_id = ch.ck_class_child
              join s_mt.t_class_attr pca on pca.ck_id = ch.ck_class_attr
             where po3.ck_parent = po.ck_id and pca.ck_class = c.ck_id
             group by pca.ck_attr) as t), '{}'::jsonb)
    from s_mt.t_object o
    join s_mt.t_class c on o.ck_class = c.ck_id
    join s_mt.t_page_object po on o.ck_id = po.ck_object
    join s_mt.t_page p on p.ck_id = po.ck_page
    left join(select po_master.ck_object,
                     1 as cl_is_master
                from s_mt.t_page_object po_master
                join s_mt.t_page_object po_master_related on po_master_related.ck_master = po_master.ck_id
               group by po_master.ck_object) t_master_list on t_master_list.ck_object = o.ck_id
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
end;
$$;

ALTER FUNCTION pkg_json.f_decode_attr(pv_value varchar, pk_data_type varchar) OWNER TO s_mp;
