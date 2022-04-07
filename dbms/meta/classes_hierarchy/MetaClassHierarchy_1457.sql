--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_1457 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '2986' as ck_id, '137' as ck_class_parent, '1457' as ck_class_child, '619' as ck_class_attr, '10020785' as ck_user, '2018-07-15T00:00:00.000+0000' as ct_change
    union all
    select '1985' as ck_id, '1457' as ck_class_parent, '19' as ck_class_child, '5176' as ck_class_attr, '10020785' as ck_user, '2018-07-12T00:00:00.000+0000' as ct_change
    union all
    select 'B2E648A03D36404F8EFA51B23B07E025' as ck_id, '1457' as ck_class_parent, '8C96F9B255F5407FBCB8DE9189B15F39' as ck_class_child, '5176' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-11-18T12:15:34.260+0000' as ct_change
    union all
    select '2985' as ck_id, '18' as ck_class_parent, '1457' as ck_class_child, '31' as ck_class_attr, '10020785' as ck_user, '2018-07-15T00:00:00.000+0000' as ct_change
    union all
    select '29CE713D6887494EB4DB90AE8FA294C4' as ck_id, '1807D17438814B31B75A279C4CBC6C0C' as ck_class_parent, '1457' as ck_class_child, '225864898ED0411FA0E5434CD3A85346' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-04T00:00:00.000+0000' as ct_change
    union all
    select '2987' as ck_id, '217' as ck_class_parent, '1457' as ck_class_child, '830' as ck_class_attr, '10020785' as ck_user, '2018-07-15T00:00:00.000+0000' as ct_change
    union all
    select '2988' as ck_id, '32' as ck_class_parent, '1457' as ck_class_child, '132' as ck_class_attr, '10020785' as ck_user, '2018-07-15T00:00:00.000+0000' as ct_change
    union all
    select '1986' as ck_id, '8' as ck_class_parent, '1457' as ck_class_child, '30' as ck_class_attr, '10020785' as ck_user, '2018-07-12T00:00:00.000+0000' as ct_change
    union all
    select '45BF9FC5FBF44372B0D32F16B9B94207' as ck_id, 'BA125F895507411E8730C07D3AD26A3A' as ck_class_parent, '1457' as ck_class_child, '0A71556DD08146C496C07ED8E2375751' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-03T00:00:00.000+0000' as ct_change
    union all
    select '6BFCEB3FE9134A488062E8BFFC4246A4' as ck_id, 'DB557A6113634FD2BC40D2A58EE1EB3F' as ck_class_parent, '1457' as ck_class_child, '061FCBDA3AEB49F397D36170131F36C6' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-03T00:00:00.000+0000' as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
