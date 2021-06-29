--liquibase formatted sql
--changeset dudin_m:MTClassAttrType.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTClassAttrType', '/*MTClassAttrType*/
select t.ck_id,
       t.cv_name,	
       t.cv_description
  from (select att.ck_id,
               att.cv_name,
               att.cv_description
          from s_mt.t_attr_type att
         union all
        select ''all'',
               ''Все'',
               ''все атрибуты''
       ) t
 order by t.ck_id asc', 'meta', '20783', '2019-11-22 12:06:22.563679+03', 'select', 'po_session', NULL, 'Необходимо актуализировать')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cn_action = excluded.cn_action, cv_description = excluded.cv_description;

