--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_1 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '217' as ck_id, '1' as ck_class_parent, '1' as ck_class_child, '623' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '11985' as ck_id, '1' as ck_class_parent, '10457' as ck_class_child, '623' as ck_class_attr, '30021381' as ck_user, '2019-01-24T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '218' as ck_id, '1' as ck_class_parent, '137' as ck_class_child, '623' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '258' as ck_id, '1' as ck_class_parent, '157' as ck_class_child, '623' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '221' as ck_id, '1' as ck_class_parent, '18' as ck_class_child, '623' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '287' as ck_id, '1' as ck_class_parent, '197' as ck_class_child, '623' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '230' as ck_id, '1' as ck_class_parent, '26' as ck_class_child, '623' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '227' as ck_id, '1' as ck_class_parent, '27' as ck_class_child, '623' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '228' as ck_id, '1' as ck_class_parent, '28' as ck_class_child, '623' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '222' as ck_id, '1' as ck_class_parent, '29' as ck_class_child, '623' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '224' as ck_id, '1' as ck_class_parent, '30' as ck_class_child, '623' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '8129A24CBDD5454DAA65769B5447157D' as ck_id, '1' as ck_class_parent, '3061ADE6780F432B93F17C1DCCC33D93' as ck_class_child, '623' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:35.711+0000'::timestamp with time zone as ct_change
    union all
    select '223' as ck_id, '1' as ck_class_parent, '31' as ck_class_child, '623' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '226' as ck_id, '1' as ck_class_parent, '33' as ck_class_child, '623' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '705' as ck_id, '1' as ck_class_parent, '337' as ck_class_child, '623' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '219' as ck_id, '1' as ck_class_parent, '35' as ck_class_child, '623' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '647' as ck_id, '1' as ck_class_parent, '357' as ck_class_child, '623' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '231' as ck_id, '1' as ck_class_parent, '37' as ck_class_child, '623' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '225' as ck_id, '1' as ck_class_parent, '38' as ck_class_child, '623' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '05040B1318CE4C21A0FE5248D1605E65' as ck_id, '1' as ck_class_parent, '39AB8EAF9DCD456197944E6B6321989D' as ck_class_child, '623' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-23T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '8F7C9522838F4E5DAB22B2F25C96B26D' as ck_id, '1' as ck_class_parent, '417' as ck_class_child, '623' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-05-09T10:29:42.141+0000'::timestamp with time zone as ct_change
    union all
    select '5985' as ck_id, '1' as ck_class_parent, '4457' as ck_class_child, '623' as ck_class_attr, '10020785' as ck_user, '2018-10-07T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'DC201ABB803C4196A350BE8CFD427FFB' as ck_id, '1' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, '623' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-04-09T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '2EF0A80070544148A5AE453CCE8B72BF' as ck_id, '1' as ck_class_parent, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_child, '623' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T10:02:12.675+0000'::timestamp with time zone as ct_change
    union all
    select '463012588CB0436982875EE4D5191B4D' as ck_id, '1' as ck_class_parent, '508B0DE5C67B464CB3A5CED4DF778084' as ck_class_child, '623' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:14.957+0000'::timestamp with time zone as ct_change
    union all
    select '1219ADF584634D82A7A83D7DB9662516' as ck_id, '1' as ck_class_parent, '5833D73B31E04F8ABE9D307DBCE845A9' as ck_class_child, '623' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-03-18T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '06A70E0E355D4B999B51CACCC67CC7B6' as ck_id, '1' as ck_class_parent, '5F229304828F4AADBF9B0BE6463B1248' as ck_class_child, '623' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-06-15T13:31:05.701+0000'::timestamp with time zone as ct_change
    union all
    select 'F20C870B32BD47AC8C2FACF032B2B7EF' as ck_id, '1' as ck_class_parent, '664B30CA82FC453BAADF14EE7C102312' as ck_class_child, '623' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-02-10T16:46:17.657+0000'::timestamp with time zone as ct_change
    union all
    select '220' as ck_id, '1' as ck_class_parent, '8' as ck_class_child, '623' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '8986' as ck_id, '1' as ck_class_parent, '8457' as ck_class_child, '623' as ck_class_attr, '20786' as ck_user, '2018-12-24T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '74824813DEC549BE9EBF5556DCC43300' as ck_id, '1' as ck_class_parent, '8672B08AF8C044BC963186193AA923F5' as ck_class_child, '623' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-09-30T06:32:47.649+0000'::timestamp with time zone as ct_change
    union all
    select '1786E6C06F2B404A8C15B8BA4C44633B' as ck_id, '1' as ck_class_parent, '871CB755C589248AE053809BA8C0F31E' as ck_class_child, '623' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-06-11T13:30:42.376+0000'::timestamp with time zone as ct_change
    union all
    select '8D2BA0EF3702627EE053809BA8C0076B' as ck_id, '1' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '623' as ck_class_attr, '20785' as ck_user, '2019-07-13T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '4A50D11419BA492CAF12BBCA044C0BD0' as ck_id, '1' as ck_class_parent, '8FFC6C4564B84157E053809BA8C00266' as ck_class_child, '623' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-10-12T15:17:43.050+0000'::timestamp with time zone as ct_change
    union all
    select '45D749C94E1041AAAE6D5FC1CDA8AA7B' as ck_id, '1' as ck_class_parent, '92D23B81FAEA445DAB66C6651F1F0479' as ck_class_child, '623' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-10-24T11:41:48.602+0000'::timestamp with time zone as ct_change
    union all
    select '229' as ck_id, '1' as ck_class_parent, '97' as ck_class_child, '623' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '8C43764A693544ABAEA15F65A339A3CC' as ck_id, '1' as ck_class_parent, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_child, '623' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-03-09T13:21:02.285+0000'::timestamp with time zone as ct_change
    union all
    select 'BCB20A4360E04E7DA169553A5E5BF93E' as ck_id, '1' as ck_class_parent, 'BA125F895507411E8730C07D3AD26A3A' as ck_class_child, '623' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-03T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '58D9E3DC7AB342CDB3578111FF1EC034' as ck_id, '1' as ck_class_parent, 'C3F1A4DE593B40FD81079A422C16070D' as ck_class_child, '623' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-06-17T07:57:44.359+0000'::timestamp with time zone as ct_change
    union all
    select '8E5C6E77F6FC4B3E9EEE1DE5A3AD4CF1' as ck_id, '1' as ck_class_parent, 'D966BA30FBA3469FB5FEA82127B1ED6D' as ck_class_child, '623' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-09-27T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '8B843F6A73AE49B0BC8A1CFE7DADEA24' as ck_id, '1' as ck_class_parent, 'DAB69DA8C46746AD959E331D4CFAC8AD' as ck_class_child, '623' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-01-17T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '202' as ck_id, '137' as ck_class_parent, '1' as ck_class_child, '621' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '49EF47513E074997AA1944FEF695C603' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '1' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-06-15T13:30:57.532+0000'::timestamp with time zone as ct_change
    union all
    select '305' as ck_id, '217' as ck_class_parent, '1' as ck_class_child, '829' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '269' as ck_id, '32' as ck_class_parent, '1' as ck_class_child, '138' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '69242842B678467E8C6A16BB30EEAB6D' as ck_id, '35' as ck_class_parent, '1' as ck_class_child, '172' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-06-11T13:29:20.057+0000'::timestamp with time zone as ct_change
    union all
    select '2019FF6677AE484BA7731DC0AD34B0EA' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '1' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:55:17.249+0000'::timestamp with time zone as ct_change
    union all
    select 'DBCD75F2366C4CEC9014274EE8D7E170' as ck_id, '92D23B81FAEA445DAB66C6651F1F0479' as ck_class_parent, '1' as ck_class_child, '5A77102C08BB468EA5E45DCF6036C048' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-10-24T11:39:02.438+0000'::timestamp with time zone as ct_change
    union all
    select 'B70E831C3BD2427A844A3FA193B80914' as ck_id, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_parent, '1' as ck_class_child, '4F0C103E377040179EF412F13E09D265' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-11-13T16:11:48.272+0000'::timestamp with time zone as ct_change
    union all
    select '74741F6AD2144260A9D88DB54A2DF3CA' as ck_id, 'C3F1A4DE593B40FD81079A422C16070D' as ck_class_parent, '1' as ck_class_child, 'C5CC30188D464E26A99E092BA1EB128B' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-06-11T11:52:10.054+0000'::timestamp with time zone as ct_change
    union all
    select '756B52456E2E476A9DA563A71F1C61C9' as ck_id, 'DF451F5CC0A54F8791C4DFAC12DAE42E' as ck_class_parent, '1' as ck_class_child, 'E2D0A96506384965A7B2666E5D2D1970' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-21T00:00:00.000+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
