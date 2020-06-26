--liquibase formatted sql
--changeset artemov_i:MOVE_FILE dbms:postgresql runOnChange:true splitStatements:false stripComments:false
UPDATE public.databasechangelog
SET filename='meta/scripts.sql'
WHERE id='CORE-601' AND filename='./meta/scripts.sql';
UPDATE public.databasechangelog
SET filename='meta/scripts.sql'
WHERE id='CORE-642' AND filename='./meta/scripts.sql';
UPDATE public.databasechangelog
SET filename='meta/scripts.sql'
WHERE id='CORE-689' AND filename='./meta/scripts.sql';
UPDATE public.databasechangelog
SET filename='meta/scripts.sql'
WHERE id='CORE-650-meta-to-static' AND filename='./meta/scripts.sql';
UPDATE public.databasechangelog
SET filename='meta/scripts.sql'
WHERE id='CORE-847_clear_page_variable' AND filename='./meta/scripts.sql';
UPDATE public.databasechangelog
SET filename='meta/scripts.sql'
WHERE id='CORE-1772_clear_edit_mode' AND filename='./meta/scripts.sql';
--changeset artemov_i:CORE-601 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
select pkg_patcher.p_update_localization();
--changeset artemov_i:CORE-642 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
select pkg_patcher.p_delete_dup_localization();
--changeset artemov_i:CORE-650-meta-to-static dbms:postgresql
select pkg_patcher.p_find_static_in_meta_localization();
--changeset artemov_i:CORE-689 dbms:postgresql runOnChange:true
update s_mt.t_object_attr toa1
set ck_class_attr = toa2.ck_class_attr_new
from (select 
toa.ck_class_attr, ca1.ck_id as ck_class_attr_new 
from s_mt.t_object_attr toa
join s_mt.t_class_attr ca 
on toa.ck_class_attr = ca.ck_id and ca.ck_attr = 'idproperty'
join s_mt.t_class_attr ca1
on ca.ck_class = ca1.ck_class and ca1.ck_attr = 'getmastervalue') as toa2
where toa1.ck_class_attr = toa2.ck_class_attr and not exists (select 1 from s_mt.t_object_attr where ck_class_attr=toa2.ck_class_attr_new);

update s_mt.t_page_object_attr toa1
set ck_class_attr = toa2.ck_class_attr_new
from (select 
toa.ck_class_attr, ca1.ck_id as ck_class_attr_new 
from s_mt.t_page_object_attr toa
join s_mt.t_class_attr ca 
on toa.ck_class_attr = ca.ck_id and ca.ck_attr = 'idproperty'
join s_mt.t_class_attr ca1
on ca.ck_class = ca1.ck_class and ca1.ck_attr = 'getmastervalue') as toa2
where toa1.ck_class_attr = toa2.ck_class_attr and not exists (select 1 from s_mt.t_page_object_attr where ck_class_attr=toa2.ck_class_attr_new);

--changeset artemov_i:CORE-847_clear_page_variable dbms:postgresql runOnChange:true
DELETE FROM s_mt.t_page_variable
WHERE upper(cv_name) like 'G_SESS%' or upper(cv_name) like 'G_SYS%' or upper(cv_name) like 'GSYS%' or upper(cv_name) like 'GSESS%';

--changeset artemov_i:CORE-1772_clear_edit_mode dbms:postgresql runOnChange:true
delete from s_mt.t_page_object_attr toa1
where toa1.ck_id in (
select toa.ck_id from s_mt.t_page_object_attr toa
join s_mt.t_page_object tpo
on toa.ck_page_object = tpo.ck_id
join s_mt.t_object to2
on tpo.ck_object = to2.ck_id
where toa.ck_class_attr = '632' and to2.ck_query is null);

delete from s_mt.t_object_attr toa1
where toa1.ck_id in 
(select toa.ck_id from s_mt.t_object_attr toa   
join s_mt.t_object to2
on toa.ck_object = to2.ck_id
where toa.ck_class_attr = '632' and to2.ck_query is null);
