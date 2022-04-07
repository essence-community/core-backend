--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_DF451F5CC0A54F8791C4DFAC12DAE42E dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '24962C7D46404D2D8366D169AE6EC336' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, 'DF451F5CC0A54F8791C4DFAC12DAE42E' as ck_class_child, '8E3A9174CCB442F1B50A7E5F97806827' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-17T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '756B52456E2E476A9DA563A71F1C61C9' as ck_id, 'DF451F5CC0A54F8791C4DFAC12DAE42E' as ck_class_parent, '1' as ck_class_child, 'E2D0A96506384965A7B2666E5D2D1970' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-21T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '7E11698D105343A99B01889BBB993A90' as ck_id, 'DF451F5CC0A54F8791C4DFAC12DAE42E' as ck_class_parent, '137' as ck_class_child, 'E2D0A96506384965A7B2666E5D2D1970' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-24T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '64D4D9D5C9E0445D8A6607CF1AF69A41' as ck_id, 'DF451F5CC0A54F8791C4DFAC12DAE42E' as ck_class_parent, '2BB74480D7E2455B97AED5B3A070FE35' as ck_class_child, 'E2D0A96506384965A7B2666E5D2D1970' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-24T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'E180EBE0D62B4ECAB1782C7B2E5D7566' as ck_id, 'DF451F5CC0A54F8791C4DFAC12DAE42E' as ck_class_parent, '337' as ck_class_child, 'E2D0A96506384965A7B2666E5D2D1970' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-21T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '27FF6AE691F94BF2A5D1309381807113' as ck_id, 'DF451F5CC0A54F8791C4DFAC12DAE42E' as ck_class_parent, '39AB8EAF9DCD456197944E6B6321989D' as ck_class_child, 'E2D0A96506384965A7B2666E5D2D1970' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-23T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '183578067D4942A0BE74E1C94F52424D' as ck_id, 'DF451F5CC0A54F8791C4DFAC12DAE42E' as ck_class_parent, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_child, 'E2D0A96506384965A7B2666E5D2D1970' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T10:00:08.186+0000'::timestamp with time zone as ct_change
    union all
    select 'EC5ED137F0AB470AB3FE843BF21BC36F' as ck_id, 'DF451F5CC0A54F8791C4DFAC12DAE42E' as ck_class_parent, '858DBC49DF354ECCA2F57F36DAF4E37A' as ck_class_child, 'E2D0A96506384965A7B2666E5D2D1970' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-30T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '8F49F08F2DE04A6A87363FAE357BDED2' as ck_id, 'DF451F5CC0A54F8791C4DFAC12DAE42E' as ck_class_parent, '871CB755C589248AE053809BA8C0F31E' as ck_class_child, 'E2D0A96506384965A7B2666E5D2D1970' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-24T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'F74CEACE01724EBAA357CF3A8984FBED' as ck_id, 'DF451F5CC0A54F8791C4DFAC12DAE42E' as ck_class_parent, 'BA125F895507411E8730C07D3AD26A3A' as ck_class_child, 'E2D0A96506384965A7B2666E5D2D1970' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-13T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'AE0ACB80A93B4AEEAB9E0F454880F100' as ck_id, 'DF451F5CC0A54F8791C4DFAC12DAE42E' as ck_class_parent, 'C0D39ADC290C40B3AF7AB27171051C9F' as ck_class_child, 'E2D0A96506384965A7B2666E5D2D1970' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-23T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '8A49EDBA6A594AE39BA3B89B6FD289F5' as ck_id, 'DF451F5CC0A54F8791C4DFAC12DAE42E' as ck_class_parent, 'C12028B0A13B4AE28E63CBB90F3428E1' as ck_class_child, 'E2D0A96506384965A7B2666E5D2D1970' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-10-21T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '14A4CA9ACCA5444DA53AFBDC70329832' as ck_id, 'DF451F5CC0A54F8791C4DFAC12DAE42E' as ck_class_parent, 'DAB69DA8C46746AD959E331D4CFAC8AD' as ck_class_child, 'E2D0A96506384965A7B2666E5D2D1970' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-01-17T00:00:00.000+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
