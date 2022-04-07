--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_4457 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '5985' as ck_id, '1' as ck_class_parent, '4457' as ck_class_child, '623' as ck_class_attr, '10020785' as ck_user, '2018-10-07T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '5988' as ck_id, '137' as ck_class_parent, '4457' as ck_class_child, '621' as ck_class_attr, '10020785' as ck_user, '2018-10-07T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '59CFC1DF83B94A2F8FE3467EFD0A32E4' as ck_id, '1807D17438814B31B75A279C4CBC6C0C' as ck_class_parent, '4457' as ck_class_child, '225864898ED0411FA0E5434CD3A85346' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-04-07T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '5989' as ck_id, '32' as ck_class_parent, '4457' as ck_class_child, '138' as ck_class_attr, '10020785' as ck_user, '2018-10-07T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '5986' as ck_id, '417' as ck_class_parent, '4457' as ck_class_child, '1850' as ck_class_attr, '10020785' as ck_user, '2018-10-07T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '307CA79817A14F668B5464F0E8AFDBCC' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '4457' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:54:55.631+0000'::timestamp with time zone as ct_change
    union all
    select '68405D6DA7A84DCC97A6F7941A95E104' as ck_id, '4BA159E82B434939AAD293411854ED95' as ck_class_parent, '4457' as ck_class_child, '53F747643BEE49B795CA755F3532E598' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-05-15T08:12:56.048+0000'::timestamp with time zone as ct_change
    union all
    select '5987' as ck_id, '58' as ck_class_parent, '4457' as ck_class_child, '382' as ck_class_attr, '10020785' as ck_user, '2018-10-07T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '12985' as ck_id, '6457' as ck_class_parent, '4457' as ck_class_child, '36173' as ck_class_attr, '10028610' as ck_user, '2019-02-05T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '7985' as ck_id, '7457' as ck_class_parent, '4457' as ck_class_child, '37172' as ck_class_attr, '20785' as ck_user, '2018-12-19T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '358D12A05FEA413E8541A49B1A41D77F' as ck_id, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_parent, '4457' as ck_class_child, '4F0C103E377040179EF412F13E09D265' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-26T00:00:00.000+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
