--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_33 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '226' as ck_id, '1' as ck_class_parent, '33' as ck_class_child, '623' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '626' as ck_id, '10' as ck_class_parent, '33' as ck_class_child, '40' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '629' as ck_id, '11' as ck_class_parent, '33' as ck_class_child, '43' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '210' as ck_id, '137' as ck_class_parent, '33' as ck_class_child, '621' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '13985' as ck_id, '157' as ck_class_parent, '33' as ck_class_child, '735' as ck_class_attr, '10028610' as ck_user, '2019-02-06T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '628' as ck_id, '17' as ck_class_parent, '33' as ck_class_child, '524' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '4C6D6775538B47A7A80865F1B8B5BF92' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '33' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'CD94973B33ED4C068436CB4A13533DDB' as ck_id, '217' as ck_class_parent, '33' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '60' as ck_id, '32' as ck_class_parent, '33' as ck_class_child, '138' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '53902C7FF33647C5803E706CC4C1DA8B' as ck_id, '36' as ck_class_parent, '33' as ck_class_child, '254' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '893' as ck_id, '417' as ck_class_parent, '33' as ck_class_child, '1850' as ck_class_attr, '10020786' as ck_user, '2018-03-05T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'FEF1215CB72F4301AB883307AAC036A2' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '33' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:57:00.179+0000'::timestamp with time zone as ct_change
    union all
    select '4A03C907BF104EFFB657E0464C41D28C' as ck_id, '4BA159E82B434939AAD293411854ED95' as ck_class_parent, '33' as ck_class_child, '53F747643BEE49B795CA755F3532E598' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '585' as ck_id, '58' as ck_class_parent, '33' as ck_class_child, '382' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '3C39A4012CF343FCA48017574367A133' as ck_id, '6457' as ck_class_parent, '33' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '6A74B89E189A4499B7A58D8692B255E4' as ck_id, '7457' as ck_class_parent, '33' as ck_class_child, '37172' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '625' as ck_id, '77' as ck_class_parent, '33' as ck_class_child, '450' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '87A9EF4DBB2C5226E053809BA8C0E1C2' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '33' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '20785' as ck_user, '2019-05-16T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '627' as ck_id, '9' as ck_class_parent, '33' as ck_class_child, '39' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '9029E5800C1A4B0DB83A911341FB0446' as ck_id, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_parent, '33' as ck_class_child, '4F0C103E377040179EF412F13E09D265' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-17T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '673082E710E04ACCB93D4717CED2B1F6' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '33' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'A78AC43977D34CEC9CC31AD9466E27B9' as ck_id, 'DF451F5CC0A54F8791C4DFAC12DAE42E' as ck_class_parent, '33' as ck_class_child, 'E2D0A96506384965A7B2666E5D2D1970' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
