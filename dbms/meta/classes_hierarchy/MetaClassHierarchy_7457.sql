--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_7457 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '06EEA36D2F444E51A3EC28E9E9FECDCF' as ck_id, '1' as ck_class_parent, '7457' as ck_class_child, '623' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '8F0CC686198C325DE053809BA8C053B6' as ck_id, '137' as ck_class_parent, '7457' as ck_class_child, '621' as ck_class_attr, '20780' as ck_user, '2019-08-06T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '914E9DE59B504109901B3D9A429DF04F' as ck_id, '157' as ck_class_parent, '7457' as ck_class_child, '735' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-04-22T13:03:35.560+0000'::timestamp with time zone as ct_change
    union all
    select '83219990AC26470782E005135A2E65E5' as ck_id, '17' as ck_class_parent, '7457' as ck_class_child, '524' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select 'C3C17C96E5C944368A9EA68E19537F3E' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '7457' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '0EAF6B5379C14BE5B93EF96ECE18C775' as ck_id, '217' as ck_class_parent, '7457' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '14985' as ck_id, '32' as ck_class_parent, '7457' as ck_class_child, '138' as ck_class_attr, '10028610' as ck_user, '2019-02-10T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '02F41B760C5C40DB8AC1BD3F67F02817' as ck_id, '417' as ck_class_parent, '7457' as ck_class_child, '1850' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '00E87900616B48829BED4BB2E9DB7FB7' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '7457' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'D9E8E2094E3A4F55BA842AE126ED8B1A' as ck_id, '4BA159E82B434939AAD293411854ED95' as ck_class_parent, '7457' as ck_class_child, '53F747643BEE49B795CA755F3532E598' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '7996' as ck_id, '58' as ck_class_parent, '7457' as ck_class_child, '382' as ck_class_attr, '20785' as ck_user, '2018-12-19T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '270AD6B6BD6342E0855407F077795843' as ck_id, '6457' as ck_class_parent, '7457' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '564FC9FDAAD44C388D578B24F9557450' as ck_id, '7457' as ck_class_parent, '1' as ck_class_child, '37172' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:33:23.574+0000'::timestamp with time zone as ct_change
    union all
    select '11986' as ck_id, '7457' as ck_class_parent, '10457' as ck_class_child, '37172' as ck_class_attr, '30021381' as ck_user, '2019-01-24T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '8F272F197A4C46A298E7FD358CE008AB' as ck_id, '7457' as ck_class_parent, '15593D209A1D46FC873706F69EE71E7A' as ck_class_child, '37172' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '73B8340E54424D48BB23D2CE3ACE44BD' as ck_id, '7457' as ck_class_parent, '197' as ck_class_child, '37172' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '7986' as ck_id, '7457' as ck_class_parent, '26' as ck_class_child, '37172' as ck_class_attr, '20785' as ck_user, '2018-12-19T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '7987' as ck_id, '7457' as ck_class_parent, '27' as ck_class_child, '37172' as ck_class_attr, '20785' as ck_user, '2018-12-19T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '7988' as ck_id, '7457' as ck_class_parent, '28' as ck_class_child, '37172' as ck_class_attr, '20785' as ck_user, '2018-12-19T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '7989' as ck_id, '7457' as ck_class_parent, '29' as ck_class_child, '37172' as ck_class_attr, '20785' as ck_user, '2018-12-19T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '7990' as ck_id, '7457' as ck_class_parent, '30' as ck_class_child, '37172' as ck_class_attr, '20785' as ck_user, '2018-12-19T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'BF0719D8058C4CE2B93E89BCC49D5CF7' as ck_id, '7457' as ck_class_parent, '3061ADE6780F432B93F17C1DCCC33D93' as ck_class_child, '37172' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:35.711+0000'::timestamp with time zone as ct_change
    union all
    select '7992' as ck_id, '7457' as ck_class_parent, '31' as ck_class_child, '37172' as ck_class_attr, '20785' as ck_user, '2018-12-19T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '4FEE8CBB77CD4D1A899AF643057FAFE4' as ck_id, '7457' as ck_class_parent, '317' as ck_class_child, '37172' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '6A74B89E189A4499B7A58D8692B255E4' as ck_id, '7457' as ck_class_parent, '33' as ck_class_child, '37172' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'EBDA596A60684B2D95F10DA9D5EA7C4E' as ck_id, '7457' as ck_class_parent, '357' as ck_class_child, '37172' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '7993' as ck_id, '7457' as ck_class_parent, '37' as ck_class_child, '37172' as ck_class_attr, '20785' as ck_user, '2018-12-19T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '7994' as ck_id, '7457' as ck_class_parent, '38' as ck_class_child, '37172' as ck_class_attr, '20785' as ck_user, '2018-12-19T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'F07203F5DB844932AC3E58B511C75041' as ck_id, '7457' as ck_class_parent, '417' as ck_class_child, '37172' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '7985' as ck_id, '7457' as ck_class_parent, '4457' as ck_class_child, '37172' as ck_class_attr, '20785' as ck_user, '2018-12-19T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '6524DFEE3037413481D9FC632DDA2CD5' as ck_id, '7457' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, '37172' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'F6F38A01BFFC4DEDBEFACCA7A568CEA7' as ck_id, '7457' as ck_class_parent, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_child, '37172' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T10:02:47.317+0000'::timestamp with time zone as ct_change
    union all
    select 'F76FF0B780484608AC525507EABF6C2B' as ck_id, '7457' as ck_class_parent, '508B0DE5C67B464CB3A5CED4DF778084' as ck_class_child, '37172' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:14.957+0000'::timestamp with time zone as ct_change
    union all
    select 'E0D38235AFF64A478C62BC2305D56A62' as ck_id, '7457' as ck_class_parent, '5833D73B31E04F8ABE9D307DBCE845A9' as ck_class_child, '37172' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '9D00BAD27C7A4828B7C37ECAEAA57BA3' as ck_id, '7457' as ck_class_parent, '5F229304828F4AADBF9B0BE6463B1248' as ck_class_child, '37172' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-05-27T11:16:47.642+0000'::timestamp with time zone as ct_change
    union all
    select 'DB36C35152BC467EAB66AD6C2F1BED99' as ck_id, '7457' as ck_class_parent, '664B30CA82FC453BAADF14EE7C102312' as ck_class_child, '37172' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '978AA136E4C1442AB3C3534BC2C2D25A' as ck_id, '7457' as ck_class_parent, '6B1F10465BA848B4BF8E75924A6268A2' as ck_class_child, '37172' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'EAC4DAE8E73B4A74AC56C282D2B881A7' as ck_id, '7457' as ck_class_parent, '7457' as ck_class_child, '37172' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'D5E11A2FA04C41D48FF2BAE50D4FECBB' as ck_id, '7457' as ck_class_parent, '8457' as ck_class_child, '37172' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'E42F9F9DF09647709D8DBFAC1ACC6F3B' as ck_id, '7457' as ck_class_parent, '84599990888B6BCCE053809BA8C00CC8' as ck_class_child, '37172' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '842BDEDCFE4A4CF0996AA37C5B796669' as ck_id, '7457' as ck_class_parent, '8672B08AF8C044BC963186193AA923F5' as ck_class_child, '37172' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:38:16.403+0000'::timestamp with time zone as ct_change
    union all
    select '8D3A50B6DE966276E053809BA8C0911C' as ck_id, '7457' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '37172' as ck_class_attr, '20785' as ck_user, '2019-07-13T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'DD62CE67B88E4199A9408E22A1CE91E1' as ck_id, '7457' as ck_class_parent, '8E6AC2B44FCB8D3BE053809BA8C0E74D' as ck_class_child, '37172' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '7995' as ck_id, '7457' as ck_class_parent, '97' as ck_class_child, '37172' as ck_class_attr, '20785' as ck_user, '2018-12-19T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '7194DAE8161E447A8FD09323B114F967' as ck_id, '7457' as ck_class_parent, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_child, '37172' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T10:03:02.960+0000'::timestamp with time zone as ct_change
    union all
    select 'EFAE0ECC1ECD4668BDCFB8E46B56E80D' as ck_id, '7457' as ck_class_parent, 'DA77FDDE896F48909B19EBB516326D33' as ck_class_child, '37172' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '87BF545279B213EDE053809BA8C0A884' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '7457' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '20785' as ck_user, '2019-05-16T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '20880F2B6EBA4AC7AF66782073ECBB69' as ck_id, '9' as ck_class_parent, '7457' as ck_class_child, '39' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select 'A4350660DD8F4772BB9C8A9C0524E1F4' as ck_id, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_parent, '7457' as ck_class_child, '4F0C103E377040179EF412F13E09D265' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-26T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '2D9027400C9846D99F10AB6DAA3B5C11' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '7457' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '8A4BFDA2AA6D49DFBD9D9EECB715ACAD' as ck_id, 'DF451F5CC0A54F8791C4DFAC12DAE42E' as ck_class_parent, '7457' as ck_class_child, 'E2D0A96506384965A7B2666E5D2D1970' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '839F015C54B148C6B02BA74CCD8A6BF3' as ck_id, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_parent, '7457' as ck_class_child, 'EEBFE7B1ABBA407EAA22DE1DB8960C9C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-05-15T14:34:02.345+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
