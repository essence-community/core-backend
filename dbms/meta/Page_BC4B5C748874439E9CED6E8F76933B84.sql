--liquibase formatted sql
--changeset patcher-core:Page_BC4B5C748874439E9CED6E8F76933B84 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
with recursive page as (
select
    ck_id
from
    s_mt.t_page
where
    ck_id = 'BC4B5C748874439E9CED6E8F76933B84'
union all
select
    p.ck_id
from
    s_mt.t_page p
join page rp on
    p.ck_parent = rp.ck_id )
delete
from
    s_mt.t_page_action ap
where ap.ck_page in (select ck_id from page);
with recursive page as (
select
    ck_id
from
    s_mt.t_page
where
    ck_id = 'BC4B5C748874439E9CED6E8F76933B84'
union all
select
    p.ck_id
from
    s_mt.t_page p
join page rp on
    p.ck_parent = rp.ck_id )
delete
from
    s_mt.t_page_variable ap
where ap.ck_page in (select ck_id from page);
with recursive page_object as (
select
    ck_id
from
    s_mt.t_page_object
where
    ck_page in ( with recursive page as (
    select
        ck_id
    from
        s_mt.t_page
    where
        ck_id = 'BC4B5C748874439E9CED6E8F76933B84'
union all
    select
        p.ck_id
    from
        s_mt.t_page p
    join page rp on
        p.ck_parent = rp.ck_id )
    select
        ck_id
    from
        page )
union all
select
    po.ck_id
from
    s_mt.t_page_object po
join page_object rp on
    po.ck_parent = rp.ck_id )
delete
from
    s_mt.t_page_object_attr attr
where attr.ck_page_object in (select ck_id from page_object);
with recursive page_object as (
select
    ck_id
from
    s_mt.t_page_object
where
    ck_page in ( with recursive page as (
    select
        ck_id
    from
        s_mt.t_page
    where
        ck_id = 'BC4B5C748874439E9CED6E8F76933B84'
union all
    select
        p.ck_id
    from
        s_mt.t_page p
    join page rp on
        p.ck_parent = rp.ck_id )
    select
        ck_id
    from
        page )
union all
select
    po.ck_id
from
    s_mt.t_page_object po
join page_object rp on
    po.ck_parent = rp.ck_id )
delete
from
    s_mt.t_page_object ob
where ob.ck_id in (select ck_id from page_object);
with recursive page as (
select
    ck_id
from
    s_mt.t_page
where
    ck_id = 'BC4B5C748874439E9CED6E8F76933B84'
union all
select
    p.ck_id
from
    s_mt.t_page p
join page rp on
    p.ck_parent = rp.ck_id )
delete
from
    s_mt.t_page p
where p.ck_id in (select ck_id from page);

