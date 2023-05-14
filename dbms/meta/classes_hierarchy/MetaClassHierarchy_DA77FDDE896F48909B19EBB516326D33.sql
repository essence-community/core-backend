--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_DA77FDDE896F48909B19EBB516326D33 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '390520C814734D2399202BC19A0ABA86' as ck_id, '1' as ck_class_parent, 'DA77FDDE896F48909B19EBB516326D33' as ck_class_child, '623' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'F8788136EDDD47D7AB0571AECA4B791F' as ck_id, '137' as ck_class_parent, 'DA77FDDE896F48909B19EBB516326D33' as ck_class_child, '621' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'FD6B54E24B7A455FBF22C77152C92425' as ck_id, '17' as ck_class_parent, 'DA77FDDE896F48909B19EBB516326D33' as ck_class_child, '524' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '1C22D6B5A6D74B8B9CF006F8C9D66DD8' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, 'DA77FDDE896F48909B19EBB516326D33' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'F598AC63012B48E086B56445E98213E2' as ck_id, '217' as ck_class_parent, 'DA77FDDE896F48909B19EBB516326D33' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'C669B151F2F542B3921AAA215637421B' as ck_id, '32' as ck_class_parent, 'DA77FDDE896F48909B19EBB516326D33' as ck_class_child, '138' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-06-25T11:47:18.474+0000'::timestamp with time zone as ct_change
    union all
    select '0058B13FB7B64FF8B7C9353121D08DC8' as ck_id, '417' as ck_class_parent, 'DA77FDDE896F48909B19EBB516326D33' as ck_class_child, '1850' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '38E793088A094F3BA99F1D5E68FF8281' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, 'DA77FDDE896F48909B19EBB516326D33' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '97CAD69624004952956D26A6CFC81CDC' as ck_id, '4BA159E82B434939AAD293411854ED95' as ck_class_parent, 'DA77FDDE896F48909B19EBB516326D33' as ck_class_child, '53F747643BEE49B795CA755F3532E598' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '788AB928E4554FF29766B1862D978AFE' as ck_id, '58' as ck_class_parent, 'DA77FDDE896F48909B19EBB516326D33' as ck_class_child, '382' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '7DBCC49259C64470913A3C0CAEF5E68A' as ck_id, '6457' as ck_class_parent, 'DA77FDDE896F48909B19EBB516326D33' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'EFAE0ECC1ECD4668BDCFB8E46B56E80D' as ck_id, '7457' as ck_class_parent, 'DA77FDDE896F48909B19EBB516326D33' as ck_class_child, '37172' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'F4B8714B2AB0462D8223CD3FFF433F39' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, 'DA77FDDE896F48909B19EBB516326D33' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '9D0879C0F086450FABF015D6F256459F' as ck_id, '9' as ck_class_parent, 'DA77FDDE896F48909B19EBB516326D33' as ck_class_child, '39' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-06-03T13:49:26.799+0000'::timestamp with time zone as ct_change
    union all
    select '5CB53CF2EE0F4925BF4A0DD208473F89' as ck_id, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_parent, 'DA77FDDE896F48909B19EBB516326D33' as ck_class_child, '4F0C103E377040179EF412F13E09D265' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '4528EB269D124EE8B9EB59E2C56E7F94' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, 'DA77FDDE896F48909B19EBB516326D33' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '7FA99CD3DC7B42DEA821AF536FE40AD6' as ck_id, 'DF451F5CC0A54F8791C4DFAC12DAE42E' as ck_class_parent, 'DA77FDDE896F48909B19EBB516326D33' as ck_class_child, 'E2D0A96506384965A7B2666E5D2D1970' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
