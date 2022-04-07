--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_18 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '221' as ck_id, '1' as ck_class_parent, '18' as ck_class_child, '623' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '204' as ck_id, '137' as ck_class_parent, '18' as ck_class_child, '621' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '9985' as ck_id, '18' as ck_class_parent, '10' as ck_class_child, '27' as ck_class_attr, '20788' as ck_user, '2019-01-16T00:00:00.000+0000' as ct_change
    union all
    select '925' as ck_id, '18' as ck_class_parent, '11' as ck_class_child, '27' as ck_class_attr, '10020786' as ck_user, '2018-04-19T00:00:00.000+0000' as ct_change
    union all
    select '2985' as ck_id, '18' as ck_class_parent, '1457' as ck_class_child, '31' as ck_class_attr, '10020785' as ck_user, '2018-07-15T00:00:00.000+0000' as ct_change
    union all
    select '6' as ck_id, '18' as ck_class_parent, '15' as ck_class_child, '27' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '7' as ck_id, '18' as ck_class_parent, '16' as ck_class_child, '27' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '9' as ck_id, '18' as ck_class_parent, '17' as ck_class_child, '27' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '13' as ck_id, '18' as ck_class_parent, '19' as ck_class_child, '31' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '447' as ck_id, '18' as ck_class_parent, '257' as ck_class_child, '977' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '35' as ck_id, '18' as ck_class_parent, '32' as ck_class_child, '55' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '86' as ck_id, '18' as ck_class_parent, '36' as ck_class_child, '27' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '909' as ck_id, '18' as ck_class_parent, '437' as ck_class_child, '27' as ck_class_attr, '-11' as ck_user, '2018-04-04T00:00:00.000+0000' as ct_change
    union all
    select '105' as ck_id, '18' as ck_class_parent, '57' as ck_class_child, '27' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '117' as ck_id, '18' as ck_class_parent, '58' as ck_class_child, '392' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '128' as ck_id, '18' as ck_class_parent, '77' as ck_class_child, '27' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '5BAE3378AF3744848ED597A74E54B902' as ck_id, '18' as ck_class_parent, '8C96F9B255F5407FBCB8DE9189B15F39' as ck_class_child, '31' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-11-18T12:15:34.260+0000' as ct_change
    union all
    select '10' as ck_id, '18' as ck_class_parent, '9' as ck_class_child, '27' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '94' as ck_id, '32' as ck_class_parent, '18' as ck_class_child, '138' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '63' as ck_id, '35' as ck_class_parent, '18' as ck_class_child, '172' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
