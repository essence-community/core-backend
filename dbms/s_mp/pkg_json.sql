--liquibase formatted sql
--changeset artemov_i:pkg_json dbms:postgresql runOnChange:true splitStatements:false stripComments:false
DROP SCHEMA IF EXISTS pkg_json cascade;

CREATE SCHEMA pkg_json
    AUTHORIZATION s_mp;


ALTER SCHEMA pkg_json OWNER TO s_mp;

CREATE FUNCTION pkg_json.f_get_object(pk_start character varying) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
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
      end ||
      /*Добавление динамических атрибутов из класса и обьекта*/
      coalesce(
        (select jsonb_object_agg(t.ck_attr,
                                 pkg_json.f_decode_attr(coalesce(t.cv_value_poa, t.cv_value_oa, t.cv_value_ca), t.ck_d_data_type))
           from
           (select ca.ck_attr,
                   a.ck_d_data_type,
                   poa.cv_value as cv_value_poa,
                   oa.cv_value as cv_value_oa,
                   ca.cv_value as cv_value_ca
              from s_mt.t_object o2
              join s_mt.t_class c on c.ck_id = o2.ck_class
              join s_mt.t_class_attr ca on c.ck_id = ca.ck_class
              join s_mt.t_attr a on a.ck_id = ca.ck_attr
              left join s_mt.t_object_attr oa on o2.ck_id = oa.ck_object and ca.ck_id = oa.ck_class_attr
              left join s_mt.t_page_object_attr poa on  poa.ck_page_object = po.ck_id and poa.ck_class_attr = ca.ck_id
             where o2.ck_id = o.ck_id
               and not exists (select 1
                                 from s_mt.t_class_hierarchy ch
                                where ca.ck_id = ch.ck_class_attr)
                                order by ca.ck_attr) t
        ),
        '{}'::jsonb
      ) ||
      /*Сборка атрибутов дочерних объектов*/
      coalesce(
        (select jsonb_object_agg(q.ck_attr,
                                 q.val)
           from
           (select tp.ck_attr,
                   jsonb_agg(res.jdata::jsonb) as val
              from
              (select ca.ck_attr,
                      attr_po.ck_id
                 from s_mt.t_page_object attr_po
                 join s_mt.t_object attr_o on attr_po.ck_object = attr_o.ck_id
                 join s_mt.t_class attr_c on attr_c.ck_id = attr_o.ck_class
                 join s_mt.t_class_hierarchy ch on ch.ck_class_child = attr_c.ck_id
                 join s_mt.t_object o2 on ch.ck_class_parent = o2.ck_class
                 join s_mt.t_page_object h on o2.ck_id = h.ck_object
                 join s_mt.t_class_attr ca on ca.ck_id = ch.ck_class_attr
                where attr_po.ck_parent = pk_start
                  and h.ck_id = pk_start
                order by ca.ck_attr,
                      coalesce(attr_po.cn_order, attr_o.cn_order)) tp
              left join f_get_object(tp.ck_id) as res(jdata) on 1 = 1
             group by tp.ck_attr
             order by tp.ck_attr
          ) as q
        ),
        '{}'::jsonb
      )
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
    LANGUAGE plpgsql SECURITY DEFINER
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
