--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_871CB755C589248AE053809BA8C0F31E dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '1786E6C06F2B404A8C15B8BA4C44633B' as ck_id, '1' as ck_class_parent, '871CB755C589248AE053809BA8C0F31E' as ck_class_child, '623' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-06-11T13:30:42.376+0000'::timestamp with time zone as ct_change
    union all
    select '871CB755C58C248AE053809BA8C0F31E' as ck_id, '137' as ck_class_parent, '871CB755C589248AE053809BA8C0F31E' as ck_class_child, '621' as ck_class_attr, '20785' as ck_user, '2019-05-15T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '87BF545279B513EDE053809BA8C0A884' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '10457' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '20785' as ck_user, '2019-05-16T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '59F26FA2D6ED456987D2E8C155B53969' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '137' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-28T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '11706B0DB96146298024A628F9E601C4' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '15593D209A1D46FC873706F69EE71E7A' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-05-20T10:09:12.593+0000'::timestamp with time zone as ct_change
    union all
    select '87A9EF4DBB2A5226E053809BA8C0E1C2' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '197' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '20785' as ck_user, '2019-05-16T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '87BF581B3930242FE053809BA8C0461B' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '26' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '20785' as ck_user, '2019-05-15T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '87A9EF4DBB2D5226E053809BA8C0E1C2' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '27' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '20785' as ck_user, '2019-05-16T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '87A9EF4DBB2E5226E053809BA8C0E1C2' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '28' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '20785' as ck_user, '2019-05-16T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '87BF545279B013EDE053809BA8C0A884' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '29' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '20785' as ck_user, '2019-05-16T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'ED4566DC08DC43C69C61E2F8E2D2823D' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '2BB74480D7E2455B97AED5B3A070FE35' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-24T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '87A9EF4DBB2B5226E053809BA8C0E1C2' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '30' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '20785' as ck_user, '2019-05-16T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '642075F047CC4ABDB7BCE9FA3BE8B0AE' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '3061ADE6780F432B93F17C1DCCC33D93' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:35.711+0000'::timestamp with time zone as ct_change
    union all
    select '87BF581B392D242FE053809BA8C0461B' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '31' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '20785' as ck_user, '2019-05-15T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '87BF545279B313EDE053809BA8C0A884' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '317' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '20785' as ck_user, '2019-05-16T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '2DA263902A8E4F13B78E689115AB6949' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '32' as ck_class_child, '4054B98E02F342168872C8F83B86C7D4' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-12-08T10:32:48.010+0000'::timestamp with time zone as ct_change
    union all
    select '87A9EF4DBB2C5226E053809BA8C0E1C2' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '33' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '20785' as ck_user, '2019-05-16T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '871A04B659F22480E053809BA8C06ED2' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '357' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '20785' as ck_user, '2019-05-16T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '87A9EF4DBB305226E053809BA8C0E1C2' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '37' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '20785' as ck_user, '2019-05-16T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '87BF545279B113EDE053809BA8C0A884' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '38' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '20785' as ck_user, '2019-05-16T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '87A9EF4DBB2F5226E053809BA8C0E1C2' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '417' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '20785' as ck_user, '2019-05-16T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'E2938D9CA21642F18E04EAA7A75B2312' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '47AC6CC616C3493E923FAD5E79B28166' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-04-09T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '8BA232ADDB3F40B192C7164197C97109' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T10:00:41.437+0000'::timestamp with time zone as ct_change
    union all
    select 'E08F77B21B7B47ADBC571FEE550C0978' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '508B0DE5C67B464CB3A5CED4DF778084' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-02-19T12:45:14.957+0000'::timestamp with time zone as ct_change
    union all
    select '48FF0C90DAFC4AC88BD20F112189952A' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '664B30CA82FC453BAADF14EE7C102312' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2021-02-10T16:44:58.494+0000'::timestamp with time zone as ct_change
    union all
    select '87BF545279B213EDE053809BA8C0A884' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '7457' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '20785' as ck_user, '2019-05-16T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '667B5779F6034956B769FBA43E60F3E2' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '8457' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-04-02T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '87A9EF4DBB295226E053809BA8C0E1C2' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '84599990888B6BCCE053809BA8C00CC8' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '20785' as ck_user, '2019-05-16T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '8D4FD9E32887628AE053809BA8C080EB' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '20785' as ck_user, '2019-07-13T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '87BF545279B413EDE053809BA8C0A884' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '97' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '20785' as ck_user, '2019-05-16T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'F482E3FA91F74DA7AE626026A3C4C748' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, 'DAB69DA8C46746AD959E331D4CFAC8AD' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-01-17T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '8F49F08F2DE04A6A87363FAE357BDED2' as ck_id, 'DF451F5CC0A54F8791C4DFAC12DAE42E' as ck_class_parent, '871CB755C589248AE053809BA8C0F31E' as ck_class_child, 'E2D0A96506384965A7B2666E5D2D1970' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-24T00:00:00.000+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
