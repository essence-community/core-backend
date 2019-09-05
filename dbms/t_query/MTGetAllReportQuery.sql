--liquibase formatted sql
--changeset artemov_i:MTGetAllReportQuery.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTGetAllReportQuery', '/*MTGetAllReportQuery*/
select ck_id, cv_description, ck_provider, cn_action, ck_page, cv_page
  from (select q.ck_id, q.cv_description, q.ck_provider, q.cn_action, r.ck_page, p.cv_name as cv_page
          from t_query q
          join t_dynamic_report r
            on q.ck_id = r.ck_query
          left join t_page p 
            on p.ck_id = r.ck_page
         where q.cr_type = ''report'') as t
 where &FILTER
 order by &SORT', 'meta', '-11', '2019-07-23 06:52:27+03', 'select', 'po_session', NULL, 'Список всех запросов универсальной печати')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;

