--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_37 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '231' as ck_id, '1' as ck_class_parent, '37' as ck_class_child, '623' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '36A9FA9CAFE744AE907F6252D9A8EC46' as ck_id, '10' as ck_class_parent, '37' as ck_class_child, '40' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select 'C44DEE537D6C4B75893F3A808D8F7FB6' as ck_id, '11' as ck_class_parent, '37' as ck_class_child, '43' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '215' as ck_id, '137' as ck_class_parent, '37' as ck_class_child, '621' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '252' as ck_id, '157' as ck_class_parent, '37' as ck_class_child, '735' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '150' as ck_id, '17' as ck_class_parent, '37' as ck_class_child, '524' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '1C4942F69DF44CF696EE54F8AF865622' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '37' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'BC014BF9468D4827A06106479CB83857' as ck_id, '217' as ck_class_parent, '37' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '95' as ck_id, '32' as ck_class_parent, '37' as ck_class_child, '138' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'E70AF74669D34D55927E666016770775' as ck_id, '36' as ck_class_parent, '37' as ck_class_child, '254' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '93' as ck_id, '37' as ck_class_parent, '10' as ck_class_child, '270' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '131' as ck_id, '37' as ck_class_parent, '11' as ck_class_child, '270' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '91' as ck_id, '37' as ck_class_parent, '17' as ck_class_child, '270' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '133' as ck_id, '37' as ck_class_parent, '36' as ck_class_child, '270' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '20A30007B2B84742AE85C5A66E2A790F' as ck_id, '37' as ck_class_parent, '437' as ck_class_child, '270' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-18T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '147' as ck_id, '37' as ck_class_parent, '58' as ck_class_child, '519' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '130' as ck_id, '37' as ck_class_parent, '77' as ck_class_child, '270' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'D48C7B53A2494082917AA1932CBE7A92' as ck_id, '37' as ck_class_parent, '7C133EA0021A44A0864B82F7BC40F183' as ck_class_child, 'BFAEF3A5F1094DB5A58521C3A358CF23' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-11-08T14:37:55.920+0000'::timestamp with time zone as ct_change
    union all
    select '92' as ck_id, '37' as ck_class_parent, '9' as ck_class_child, '270' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '899' as ck_id, '417' as ck_class_parent, '37' as ck_class_child, '1850' as ck_class_attr, '10020786' as ck_user, '2018-03-05T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '7686CAC6706E47E7BAF6568FE1EE9462' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '37' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:56:46.468+0000'::timestamp with time zone as ct_change
    union all
    select 'FCF34A313A5B43EBBCE75DB389AE9835' as ck_id, '4BA159E82B434939AAD293411854ED95' as ck_class_parent, '37' as ck_class_child, '53F747643BEE49B795CA755F3532E598' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-09-20T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '114' as ck_id, '58' as ck_class_parent, '37' as ck_class_child, '382' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'E08B18C7093F4989B61C7B8DBDABBE03' as ck_id, '6457' as ck_class_parent, '37' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '7993' as ck_id, '7457' as ck_class_parent, '37' as ck_class_child, '37172' as ck_class_attr, '20785' as ck_user, '2018-12-19T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'C809404517C84BAF81A9EA654E3CA890' as ck_id, '77' as ck_class_parent, '37' as ck_class_child, '450' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '87A9EF4DBB305226E053809BA8C0E1C2' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '37' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '20785' as ck_user, '2019-05-16T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '126' as ck_id, '9' as ck_class_parent, '37' as ck_class_child, '39' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '592472D6FFED4D7E990CD195A9320FAD' as ck_id, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_parent, '37' as ck_class_child, '4F0C103E377040179EF412F13E09D265' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-17T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'B349363B00F14181ADFC0EFB3C441D93' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '37' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'E7544B8797964486B15FCAD43F1A4452' as ck_id, 'DF451F5CC0A54F8791C4DFAC12DAE42E' as ck_class_parent, '37' as ck_class_child, 'E2D0A96506384965A7B2666E5D2D1970' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
