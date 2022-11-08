--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_7C133EA0021A44A0864B82F7BC40F183 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '6CC97C956FEB49BEAF6BBC6509405B29' as ck_id, '137' as ck_class_parent, '7C133EA0021A44A0864B82F7BC40F183' as ck_class_child, '97A52FF652D34AE6BDC9C1442FBFD785' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-11-08T14:35:43.253+0000'::timestamp with time zone as ct_change
    union all
    select '239C5C4FB98F409BBDB0F7A1CEBCFCEF' as ck_id, '18' as ck_class_parent, '7C133EA0021A44A0864B82F7BC40F183' as ck_class_child, 'AEAE3F4A3E864A648D66BB31A5F26BAF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-11-08T14:34:33.061+0000'::timestamp with time zone as ct_change
    union all
    select 'D34644DED7504C57BC2BB31394FA0FD8' as ck_id, '217' as ck_class_parent, '7C133EA0021A44A0864B82F7BC40F183' as ck_class_child, '91BEE2DE87E64937A1F1EC6339BB79D9' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-11-08T14:37:06.732+0000'::timestamp with time zone as ct_change
    union all
    select '938F503C08444EE980AB87838F5D197B' as ck_id, '31' as ck_class_parent, '7C133EA0021A44A0864B82F7BC40F183' as ck_class_child, '05EC92721264431DBE89B8C3B7A53C85' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-13T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'D48C7B53A2494082917AA1932CBE7A92' as ck_id, '37' as ck_class_parent, '7C133EA0021A44A0864B82F7BC40F183' as ck_class_child, 'BFAEF3A5F1094DB5A58521C3A358CF23' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-11-08T14:37:55.920+0000'::timestamp with time zone as ct_change
    union all
    select 'D67802E5A80F44ECA586D21E3F6E3BE2' as ck_id, '38' as ck_class_parent, '7C133EA0021A44A0864B82F7BC40F183' as ck_class_child, '839DDEC274964C3EBD2588CF21A8F6A6' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-11-08T14:34:47.405+0000'::timestamp with time zone as ct_change
    union all
    select 'E2FC7FF82007471F8C75EB890A58EC11' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '7C133EA0021A44A0864B82F7BC40F183' as ck_class_child, '0BA955FE0DD245448E0FDABF5FEBD752' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-11-08T14:37:20.761+0000'::timestamp with time zone as ct_change
    union all
    select '0B9A8F74F28A43CDBACF5C45F66DA591' as ck_id, '5833D73B31E04F8ABE9D307DBCE845A9' as ck_class_parent, '7C133EA0021A44A0864B82F7BC40F183' as ck_class_child, '4AEC70A0D12E482CAD770D943783B1FD' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-11-08T14:36:49.100+0000'::timestamp with time zone as ct_change
    union all
    select '099D3439D2E24F3F8BD1BD92CC6161A1' as ck_id, '8' as ck_class_parent, '7C133EA0021A44A0864B82F7BC40F183' as ck_class_child, 'FD840D78642F46CBBD2E025094D42051' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-11-08T14:37:39.055+0000'::timestamp with time zone as ct_change
    union all
    select '0613F240B81D4E9590D128C1887BCDA0' as ck_id, '8C96F9B255F5407FBCB8DE9189B15F39' as ck_class_parent, '7C133EA0021A44A0864B82F7BC40F183' as ck_class_child, '2D96892FFDCF4D0F9BC2B4A85DCB27DC' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-11-08T14:36:16.391+0000'::timestamp with time zone as ct_change
    union all
    select 'DAC90BBE9CCA405CBFCB9B8B739DD270' as ck_id, '8D547C621A02626CE053809BA8C0882B' as ck_class_parent, '7C133EA0021A44A0864B82F7BC40F183' as ck_class_child, '433F410317974A2EA8BAEA2AE491B216' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-03-30T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '449B64E5FFC243A69F9874252CB1A647' as ck_id, '8FFC6C4564B84157E053809BA8C00266' as ck_class_parent, '7C133EA0021A44A0864B82F7BC40F183' as ck_class_child, '1F2E492BDEFF426AA8F608C273E0D256' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-11-08T14:34:07.235+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
