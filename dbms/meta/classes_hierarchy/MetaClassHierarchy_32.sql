--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_32 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '9D14E9ED27F64920971192825DE664E7' as ck_id, '137' as ck_class_parent, '32' as ck_class_child, 'E292FDA1A128432D90B468F23A6CA3BB' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-12-08T10:33:28.254+0000'::timestamp with time zone as ct_change
    union all
    select '35' as ck_id, '18' as ck_class_parent, '32' as ck_class_child, '55' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'D0DEC310D76345519B02CF77D2199005' as ck_id, '19' as ck_class_parent, '32' as ck_class_child, '2419E72C5EFB42D3965A503A9D00B7F2' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-12-08T10:32:14.282+0000'::timestamp with time zone as ct_change
    union all
    select '5CC1B4AA488E47459FA15BD8E202C1D7' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '32' as ck_class_child, '8E3A9174CCB442F1B50A7E5F97806827' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-23T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '269' as ck_id, '32' as ck_class_parent, '1' as ck_class_child, '138' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '11993' as ck_id, '32' as ck_class_parent, '10457' as ck_class_child, '138' as ck_class_attr, '30021381' as ck_user, '2019-01-24T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '270' as ck_id, '32' as ck_class_parent, '137' as ck_class_child, '138' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '2988' as ck_id, '32' as ck_class_parent, '1457' as ck_class_child, '132' as ck_class_attr, '10020785' as ck_user, '2018-07-15T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'A45DA9D75B5541099C42C16C3E8205FB' as ck_id, '32' as ck_class_parent, '15593D209A1D46FC873706F69EE71E7A' as ck_class_child, '138' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '94' as ck_id, '32' as ck_class_parent, '18' as ck_class_child, '138' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '31' as ck_id, '32' as ck_class_parent, '19' as ck_class_child, '132' as ck_class_attr, '10020788' as ck_user, '2018-04-21T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '288' as ck_id, '32' as ck_class_parent, '197' as ck_class_child, '138' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '36' as ck_id, '32' as ck_class_parent, '26' as ck_class_child, '138' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '37' as ck_id, '32' as ck_class_parent, '27' as ck_class_child, '138' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '38' as ck_id, '32' as ck_class_parent, '28' as ck_class_child, '138' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '39' as ck_id, '32' as ck_class_parent, '29' as ck_class_child, '138' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'EF4739E55DBA41559FF0B048330DFDCB' as ck_id, '32' as ck_class_parent, '2BB74480D7E2455B97AED5B3A070FE35' as ck_class_child, '138' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-24T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '40' as ck_id, '32' as ck_class_parent, '30' as ck_class_child, '138' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'FD90342E17724D6685037CE3A2C6506D' as ck_id, '32' as ck_class_parent, '3061ADE6780F432B93F17C1DCCC33D93' as ck_class_child, '138' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:35.711+0000'::timestamp with time zone as ct_change
    union all
    select '41' as ck_id, '32' as ck_class_parent, '31' as ck_class_child, '138' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '885' as ck_id, '32' as ck_class_parent, '317' as ck_class_child, '138' as ck_class_attr, '10020785' as ck_user, '2018-03-05T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'C4BB8546759A47AAA4102F5EFB72B7DB' as ck_id, '32' as ck_class_parent, '32' as ck_class_child, '138' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-09-27T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '60' as ck_id, '32' as ck_class_parent, '33' as ck_class_child, '138' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '707' as ck_id, '32' as ck_class_parent, '337' as ck_class_child, '138' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '16985' as ck_id, '32' as ck_class_parent, '357' as ck_class_child, '138' as ck_class_attr, '10028610' as ck_user, '2019-02-13T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '95' as ck_id, '32' as ck_class_parent, '37' as ck_class_child, '138' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '97' as ck_id, '32' as ck_class_parent, '38' as ck_class_child, '138' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'E98958A14D304C1AB5D97C625ED0CDE0' as ck_id, '32' as ck_class_parent, '39AB8EAF9DCD456197944E6B6321989D' as ck_class_child, '138' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-23T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '44DB8433C10845FAAD218CE69310AB49' as ck_id, '32' as ck_class_parent, '417' as ck_class_child, '138' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-05-09T10:29:57.047+0000'::timestamp with time zone as ct_change
    union all
    select '5989' as ck_id, '32' as ck_class_parent, '4457' as ck_class_child, '138' as ck_class_attr, '10020785' as ck_user, '2018-10-07T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'A36690E5AB7143519E2EE658036F1491' as ck_id, '32' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, '138' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-04-09T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '76F8B118ADCC4E5DAB0887A7CE925B5A' as ck_id, '32' as ck_class_parent, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_child, '138' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:59:50.873+0000'::timestamp with time zone as ct_change
    union all
    select 'CB10D869610A461C952356441FF4A7A3' as ck_id, '32' as ck_class_parent, '508B0DE5C67B464CB3A5CED4DF778084' as ck_class_child, '138' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:14.957+0000'::timestamp with time zone as ct_change
    union all
    select 'D6FF702A485243118EE6AC689910FCB6' as ck_id, '32' as ck_class_parent, '5833D73B31E04F8ABE9D307DBCE845A9' as ck_class_child, '138' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-03-18T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'C6C01387B1FF4FF3BA64071B3803F73E' as ck_id, '32' as ck_class_parent, '5F229304828F4AADBF9B0BE6463B1248' as ck_class_child, '138' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-05-27T11:16:07.443+0000'::timestamp with time zone as ct_change
    union all
    select '65EBDA0371204C6A94E8EC28446176BE' as ck_id, '32' as ck_class_parent, '664B30CA82FC453BAADF14EE7C102312' as ck_class_child, '138' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-02-10T16:46:05.499+0000'::timestamp with time zone as ct_change
    union all
    select '512CE2DCD7F74C1C978639ACAC0FBAF5' as ck_id, '32' as ck_class_parent, '6B1F10465BA848B4BF8E75924A6268A2' as ck_class_child, '138' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-06-24T13:21:37.418+0000'::timestamp with time zone as ct_change
    union all
    select '14985' as ck_id, '32' as ck_class_parent, '7457' as ck_class_child, '138' as ck_class_attr, '10028610' as ck_user, '2019-02-10T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '865' as ck_id, '32' as ck_class_parent, '8' as ck_class_child, '138' as ck_class_attr, '10020785' as ck_user, '2018-03-04T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'B4F4D16D482E427398570E7DFE91D97D' as ck_id, '32' as ck_class_parent, '8457' as ck_class_child, '138' as ck_class_attr, '1' as ck_user, '2019-08-28T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '846060F16DF560F2E053809BA8C0CA26' as ck_id, '32' as ck_class_parent, '84599990888B6BCCE053809BA8C00CC8' as ck_class_child, '138' as ck_class_attr, '20785' as ck_user, '2019-03-17T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '10FEBD0259694AA4A00F3428EFD4D8A1' as ck_id, '32' as ck_class_parent, '858DBC49DF354ECCA2F57F36DAF4E37A' as ck_class_child, '138' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-03-01T12:34:06.588+0000'::timestamp with time zone as ct_change
    union all
    select 'CB306CE3F7EC43C69CB81846E6F6CC88' as ck_id, '32' as ck_class_parent, '8672B08AF8C044BC963186193AA923F5' as ck_class_child, '138' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-09-30T06:34:35.943+0000'::timestamp with time zone as ct_change
    union all
    select '05F5062AEED44747948175B4FB6E2627' as ck_id, '32' as ck_class_parent, '8C96F9B255F5407FBCB8DE9189B15F39' as ck_class_child, '132' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-11-18T12:15:34.260+0000'::timestamp with time zone as ct_change
    union all
    select '8D2BA0EF3704627EE053809BA8C0076B' as ck_id, '32' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '138' as ck_class_attr, '20785' as ck_user, '2019-07-13T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '8E809B5872E626FBE053809BA8C0A2F5' as ck_id, '32' as ck_class_parent, '8E6AC2B44FCB8D3BE053809BA8C0E74D' as ck_class_child, '138' as ck_class_attr, '20785' as ck_user, '2019-07-24T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'D2070D6582414F0D89D5D95143EDB6A1' as ck_id, '32' as ck_class_parent, '8FFC6C4564B84157E053809BA8C00266' as ck_class_child, '138' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-02-03T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '9B0E3F3715EF469DABBC6ACDC068D963' as ck_id, '32' as ck_class_parent, '92D23B81FAEA445DAB66C6651F1F0479' as ck_class_child, '138' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-10-24T11:42:29.988+0000'::timestamp with time zone as ct_change
    union all
    select '145' as ck_id, '32' as ck_class_parent, '97' as ck_class_child, '138' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '4302C39D93A04E1D9BB6D47E41B2FD00' as ck_id, '32' as ck_class_parent, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_child, '138' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-04-10T08:47:58.732+0000'::timestamp with time zone as ct_change
    union all
    select '5E09EE59B98C45338C3A9A40158DADDC' as ck_id, '32' as ck_class_parent, '9CC06E8D9D7E4791BA1C6232DAF60CDD' as ck_class_child, '132' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-18T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '19F9F82644044A77B605A78625930B7B' as ck_id, '32' as ck_class_parent, 'D966BA30FBA3469FB5FEA82127B1ED6D' as ck_class_child, '138' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-09-30T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'C669B151F2F542B3921AAA215637421B' as ck_id, '32' as ck_class_parent, 'DA77FDDE896F48909B19EBB516326D33' as ck_class_child, '138' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-06-25T11:47:18.474+0000'::timestamp with time zone as ct_change
    union all
    select '05D16C4ED7B0445BB2054212A032F47E' as ck_id, '32' as ck_class_parent, 'DAB69DA8C46746AD959E331D4CFAC8AD' as ck_class_child, '138' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-01-17T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '8E42D006A88143E486E6B4C4515B6983' as ck_id, '32' as ck_class_parent, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_child, '138' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-05-15T14:42:01.109+0000'::timestamp with time zone as ct_change
    union all
    select '66' as ck_id, '8' as ck_class_parent, '32' as ck_class_child, '54' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'BEE274C5DE2B4B508EF26B7A7D9A4763' as ck_id, '8672B08AF8C044BC963186193AA923F5' as ck_class_parent, '32' as ck_class_child, '020498F1380F44CF9C834F80C28DAD9E' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-10-10T11:09:13.447+0000'::timestamp with time zone as ct_change
    union all
    select '2DA263902A8E4F13B78E689115AB6949' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '32' as ck_class_child, '4054B98E02F342168872C8F83B86C7D4' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-12-08T10:32:48.010+0000'::timestamp with time zone as ct_change
    union all
    select '2E4517246F8048B081FE589A8C11D9F0' as ck_id, '8C96F9B255F5407FBCB8DE9189B15F39' as ck_class_parent, '32' as ck_class_child, 'A2568EEB60A442A8B8F4DF90DF547BC7' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-12-08T10:31:50.678+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
