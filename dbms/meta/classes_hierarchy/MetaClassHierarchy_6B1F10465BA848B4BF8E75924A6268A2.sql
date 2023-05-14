--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_6B1F10465BA848B4BF8E75924A6268A2 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '6F3844C23E9245F7A8A389AAF99CAD61' as ck_id, '1' as ck_class_parent, '6B1F10465BA848B4BF8E75924A6268A2' as ck_class_child, '623' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'D5207F90BD57457096F5012D33DC5562' as ck_id, '137' as ck_class_parent, '6B1F10465BA848B4BF8E75924A6268A2' as ck_class_child, '621' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '3DFBA9E81DA24D3092829BF3CFAAD473' as ck_id, '17' as ck_class_parent, '6B1F10465BA848B4BF8E75924A6268A2' as ck_class_child, '524' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select 'D70AF7C085F34FE6AE11B6D80C0BAEAA' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '6B1F10465BA848B4BF8E75924A6268A2' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'BD4712C098DB407D81CDC45EC21DCB14' as ck_id, '217' as ck_class_parent, '6B1F10465BA848B4BF8E75924A6268A2' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '512CE2DCD7F74C1C978639ACAC0FBAF5' as ck_id, '32' as ck_class_parent, '6B1F10465BA848B4BF8E75924A6268A2' as ck_class_child, '138' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-06-24T13:21:37.418+0000'::timestamp with time zone as ct_change
    union all
    select '5AB11493B97A403B913B3881B5243B11' as ck_id, '417' as ck_class_parent, '6B1F10465BA848B4BF8E75924A6268A2' as ck_class_child, '1850' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '5C1B5C9957774207AB66F1F0DD86FAF8' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '6B1F10465BA848B4BF8E75924A6268A2' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:58:39.646+0000'::timestamp with time zone as ct_change
    union all
    select 'C31A1B79191D49E291BE2C9A71863647' as ck_id, '4BA159E82B434939AAD293411854ED95' as ck_class_parent, '6B1F10465BA848B4BF8E75924A6268A2' as ck_class_child, '53F747643BEE49B795CA755F3532E598' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '0EB5EF572AFD4A1EAD094219BAD606A5' as ck_id, '58' as ck_class_parent, '6B1F10465BA848B4BF8E75924A6268A2' as ck_class_child, '382' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '0AE797D1482E4EBEAC4EAA02BEB81EAA' as ck_id, '6457' as ck_class_parent, '6B1F10465BA848B4BF8E75924A6268A2' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '978AA136E4C1442AB3C3534BC2C2D25A' as ck_id, '7457' as ck_class_parent, '6B1F10465BA848B4BF8E75924A6268A2' as ck_class_child, '37172' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '7CA24468B9F7451EBF3CB1C60E7AF6FA' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '6B1F10465BA848B4BF8E75924A6268A2' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '04540E15612B4C9BACB6827C68CE4810' as ck_id, '9' as ck_class_parent, '6B1F10465BA848B4BF8E75924A6268A2' as ck_class_child, '39' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '1AB788AE5FD14A68BE0A31923D9CB9F4' as ck_id, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_parent, '6B1F10465BA848B4BF8E75924A6268A2' as ck_class_child, '4F0C103E377040179EF412F13E09D265' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '9B4F219809B14D0B804D425D5E3A8651' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '6B1F10465BA848B4BF8E75924A6268A2' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '40A2A725BB3A4A8CA771DA9A1ABD13F9' as ck_id, 'DF451F5CC0A54F8791C4DFAC12DAE42E' as ck_class_parent, '6B1F10465BA848B4BF8E75924A6268A2' as ck_class_child, 'E2D0A96506384965A7B2666E5D2D1970' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
