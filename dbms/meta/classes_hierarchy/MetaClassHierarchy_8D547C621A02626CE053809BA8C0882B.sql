--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_8D547C621A02626CE053809BA8C0882B dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '8D2BA0EF3702627EE053809BA8C0076B' as ck_id, '1' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '623' as ck_class_attr, '20785' as ck_user, '2019-07-13T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'BD4157E7C46D444FA3BCC203ED09E571' as ck_id, '10' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '40' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '3FD90C812CE644B782F0254C3106C837' as ck_id, '11' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '43' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '8D3A50B6DE976276E053809BA8C0911C' as ck_id, '137' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '621' as ck_class_attr, '20785' as ck_user, '2019-07-13T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '8D4FD9E32888628AE053809BA8C080EB' as ck_id, '157' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '735' as ck_class_attr, '20785' as ck_user, '2019-07-13T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '9FBB5BC5E31D4113932794F3E4601004' as ck_id, '17' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '524' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select 'C4291105ED6C4BF3B2220AFB305AA1D7' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '9E19FEB1C88B4BEE80D463A530708E02' as ck_id, '217' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '8D2BA0EF3704627EE053809BA8C0076B' as ck_id, '32' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '138' as ck_class_attr, '20785' as ck_user, '2019-07-13T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '259D5AB70F9F41D886DBBCF1FF44B1B4' as ck_id, '36' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '254' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '8D2BA0EF3703627EE053809BA8C0076B' as ck_id, '417' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '1850' as ck_class_attr, '20785' as ck_user, '2019-07-13T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '644EDDB119524E7499E8522E8AE622C3' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:58:26.567+0000'::timestamp with time zone as ct_change
    union all
    select '4261B486BE6C41D89E82F667D1AC355D' as ck_id, '4BA159E82B434939AAD293411854ED95' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '53F747643BEE49B795CA755F3532E598' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '8D4FD9E32889628AE053809BA8C080EB' as ck_id, '58' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '382' as ck_class_attr, '20785' as ck_user, '2019-07-13T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '8D547C621A0A626CE053809BA8C0882B' as ck_id, '6457' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '36173' as ck_class_attr, '20785' as ck_user, '2019-07-13T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '8D3A50B6DE966276E053809BA8C0911C' as ck_id, '7457' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '37172' as ck_class_attr, '20785' as ck_user, '2019-07-13T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'DFA51AFA878441D29AB751023003FC57' as ck_id, '77' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '450' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '8D4FD9E32887628AE053809BA8C080EB' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '20785' as ck_user, '2019-07-13T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'DAC90BBE9CCA405CBFCB9B8B739DD270' as ck_id, '8D547C621A02626CE053809BA8C0882B' as ck_class_parent, '7C133EA0021A44A0864B82F7BC40F183' as ck_class_child, '433F410317974A2EA8BAEA2AE491B216' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-03-30T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '5AC5D95DA3C64FFDB3DDECC9C2D7CCA4' as ck_id, '9' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '39' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select 'D1335D27D18F45F79A53722E83124146' as ck_id, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '4F0C103E377040179EF412F13E09D265' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-17T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '097DEB711510476187C19144D2C8CAE5' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '30D78C17E3CF405BAE44A872CF83A669' as ck_id, 'DF451F5CC0A54F8791C4DFAC12DAE42E' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, 'E2D0A96506384965A7B2666E5D2D1970' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
