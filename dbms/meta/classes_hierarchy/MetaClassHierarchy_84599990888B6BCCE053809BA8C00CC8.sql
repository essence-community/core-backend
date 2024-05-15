--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_84599990888B6BCCE053809BA8C00CC8 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '7BD9F3B7009E432FA4AD773C0967CC10' as ck_id, '1' as ck_class_parent, '84599990888B6BCCE053809BA8C00CC8' as ck_class_child, '623' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-11T07:53:15.659+0000'::timestamp with time zone as ct_change
    union all
    select 'A72010936FC24CB3BD2C91CFC6E12799' as ck_id, '10' as ck_class_parent, '84599990888B6BCCE053809BA8C00CC8' as ck_class_child, '40' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '724962CD79BE48FAAFE1F65F6C9F8D56' as ck_id, '11' as ck_class_parent, '84599990888B6BCCE053809BA8C00CC8' as ck_class_child, '43' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '5F011702D62946EF9A0E1BEBFCFF406A' as ck_id, '137' as ck_class_parent, '84599990888B6BCCE053809BA8C00CC8' as ck_class_child, '621' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-11T07:53:34.083+0000'::timestamp with time zone as ct_change
    union all
    select 'EE560C08F10C4D6987E68264F8289FBD' as ck_id, '17' as ck_class_parent, '84599990888B6BCCE053809BA8C00CC8' as ck_class_child, '524' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select 'BE59302EC3594B62BAC6D729D0568924' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '84599990888B6BCCE053809BA8C00CC8' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'D0F6B6CADA4F4A2BB32C40EF3F8D993C' as ck_id, '217' as ck_class_parent, '84599990888B6BCCE053809BA8C00CC8' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '846060F16DF560F2E053809BA8C0CA26' as ck_id, '32' as ck_class_parent, '84599990888B6BCCE053809BA8C00CC8' as ck_class_child, '138' as ck_class_attr, '20785' as ck_user, '2019-03-17T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'A35FDF73B3D349E199F22A30FE227C79' as ck_id, '36' as ck_class_parent, '84599990888B6BCCE053809BA8C00CC8' as ck_class_child, '254' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select 'E34A2CDA2EE9477D8C1DD72E237E9D61' as ck_id, '417' as ck_class_parent, '84599990888B6BCCE053809BA8C00CC8' as ck_class_child, '1850' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-11T07:57:28.489+0000'::timestamp with time zone as ct_change
    union all
    select 'B48FA45DFC7E439C95D2934C111E18F3' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '84599990888B6BCCE053809BA8C00CC8' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:55:57.282+0000'::timestamp with time zone as ct_change
    union all
    select '631D579AFA48484C8EF21919FB22ECF3' as ck_id, '4BA159E82B434939AAD293411854ED95' as ck_class_parent, '84599990888B6BCCE053809BA8C00CC8' as ck_class_child, '53F747643BEE49B795CA755F3532E598' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-09-20T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'F3CE5E5071A14D17AABD720D59D2EE0B' as ck_id, '58' as ck_class_parent, '84599990888B6BCCE053809BA8C00CC8' as ck_class_child, '382' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '6D6C08B721DD45E9B8CE1F9ABD308B3A' as ck_id, '6457' as ck_class_parent, '84599990888B6BCCE053809BA8C00CC8' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'E42F9F9DF09647709D8DBFAC1ACC6F3B' as ck_id, '7457' as ck_class_parent, '84599990888B6BCCE053809BA8C00CC8' as ck_class_child, '37172' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '389014E5DC644A5FAA9F5D5613F01A90' as ck_id, '77' as ck_class_parent, '84599990888B6BCCE053809BA8C00CC8' as ck_class_child, '450' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '87A9EF4DBB295226E053809BA8C0E1C2' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '84599990888B6BCCE053809BA8C00CC8' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '20785' as ck_user, '2019-05-16T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '591BA75BE45A4E8786C6073ACFF78701' as ck_id, '9' as ck_class_parent, '84599990888B6BCCE053809BA8C00CC8' as ck_class_child, '39' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '2B17C2D5FDF949E9A1B17B4BE0D0EE7C' as ck_id, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_parent, '84599990888B6BCCE053809BA8C00CC8' as ck_class_child, '4F0C103E377040179EF412F13E09D265' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-11T07:56:23.975+0000'::timestamp with time zone as ct_change
    union all
    select 'DCB9FF0E14AA48D8A8A6D2CF8CEB91DC' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '84599990888B6BCCE053809BA8C00CC8' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '68F5EA5EC070464FA775D1794F610DA7' as ck_id, 'DF451F5CC0A54F8791C4DFAC12DAE42E' as ck_class_parent, '84599990888B6BCCE053809BA8C00CC8' as ck_class_child, 'E2D0A96506384965A7B2666E5D2D1970' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-11T07:53:53.491+0000'::timestamp with time zone as ct_change
    union all
    select '12004615278A466183E771172C229F86' as ck_id, 'EC0610DA03D748E3B3086F49BEEE94ED' as ck_class_parent, '84599990888B6BCCE053809BA8C00CC8' as ck_class_child, 'EEBFE7B1ABBA407EAA22DE1DB8960C9C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2024-05-15T14:32:17.094+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
