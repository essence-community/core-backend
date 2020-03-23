--liquibase formatted sql
--changeset artemov_i:MTGetObjectUsedQuery dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTGetObjectUsedQuery', '/*MTGetObjectUsedQuery*/
select
    ob.ck_id,
    ob.cv_name,
    ob.cv_displayed,
    ob.cv_obj_path,
    ob.ck_user,
    ob.ct_change at time zone :sess_cv_timezone as ct_change
from
    (
        with obj as (
            with class_attr as (
                select ck_id from s_mt.t_class_attr ca where ca.ck_attr in (''defaultvaluequery'',''redirectusequery'',''updatequery'')
            )
            select
                distinct o.ck_id,
                o.cv_name,
                o.cv_displayed,
                o.ck_user,
                o.ct_change
            from
                s_mt.t_query tq
            left join s_mt.t_object_attr o_attr on
                o_attr.ck_class_attr in (select ck_id from class_attr) and o_attr.cv_value = tq.ck_id
            left join s_mt.t_class_attr ca on
                ca.ck_id in (select ck_id from class_attr) and ca.cv_value = tq.ck_id
            join s_mt.t_object o on
                tq.ck_id = o.ck_query
                or o_attr.ck_object = o.ck_id
                or ca.ck_class = o.ck_id
            where
                tq.ck_id = :json::json#>>''{master,ck_id}''
                /*##filter.ck_id*/and o.ck_id = :json::json#>>''{filter,ck_id}''/*filter.ck_id##*/
        )
        select
            o.ck_id,
            o.cv_name,
            o.cv_displayed,
            o.ck_user,
            o.ct_change,
            ro2.cv_obj_path
        from
            obj o
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
                                ck_id
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
            ro2.ck_object = o.ck_id
    ) as ob
where &FILTER
order by &SORT
   ', 'meta', '20783', '2019-05-31 11:31:00.722329+03', 'select', 'po_session', NULL, 'Список объектов использующих сервис')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;
