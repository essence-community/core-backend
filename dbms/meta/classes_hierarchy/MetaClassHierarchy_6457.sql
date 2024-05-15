--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_6457 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '10985' as ck_id, '38' as ck_class_parent, '6457' as ck_class_child, '40169' as ck_class_attr, '20785' as ck_user, '2019-01-21T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '11991' as ck_id, '6457' as ck_class_parent, '10457' as ck_class_child, '36173' as ck_class_attr, '30021381' as ck_user, '2019-01-24T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '6995' as ck_id, '6457' as ck_class_parent, '137' as ck_class_child, '36173' as ck_class_attr, '20785' as ck_user, '2018-12-12T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '0A8CC58BBEE14A948E10641E0E5FC494' as ck_id, '6457' as ck_class_parent, '15593D209A1D46FC873706F69EE71E7A' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '6600C5615EAF45BBA1DC8BACE07E281C' as ck_id, '6457' as ck_class_parent, '197' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '6986' as ck_id, '6457' as ck_class_parent, '26' as ck_class_child, '36173' as ck_class_attr, '20785' as ck_user, '2018-12-11T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '6987' as ck_id, '6457' as ck_class_parent, '27' as ck_class_child, '36173' as ck_class_attr, '20785' as ck_user, '2018-12-11T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '6988' as ck_id, '6457' as ck_class_parent, '28' as ck_class_child, '36173' as ck_class_attr, '20785' as ck_user, '2018-12-11T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '6989' as ck_id, '6457' as ck_class_parent, '29' as ck_class_child, '36173' as ck_class_attr, '20785' as ck_user, '2018-12-11T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '6990' as ck_id, '6457' as ck_class_parent, '30' as ck_class_child, '36173' as ck_class_attr, '20785' as ck_user, '2018-12-11T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '42C9DBB806AF4AF48631D3C8F86BEFE7' as ck_id, '6457' as ck_class_parent, '3061ADE6780F432B93F17C1DCCC33D93' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:35.711+0000'::timestamp with time zone as ct_change
    union all
    select '6991' as ck_id, '6457' as ck_class_parent, '31' as ck_class_child, '36173' as ck_class_attr, '20785' as ck_user, '2018-12-11T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '37A375F940CA419885C2B2A5E3B17EC9' as ck_id, '6457' as ck_class_parent, '317' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '3C39A4012CF343FCA48017574367A133' as ck_id, '6457' as ck_class_parent, '33' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'B26BBB461925403C91B0A27C0A22B801' as ck_id, '6457' as ck_class_parent, '357' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'E08B18C7093F4989B61C7B8DBDABBE03' as ck_id, '6457' as ck_class_parent, '37' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'D605315FBDD24BB180AD44C5ED01C94A' as ck_id, '6457' as ck_class_parent, '38' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '3A74D67E004E47589A588117E56F94D6' as ck_id, '6457' as ck_class_parent, '417' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '12985' as ck_id, '6457' as ck_class_parent, '4457' as ck_class_child, '36173' as ck_class_attr, '10028610' as ck_user, '2019-02-05T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '75D16228383245ABA11795C44A3F9A1D' as ck_id, '6457' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-04-09T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '5C80529ED28D46489D94A7B23457BACB' as ck_id, '6457' as ck_class_parent, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T10:01:45.975+0000'::timestamp with time zone as ct_change
    union all
    select '6B64D0858FA04090AE789C444ABB833D' as ck_id, '6457' as ck_class_parent, '508B0DE5C67B464CB3A5CED4DF778084' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:14.957+0000'::timestamp with time zone as ct_change
    union all
    select '96A90F586FF84A86B688033E7F9434BC' as ck_id, '6457' as ck_class_parent, '5833D73B31E04F8ABE9D307DBCE845A9' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '178DF055B7364F4F860F1F10898D1FD8' as ck_id, '6457' as ck_class_parent, '5F229304828F4AADBF9B0BE6463B1248' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-05-27T11:15:53.605+0000'::timestamp with time zone as ct_change
    union all
    select '1BF8298D0AE340EC928820A3CB14E331' as ck_id, '6457' as ck_class_parent, '664B30CA82FC453BAADF14EE7C102312' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '0AE797D1482E4EBEAC4EAA02BEB81EAA' as ck_id, '6457' as ck_class_parent, '6B1F10465BA848B4BF8E75924A6268A2' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '270AD6B6BD6342E0855407F077795843' as ck_id, '6457' as ck_class_parent, '7457' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '6259EF69B72F4B6C82E39BFBD2D47517' as ck_id, '6457' as ck_class_parent, '8457' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '6D6C08B721DD45E9B8CE1F9ABD308B3A' as ck_id, '6457' as ck_class_parent, '84599990888B6BCCE053809BA8C00CC8' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '37DB8F31FF244EAD992C7F2B40315D0D' as ck_id, '6457' as ck_class_parent, '8672B08AF8C044BC963186193AA923F5' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-09-30T06:33:35.904+0000'::timestamp with time zone as ct_change
    union all
    select '8D547C621A0A626CE053809BA8C0882B' as ck_id, '6457' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '36173' as ck_class_attr, '20785' as ck_user, '2019-07-13T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'E63662D15EFE4763BA8D5A2D28A0F2B6' as ck_id, '6457' as ck_class_parent, '8E6AC2B44FCB8D3BE053809BA8C0E74D' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '6992' as ck_id, '6457' as ck_class_parent, '97' as ck_class_child, '36173' as ck_class_attr, '20785' as ck_user, '2018-12-11T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'A922E50420E54235BBFDDFC9B0B2A095' as ck_id, '6457' as ck_class_parent, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-03-30T13:27:02.090+0000'::timestamp with time zone as ct_change
    union all
    select '7DBCC49259C64470913A3C0CAEF5E68A' as ck_id, '6457' as ck_class_parent, 'DA77FDDE896F48909B19EBB516326D33' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '8208F5E4426943DCB9E2F3A06122BDE5' as ck_id, '6457' as ck_class_parent, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-05-15T14:40:52.011+0000'::timestamp with time zone as ct_change
    union all
    select '6994' as ck_id, '8' as ck_class_parent, '6457' as ck_class_child, '36174' as ck_class_attr, '20785' as ck_user, '2018-12-11T00:00:00.000+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
