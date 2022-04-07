--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_337 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '705' as ck_id, '1' as ck_class_parent, '337' as ck_class_child, '623' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '706' as ck_id, '137' as ck_class_parent, '337' as ck_class_child, '621' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '707' as ck_id, '32' as ck_class_parent, '337' as ck_class_child, '138' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '912' as ck_id, '337' as ck_class_parent, '438' as ck_class_child, '1729' as ck_class_attr, '-11' as ck_user, '2018-04-05T00:00:00.000+0000' as ct_change
    union all
    select '8E7C598A0D9F6572E053809BA8C0F580' as ck_id, '58' as ck_class_parent, '337' as ck_class_child, '382' as ck_class_attr, '20786' as ck_user, '2019-07-24T00:00:00.000+0000' as ct_change
    union all
    select 'E180EBE0D62B4ECAB1782C7B2E5D7566' as ck_id, 'DF451F5CC0A54F8791C4DFAC12DAE42E' as ck_class_parent, '337' as ck_class_child, 'E2D0A96506384965A7B2666E5D2D1970' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-21T00:00:00.000+0000' as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
