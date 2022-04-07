--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_417 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '8F7C9522838F4E5DAB22B2F25C96B26D' as ck_id, '1' as ck_class_parent, '417' as ck_class_child, '623' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-05-09T10:29:42.141+0000' as ct_change
    union all
    select '44DB8433C10845FAAD218CE69310AB49' as ck_id, '32' as ck_class_parent, '417' as ck_class_child, '138' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-05-09T10:29:57.047+0000' as ct_change
    union all
    select '11987' as ck_id, '417' as ck_class_parent, '10457' as ck_class_child, '1850' as ck_class_attr, '30021381' as ck_user, '2019-01-24T00:00:00.000+0000' as ct_change
    union all
    select '888' as ck_id, '417' as ck_class_parent, '197' as ck_class_child, '1850' as ck_class_attr, '10020786' as ck_user, '2018-03-05T00:00:00.000+0000' as ct_change
    union all
    select '898' as ck_id, '417' as ck_class_parent, '26' as ck_class_child, '1850' as ck_class_attr, '10020786' as ck_user, '2018-03-05T00:00:00.000+0000' as ct_change
    union all
    select '894' as ck_id, '417' as ck_class_parent, '27' as ck_class_child, '1850' as ck_class_attr, '10020786' as ck_user, '2018-03-05T00:00:00.000+0000' as ct_change
    union all
    select '896' as ck_id, '417' as ck_class_parent, '28' as ck_class_child, '1850' as ck_class_attr, '10020786' as ck_user, '2018-03-05T00:00:00.000+0000' as ct_change
    union all
    select '886' as ck_id, '417' as ck_class_parent, '29' as ck_class_child, '1850' as ck_class_attr, '10020786' as ck_user, '2018-03-05T00:00:00.000+0000' as ct_change
    union all
    select '890' as ck_id, '417' as ck_class_parent, '30' as ck_class_child, '1850' as ck_class_attr, '10020786' as ck_user, '2018-03-05T00:00:00.000+0000' as ct_change
    union all
    select '887' as ck_id, '417' as ck_class_parent, '31' as ck_class_child, '1850' as ck_class_attr, '10020786' as ck_user, '2018-03-05T00:00:00.000+0000' as ct_change
    union all
    select '893' as ck_id, '417' as ck_class_parent, '33' as ck_class_child, '1850' as ck_class_attr, '10020786' as ck_user, '2018-03-05T00:00:00.000+0000' as ct_change
    union all
    select '889' as ck_id, '417' as ck_class_parent, '357' as ck_class_child, '1850' as ck_class_attr, '10020786' as ck_user, '2018-03-05T00:00:00.000+0000' as ct_change
    union all
    select '899' as ck_id, '417' as ck_class_parent, '37' as ck_class_child, '1850' as ck_class_attr, '10020786' as ck_user, '2018-03-05T00:00:00.000+0000' as ct_change
    union all
    select '892' as ck_id, '417' as ck_class_parent, '38' as ck_class_child, '1850' as ck_class_attr, '10020786' as ck_user, '2018-03-05T00:00:00.000+0000' as ct_change
    union all
    select '897' as ck_id, '417' as ck_class_parent, '417' as ck_class_child, '1850' as ck_class_attr, '10020786' as ck_user, '2018-03-05T00:00:00.000+0000' as ct_change
    union all
    select '5986' as ck_id, '417' as ck_class_parent, '4457' as ck_class_child, '1850' as ck_class_attr, '10020785' as ck_user, '2018-10-07T00:00:00.000+0000' as ct_change
    union all
    select '0567A396904E4C72B072F3DC2F2EEA19' as ck_id, '417' as ck_class_parent, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_child, '1850' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T10:01:15.179+0000' as ct_change
    union all
    select '8D2BA0EF3703627EE053809BA8C0076B' as ck_id, '417' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '1850' as ck_class_attr, '20785' as ck_user, '2019-07-13T00:00:00.000+0000' as ct_change
    union all
    select 'CAEDBBF6EF3D494CB5EC8922BEB64B4B' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '417' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:58:56.697+0000' as ct_change
    union all
    select '87A9EF4DBB2F5226E053809BA8C0E1C2' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '417' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '20785' as ck_user, '2019-05-16T00:00:00.000+0000' as ct_change
    union all
    select 'BC77BE97AE904C199C8250B91940064F' as ck_id, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_parent, '417' as ck_class_child, '4F0C103E377040179EF412F13E09D265' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-17T00:00:00.000+0000' as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
