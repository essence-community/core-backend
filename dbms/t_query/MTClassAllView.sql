--liquibase formatted sql
--changeset artemov_i:MTClassAllView dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTClassAllView', '/*MTClassAllView*/
select
    row_to_json(t.*) as json
from
    (
        select
            tc.ck_id,
            tc.cl_dataset,
            tc.cl_final,
            tc.ck_view,
            tc.cv_description,
            tc.cv_name,
            tca.cv_value as cv_type,
            tca2.cv_value as cv_datatype,
            (
                select
                    jsonb_agg(jsonb_build_object(''ck_attr'', tca3.ck_attr, ''ck_d_data_type'', ta2.ck_d_data_type, ''cv_data_type_extra'', coalesce(tca3.cv_data_type_extra, ta2.cv_data_type_extra)))
                from
                    s_mt.t_class_attr tca3
                join s_mt.t_attr ta2 on
                    tca3.ck_attr = ta2.ck_id
                where
                    tca3.ck_class = tc.ck_id
                    and tca3.ck_attr not in (
                        select
                            ta.ck_id
                        from
                            s_mt.t_attr ta
                        where
                            ta.ck_attr_type in (
                                ''placement'', ''system''
                            )
                    )
            ) as properties,
            (
                select
                    jsonb_agg(jsonb_build_object(''ck_attr'', tca1.ck_attr, ''ck_class'', tc1.ck_id, ''cv_type'', tca.cv_value, ''cv_datatype'', tca2.cv_value))
                from
                    s_mt.t_class_hierarchy tch
                join s_mt.t_class_attr tca1 on
                    tch.ck_class_attr = tca1.ck_id
                join s_mt.t_class tc1 on
                    tc1.ck_id = tch.ck_class_child
                join s_mt.t_class_attr tca on
                    tc1.ck_id = tca.ck_class
                    and tca.ck_attr = ''type''
                left join s_mt.t_class_attr tca2 on
                    tc1.ck_id = tca2.ck_class
                    and tca2.ck_attr = ''datatype''
                where
                    tch.ck_class_parent = tc.ck_id
            ) as children,
            (
                select
                    jsonb_agg(jsonb_build_object(''ck_attr'', tca1.ck_attr, ''ck_class'', tc1.ck_id, ''cv_type'', tca.cv_value, ''cv_datatype'', tca2.cv_value))
                from
                    s_mt.t_class_hierarchy tch
                join s_mt.t_class_attr tca1 on
                    tch.ck_class_attr = tca1.ck_id
                join s_mt.t_class tc1 on
                    tc1.ck_id = tch.ck_class_parent
                join s_mt.t_class_attr tca on
                    tc1.ck_id = tca.ck_class
                    and tca.ck_attr = ''type''
                left join s_mt.t_class_attr tca2 on
                    tc1.ck_id = tca2.ck_class
                    and tca2.ck_attr = ''datatype''
                where
                    tch.ck_class_child = tc.ck_id
            ) as parents
        from
            s_mt.t_class tc
        join s_mt.t_class_attr tca on
            tc.ck_id = tca.ck_class
            and tca.ck_attr = ''type''
        left join s_mt.t_class_attr tca2 on
            tc.ck_id = tca2.ck_class
            and tca2.ck_attr = ''datatype''
        where
            true
            /*##filter.ck_view*/ and tc.ck_view = :json::json#>>''{filter,ck_view}''/*filter.ck_view##*/ 
            /*##filter.gk_view*/ and tc.ck_view = :json::json#>>''{filter,gk_view}''/*filter.gk_view##*/
    ) as t
 ', 'meta', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-06-03 11:18:09.874041+03', 'select', 'po_session', NULL, 'Список всех классов')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cn_action = excluded.cn_action, cv_description = excluded.cv_description;
