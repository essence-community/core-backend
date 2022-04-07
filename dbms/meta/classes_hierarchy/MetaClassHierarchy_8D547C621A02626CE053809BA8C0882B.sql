--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_8D547C621A02626CE053809BA8C0882B dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '8D2BA0EF3702627EE053809BA8C0076B' as ck_id, '1' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '623' as ck_class_attr, '20785' as ck_user, '2019-07-13T00:00:00.000+0000' as ct_change
    union all
    select '8D3A50B6DE976276E053809BA8C0911C' as ck_id, '137' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '621' as ck_class_attr, '20785' as ck_user, '2019-07-13T00:00:00.000+0000' as ct_change
    union all
    select '8D4FD9E32888628AE053809BA8C080EB' as ck_id, '157' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '735' as ck_class_attr, '20785' as ck_user, '2019-07-13T00:00:00.000+0000' as ct_change
    union all
    select '8D2BA0EF3704627EE053809BA8C0076B' as ck_id, '32' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '138' as ck_class_attr, '20785' as ck_user, '2019-07-13T00:00:00.000+0000' as ct_change
    union all
    select '8D2BA0EF3703627EE053809BA8C0076B' as ck_id, '417' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '1850' as ck_class_attr, '20785' as ck_user, '2019-07-13T00:00:00.000+0000' as ct_change
    union all
    select '644EDDB119524E7499E8522E8AE622C3' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:58:26.567+0000' as ct_change
    union all
    select '8D4FD9E32889628AE053809BA8C080EB' as ck_id, '58' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '382' as ck_class_attr, '20785' as ck_user, '2019-07-13T00:00:00.000+0000' as ct_change
    union all
    select '8D547C621A0A626CE053809BA8C0882B' as ck_id, '6457' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '36173' as ck_class_attr, '20785' as ck_user, '2019-07-13T00:00:00.000+0000' as ct_change
    union all
    select '8D3A50B6DE966276E053809BA8C0911C' as ck_id, '7457' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '37172' as ck_class_attr, '20785' as ck_user, '2019-07-13T00:00:00.000+0000' as ct_change
    union all
    select '8D4FD9E32887628AE053809BA8C080EB' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '20785' as ck_user, '2019-07-13T00:00:00.000+0000' as ct_change
    union all
    select 'DAC90BBE9CCA405CBFCB9B8B739DD270' as ck_id, '8D547C621A02626CE053809BA8C0882B' as ck_class_parent, '7C133EA0021A44A0864B82F7BC40F183' as ck_class_child, '433F410317974A2EA8BAEA2AE491B216' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-03-30T00:00:00.000+0000' as ct_change
    union all
    select 'D1335D27D18F45F79A53722E83124146' as ck_id, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '4F0C103E377040179EF412F13E09D265' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-17T00:00:00.000+0000' as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
