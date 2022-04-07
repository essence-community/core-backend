--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_317 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '566' as ck_id, '137' as ck_class_parent, '317' as ck_class_child, '621' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '565' as ck_id, '317' as ck_class_parent, '8' as ck_class_child, '1149' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '885' as ck_id, '32' as ck_class_parent, '317' as ck_class_child, '138' as ck_class_attr, '10020785' as ck_user, '2018-03-05T00:00:00.000+0000' as ct_change
    union all
    select '87BF545279B313EDE053809BA8C0A884' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '317' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '20785' as ck_user, '2019-05-16T00:00:00.000+0000' as ct_change
    union all
    select '846' as ck_id, '9' as ck_class_parent, '317' as ck_class_child, '39' as ck_class_attr, '10020785' as ck_user, '2018-02-28T00:00:00.000+0000' as ct_change
    union all
    select '4405DAE3F4AE478CB0E0B9B8EF635A60' as ck_id, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_parent, '317' as ck_class_child, '4F0C103E377040179EF412F13E09D265' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-17T00:00:00.000+0000' as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
