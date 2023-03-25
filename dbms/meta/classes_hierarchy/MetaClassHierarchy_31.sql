--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_31 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '223' as ck_id, '1' as ck_class_parent, '31' as ck_class_child, '623' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '53' as ck_id, '10' as ck_class_parent, '31' as ck_class_child, '40' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '54' as ck_id, '11' as ck_class_parent, '31' as ck_class_child, '43' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '207' as ck_id, '137' as ck_class_parent, '31' as ck_class_child, '621' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '246' as ck_id, '157' as ck_class_parent, '31' as ck_class_child, '735' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '234' as ck_id, '17' as ck_class_parent, '31' as ck_class_child, '524' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '938F503C08444EE980AB87838F5D197B' as ck_id, '31' as ck_class_parent, '7C133EA0021A44A0864B82F7BC40F183' as ck_class_child, '05EC92721264431DBE89B8C3B7A53C85' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-13T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '41' as ck_id, '32' as ck_class_parent, '31' as ck_class_child, '138' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '857A42F381668F75E053809BA8C0916B' as ck_id, '357' as ck_class_parent, '31' as ck_class_child, '857A4193E2E18F83E053809BA8C07E37' as ck_class_attr, '20786' as ck_user, '2019-03-31T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '887' as ck_id, '417' as ck_class_parent, '31' as ck_class_child, '1850' as ck_class_attr, '10020786' as ck_user, '2018-03-05T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '6D973D7B9B904ECEA305B29DDA7B8487' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '31' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:55:45.672+0000'::timestamp with time zone as ct_change
    union all
    select '972885F33B9E4414A66FF47185D60147' as ck_id, '4BA159E82B434939AAD293411854ED95' as ck_class_parent, '31' as ck_class_child, '53F747643BEE49B795CA755F3532E598' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-09-20T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '109' as ck_id, '58' as ck_class_parent, '31' as ck_class_child, '382' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '6991' as ck_id, '6457' as ck_class_parent, '31' as ck_class_child, '36173' as ck_class_attr, '20785' as ck_user, '2018-12-11T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '7992' as ck_id, '7457' as ck_class_parent, '31' as ck_class_child, '37172' as ck_class_attr, '20785' as ck_user, '2018-12-19T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '809' as ck_id, '77' as ck_class_parent, '31' as ck_class_child, '450' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '87BF581B392D242FE053809BA8C0461B' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '31' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '20785' as ck_user, '2019-05-15T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '47' as ck_id, '9' as ck_class_parent, '31' as ck_class_child, '39' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000'::timestamp with time zone as ct_change
    union all
    select '27346855F265411BB59C3624BBEDDFAF' as ck_id, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_parent, '31' as ck_class_child, '4F0C103E377040179EF412F13E09D265' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-16T00:00:00.000+0000'::timestamp with time zone as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
