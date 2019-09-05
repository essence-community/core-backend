--liquibase formatted sql
--changeset artemov_i:MTGetPage.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTGetPage', '/*MTGetPage*/

select t.ck_id, t.cv_name

  from (

  with recursive

    q as (select p.ck_id,

                 p.cv_name,

                 p.cr_type,

                 array[p.cn_order] as sort

            from s_mt.t_page p

           where p.ck_parent is null



           union all



          select p.ck_id,

                 p.cv_name,

                 p.cr_type,

                 q.sort || p.cn_order as sort

            from s_mt.t_page p

            join q on p.ck_parent = q.ck_id)

  select q.ck_id,

         q.cv_name

    from q

    where cr_type = 2 /* Страницы */

   order by q.sort

) t

where true 

/*##filter.cv_entered*/ and lower(t.cv_name) like (lower(:json::json#>>''{filter,cv_entered}'') || ''%'')/*filter.cv_entered##*/

 ', 'meta', '20783', '2019-05-28 09:01:45.268324+03', 'select', 'po_session', NULL, 'Необходимо актуализировать')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;

