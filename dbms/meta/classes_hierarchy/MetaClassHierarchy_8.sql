--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_8 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '220' as ck_id, '1' as ck_class_parent, '8' as ck_class_child, '623' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '203' as ck_id, '137' as ck_class_parent, '8' as ck_class_child, '621' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '565' as ck_id, '317' as ck_class_parent, '8' as ck_class_child, '1149' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '865' as ck_id, '32' as ck_class_parent, '8' as ck_class_child, '138' as ck_class_attr, '10020785' as ck_user, '2018-03-04T00:00:00.000+0000' as ct_change
    union all
    select '62' as ck_id, '35' as ck_class_parent, '8' as ck_class_child, '172' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '2' as ck_id, '8' as ck_class_parent, '10' as ck_class_child, '8' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '3' as ck_id, '8' as ck_class_parent, '11' as ck_class_child, '8' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '1986' as ck_id, '8' as ck_class_parent, '1457' as ck_class_child, '30' as ck_class_attr, '10020785' as ck_user, '2018-07-12T00:00:00.000+0000' as ct_change
    union all
    select '64' as ck_id, '8' as ck_class_parent, '15' as ck_class_child, '8' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '8' as ck_id, '8' as ck_class_parent, '16' as ck_class_child, '8' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '11' as ck_id, '8' as ck_class_parent, '19' as ck_class_child, '30' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '446' as ck_id, '8' as ck_class_parent, '257' as ck_class_child, '974' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '66' as ck_id, '8' as ck_class_parent, '32' as ck_class_child, '54' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '4985' as ck_id, '8' as ck_class_parent, '3457' as ck_class_child, '8' as ck_class_attr, '10020785' as ck_user, '2018-08-28T00:00:00.000+0000' as ct_change
    union all
    select '85' as ck_id, '8' as ck_class_parent, '36' as ck_class_child, '8' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '907' as ck_id, '8' as ck_class_parent, '437' as ck_class_child, '8' as ck_class_attr, '-11' as ck_user, '2018-04-04T00:00:00.000+0000' as ct_change
    union all
    select '106' as ck_id, '8' as ck_class_parent, '57' as ck_class_child, '8' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '116' as ck_id, '8' as ck_class_parent, '58' as ck_class_child, '391' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '6994' as ck_id, '8' as ck_class_parent, '6457' as ck_class_child, '36174' as ck_class_attr, '20785' as ck_user, '2018-12-11T00:00:00.000+0000' as ct_change
    union all
    select '127' as ck_id, '8' as ck_class_parent, '77' as ck_class_child, '8' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select 'EAA1EB370989422689188E72C3CFD01B' as ck_id, '8' as ck_class_parent, '8C96F9B255F5407FBCB8DE9189B15F39' as ck_class_child, '30' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-11-18T12:15:34.260+0000' as ct_change
    union all
    select '1' as ck_id, '8' as ck_class_parent, '9' as ck_class_child, '8' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
