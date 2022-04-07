--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_9CC06E8D9D7E4791BA1C6232DAF60CDD dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '5E09EE59B98C45338C3A9A40158DADDC' as ck_id, '32' as ck_class_parent, '9CC06E8D9D7E4791BA1C6232DAF60CDD' as ck_class_child, '132' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-18T00:00:00.000+0000' as ct_change
    union all
    select 'B6BC04C53EFF43DF84C03785E23073D4' as ck_id, '9CC06E8D9D7E4791BA1C6232DAF60CDD' as ck_class_parent, '19' as ck_class_child, '1CEDCCF877584C01B3BD292C10D65DC9' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-18T00:00:00.000+0000' as ct_change
    union all
    select '96A2FF6D2AE249AE97D505EC0AE4DE1C' as ck_id, '9CC06E8D9D7E4791BA1C6232DAF60CDD' as ck_class_parent, '8C96F9B255F5407FBCB8DE9189B15F39' as ck_class_child, '1CEDCCF877584C01B3BD292C10D65DC9' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-11-18T12:15:34.260+0000' as ct_change
    union all
    select '445A7E7372BA417CA0572651D03AE4CF' as ck_id, 'BA125F895507411E8730C07D3AD26A3A' as ck_class_parent, '9CC06E8D9D7E4791BA1C6232DAF60CDD' as ck_class_child, '0A71556DD08146C496C07ED8E2375751' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-18T00:00:00.000+0000' as ct_change
    union all
    select 'A8A54B8686FE4ACD93B012192118D816' as ck_id, 'DB557A6113634FD2BC40D2A58EE1EB3F' as ck_class_parent, '9CC06E8D9D7E4791BA1C6232DAF60CDD' as ck_class_child, '061FCBDA3AEB49F397D36170131F36C6' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-18T00:00:00.000+0000' as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
