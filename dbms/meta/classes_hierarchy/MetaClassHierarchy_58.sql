--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_58 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '233' as ck_id, '137' as ck_class_parent, '58' as ck_class_child, '634' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '117' as ck_id, '18' as ck_class_parent, '58' as ck_class_child, '392' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '147' as ck_id, '37' as ck_class_parent, '58' as ck_class_child, '519' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '148' as ck_id, '38' as ck_class_parent, '58' as ck_class_child, '520' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '11990' as ck_id, '58' as ck_class_parent, '10457' as ck_class_child, '382' as ck_class_attr, '30021381' as ck_user, '2019-01-24T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '001BFAB7785749A6AA86EA5EF6280726' as ck_id, '58' as ck_class_parent, '15593D209A1D46FC873706F69EE71E7A' as ck_class_child, '382' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-05-20T10:09:23.578+0000'::timestamp with time zone as ct_change
    union all
    select '286' as ck_id, '58' as ck_class_parent, '197' as ck_class_child, '382' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '115' as ck_id, '58' as ck_class_parent, '26' as ck_class_child, '382' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '112' as ck_id, '58' as ck_class_parent, '27' as ck_class_child, '382' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '113' as ck_id, '58' as ck_class_parent, '28' as ck_class_child, '382' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '108' as ck_id, '58' as ck_class_parent, '29' as ck_class_child, '382' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '110' as ck_id, '58' as ck_class_parent, '30' as ck_class_child, '382' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'D998264F349741D28698A0B8938E07E6' as ck_id, '58' as ck_class_parent, '3061ADE6780F432B93F17C1DCCC33D93' as ck_class_child, '382' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:35.711+0000'::timestamp with time zone as ct_change
    union all
    select '109' as ck_id, '58' as ck_class_parent, '31' as ck_class_child, '382' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'AF5185B421174BA2B15515068CE50E85' as ck_id, '58' as ck_class_parent, '317' as ck_class_child, '382' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '585' as ck_id, '58' as ck_class_parent, '33' as ck_class_child, '382' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '8E7C598A0D9F6572E053809BA8C0F580' as ck_id, '58' as ck_class_parent, '337' as ck_class_child, '382' as ck_class_attr, '20786' as ck_user, '2019-07-24T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '649' as ck_id, '58' as ck_class_parent, '357' as ck_class_child, '382' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '114' as ck_id, '58' as ck_class_parent, '37' as ck_class_child, '382' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '111' as ck_id, '58' as ck_class_parent, '38' as ck_class_child, '382' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'A0915444A38B403780EECCC9209CA8CE' as ck_id, '58' as ck_class_parent, '417' as ck_class_child, '382' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '5987' as ck_id, '58' as ck_class_parent, '4457' as ck_class_child, '382' as ck_class_attr, '10020785' as ck_user, '2018-10-07T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '59228798E25A4622AC306F3B104DC502' as ck_id, '58' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, '382' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'A9D1A80CA3114F65B7058A82E5410221' as ck_id, '58' as ck_class_parent, '4BA159E82B434939AAD293411854ED95' as ck_class_child, '382' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-09-20T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '59D6DF6F54414752A08DC6E2D8A572F2' as ck_id, '58' as ck_class_parent, '508B0DE5C67B464CB3A5CED4DF778084' as ck_class_child, '382' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:14.957+0000'::timestamp with time zone as ct_change
    union all
    select '11988' as ck_id, '58' as ck_class_parent, '58' as ck_class_child, '382' as ck_class_attr, '30021381' as ck_user, '2019-01-24T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '30F71583AF674BBBA6E4055B2E4E465E' as ck_id, '58' as ck_class_parent, '5833D73B31E04F8ABE9D307DBCE845A9' as ck_class_child, '382' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-03-18T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'CC789AEB6002418BBB471227F7CF4A72' as ck_id, '58' as ck_class_parent, '5F229304828F4AADBF9B0BE6463B1248' as ck_class_child, '382' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:23:06.119+0000'::timestamp with time zone as ct_change
    union all
    select '8F709C09D77F46DD851FD978894D5EBE' as ck_id, '58' as ck_class_parent, '664B30CA82FC453BAADF14EE7C102312' as ck_class_child, '382' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-02-10T16:45:22.782+0000'::timestamp with time zone as ct_change
    union all
    select '0EB5EF572AFD4A1EAD094219BAD606A5' as ck_id, '58' as ck_class_parent, '6B1F10465BA848B4BF8E75924A6268A2' as ck_class_child, '382' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '7996' as ck_id, '58' as ck_class_parent, '7457' as ck_class_child, '382' as ck_class_attr, '20785' as ck_user, '2018-12-19T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '8988' as ck_id, '58' as ck_class_parent, '8457' as ck_class_child, '382' as ck_class_attr, '20786' as ck_user, '2018-12-24T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'F3CE5E5071A14D17AABD720D59D2EE0B' as ck_id, '58' as ck_class_parent, '84599990888B6BCCE053809BA8C00CC8' as ck_class_child, '382' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '024903D72349465A8FFE151E8CCFB954' as ck_id, '58' as ck_class_parent, '8672B08AF8C044BC963186193AA923F5' as ck_class_child, '382' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:38:16.403+0000'::timestamp with time zone as ct_change
    union all
    select '8D4FD9E32889628AE053809BA8C080EB' as ck_id, '58' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '382' as ck_class_attr, '20785' as ck_user, '2019-07-13T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'F1F5F2C71E7E4082850DD513B52FBFF7' as ck_id, '58' as ck_class_parent, '8E6AC2B44FCB8D3BE053809BA8C0E74D' as ck_class_child, '382' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '146' as ck_id, '58' as ck_class_parent, '97' as ck_class_child, '382' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '688214CF411B431CBBC383FED3B9F5AE' as ck_id, '58' as ck_class_parent, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_child, '382' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '788AB928E4554FF29766B1862D978AFE' as ck_id, '58' as ck_class_parent, 'DA77FDDE896F48909B19EBB516326D33' as ck_class_child, '382' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '116' as ck_id, '8' as ck_class_parent, '58' as ck_class_child, '391' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
