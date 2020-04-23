--liquibase formatted sql
--changeset artemov_i:MTGetValuesForPOA.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTGetValuesForPOA', '/*MTGetValuesForPOA*/
select
    jsonb_build_object (
        ''cv_value'',
        t.cv_value
    ) as json
from
    (
        select
            ca.cv_value
        from
            s_mt.t_class_attr ca
        where
            ca.cv_value is not null
            /*##filter.gk_attr*/and ca.ck_attr = :json::json#>>''{filter,gk_attr}'' /*##filter.gk_attr*/
            /*##filter.cv_entered*/and lower(ca.cv_value) like lower(:json::json#>>''{filter,cv_entered}'') || ''%'' /*filter.cv_entered##*/
        group by
            ca.cv_value
    union
        select
            oa.cv_value
        from
            s_mt.t_object_attr oa
        join s_mt.t_class_attr ca on
            ca.ck_id = oa.ck_class_attr
        where
            oa.cv_value is not null
            /*##filter.gk_attr*/and ca.ck_attr = :json::json#>>''{filter,gk_attr}'' /*##filter.gk_attr*/
            /*##filter.cv_entered*/and lower(oa.cv_value) like lower(:json::json#>>''{filter,cv_entered}'') || ''%'' /*filter.cv_entered##*/
        group by
            oa.cv_value
    union
        select
            poa.cv_value
        from
            s_mt.t_page_object_attr poa
        join s_mt.t_class_attr ca on
            ca.ck_id = poa.ck_class_attr
        where
            poa.cv_value is not null 
            /*##filter.gk_attr*/and ca.ck_attr = :json::json#>>''{filter,gk_attr}'' /*##filter.gk_attr*/
            /*##filter.cv_entered*/and lower(poa.cv_value) like lower(:json::json#>>''{filter,cv_entered}'') || ''%'' /*filter.cv_entered##*/
        group by
            poa.cv_value
        order by
            cv_value
    ) t
   ', 'meta', '20783', '2019-05-31 11:45:15.860063+03', 'select', 'po_session', NULL, 'Необходимо актуализировать')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;

