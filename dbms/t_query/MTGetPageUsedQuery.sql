--liquibase formatted sql
--changeset artemov_i:MTGetPageUsedQuery dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTGetPageUsedQuery', '/*MTGetPageUsedQuery*/
select
    p.ck_id,
    p.cv_name,        
    p.cv_page_obj_path,
    p.ck_user,
    p.ct_change at time zone :sess_cv_timezone as ct_change
from
    (
        with obj as (
            select
                distinct 
                p.ck_id,
                o.ck_id as ck_object,
                p.cv_name,
                p.ck_user,
                p.ct_change
            from
                s_mt.t_query tq
            left join s_mt.t_object_attr o_attr on
                o_attr.cv_value = tq.ck_id
            left join s_mt.t_class_attr ca on
                ca.cv_value = tq.ck_id
            left join s_mt.t_page_object_attr po_attr on
                po_attr.cv_value = tq.ck_id
            left join s_mt.t_page_object po on
                po.ck_id = po_attr.ck_page_object
            join s_mt.t_object o on
                tq.ck_id = o.ck_query
                or o_attr.ck_object = o.ck_id
                or po.ck_object = o.ck_id
                or ca.ck_class = o.ck_id
            join s_mt.t_page_object po2
               on po2.ck_object = o.ck_id
            join s_mt.t_page p
               on po2.ck_page = p.ck_id 
            where
                tq.ck_id = :json::json#>>''{master,ck_id}''
                /*##filter.ck_id*/and o.ck_id = :json::json#>>''{filter,ck_id}''/*filter.ck_id##*/
        )
        select
            p.ck_id,
            p.cv_name,
            p.ck_user,
            p.ct_change,
            string_agg(ro2.cv_obj_path, chr(10)) as cv_page_obj_path
        from
            obj p
        join (
                with recursive tr_obj as (
                    select
                        to2.ck_id,
                        to2.ck_parent,
                        to2.cv_name,
                        to2.ck_id as ck_object,
                        1 as lvl
                    from
                        s_mt.t_object to2
                    where
                        ck_id in (
                            select
                                ck_object
                            from
                                obj
                        )
                union all
                    select
                        to2.ck_id,
                        to2.ck_parent,
                        to2.cv_name,
                        ro.ck_object,
                        ro.lvl + 1 as lvl
                    from
                        s_mt.t_object to2
                    join tr_obj ro on
                        ro.ck_parent = to2.ck_id
                )
                select
                    ro.ck_object,
                    string_agg(ro.cv_name, '' / '' order by ro.lvl desc) as cv_obj_path
                from
                    tr_obj ro
                group by
                    ro.ck_object
            ) as ro2 on
            ro2.ck_object = p.ck_object
          group by p.ck_id,
            p.cv_name,
            p.ck_user,
            p.ct_change
    ) as p
where &FILTER
order by &SORT
   ', 'meta', '20783', '2019-05-31 11:31:00.722329+03', 'select', 'po_session', NULL, 'Список страниц использующих сервис')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;