INSERT INTO s_mt.t_page (ck_id, ck_parent, cr_type, cv_name, cn_order, cl_static, cv_url, ck_icon, ck_user, ct_change, cl_menu)VALUES('BC4B5C748874439E9CED6E8F76933B84', '4', 1, 'Локализация', 4, 0, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000', 1) on conflict (ck_id) do update set ck_parent = excluded.ck_parent, cr_type = excluded.cr_type, cv_name = excluded.cv_name, cn_order = excluded.cn_order, cl_static = excluded.cl_static, cv_url = excluded.cv_url, ck_icon = excluded.ck_icon, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_menu = excluded.cl_menu;
INSERT INTO s_mt.t_page (ck_id, ck_parent, cr_type, cv_name, cn_order, cl_static, cv_url, ck_icon, ck_user, ct_change, cl_menu)VALUES('DDBEA79C5CBE4DC3A2CEA74DA46216A7', 'BC4B5C748874439E9CED6E8F76933B84', 2, 'Список языков', 1, 0, null, '396', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000', 1) on conflict (ck_id) do update set ck_parent = excluded.ck_parent, cr_type = excluded.cr_type, cv_name = excluded.cv_name, cn_order = excluded.cn_order, cl_static = excluded.cl_static, cv_url = excluded.cv_url, ck_icon = excluded.ck_icon, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_menu = excluded.cl_menu;
INSERT INTO s_mt.t_page (ck_id, ck_parent, cr_type, cv_name, cn_order, cl_static, cv_url, ck_icon, ck_user, ct_change, cl_menu)VALUES('F5CAF3CF206A4454A48FA1466932B969', 'BC4B5C748874439E9CED6E8F76933B84', 2, 'Словарь', 20, 0, null, '280', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000', 1) on conflict (ck_id) do update set ck_parent = excluded.ck_parent, cr_type = excluded.cr_type, cv_name = excluded.cv_name, cn_order = excluded.cn_order, cl_static = excluded.cl_static, cv_url = excluded.cv_url, ck_icon = excluded.ck_icon, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_menu = excluded.cl_menu;
INSERT INTO s_mt.t_page_action (ck_id, ck_page, cr_type, cn_action, ck_user, ct_change)VALUES('12812E3772C4402597EC80FB52204B69', 'DDBEA79C5CBE4DC3A2CEA74DA46216A7', 'edit', 516, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cr_type = excluded.cr_type, cn_action = excluded.cn_action, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_action (ck_id, ck_page, cr_type, cn_action, ck_user, ct_change)VALUES('9375D16F2BF1494A9E231C5734F1D005', 'F5CAF3CF206A4454A48FA1466932B969', 'edit', 516, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cr_type = excluded.cr_type, cn_action = excluded.cn_action, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_action (ck_id, ck_page, cr_type, cn_action, ck_user, ct_change)VALUES('05BB5278147F43E7AB026A8204FD8A86', 'DDBEA79C5CBE4DC3A2CEA74DA46216A7', 'view', 515, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cr_type = excluded.cr_type, cn_action = excluded.cn_action, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_action (ck_id, ck_page, cr_type, cn_action, ck_user, ct_change)VALUES('B62D8310574C466C8E5D9C64BDC8ACF5', 'F5CAF3CF206A4454A48FA1466932B969', 'view', 515, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cr_type = excluded.cr_type, cn_action = excluded.cn_action, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_variable (ck_id, ck_page, cv_name, cv_description, ck_user, ct_change)VALUES('CAEFC7FE1DA94907AE3CFF57FCD39FE5', 'F5CAF3CF206A4454A48FA1466932B969', 'g_lang_exclude', 'ID слова/фразы', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cv_name = excluded.cv_name, cv_description = excluded.cv_description, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
select pkg_patcher.p_merge_object('6101F84D8CCC469892BB236F6068A71F', '8', null, 'SYS Language Grid', 1004002, 'MTGetLang', 'Список языков', null, 'pkg_json_localization.f_modify_lang', 'meta', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000');
select pkg_patcher.p_merge_object('03F927C598AE44B4BA12B8AB47EA139D', '19', '6101F84D8CCC469892BB236F6068A71F', 'Add Button', 10, null, 'Добавить', 'Добавить', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000');
select pkg_patcher.p_merge_object('DE15761B28524F9A839771FBFE3CBD30', '16', '6101F84D8CCC469892BB236F6068A71F', 'Edit Button', 20, null, 'Edit Button', null, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000');
select pkg_patcher.p_merge_object('2521C6316782498B9AD9656B933851DC', '9', '6101F84D8CCC469892BB236F6068A71F', 'ck_id', 30, null, 'Код языка', 'Код языка', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000');
select pkg_patcher.p_merge_object('3B2DF065710142FE9626F9BA36064E6F', '9', '6101F84D8CCC469892BB236F6068A71F', 'cv_name', 40, null, 'Наименование', 'Наименование', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000');
select pkg_patcher.p_merge_object('87EB6A9412F642C6B7BA3F0EAD5B55A3', '36', '6101F84D8CCC469892BB236F6068A71F', 'cl_default', 50, null, 'По умолчанию', 'По умолчанию', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('A313F5E188444EFD96E59AEBC0AB9396', '6101F84D8CCC469892BB236F6068A71F', '852', 'ck_id', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('9B7275DD09254958924683AA8F8C7DC5', '6101F84D8CCC469892BB236F6068A71F', '572', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('70DE15AF9ACB4235AE5F0B7D38A85EF1', '6101F84D8CCC469892BB236F6068A71F', '853', 'ASC', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('2E958F551CA14F89BBFAF71B807A6753', '6101F84D8CCC469892BB236F6068A71F', '28169', 'true', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('F2CE542569614E22B8B1978E2891C067', '03F927C598AE44B4BA12B8AB47EA139D', '155', '1', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('62CDDF8BD2DE4AEBBC35DE6676982387', '2521C6316782498B9AD9656B933851DC', '47', 'ck_id', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('B5D4EBBE8AB8476D96AB2BE0E1A42EA5', '2521C6316782498B9AD9656B933851DC', '433', 'insert', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('B70AB1771BC3480B97B2A41BE61D50D5', '3B2DF065710142FE9626F9BA36064E6F', '47', 'cv_name', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('8D6866E74DA74AD087286B8672A5BD38', '87EB6A9412F642C6B7BA3F0EAD5B55A3', '250', 'cl_default', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000');
select pkg_patcher.p_merge_object('0F1117C047384041B24D44E81C50634D', '137', null, 'SYS Localization Panel', 1004001, null, 'Локализация', null, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000');
select pkg_patcher.p_merge_object('DBCA7FE4E17548A7AFBE21B3E1FF060C', '8', '0F1117C047384041B24D44E81C50634D', 'Dictionary Grid', 10, 'MTGetDefaultLocalization', 'Список слов/фраз', 'Список слов/фраз', 'pkg_json_localization.f_modify_default_localization', 'meta', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000');
select pkg_patcher.p_merge_object('4FA67852465C4A08AF79D402DEA15054', '8', '0F1117C047384041B24D44E81C50634D', 'Translate Grid', 20, 'MTGetLocalization', 'Перевод', 'Перевод', 'pkg_json_localization.f_modify_localization', 'meta', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000');
select pkg_patcher.p_merge_object('9176BFC191804165ABDA5AB9F967BA3B', '19', 'DBCA7FE4E17548A7AFBE21B3E1FF060C', 'Add Button', 10, null, 'Добавить', 'Добавить', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000');
select pkg_patcher.p_merge_object('F0814387A1CC4C17BEAE4EB59DB3DEFF', '19', '4FA67852465C4A08AF79D402DEA15054', 'Add button', 10, null, 'Добавить', 'Добавить', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000');
select pkg_patcher.p_merge_object('F35C4A7DC6584774B5761BC2BD4BBEFB', '16', '4FA67852465C4A08AF79D402DEA15054', 'Edit Button', 20, null, 'Редактировать', null, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000');
select pkg_patcher.p_merge_object('845C3929F9D74FE2829E1E38D7F57B33', '16', 'DBCA7FE4E17548A7AFBE21B3E1FF060C', 'Edit Button', 20, null, 'Редактирование', null, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000');
select pkg_patcher.p_merge_object('1ED129A364054C1A81788D0A1080F689', '9', 'DBCA7FE4E17548A7AFBE21B3E1FF060C', 'ck_id', 30, null, 'Идентификатор', 'Идентификатор', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000');
select pkg_patcher.p_merge_object('B6512521E118405986D40EA94106B702', '9', '4FA67852465C4A08AF79D402DEA15054', 'cv_lang', 30, null, 'Язык', 'Язык', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000');
select pkg_patcher.p_merge_object('2CD90B3C086047D39DC887E28C949F88', '9', '4FA67852465C4A08AF79D402DEA15054', 'cv_value', 40, null, 'Перевод', 'Перевод', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000');
select pkg_patcher.p_merge_object('A4B0D06DCC904AD9BF3C7906DAB98744', '9', 'DBCA7FE4E17548A7AFBE21B3E1FF060C', 'cv_word', 40, null, 'Слово/Фраза', 'Слово/Фраза', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000');
select pkg_patcher.p_merge_object('DDAEA661457B4AA185099E7122BC131B', '9', 'DBCA7FE4E17548A7AFBE21B3E1FF060C', 'cv_type', 50, null, 'Тип расположения', 'Тип расположения', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000');
select pkg_patcher.p_merge_object('A0949123DBA248CAA93F68905BFEE127', '9', 'DBCA7FE4E17548A7AFBE21B3E1FF060C', 'cv_path', 60, null, 'Расположение', 'Расположение', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000');
select pkg_patcher.p_merge_object('196843D6A4AA462F86AB603457CE2100', '31', 'B6512521E118405986D40EA94106B702', 'cv_lang', 10, 'MTGetLang', 'Язык', 'Язык', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000');
select pkg_patcher.p_merge_object('F323F8193613406E85F6962024B2EC9C', '31', 'DDAEA661457B4AA185099E7122BC131B', 'cv_type', 10, 'MTGetLocalNameSpace', 'Тип расположения', 'Тип расположения', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('0DACE209FAD04395BF1105AB690A1E40', 'DBCA7FE4E17548A7AFBE21B3E1FF060C', '401', '25', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('6F4D56EB7C894A4E9F8D1DF7C906413D', 'DBCA7FE4E17548A7AFBE21B3E1FF060C', '852', 'cv_value', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('A8D2EFD54A744A23BBE3F8C87D85047E', 'DBCA7FE4E17548A7AFBE21B3E1FF060C', '853', 'ASC', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('BD01533E71E64F7281028A75CEE86364', '4FA67852465C4A08AF79D402DEA15054', '852', 'ck_d_lang', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('7FAE9FBC58254EA5BB03E92D10FD831D', '4FA67852465C4A08AF79D402DEA15054', '853', 'asc', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('C62398B5D473485897E3A31679D6C085', '4FA67852465C4A08AF79D402DEA15054', '572', 'false', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('B3F482EB54D749EC997F625CB5313881', '9176BFC191804165ABDA5AB9F967BA3B', '155', '1', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('259E71D7C79447EC90C302D16FF2CFB8', 'F0814387A1CC4C17BEAE4EB59DB3DEFF', '155', '1', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('11299E2870E04F3A9CAADA82A4757E95', '1ED129A364054C1A81788D0A1080F689', '47', 'ck_id', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('83BE1211DF044937B3DB35A24E14B5CD', '1ED129A364054C1A81788D0A1080F689', '433', 'disabled', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('2E5ACFF558E44D499313016E7A2F1162', 'B6512521E118405986D40EA94106B702', '47', 'cv_d_lang', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('E0BD2DC35C3A46338F5276A222028B3A', 'B6512521E118405986D40EA94106B702', '433', 'insert', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('7AC27088CF65401DBFD6AB887F40392C', '2CD90B3C086047D39DC887E28C949F88', '47', 'cv_value', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('B39243CCBFDE444583A8836E613E4BD0', 'A4B0D06DCC904AD9BF3C7906DAB98744', '47', 'cv_value', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('80DEDCFCCA964BFB9C33C2E3ACB2C245', 'DDAEA661457B4AA185099E7122BC131B', '47', 'cr_namespace', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('0D1C41CCB9374BFA8733EC7D6A2E415E', 'A0949123DBA248CAA93F68905BFEE127', '47', 'cv_path', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('C82AF6ECA5E5447A9B3962786AD9F215', 'A0949123DBA248CAA93F68905BFEE127', '433', 'disabled', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('0A11248F02814AAC900AFD8BB4B024AF', '196843D6A4AA462F86AB603457CE2100', '126', 'ck_id', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('C325C789DB214B268A2D6235B6F09D79', '196843D6A4AA462F86AB603457CE2100', '125', 'cv_name', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('C2FDD150508D421A88D9A5CA4F0E2793', '196843D6A4AA462F86AB603457CE2100', '120', 'ck_d_lang', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('2437B4E2880D448CB7F8A460FB40916B', 'F323F8193613406E85F6962024B2EC9C', '126', 'ck_id', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('5993C11A04EF46ACA87EF0627C138A95', 'F323F8193613406E85F6962024B2EC9C', '125', 'ck_id', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('577F681A02964FAEA35A9A37758DB1CD', 'F323F8193613406E85F6962024B2EC9C', '120', 'cr_namespace', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000');
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('EB7DA66474084531B31819AF930A2506', 'DDBEA79C5CBE4DC3A2CEA74DA46216A7', '6101F84D8CCC469892BB236F6068A71F', 10, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7255DF42D26C4AED9B479167A9FD242D', 'F5CAF3CF206A4454A48FA1466932B969', '0F1117C047384041B24D44E81C50634D', 10, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('571C350701F5432FA984B80205EABC24', 'DDBEA79C5CBE4DC3A2CEA74DA46216A7', '03F927C598AE44B4BA12B8AB47EA139D', 10, 'EB7DA66474084531B31819AF930A2506', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('D3A8514840FE4C3CB713C99B66446CA2', 'DDBEA79C5CBE4DC3A2CEA74DA46216A7', 'DE15761B28524F9A839771FBFE3CBD30', 20, 'EB7DA66474084531B31819AF930A2506', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('E0075E19832E4C9CAC6FB86DB3F305D8', 'DDBEA79C5CBE4DC3A2CEA74DA46216A7', '2521C6316782498B9AD9656B933851DC', 30, 'EB7DA66474084531B31819AF930A2506', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('21925871E5034726B171CCCA5C344930', 'DDBEA79C5CBE4DC3A2CEA74DA46216A7', '3B2DF065710142FE9626F9BA36064E6F', 40, 'EB7DA66474084531B31819AF930A2506', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('D4EB5D068C4440CCA15EB34FB0330954', 'DDBEA79C5CBE4DC3A2CEA74DA46216A7', '87EB6A9412F642C6B7BA3F0EAD5B55A3', 50, 'EB7DA66474084531B31819AF930A2506', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('C8E575B2C483413CAF2884477FB6E548', 'F5CAF3CF206A4454A48FA1466932B969', 'DBCA7FE4E17548A7AFBE21B3E1FF060C', 10, '7255DF42D26C4AED9B479167A9FD242D', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('DD14E144DFBA4DE892375B07E70EA17A', 'F5CAF3CF206A4454A48FA1466932B969', '4FA67852465C4A08AF79D402DEA15054', 20, '7255DF42D26C4AED9B479167A9FD242D', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('A78080CAE07D4A1388E108965DD08B11', 'F5CAF3CF206A4454A48FA1466932B969', '9176BFC191804165ABDA5AB9F967BA3B', 10, 'C8E575B2C483413CAF2884477FB6E548', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('90DDA76E04A5451AA8BD7D1C4EFF490D', 'F5CAF3CF206A4454A48FA1466932B969', 'F0814387A1CC4C17BEAE4EB59DB3DEFF', 10, 'DD14E144DFBA4DE892375B07E70EA17A', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('DA5B9A00E589436382F6E290450D5438', 'F5CAF3CF206A4454A48FA1466932B969', '845C3929F9D74FE2829E1E38D7F57B33', 20, 'C8E575B2C483413CAF2884477FB6E548', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('C9C3FD96155D4DD19F4247B9BC52FB8C', 'F5CAF3CF206A4454A48FA1466932B969', 'F35C4A7DC6584774B5761BC2BD4BBEFB', 20, 'DD14E144DFBA4DE892375B07E70EA17A', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('59D854A07011489887D06C5B45435C52', 'F5CAF3CF206A4454A48FA1466932B969', '1ED129A364054C1A81788D0A1080F689', 30, 'C8E575B2C483413CAF2884477FB6E548', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('B1BF3AE7AA30471483F25DFEFC306DC3', 'F5CAF3CF206A4454A48FA1466932B969', 'B6512521E118405986D40EA94106B702', 30, 'DD14E144DFBA4DE892375B07E70EA17A', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('F77E1E55405A4C4298A5DFFBC25CA701', 'F5CAF3CF206A4454A48FA1466932B969', '2CD90B3C086047D39DC887E28C949F88', 40, 'DD14E144DFBA4DE892375B07E70EA17A', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('B9D343B37491446DB8DF4BAAFC2B482A', 'F5CAF3CF206A4454A48FA1466932B969', 'A4B0D06DCC904AD9BF3C7906DAB98744', 40, 'C8E575B2C483413CAF2884477FB6E548', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('C8BDBD307BA24429AB47D34B8820C81D', 'F5CAF3CF206A4454A48FA1466932B969', 'DDAEA661457B4AA185099E7122BC131B', 50, 'C8E575B2C483413CAF2884477FB6E548', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('C9B828A2EBFE462C80C8E4C7ACE285D4', 'F5CAF3CF206A4454A48FA1466932B969', 'A0949123DBA248CAA93F68905BFEE127', 60, 'C8E575B2C483413CAF2884477FB6E548', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('8B1B032C07B641819232282953EE1BD4', 'F5CAF3CF206A4454A48FA1466932B969', '196843D6A4AA462F86AB603457CE2100', 10, 'B1BF3AE7AA30471483F25DFEFC306DC3', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('77111CDF68074B7F9524AF674FA99C68', 'F5CAF3CF206A4454A48FA1466932B969', 'F323F8193613406E85F6962024B2EC9C', 10, 'C8BDBD307BA24429AB47D34B8820C81D', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-11T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object_attr (ck_id, ck_page_object, ck_class_attr, cv_value, ck_user, ct_change) VALUES ('716EB8E9028B4FE5802950384FC891E3', 'C8E575B2C483413CAF2884477FB6E548', '1204', 'ck_id=g_lang_exclude', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000')  ON CONFLICT ON CONSTRAINT cin_c_page_object_attr_1 do update set ck_id=excluded.ck_id, ck_page_object = excluded.ck_page_object, ck_class_attr = excluded.ck_class_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object_attr (ck_id, ck_page_object, ck_class_attr, cv_value, ck_user, ct_change) VALUES ('C6758F2F825245F5AA19218FFBCC4E1B', '8B1B032C07B641819232282953EE1BD4', '1219', 'g_lang_exclude', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2019-11-12T00:00:00.000+0000')  ON CONFLICT ON CONSTRAINT cin_c_page_object_attr_1 do update set ck_id=excluded.ck_id, ck_page_object = excluded.ck_page_object, ck_class_attr = excluded.ck_class_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
update s_mt.t_page_object set ck_master='C8E575B2C483413CAF2884477FB6E548' where ck_id='DD14E144DFBA4DE892375B07E70EA17A';
