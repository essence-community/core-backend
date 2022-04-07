--liquibase formatted sql
--changeset patcher-core:MetaClassHierarchy_7457 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_class_hierarchy
(ck_id, ck_class_parent, ck_class_child, ck_class_attr, ck_user, ct_change)
 select t.ck_id, t.ck_class_parent, t.ck_class_child, t.ck_class_attr, t.ck_user, t.ct_change from (
    select '8F0CC686198C325DE053809BA8C053B6' as ck_id, '137' as ck_class_parent, '7457' as ck_class_child, '621' as ck_class_attr, '20780' as ck_user, '2019-08-06T00:00:00.000+0000' as ct_change
    union all
    select '914E9DE59B504109901B3D9A429DF04F' as ck_id, '157' as ck_class_parent, '7457' as ck_class_child, '735' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-04-22T13:03:35.560+0000' as ct_change
    union all
    select '14985' as ck_id, '32' as ck_class_parent, '7457' as ck_class_child, '138' as ck_class_attr, '10028610' as ck_user, '2019-02-10T00:00:00.000+0000' as ct_change
    union all
    select '7996' as ck_id, '58' as ck_class_parent, '7457' as ck_class_child, '382' as ck_class_attr, '20785' as ck_user, '2018-12-19T00:00:00.000+0000' as ct_change
    union all
    select '11986' as ck_id, '7457' as ck_class_parent, '10457' as ck_class_child, '37172' as ck_class_attr, '30021381' as ck_user, '2019-01-24T00:00:00.000+0000' as ct_change
    union all
    select '7986' as ck_id, '7457' as ck_class_parent, '26' as ck_class_child, '37172' as ck_class_attr, '20785' as ck_user, '2018-12-19T00:00:00.000+0000' as ct_change
    union all
    select '7987' as ck_id, '7457' as ck_class_parent, '27' as ck_class_child, '37172' as ck_class_attr, '20785' as ck_user, '2018-12-19T00:00:00.000+0000' as ct_change
    union all
    select '7988' as ck_id, '7457' as ck_class_parent, '28' as ck_class_child, '37172' as ck_class_attr, '20785' as ck_user, '2018-12-19T00:00:00.000+0000' as ct_change
    union all
    select '7989' as ck_id, '7457' as ck_class_parent, '29' as ck_class_child, '37172' as ck_class_attr, '20785' as ck_user, '2018-12-19T00:00:00.000+0000' as ct_change
    union all
    select '7990' as ck_id, '7457' as ck_class_parent, '30' as ck_class_child, '37172' as ck_class_attr, '20785' as ck_user, '2018-12-19T00:00:00.000+0000' as ct_change
    union all
    select '7992' as ck_id, '7457' as ck_class_parent, '31' as ck_class_child, '37172' as ck_class_attr, '20785' as ck_user, '2018-12-19T00:00:00.000+0000' as ct_change
    union all
    select '7993' as ck_id, '7457' as ck_class_parent, '37' as ck_class_child, '37172' as ck_class_attr, '20785' as ck_user, '2018-12-19T00:00:00.000+0000' as ct_change
    union all
    select '7994' as ck_id, '7457' as ck_class_parent, '38' as ck_class_child, '37172' as ck_class_attr, '20785' as ck_user, '2018-12-19T00:00:00.000+0000' as ct_change
    union all
    select '7985' as ck_id, '7457' as ck_class_parent, '4457' as ck_class_child, '37172' as ck_class_attr, '20785' as ck_user, '2018-12-19T00:00:00.000+0000' as ct_change
    union all
    select 'F6F38A01BFFC4DEDBEFACCA7A568CEA7' as ck_id, '7457' as ck_class_parent, '4A7B7B56D5D544A7B81EB8D50EA8C8EC' as ck_class_child, '37172' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T10:02:47.317+0000' as ct_change
    union all
    select '8D3A50B6DE966276E053809BA8C0911C' as ck_id, '7457' as ck_class_parent, '8D547C621A02626CE053809BA8C0882B' as ck_class_child, '37172' as ck_class_attr, '20785' as ck_user, '2019-07-13T00:00:00.000+0000' as ct_change
    union all
    select '7995' as ck_id, '7457' as ck_class_parent, '97' as ck_class_child, '37172' as ck_class_attr, '20785' as ck_user, '2018-12-19T00:00:00.000+0000' as ct_change
    union all
    select '7194DAE8161E447A8FD09323B114F967' as ck_id, '7457' as ck_class_parent, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_child, '37172' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-08-27T10:03:02.960+0000' as ct_change
    union all
    select '87BF545279B213EDE053809BA8C0A884' as ck_id, '871CB755C589248AE053809BA8C0F31E' as ck_class_parent, '7457' as ck_class_child, '876936326A5213F3E053809BA8C0487C' as ck_class_attr, '20785' as ck_user, '2019-05-16T00:00:00.000+0000' as ct_change
    union all
    select 'A4350660DD8F4772BB9C8A9C0524E1F4' as ck_id, '9964E8D5F6C04D9F85AC78E6EFBD72F1' as ck_class_parent, '7457' as ck_class_child, '4F0C103E377040179EF412F13E09D265' as ck_class_attr, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-26T00:00:00.000+0000' as ct_change
 ) as t
 where t.ck_class_parent in (select ck_id from s_mt.t_class) and t.ck_class_child in (select ck_id from s_mt.t_class)
 on conflict on constraint cin_c_class_hierarchy_1 do update set ck_class_parent = excluded.ck_class_parent, ck_class_child = excluded.ck_class_child, ck_class_attr = excluded.ck_class_attr, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
