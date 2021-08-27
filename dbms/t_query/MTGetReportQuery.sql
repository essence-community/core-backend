--liquibase formatted sql
--changeset artemov_i:MTGetReportQuery.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTGetReportQuery', '/*MTGetReportQuery*/
select qu.ck_id, qu.cv_description, qu.ck_page
  from (select q.ck_id, q.cv_description, r.ck_page
          from t_query q
          join t_dynamic_report r
            on q.ck_id = r.ck_query
         where q.cn_action in (
                    select tss.cv_value::bigint as cn_action from s_mt.t_sys_setting tss where tss.ck_id = ''g_sys_anonymous_action''
                    union all
                    select value::bigint as cn_action from jsonb_array_elements_text(:sess_ca_actions::jsonb)
                )
           and q.cr_type = ''report'') as qu
 where &FILTER
 order by &SORT', 'meta', '-11', '2019-07-23 06:52:27+03', 'select', 'po_session', NULL, 'Список запросов универсальной печати')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;

