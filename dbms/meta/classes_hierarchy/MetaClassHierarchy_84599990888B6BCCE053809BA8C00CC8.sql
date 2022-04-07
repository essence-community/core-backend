--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_84599990888B6BCCE053809BA8C00CC8 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '846060F16DF560F2E053809BA8C0CA26' as ck_id, '32' as ck_class_parent, '84599990888B6BCCE053809BA8C00CC8' as ck_class_child, '138' as ck_class_attr, '20785' as ck_user, '2019-03-17T00:00:00.000+0000' as ct_change
    union all
    select 'B48FA45DFC7E439C95D2934C111E18F3' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '84599990888B6BCCE053809BA8C00CC8' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:55:57.282+0000' as ct_change
    union all
    select '631D579AFA48484C8EF21919FB22ECF3' as ck_id, '4BA159E82B434939AAD293411854ED95' as ck_class_parent, '84599990888B6BCCE053809BA8C00CC8' as ck_class_child, '53F747643BEE49B795CA755F3532E598' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-09-20T00:00:00.000+0000' as ct_change
    union all
    select '87A9EF4DBB295226E053809BA8C0E1C2' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '84599990888B6BCCE053809BA8C00CC8' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '20785' as ck_user, '2019-05-16T00:00:00.000+0000' as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
