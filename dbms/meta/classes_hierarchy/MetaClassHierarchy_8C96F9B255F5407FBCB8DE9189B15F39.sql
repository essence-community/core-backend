--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_8C96F9B255F5407FBCB8DE9189B15F39 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select 'EAC52733D70A4C019F1C993A7C766518' as ck_id, '137' as ck_class_parent, '8C96F9B255F5407FBCB8DE9189B15F39' as ck_class_child, '619' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-11-18T12:15:34.260+0000'::timestamp with time zone as ct_change
    union all
    select 'B2E648A03D36404F8EFA51B23B07E025' as ck_id, '1457' as ck_class_parent, '8C96F9B255F5407FBCB8DE9189B15F39' as ck_class_child, '5176' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-11-18T12:15:34.260+0000'::timestamp with time zone as ct_change
    union all
    select '8BA063D683FA4B2987C158B9590F7FEC' as ck_id, '157' as ck_class_parent, '8C96F9B255F5407FBCB8DE9189B15F39' as ck_class_child, '36169' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-11-18T12:15:34.260+0000'::timestamp with time zone as ct_change
    union all
    select '5BAE3378AF3744848ED597A74E54B902' as ck_id, '18' as ck_class_parent, '8C96F9B255F5407FBCB8DE9189B15F39' as ck_class_child, '31' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-11-18T12:15:34.260+0000'::timestamp with time zone as ct_change
    union all
    select 'A30ABA0CE0614CDFB50844C2B78A619C' as ck_id, '1807D17438814B31B75A279C4CBC6C0C' as ck_class_parent, '8C96F9B255F5407FBCB8DE9189B15F39' as ck_class_child, '225864898ED0411FA0E5434CD3A85346' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-11-18T12:15:34.260+0000'::timestamp with time zone as ct_change
    union all
    select 'C28A691EE5324BC18072BA6C4E1CB266' as ck_id, '217' as ck_class_parent, '8C96F9B255F5407FBCB8DE9189B15F39' as ck_class_child, '830' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-11-18T12:15:34.260+0000'::timestamp with time zone as ct_change
    union all
    select '05F5062AEED44747948175B4FB6E2627' as ck_id, '32' as ck_class_parent, '8C96F9B255F5407FBCB8DE9189B15F39' as ck_class_child, '132' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-11-18T12:15:34.260+0000'::timestamp with time zone as ct_change
    union all
    select 'DC17044025A1468A95659E655C81D702' as ck_id, '57' as ck_class_parent, '8C96F9B255F5407FBCB8DE9189B15F39' as ck_class_child, '5A71798ADE90475B941C914EDF5E1339' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-03-25T11:54:25.998+0000'::timestamp with time zone as ct_change
    union all
    select 'EAA1EB370989422689188E72C3CFD01B' as ck_id, '8' as ck_class_parent, '8C96F9B255F5407FBCB8DE9189B15F39' as ck_class_child, '30' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-11-18T12:15:34.260+0000'::timestamp with time zone as ct_change
    union all
    select '2E4517246F8048B081FE589A8C11D9F0' as ck_id, '8C96F9B255F5407FBCB8DE9189B15F39' as ck_class_parent, '32' as ck_class_child, 'A2568EEB60A442A8B8F4DF90DF547BC7' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-12-08T10:31:50.678+0000'::timestamp with time zone as ct_change
    union all
    select '0613F240B81D4E9590D128C1887BCDA0' as ck_id, '8C96F9B255F5407FBCB8DE9189B15F39' as ck_class_parent, '7C133EA0021A44A0864B82F7BC40F183' as ck_class_child, '2D96892FFDCF4D0F9BC2B4A85DCB27DC' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-11-08T14:36:16.391+0000'::timestamp with time zone as ct_change
    union all
    select '96A2FF6D2AE249AE97D505EC0AE4DE1C' as ck_id, '9CC06E8D9D7E4791BA1C6232DAF60CDD' as ck_class_parent, '8C96F9B255F5407FBCB8DE9189B15F39' as ck_class_child, '1CEDCCF877584C01B3BD292C10D65DC9' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-11-18T12:15:34.260+0000'::timestamp with time zone as ct_change
    union all
    select 'F1FB884607CB418F894DE4999EA14EE0' as ck_id, 'BA125F895507411E8730C07D3AD26A3A' as ck_class_parent, '8C96F9B255F5407FBCB8DE9189B15F39' as ck_class_child, '0A71556DD08146C496C07ED8E2375751' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-11-18T12:15:34.260+0000'::timestamp with time zone as ct_change
    union all
    select 'B51AF56C87384B17848C6FE5D8BE7484' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '8C96F9B255F5407FBCB8DE9189B15F39' as ck_class_child, '6E05E9179E274246A22A1583347ACA4D' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-11-18T12:15:34.260+0000'::timestamp with time zone as ct_change
    union all
    select 'E56D6225F29447A1B29EBB05186C603E' as ck_id, 'D966BA30FBA3469FB5FEA82127B1ED6D' as ck_class_parent, '8C96F9B255F5407FBCB8DE9189B15F39' as ck_class_child, 'D910BD59B2CE4895BE263B2FC12DA80D' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-11-18T12:15:34.260+0000'::timestamp with time zone as ct_change
    union all
    select 'D73182C7A6F1473181F5DC687DCC16FA' as ck_id, 'DB557A6113634FD2BC40D2A58EE1EB3F' as ck_class_parent, '8C96F9B255F5407FBCB8DE9189B15F39' as ck_class_child, '061FCBDA3AEB49F397D36170131F36C6' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-11-18T12:15:34.260+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
