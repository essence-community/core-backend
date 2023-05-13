--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_C6C0F987FD584F42A7B7D8B2ECEE63F6 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select 'C6095F6BA57F4E4898FBA270088CD6FB' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-04-03T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '119611EFAAC040519E8C17C29E0763C8' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '10457' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '13B559EFDA6C497D963C3C6B36C78740' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '15593D209A1D46FC873706F69EE71E7A' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '293166F53C934427B2524859A2156539' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '19' as ck_class_child, '6E05E9179E274246A22A1583347ACA4D' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-04-03T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '50070505D77F45AF945532FEADBCA8EE' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '197' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '9FB904AC48784500BF5145D00984FFA8' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '26' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-04-03T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'E29CE1F60B664C6B92CB4DBFA9B6585F' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '27' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '49C0813E475F46B889BD538EA57C73A6' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '28' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'A8187F4399574BBB8E34FA66B1FD3F8C' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '29' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'F92AEBB26E81479BB19BCA97CFC93EA1' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '30' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '40F63BC5FDBA4DBCB3B403E1DE60343E' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '3061ADE6780F432B93F17C1DCCC33D93' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:35.711+0000'::timestamp with time zone as ct_change
    union all
    select '60CD9E7A7E044C06866D018E4ADE7B00' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '31' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'F0871185D0A048ADAC772580027DAFEF' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '317' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '673082E710E04ACCB93D4717CED2B1F6' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '33' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '0101CA4FA8614691A8047AE67403690E' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '357' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'B349363B00F14181ADFC0EFB3C441D93' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '37' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '5CAAF56E339A43A8B24FA25AEC283883' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '38' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '94C7FC37C7E44FD9912B6BA5E14EC864' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '417' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '331FFF4DCA6C4CDFACED97E52C12F264' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '4457' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'DAAD7FA546714E689229394D29214251' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '3B314519FFFD47CEAF49EDC6344484B7' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '508B0DE5C67B464CB3A5CED4DF778084' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:14.957+0000'::timestamp with time zone as ct_change
    union all
    select '371610D942804E95A1669A21BA9019AF' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '5833D73B31E04F8ABE9D307DBCE845A9' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '23D7350CA33E4033B3D8144E972BF52F' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '5F229304828F4AADBF9B0BE6463B1248' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:23:06.119+0000'::timestamp with time zone as ct_change
    union all
    select 'D731B655A83E49C3AA68CBF7F3888ADD' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '664B30CA82FC453BAADF14EE7C102312' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '9B4F219809B14D0B804D425D5E3A8651' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '6B1F10465BA848B4BF8E75924A6268A2' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '2D9027400C9846D99F10AB6DAA3B5C11' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '7457' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '233F0E304E804367986C4F81BA0C700D' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '8457' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-04-03T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'DCB9FF0E14AA48D8A8A6D2CF8CEB91DC' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '84599990888B6BCCE053809BA8C00CC8' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'BCCD81F36C7742238C539091D610106D' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '8672B08AF8C044BC963186193AA923F5' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:38:16.403+0000'::timestamp with time zone as ct_change
    union all
    select 'B51AF56C87384B17848C6FE5D8BE7484' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '8C96F9B255F5407FBCB8DE9189B15F39' as ck_class_child, '6E05E9179E274246A22A1583347ACA4D' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-11-18T12:15:34.260+0000'::timestamp with time zone as ct_change
    union all
    select '097DEB711510476187C19144D2C8CAE5' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'D71D4DEAC08946ABB75B9B9F34D76ED5' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '8E6AC2B44FCB8D3BE053809BA8C0E74D' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '9D870CD820544BD9A8C313488CB5B30D' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '97' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '15252FF6AAFC4FA891DDBA7C6DDF5593' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '4528EB269D124EE8B9EB59E2C56E7F94' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, 'DA77FDDE896F48909B19EBB516326D33' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
