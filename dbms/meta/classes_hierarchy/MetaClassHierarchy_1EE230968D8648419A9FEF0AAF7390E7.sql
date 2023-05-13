--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_1EE230968D8648419A9FEF0AAF7390E7 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '5F09AEEB5557411A9085B80F5E5D77E0' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '0DDBEE01777844F5AC8F129EB5A43118' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-06-05T14:43:58.828+0000'::timestamp with time zone as ct_change
    union all
    select '49EF47513E074997AA1944FEF695C603' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '1' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-06-15T13:30:57.532+0000'::timestamp with time zone as ct_change
    union all
    select '31B28F35A8D847938880D913B9B439C1' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '10457' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '682F9C44468D4BA48EA74FD9123107A1' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '137' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-04-02T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '23A37F5C4CE8478BA8AB34782D849574' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '15593D209A1D46FC873706F69EE71E7A' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'C745F4C5E8DE458AAF0A0B603A9A6E46' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '1807D17438814B31B75A279C4CBC6C0C' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-15T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'B874D99674E8462EBB9025026BA40749' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '197' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'AC8B73F2CE8E4EDEBE2779ED95E6AACE' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '26' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '86A14A07ED794BB7BE3CB73F5E212E72' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '27' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '2D0C409774E04C96BBE063F31033D0A1' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '28' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'AB33FD7766684C669AAF19E327C210B6' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '29' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '2CF514FE337A4D2EAE49328C04E2F081' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '30' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '45D05FFC2F1B4A52BD5076B5A68AC4D6' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '31' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '8DF8A5A90BDC4F91A40071F2581E32D9' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '317' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '5CC1B4AA488E47459FA15BD8E202C1D7' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '32' as ck_class_child, '8E3A9174CCB442F1B50A7E5F97806827' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-23T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '4C6D6775538B47A7A80865F1B8B5BF92' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '33' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'FC414C48010A4C928CB8AF03F85F0CF4' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '357' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '1C4942F69DF44CF696EE54F8AF865622' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '37' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '9580D6F4003B4331957115E3146DF5EE' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '38' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'F11BFC7FFB44475EA6DE431B901F29C1' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '417' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'FA731216880A4DD1903B8A812C698546' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '4457' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '3AB46278CC674FA49B66468E0438CC8F' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '39CB7BEB6B294A1E948BBE6D9E4B0AE2' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '508B0DE5C67B464CB3A5CED4DF778084' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '75D72985565B4769BA9ADC563AFB5332' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '5833D73B31E04F8ABE9D307DBCE845A9' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '8FCA386AAE064666A8B209BD6CB4C4DD' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '5F229304828F4AADBF9B0BE6463B1248' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:23:06.119+0000'::timestamp with time zone as ct_change
    union all
    select 'FF376F4455FF4D15960F052A4071D3EC' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '664B30CA82FC453BAADF14EE7C102312' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'D70AF7C085F34FE6AE11B6D80C0BAEAA' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '6B1F10465BA848B4BF8E75924A6268A2' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'C3C17C96E5C944368A9EA68E19537F3E' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '7457' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '5DAAFCA9AACA4B6C82B00FA280B7D62E' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '8457' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'BE59302EC3594B62BAC6D729D0568924' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '84599990888B6BCCE053809BA8C00CC8' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'BF85B01171364DE4B4366F1C5518ACD6' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '8672B08AF8C044BC963186193AA923F5' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:38:16.403+0000'::timestamp with time zone as ct_change
    union all
    select 'C4291105ED6C4BF3B2220AFB305AA1D7' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '2E5D618C38C341EA8A93CEDCC3EE0955' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '8E6AC2B44FCB8D3BE053809BA8C0E74D' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'E02086A5CCD2486EB3493EE6FE17AAD6' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '97' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '879DDF35BA0146E09352DD4CA63A723B' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '10AF78DDC6BC4057BC1383D5658ACAE1' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, 'C3F1A4DE593B40FD81079A422C16070D' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-14T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'C6095F6BA57F4E4898FBA270088CD6FB' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-04-03T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '1C22D6B5A6D74B8B9CF006F8C9D66DD8' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, 'DA77FDDE896F48909B19EBB516326D33' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '24962C7D46404D2D8366D169AE6EC336' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, 'DF451F5CC0A54F8791C4DFAC12DAE42E' as ck_class_child, '8E3A9174CCB442F1B50A7E5F97806827' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-17T00:00:00.000+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
