--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_357 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '647' as ck_id, '1' as ck_class_parent, '357' as ck_class_child, '623' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '645' as ck_id, '137' as ck_class_parent, '357' as ck_class_child, '621' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '646' as ck_id, '157' as ck_class_parent, '357' as ck_class_child, '735' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '16985' as ck_id, '32' as ck_class_parent, '357' as ck_class_child, '138' as ck_class_attr, '10028610' as ck_user, '2019-02-13T00:00:00.000+0000' as ct_change
    union all
    select '857A42F381668F75E053809BA8C0916B' as ck_id, '357' as ck_class_parent, '31' as ck_class_child, '857A4193E2E18F83E053809BA8C07E37' as ck_class_attr, '20786' as ck_user, '2019-03-31T00:00:00.000+0000' as ct_change
    union all
    select '889' as ck_id, '417' as ck_class_parent, '357' as ck_class_child, '1850' as ck_class_attr, '10020786' as ck_user, '2018-03-05T00:00:00.000+0000' as ct_change
    union all
    select 'D7F960DFB9254770B60D091FA571AB54' as ck_id, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_parent, '357' as ck_class_child, '030C24F8A7DF46BD87C420B866989703' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T09:56:14.157+0000' as ct_change
    union all
    select 'E599461243B443D79DAE9BE6BD901FBD' as ck_id, '4BA159E82B434939AAD293411854ED95' as ck_class_parent, '357' as ck_class_child, '53F747643BEE49B795CA755F3532E598' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-09-20T00:00:00.000+0000' as ct_change
    union all
    select '649' as ck_id, '58' as ck_class_parent, '357' as ck_class_child, '382' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
    union all
    select '871A04B659F22480E053809BA8C06ED2' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '357' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '20785' as ck_user, '2019-05-16T00:00:00.000+0000' as ct_change
    union all
    select '648' as ck_id, '9' as ck_class_parent, '357' as ck_class_child, '39' as ck_class_attr, '-11' as ck_user, '2018-02-22T00:00:00.000+0000' as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
