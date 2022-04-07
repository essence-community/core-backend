--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_C6C0F987FD584F42A7B7D8B2ECEE63F6 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select 'C6095F6BA57F4E4898FBA270088CD6FB' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-04-03T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '293166F53C934427B2524859A2156539' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '19' as ck_class_child, '6E05E9179E274246A22A1583347ACA4D' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-04-03T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '9FB904AC48784500BF5145D00984FFA8' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '26' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-04-03T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '233F0E304E804367986C4F81BA0C700D' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '8457' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-04-03T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'B51AF56C87384B17848C6FE5D8BE7484' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '8C96F9B255F5407FBCB8DE9189B15F39' as ck_class_child, '6E05E9179E274246A22A1583347ACA4D' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-11-18T12:15:34.260+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
