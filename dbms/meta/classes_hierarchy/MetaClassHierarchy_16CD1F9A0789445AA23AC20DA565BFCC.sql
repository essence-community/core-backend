--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_16CD1F9A0789445AA23AC20DA565BFCC dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '914AA4CD5A0149F69C4805B917825A21' as ck_id, '1807D17438814B31B75A279C4CBC6C0C' as ck_class_parent, '16CD1F9A0789445AA23AC20DA565BFCC' as ck_class_child, '225864898ED0411FA0E5434CD3A85346' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-04T00:00:00.000+0000' as ct_change
    union all
    select '1E6AF1F3CAA54A2F972A8E8AA68F013D' as ck_id, 'BA125F895507411E8730C07D3AD26A3A' as ck_class_parent, '16CD1F9A0789445AA23AC20DA565BFCC' as ck_class_child, '0A71556DD08146C496C07ED8E2375751' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-03T00:00:00.000+0000' as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
