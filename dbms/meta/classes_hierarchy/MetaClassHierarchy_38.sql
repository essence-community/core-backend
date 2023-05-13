--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_38 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '225' as ck_id, '1' as ck_class_parent, '38' as ck_class_child, '623' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '806' as ck_id, '10' as ck_class_parent, '38' as ck_class_child, '40' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '592B206BF34A498DBD6F381B86F30509' as ck_id, '11' as ck_class_parent, '38' as ck_class_child, '43' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '209' as ck_id, '137' as ck_class_parent, '38' as ck_class_child, '621' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '248' as ck_id, '157' as ck_class_parent, '38' as ck_class_child, '735' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '151' as ck_id, '17' as ck_class_parent, '38' as ck_class_child, '524' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '9580D6F4003B4331957115E3146DF5EE' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '38' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '251C033504A043E2876245CB730B7E51' as ck_id, '217' as ck_class_parent, '38' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '97' as ck_id, '32' as ck_class_parent, '38' as ck_class_child, '138' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '869F7391F57B426BBEA74B6DE14D1BB3' as ck_id, '36' as ck_class_parent, '38' as ck_class_child, '254' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:28:26.313+0000'::timestamp with time zone as ct_change
    union all
    select '89' as ck_id, '38' as ck_class_parent, '10' as ck_class_child, '306' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '90' as ck_id, '38' as ck_class_parent, '11' as ck_class_child, '306' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '132' as ck_id, '38' as ck_class_parent, '36' as ck_class_child, '306' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '988' as ck_id, '38' as ck_class_parent, '437' as ck_class_child, '306' as ck_class_attr, '10020848' as ck_user, '2018-07-10T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '107' as ck_id, '38' as ck_class_parent, '57' as ck_class_child, '306' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '148' as ck_id, '38' as ck_class_parent, '58' as ck_class_child, '520' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '10985' as ck_id, '38' as ck_class_parent, '6457' as ck_class_child, '40169' as ck_class_attr, '20785' as ck_user, '2019-01-21T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '129' as ck_id, '38' as ck_class_parent, '77' as ck_class_child, '306' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'D67802E5A80F44ECA586D21E3F6E3BE2' as ck_id, '38' as ck_class_parent, '7C133EA0021A44A0864B82F7BC40F183' as ck_class_child, '839DDEC274964C3EBD2588CF21A8F6A6' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-11-08T14:34:47.405+0000'::timestamp with time zone as ct_change
    union all
    select '665' as ck_id, '38' as ck_class_parent, '9' as ck_class_child, '306' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '892' as ck_id, '417' as ck_class_parent, '38' as ck_class_child, '1850' as ck_class_attr, '10020786' as ck_user, '2018-03-05T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '10DDE6E045A449D09326C4597E485213' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '38' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:56:37.417+0000'::timestamp with time zone as ct_change
    union all
    select '8B5EF501B37C4C6385C111C945CE9506' as ck_id, '4BA159E82B434939AAD293411854ED95' as ck_class_parent, '38' as ck_class_child, '53F747643BEE49B795CA755F3532E598' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-09-20T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '111' as ck_id, '58' as ck_class_parent, '38' as ck_class_child, '382' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'D605315FBDD24BB180AD44C5ED01C94A' as ck_id, '6457' as ck_class_parent, '38' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '7994' as ck_id, '7457' as ck_class_parent, '38' as ck_class_child, '37172' as ck_class_attr, '20785' as ck_user, '2018-12-19T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '808' as ck_id, '77' as ck_class_parent, '38' as ck_class_child, '450' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '87BF545279B113EDE053809BA8C0A884' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '38' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '20785' as ck_user, '2019-05-16T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '125' as ck_id, '9' as ck_class_parent, '38' as ck_class_child, '39' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '4F4C43D0554B4C218AAAD1E5310193DB' as ck_id, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_parent, '38' as ck_class_child, '4F0C103E377040179EF412F13E09D265' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-16T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '5CAAF56E339A43A8B24FA25AEC283883' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '38' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '3C18632ABBBF415792BA2996676E5F10' as ck_id, 'DF451F5CC0A54F8791C4DFAC12DAE42E' as ck_class_parent, '38' as ck_class_child, 'E2D0A96506384965A7B2666E5D2D1970' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
