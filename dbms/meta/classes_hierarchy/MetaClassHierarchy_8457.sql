--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_8457 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '8986' as ck_id, '1' as ck_class_parent, '8457' as ck_class_child, '623' as ck_class_attr, '20786' as ck_user, '2018-12-24T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'FF4F00189C8C48A4B4748A283A07EFAE' as ck_id, '10' as ck_class_parent, '8457' as ck_class_child, '40' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '3929E7C2CF7F47AE9DF38251D2D306F9' as ck_id, '11' as ck_class_parent, '8457' as ck_class_child, '43' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '8985' as ck_id, '137' as ck_class_parent, '8457' as ck_class_child, '621' as ck_class_attr, '20786' as ck_user, '2018-12-24T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '8989' as ck_id, '157' as ck_class_parent, '8457' as ck_class_child, '735' as ck_class_attr, '20786' as ck_user, '2018-12-24T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'F0B7294D33944C4297F26A278098B049' as ck_id, '17' as ck_class_parent, '8457' as ck_class_child, '524' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '5DAAFCA9AACA4B6C82B00FA280B7D62E' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '8457' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'EBC9A9227FB340A3A3A28522ECD05A02' as ck_id, '217' as ck_class_parent, '8457' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'B4F4D16D482E427398570E7DFE91D97D' as ck_id, '32' as ck_class_parent, '8457' as ck_class_child, '138' as ck_class_attr, '1' as ck_user, '2019-08-28T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '0D9C9D5B0E5C42028C69C5E8E8AC5DEC' as ck_id, '36' as ck_class_parent, '8457' as ck_class_child, '254' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '76476193BD46463DA1310A65E6D89E99' as ck_id, '417' as ck_class_parent, '8457' as ck_class_child, '1850' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'E01CDBD1BD0C402C829A430FB494928A' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '8457' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:57:58.761+0000'::timestamp with time zone as ct_change
    union all
    select '70F42DEF996E4165A64AD0598FA4EFCC' as ck_id, '4BA159E82B434939AAD293411854ED95' as ck_class_parent, '8457' as ck_class_child, '53F747643BEE49B795CA755F3532E598' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '8988' as ck_id, '58' as ck_class_parent, '8457' as ck_class_child, '382' as ck_class_attr, '20786' as ck_user, '2018-12-24T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '6259EF69B72F4B6C82E39BFBD2D47517' as ck_id, '6457' as ck_class_parent, '8457' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'D5E11A2FA04C41D48FF2BAE50D4FECBB' as ck_id, '7457' as ck_class_parent, '8457' as ck_class_child, '37172' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '70B8F15E5BAB4CA9B8BB2B9C4B5D8B63' as ck_id, '77' as ck_class_parent, '8457' as ck_class_child, '450' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '667B5779F6034956B769FBA43E60F3E2' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '8457' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-04-02T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '8987' as ck_id, '9' as ck_class_parent, '8457' as ck_class_child, '39' as ck_class_attr, '20786' as ck_user, '2018-12-24T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '004ADD5B1A074312A4C732F5DDCA7AFB' as ck_id, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_parent, '8457' as ck_class_child, '4F0C103E377040179EF412F13E09D265' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-17T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '233F0E304E804367986C4F81BA0C700D' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '8457' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-04-03T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '3C0061E184B44DF2946DF9D356248439' as ck_id, 'DF451F5CC0A54F8791C4DFAC12DAE42E' as ck_class_parent, '8457' as ck_class_child, 'E2D0A96506384965A7B2666E5D2D1970' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '3B93A56C39E14C778D35DB1BAC462CEA' as ck_id, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_parent, '8457' as ck_class_child, 'EEBFE7B1ABBA407EAA22DE1DB8960C9C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-05-15T14:35:45.424+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
