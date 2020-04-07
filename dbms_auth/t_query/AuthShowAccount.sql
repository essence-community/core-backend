--liquibase formatted sql
--changeset artemov_i:AuthShowAccount.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id,cc_query,ck_provider,ck_user,ct_change,cr_type,cr_access,cv_description)
VALUES ('AuthShowAccount','/*AuthShowAccount*/
select /*Pagination*/
       count(1) over() as jn_total_cnt,
       /*Accounts*/
       t.*
  from (
select ac.ck_id,
       ac.cv_login,
       ac.cv_name,
       ac.cv_surname,
       ac.cv_timezone,
       ac.cv_patronymic,
       ac.cv_email,
       ac.ck_user,
       ac.ct_change at time zone :sess_cv_timezone as ct_change
  from t_account ac
 where true
      /*##filter.ck_id*/
   and ac.ck_id = (:json::json#>>''{filter,ck_id}'')::uuid/*filter.ck_id##*/
      /*##filter.cv_login*/
   and upper(ac.cv_login) like
       upper(trim(:json::json#>>''{filter,cv_login}'')) || ''%'' /*filter.cv_login##*/
      /*##filter.cv_name*/
   and upper(ac.cv_name) like
       upper(trim(:json::json#>>''{filter,cv_name}'')) || ''%'' /*filter.cv_name##*/
      /*##filter.cv_surname*/
   and upper(ac.cv_surname) like
       upper(trim(:json::json#>>''{filter,cv_surname}'')) || ''%'' /*filter.cv_surname##*/
  ) t
 where &FILTER
 order by &SORT
offset &OFFSET rows
 fetch first &FETCH rows only','authcore','-11','2019-08-13 18:30:00.000','select','po_session','Отображение пользователей')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cv_description = excluded.cv_description;
