--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_97 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '229' as ck_id, '1' as ck_class_parent, '97' as ck_class_child, '623' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '213' as ck_id, '137' as ck_class_parent, '97' as ck_class_child, '621' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '254' as ck_id, '157' as ck_class_parent, '97' as ck_class_child, '735' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '145' as ck_id, '32' as ck_class_parent, '97' as ck_class_child, '138' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '93AEB109A9144D0AA8404FAF49DA7A67' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '97' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:58:10.436+0000' as ct_change
    union all
    select '6F9F548ADA3343C0B47E2256DF02CC86' as ck_id, '4BA159E82B434939AAD293411854ED95' as ck_class_parent, '97' as ck_class_child, '53F747643BEE49B795CA755F3532E598' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-09-20T00:00:00.000+0000' as ct_change
    union all
    select '146' as ck_id, '58' as ck_class_parent, '97' as ck_class_child, '382' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '6992' as ck_id, '6457' as ck_class_parent, '97' as ck_class_child, '36173' as ck_class_attr, '20785' as ck_user, '2018-12-11T00:00:00.000+0000' as ct_change
    union all
    select '7995' as ck_id, '7457' as ck_class_parent, '97' as ck_class_child, '37172' as ck_class_attr, '20785' as ck_user, '2018-12-19T00:00:00.000+0000' as ct_change
    union all
    select '87BF545279B413EDE053809BA8C0A884' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '97' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '20785' as ck_user, '2019-05-16T00:00:00.000+0000' as ct_change
    union all
    select '19985' as ck_id, '97' as ck_class_parent, '30' as ck_class_child, '50169' as ck_class_attr, '10028610' as ck_user, '2019-03-10T00:00:00.000+0000' as ct_change
    union all
    select '13A7C7265BB3475E8FE94A94FAC40A18' as ck_id, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_parent, '97' as ck_class_child, '4F0C103E377040179EF412F13E09D265' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-17T00:00:00.000+0000' as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
