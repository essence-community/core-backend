--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_8FFC6C4564B84157E053809BA8C00266 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '4A50D11419BA492CAF12BBCA044C0BD0' as ck_id, '1' as ck_class_parent, '8FFC6C4564B84157E053809BA8C00266' as ck_class_child, '623' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-10-12T15:17:43.050+0000' as ct_change
    union all
    select '8FFF734D4DB9414BE053809BA8C08F58' as ck_id, '137' as ck_class_parent, '8FFC6C4564B84157E053809BA8C00266' as ck_class_child, '621' as ck_class_attr, '20785' as ck_user, '2019-08-13T00:00:00.000+0000' as ct_change
    union all
    select 'D2070D6582414F0D89D5D95143EDB6A1' as ck_id, '32' as ck_class_parent, '8FFC6C4564B84157E053809BA8C00266' as ck_class_child, '138' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-02-03T00:00:00.000+0000' as ct_change
    union all
    select '8FFC6C4564B94157E053809BA8C00266' as ck_id, '35' as ck_class_parent, '8FFC6C4564B84157E053809BA8C00266' as ck_class_child, '172' as ck_class_attr, '20785' as ck_user, '2019-08-13T00:00:00.000+0000' as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
