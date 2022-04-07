--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_437 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '909' as ck_id, '18' as ck_class_parent, '437' as ck_class_child, '27' as ck_class_attr, '-11' as ck_user, '2018-04-04T00:00:00.000+0000' as ct_change
    union all
    select '20A30007B2B84742AE85C5A66E2A790F' as ck_id, '37' as ck_class_parent, '437' as ck_class_child, '270' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-18T00:00:00.000+0000' as ct_change
    union all
    select '988' as ck_id, '38' as ck_class_parent, '437' as ck_class_child, '306' as ck_class_attr, '10020848' as ck_user, '2018-07-10T00:00:00.000+0000' as ct_change
    union all
    select '907' as ck_id, '8' as ck_class_parent, '437' as ck_class_child, '8' as ck_class_attr, '-11' as ck_user, '2018-04-04T00:00:00.000+0000' as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
