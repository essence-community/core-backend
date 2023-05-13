--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_5833D73B31E04F8ABE9D307DBCE845A9 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '1219ADF584634D82A7A83D7DB9662516' as ck_id, '1' as ck_class_parent, '5833D73B31E04F8ABE9D307DBCE845A9' as ck_class_child, '623' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-03-18T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select 'F392C364B5BE471EA18E24FCFD9EB253' as ck_id, '137' as ck_class_parent, '5833D73B31E04F8ABE9D307DBCE845A9' as ck_class_child, '621' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-03-17T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '75D72985565B4769BA9ADC563AFB5332' as ck_id, '1EE230968D8648419A9FEF0AAF7390E7' as ck_class_parent, '5833D73B31E04F8ABE9D307DBCE845A9' as ck_class_child, '290CBFB50CFC4362B2F00C5C4D34AAB5' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '56D8DBF0B2D34923894654C8323FFEA6' as ck_id, '217' as ck_class_parent, '5833D73B31E04F8ABE9D307DBCE845A9' as ck_class_child, '829' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'D6FF702A485243118EE6AC689910FCB6' as ck_id, '32' as ck_class_parent, '5833D73B31E04F8ABE9D307DBCE845A9' as ck_class_child, '138' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-03-18T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '01F71E2674CD4904BCC717E0033E6CF2' as ck_id, '417' as ck_class_parent, '5833D73B31E04F8ABE9D307DBCE845A9' as ck_class_child, '1850' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'DF359B4372BE4D6BB2637679CDB0B754' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '5833D73B31E04F8ABE9D307DBCE845A9' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '36D3C42BD6E64DA3BE93654903269252' as ck_id, '4BA159E82B434939AAD293411854ED95' as ck_class_parent, '5833D73B31E04F8ABE9D307DBCE845A9' as ck_class_child, '53F747643BEE49B795CA755F3532E598' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '30F71583AF674BBBA6E4055B2E4E465E' as ck_id, '58' as ck_class_parent, '5833D73B31E04F8ABE9D307DBCE845A9' as ck_class_child, '382' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-03-18T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '0B9A8F74F28A43CDBACF5C45F66DA591' as ck_id, '5833D73B31E04F8ABE9D307DBCE845A9' as ck_class_parent, '7C133EA0021A44A0864B82F7BC40F183' as ck_class_child, '4AEC70A0D12E482CAD770D943783B1FD' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2022-11-08T14:36:49.100+0000'::timestamp with time zone as ct_change
    union all
    select '96A90F586FF84A86B688033E7F9434BC' as ck_id, '6457' as ck_class_parent, '5833D73B31E04F8ABE9D307DBCE845A9' as ck_class_child, '36173' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select 'E0D38235AFF64A478C62BC2305D56A62' as ck_id, '7457' as ck_class_parent, '5833D73B31E04F8ABE9D307DBCE845A9' as ck_class_child, '37172' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '48335A06A8EC448BA77488B46E3A4A51' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '5833D73B31E04F8ABE9D307DBCE845A9' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '0697A15F0785405CBCA437035830867A' as ck_id, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_parent, '5833D73B31E04F8ABE9D307DBCE845A9' as ck_class_child, '4F0C103E377040179EF412F13E09D265' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '371610D942804E95A1669A21BA9019AF' as ck_id, 'C6C0F987FD584F42A7B7D8B2ECEE63F6' as ck_class_parent, '5833D73B31E04F8ABE9D307DBCE845A9' as ck_class_child, '80DD4A0346D64BABA81C613331D14FCF' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
    union all
    select '79C33C815BEA4B8F8F56873782D5F468' as ck_id, 'DF451F5CC0A54F8791C4DFAC12DAE42E' as ck_class_parent, '5833D73B31E04F8ABE9D307DBCE845A9' as ck_class_child, 'E2D0A96506384965A7B2666E5D2D1970' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2023-05-13T13:22:02.239+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
