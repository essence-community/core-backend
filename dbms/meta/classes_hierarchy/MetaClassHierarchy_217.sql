--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_217 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '745' as ck_id, '137' as ck_class_parent, '217' as ck_class_child, '621' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '305' as ck_id, '217' as ck_class_parent, '1' as ck_class_child, '829' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '306' as ck_id, '217' as ck_class_parent, '137' as ck_class_child, '829' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '2987' as ck_id, '217' as ck_class_parent, '1457' as ck_class_child, '830' as ck_class_attr, '10020785' as ck_user, '2018-07-15T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '946' as ck_id, '217' as ck_class_parent, '19' as ck_class_child, '830' as ck_class_attr, '10020785' as ck_user, '2018-04-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'D34644DED7504C57BC2BB31394FA0FD8' as ck_id, '217' as ck_class_parent, '7C133EA0021A44A0864B82F7BC40F183' as ck_class_child, '91BEE2DE87E64937A1F1EC6339BB79D9' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-11-08T14:37:06.732+0000'::timestamp with time zone as ct_change
    union all
    select '4C4BA563B08E449FA5A2EA2F364C2F94' as ck_id, '217' as ck_class_parent, '8672B08AF8C044BC963186193AA923F5' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-09-30T06:33:49.384+0000'::timestamp with time zone as ct_change
    union all
    select 'C28A691EE5324BC18072BA6C4E1CB266' as ck_id, '217' as ck_class_parent, '8C96F9B255F5407FBCB8DE9189B15F39' as ck_class_child, '830' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-11-18T12:15:34.260+0000'::timestamp with time zone as ct_change
    union all
    select '308' as ck_id, '35' as ck_class_parent, '217' as ck_class_child, '172' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
