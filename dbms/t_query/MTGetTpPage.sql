--liquibase formatted sql
--changeset artemov_i:MTGetTpPage.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTGetTpPage', '/*MTGetTpPage*/

select 0 as cn_key, 

       ''Модуль'' as cv_value

  from dual

 union all

select 1,

       ''Каталог''

  from dual     

 union all

select 2, 

       ''Страница''

  from dual

 order by 1

   ', 'meta', '20783', '2019-05-30 14:37:08.870496+03', 'select', 'po_session', NULL, 'Необходимо актуализировать')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;

