--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_35 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '219' as ck_id, '1' as ck_class_parent, '35' as ck_class_child, '623' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '205' as ck_id, '137' as ck_class_parent, '35' as ck_class_child, '621' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '69242842B678467E8C6A16BB30EEAB6D' as ck_id, '35' as ck_class_parent, '1' as ck_class_child, '172' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-06-11T13:29:20.057+0000' as ct_change
    union all
    select '232' as ck_id, '35' as ck_class_parent, '137' as ck_class_child, '172' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '259' as ck_id, '35' as ck_class_parent, '157' as ck_class_child, '172' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '63' as ck_id, '35' as ck_class_parent, '18' as ck_class_child, '172' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '308' as ck_id, '35' as ck_class_parent, '217' as ck_class_child, '172' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '345' as ck_id, '35' as ck_class_parent, '35' as ck_class_child, '172' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '62' as ck_id, '35' as ck_class_parent, '8' as ck_class_child, '172' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '8FFC6C4564B94157E053809BA8C00266' as ck_id, '35' as ck_class_parent, '8FFC6C4564B84157E053809BA8C00266' as ck_class_child, '172' as ck_class_attr, '20785' as ck_user, '2019-08-13T00:00:00.000+0000' as ct_change
    union all
    select 'E754E5180C5D4BCEAF3EA89125E6ADD1' as ck_id, '35' as ck_class_parent, 'D966BA30FBA3469FB5FEA82127B1ED6D' as ck_class_child, '172' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-09-27T00:00:00.000+0000' as ct_change
    union all
    select 'D4241C82BFAC41E19AA89693F88EA3D9' as ck_id, '35' as ck_class_parent, 'system:check_list_container' as ck_class_child, '172' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-03-17T08:33:14.574+0000' as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
