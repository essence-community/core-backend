--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_15593D209A1D46FC873706F69EE71E7A dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select 'E9B8EA01D1A04484822C82FEFA990C42' as ck_id, '1' as ck_class_parent, '15593D209A1D46FC873706F69EE71E7A' as ck_class_child, '623' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'F9D5AE7717724C36BF66D1025A1D1668' as ck_id, '137' as ck_class_parent, '15593D209A1D46FC873706F69EE71E7A' as ck_class_child, '621' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-05-20T10:08:53.888+0000'::timestamp with time zone as ct_change
    union all
    select '5F722831E3BE4CA1B09E56A55CC665D6' as ck_id, '17' as ck_class_parent, '15593D209A1D46FC873706F69EE71E7A' as ck_class_child, '524' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '23A37F5C4CE8478BA8AB34782D849574' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '15593D209A1D46FC873706F69EE71E7A' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '70AFFAE8700047718C07D42E32582473' as ck_id, '217' as ck_class_parent, '15593D209A1D46FC873706F69EE71E7A' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'A45DA9D75B5541099C42C16C3E8205FB' as ck_id, '32' as ck_class_parent, '15593D209A1D46FC873706F69EE71E7A' as ck_class_child, '138' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '6CC42020B35C40D9B3B76AE637CA1F9F' as ck_id, '417' as ck_class_parent, '15593D209A1D46FC873706F69EE71E7A' as ck_class_child, '1850' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '49E6449F462946A18DB2D6922900384A' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '15593D209A1D46FC873706F69EE71E7A' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:55:36.098+0000'::timestamp with time zone as ct_change
    union all
    select '61B280CACC954949A303CDA3437EBC76' as ck_id, '4BA159E82B434939AAD293411854ED95' as ck_class_parent, '15593D209A1D46FC873706F69EE71E7A' as ck_class_child, '53F747643BEE49B795CA755F3532E598' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-05-20T10:09:35.568+0000'::timestamp with time zone as ct_change
    union all
    select '001BFAB7785749A6AA86EA5EF6280726' as ck_id, '58' as ck_class_parent, '15593D209A1D46FC873706F69EE71E7A' as ck_class_child, '382' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-05-20T10:09:23.578+0000'::timestamp with time zone as ct_change
    union all
    select '0A8CC58BBEE14A948E10641E0E5FC494' as ck_id, '6457' as ck_class_parent, '15593D209A1D46FC873706F69EE71E7A' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '8F272F197A4C46A298E7FD358CE008AB' as ck_id, '7457' as ck_class_parent, '15593D209A1D46FC873706F69EE71E7A' as ck_class_child, '37172' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '11706B0DB96146298024A628F9E601C4' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '15593D209A1D46FC873706F69EE71E7A' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-05-20T10:09:12.593+0000'::timestamp with time zone as ct_change
    union all
    select '82A17DB9CAD9485597895E2DCF8FFF10' as ck_id, '9' as ck_class_parent, '15593D209A1D46FC873706F69EE71E7A' as ck_class_child, '39' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '17BF0D39CFFC4DB3BCE4055F7E81BCA1' as ck_id, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_parent, '15593D209A1D46FC873706F69EE71E7A' as ck_class_child, '4F0C103E377040179EF412F13E09D265' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '13B559EFDA6C497D963C3C6B36C78740' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '15593D209A1D46FC873706F69EE71E7A' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '98CF58C8A2B5438DA376F3F816154A71' as ck_id, 'DF451F5CC0A54F8791C4DFAC12DAE42E' as ck_class_parent, '15593D209A1D46FC873706F69EE71E7A' as ck_class_child, 'E2D0A96506384965A7B2666E5D2D1970' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
