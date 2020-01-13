--liquibase formatted sql
--changeset artemov_i:CORE-601 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
select pkg_patcher.p_update_localization();
--changeset artemov_i:CORE-642 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
select pkg_patcher.p_delete_dup_localization();
--changeset artemov_i:CORE-650-meta-to-static dbms:postgresql
select pkg_patcher.p_find_static_in_meta_localization();
--changeset artemov_i:CORE-689 dbms:postgresql
update s_mt.t_object_attr toa1
set ck_class_attr = toa2.ck_class_attr_new
from (select 
toa.ck_class_attr, ca1.ck_id as ck_class_attr_new 
from s_mt.t_object_attr toa
join s_mt.t_class_attr ca 
on toa.ck_class_attr = ca.ck_id and ca.ck_attr = 'idproperty'
join s_mt.t_class_attr ca1
on ca.ck_class = ca1.ck_class and ca1.ck_attr = 'getmastervalue') as toa2
where toa1.ck_class_attr = toa2.ck_class_attr;

update s_mt.t_page_object_attr toa1
set ck_class_attr = toa2.ck_class_attr_new
from (select 
toa.ck_class_attr, ca1.ck_id as ck_class_attr_new 
from s_mt.t_page_object_attr toa
join s_mt.t_class_attr ca 
on toa.ck_class_attr = ca.ck_id and ca.ck_attr = 'idproperty'
join s_mt.t_class_attr ca1
on ca.ck_class = ca1.ck_class and ca1.ck_attr = 'getmastervalue') as toa2
where toa1.ck_class_attr = toa2.ck_class_attr;
