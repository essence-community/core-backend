--liquibase formatted sql
--changeset artemov_i:MTProvider dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description, cc_query)
 VALUES('MTProvider', 'meta', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2022-03-22T20:40:17.559+0300', 'select', 'po_session', null, 'Необходимо актуализировать',
 '/*MTProvider*/
select t.ck_id,
       t.cv_name,
       t.ck_user,
       t.ct_change at time zone :sess_cv_timezone as ct_change
  from s_mt.t_provider t
 where ( &FILTER )
 /*##filter.ck_id*/and t.ck_id = :json::jsonb#>>''{filter,ck_id}''/*filter.ck_id##*/
 /*##filter.ck_id_like*/and upper(t.ck_id) like ''%'' || upper(:json::jsonb#>>''{filter,ck_id_like}'' ) || ''%''/*filter.ck_id_like##*/
 order by &SORT
  '
) on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cn_action = excluded.cn_action, cv_description = excluded.cv_description;
