--liquibase formatted sql
--changeset artemov_i:MTGetPage.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTGetPage', '/*MTGetPage*/
select /*Pagination*/
       count(1) over() as jn_total_cnt,
       /*Page*/
       t.*
  from (
     select p.ck_id, p.cv_name, l.cv_value as cv_name_lang
     from s_mt.t_page p
     join s_mt.t_localization l
     on p.cv_name = l.ck_id and l.ck_d_lang = :json::json#>>''{filter,ck_d_lang}''
     where p.cr_type = 2
     /*##filter.ck_id*/ and p.ck_id = :json::json#>>''{filter,ck_id}'' /*filter.ck_id##*/
     /*##filter.cv_name*/ and l.cv_value = :json::json#>>''{filter,cv_name}'' /*filter.cv_name##*/
     /*##filter.cv_entered*/ and lower(l.cv_value) like (lower(:json::json#>>''{filter,cv_entered}'') || ''%'')/*filter.cv_entered##*/
) t
 where &FILTER
 order by &SORT
offset &OFFSET rows
 fetch first &FETCH rows only
 ', 'meta', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2023-03-07 09:01:45.268324+03', 'select', 'po_session', NULL, 'Список страниц')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cn_action = excluded.cn_action, cv_description = excluded.cv_description;

