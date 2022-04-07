--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_9 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '10' as ck_id, '18' as ck_class_parent, '9' as ck_class_child, '27' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '92' as ck_id, '37' as ck_class_parent, '9' as ck_class_child, '270' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '665' as ck_id, '38' as ck_class_parent, '9' as ck_class_child, '306' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '1' as ck_id, '8' as ck_class_parent, '9' as ck_class_child, '8' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '11996' as ck_id, '9' as ck_class_parent, '10457' as ck_class_child, '39' as ck_class_attr, '30021381' as ck_user, '2019-01-24T00:00:00.000+0000' as ct_change
    union all
    select '289' as ck_id, '9' as ck_class_parent, '197' as ck_class_child, '39' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '42' as ck_id, '9' as ck_class_parent, '26' as ck_class_child, '39' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '43' as ck_id, '9' as ck_class_parent, '27' as ck_class_child, '39' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '44' as ck_id, '9' as ck_class_parent, '28' as ck_class_child, '39' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '45' as ck_id, '9' as ck_class_parent, '29' as ck_class_child, '39' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '46' as ck_id, '9' as ck_class_parent, '30' as ck_class_child, '39' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '47' as ck_id, '9' as ck_class_parent, '31' as ck_class_child, '39' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '846' as ck_id, '9' as ck_class_parent, '317' as ck_class_child, '39' as ck_class_attr, '10020785' as ck_user, '2018-02-28T00:00:00.000+0000' as ct_change
    union all
    select '627' as ck_id, '9' as ck_class_parent, '33' as ck_class_child, '39' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '648' as ck_id, '9' as ck_class_parent, '357' as ck_class_child, '39' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '126' as ck_id, '9' as ck_class_parent, '37' as ck_class_child, '39' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '125' as ck_id, '9' as ck_class_parent, '38' as ck_class_child, '39' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '529089CA2C4B4263BC92171EF10627CE' as ck_id, '9' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, '39' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-04-09T00:00:00.000+0000' as ct_change
    union all
    select '8987' as ck_id, '9' as ck_class_parent, '8457' as ck_class_child, '39' as ck_class_attr, '20786' as ck_user, '2018-12-24T00:00:00.000+0000' as ct_change
    union all
    select '9D0879C0F086450FABF015D6F256459F' as ck_id, '9' as ck_class_parent, 'DA77FDDE896F48909B19EBB516326D33' as ck_class_child, '39' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-06-03T13:49:26.799+0000' as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
