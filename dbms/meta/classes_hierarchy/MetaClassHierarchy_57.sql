--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_57 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '105' as ck_id, '18' as ck_class_parent, '57' as ck_class_child, '27' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '107' as ck_id, '38' as ck_class_parent, '57' as ck_class_child, '306' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '831B66C74FEB4164B6B1D46D9EEAC76D' as ck_id, '57' as ck_class_parent, '19' as ck_class_child, '5A71798ADE90475B941C914EDF5E1339' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-03-25T11:54:16.065+0000'::timestamp with time zone as ct_change
    union all
    select 'DC17044025A1468A95659E655C81D702' as ck_id, '57' as ck_class_parent, '8C96F9B255F5407FBCB8DE9189B15F39' as ck_class_child, '5A71798ADE90475B941C914EDF5E1339' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-03-25T11:54:25.998+0000'::timestamp with time zone as ct_change
    union all
    select '106' as ck_id, '8' as ck_class_parent, '57' as ck_class_child, '8' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
