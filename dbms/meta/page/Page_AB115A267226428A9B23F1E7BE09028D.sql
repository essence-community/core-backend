--liquibase formatted sql
--changeset patcher-core:Page_AB115A267226428A9B23F1E7BE09028D dbms:postgresql runOnChange:true splitStatements:false stripComments:false
select pkg_patcher.p_remove_page('AB115A267226428A9B23F1E7BE09028D');

INSERT INTO s_mt.t_page (ck_id, ck_parent, cr_type, cv_name, cn_order, cl_static, cv_url, ck_icon, ck_view, ck_user, ct_change, cl_menu)VALUES('AB115A267226428A9B23F1E7BE09028D', 'EFFC1868B5804AABAAF7EE516BD24952', 2, '5dd02c20f14e41bd9d02b27a529765a2', 40, 0, null, null, 'system', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-11T08:37:45.858+0000', 1) on conflict (ck_id) do update set ck_parent = excluded.ck_parent, ck_view=excluded.ck_view, cr_type = excluded.cr_type, cv_name = excluded.cv_name, cn_order = excluded.cn_order, cl_static = excluded.cl_static, cv_url = excluded.cv_url, ck_icon = excluded.ck_icon, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_menu = excluded.cl_menu;
select pkg_patcher.p_merge_page_action('886B4657D59149E98A1A9B77B77AAC45', 'AB115A267226428A9B23F1E7BE09028D', 'edit', 99999, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-11T08:37:45.858+0000');
select pkg_patcher.p_merge_page_action('DEAB74159C2E419AA5158E4A816E47D4', 'AB115A267226428A9B23F1E7BE09028D', 'view', 99999, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-11T08:37:45.858+0000');
select pkg_patcher.p_merge_object('0A7BD5B1D90C44B8904F6808D7217FC9', '1EE230968D8648419A9FEF0AAF7390E7', null, 'SYS Application - Docs', 15, 'DTRoute', 'Application Docs', null, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-11T08:52:35.475+0000');
select pkg_patcher.p_merge_object('9DEEB415991744B585D5D66B44D61362', '1807D17438814B31B75A279C4CBC6C0C', '0A7BD5B1D90C44B8904F6808D7217FC9', 'App Bar Docs', 10, null, 'App Bar Docs', null, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-11T08:34:04.803+0000');
select pkg_patcher.p_merge_object('046E8E9C7ED641CD89726F6141D8168B', '1', '0A7BD5B1D90C44B8904F6808D7217FC9', 'Box Page Content', 30, null, 'Box Page Content', null, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-17T07:56:51.634+0000');
select pkg_patcher.p_merge_object('4EA909980F0942449E115F4BE0980AA0', 'DF451F5CC0A54F8791C4DFAC12DAE42E', '0A7BD5B1D90C44B8904F6808D7217FC9', 'Drawer Menu', 110, null, 'Drawer для меню', null, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-11T08:51:52.635+0000');
select pkg_patcher.p_merge_object('1D5E2008386949CF880FE00EDF6DCF02', '32', '0A7BD5B1D90C44B8904F6808D7217FC9', 'Window About', 210, null, 'О программе', '66eeff41c0c94c5ca52909fb9d97e0aa', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-15T08:52:12.575+0000');
select pkg_patcher.p_merge_object('6CAD5516D17B40ECBD1CF9958DB4B7C7', 'DF451F5CC0A54F8791C4DFAC12DAE42E', '0A7BD5B1D90C44B8904F6808D7217FC9', 'Favorite Pages', 310, null, 'Избранные страницы', null, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-15T08:53:52.229+0000');
select pkg_patcher.p_merge_object('8F78CB94849A42DC800013765DF49E3B', '39AB8EAF9DCD456197944E6B6321989D', '4EA909980F0942449E115F4BE0980AA0', 'Pages Tree', 1, null, 'Дерево страниц', null, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-11T08:52:01.696+0000');
select pkg_patcher.p_merge_object('4BF66E79AD474510A4F48588473C0097', '1', '046E8E9C7ED641CD89726F6141D8168B', 'Box Pager Tree', 10, null, 'Box Pager Tree', null, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-17T08:02:03.342+0000');
select pkg_patcher.p_merge_object('B085536AE0754E7EBD6E37F4972D7C10', 'DB557A6113634FD2BC40D2A58EE1EB3F', '9DEEB415991744B585D5D66B44D61362', 'Button Group Left', 10, null, 'Секция кнопок слева', null, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-11T08:50:44.984+0000');
select pkg_patcher.p_merge_object('535E001C1A1E4C8C8535424D569D710A', 'C0D39ADC290C40B3AF7AB27171051C9F', '6CAD5516D17B40ECBD1CF9958DB4B7C7', 'Favorite Pages', 10, null, 'Избранные страницы', null, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-15T08:54:01.563+0000');
select pkg_patcher.p_merge_object('877D85060B1B4688B3C973348E487CBC', '8FFC6C4564B84157E053809BA8C00266', '1D5E2008386949CF880FE00EDF6DCF02', 'About IFrame', 20, 'MTGetMainAppInfo', 'About IFrame', null, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-15T08:52:18.861+0000');
select pkg_patcher.p_merge_object('0ADBC859505D4651B936684A864DC34C', '16CD1F9A0789445AA23AC20DA565BFCC', '9DEEB415991744B585D5D66B44D61362', 'Docs Open Page Tabs', 20, null, 'Docs Open Page Tabs', null, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-11T11:51:10.309+0000');
select pkg_patcher.p_merge_object('B285428583D74A9E80179D4443EADFA7', 'DB557A6113634FD2BC40D2A58EE1EB3F', '9DEEB415991744B585D5D66B44D61362', 'Button Group Right', 30, null, 'Button Group Right', null, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-15T08:48:41.728+0000');
select pkg_patcher.p_merge_object('3B8E28D4C0654DED977579351066A8E9', '19', '1D5E2008386949CF880FE00EDF6DCF02', 'Close Silent', 30, null, 'Close Silent', null, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-15T08:52:25.386+0000');
select pkg_patcher.p_merge_object('2C014F2BF97A443994FFC147DA5A3C96', 'C3F1A4DE593B40FD81079A422C16070D', '046E8E9C7ED641CD89726F6141D8168B', 'Pages', 40, null, 'Список отображаемых страниц', null, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-17T07:58:38.629+0000');
select pkg_patcher.p_merge_object('2F3954CB3EAF443CB3D40FE7EB78B18E', '19', 'B085536AE0754E7EBD6E37F4972D7C10', 'Button Favorite', 10, null, 'Открытие закладок', null, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-15T08:53:00.226+0000');
select pkg_patcher.p_merge_object('A0F6F56A96314FD685755D278A212C93', 'FC278B804F4C4DE6A273C8C4D6F4037D', '2C014F2BF97A443994FFC147DA5A3C96', 'Documentation', 10, 'MTClassDoc', 'Documentation', null, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-17T07:58:44.287+0000');
select pkg_patcher.p_merge_object('48CE1DF9590B41E9B8AF9ABF4B3EFA70', '39AB8EAF9DCD456197944E6B6321989D', '4BF66E79AD474510A4F48588473C0097', 'Pages Tree', 10, null, 'Pages Tree', null, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-17T08:02:21.562+0000');
select pkg_patcher.p_merge_object('7A93258A975244DEB5104E18994C058B', '19', 'B285428583D74A9E80179D4443EADFA7', 'Button Promo', 50, null, 'Button Promo', null, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-15T08:50:00.917+0000');
select pkg_patcher.p_merge_object('BA632D5FA0C44447B37DEE7C4749CC73', '19', 'B285428583D74A9E80179D4443EADFA7', 'Button Auth', 100, null, 'Button Auth', null, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-15T08:49:35.952+0000');
select pkg_patcher.p_merge_object('8B75939BE5054D009B2520870DAC3A04', '19', 'B285428583D74A9E80179D4443EADFA7', 'Button About', 200, null, 'О программе', '66eeff41c0c94c5ca52909fb9d97e0aa', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-15T08:51:47.646+0000');
select pkg_patcher.p_merge_object_attr('CD638BD67E3B4608944533FE690BB8F3', '2F3954CB3EAF443CB3D40FE7EB78B18E', '1033', 'favorite', '-1', '2020-06-11T08:49:48.965+0000', 'ckwindow');
select pkg_patcher.p_merge_object_attr('CBA46D8FF1074F3488656F12A9CFDCE5', '2F3954CB3EAF443CB3D40FE7EB78B18E', '140', 'onWindowOpen', '-1', '2020-06-11T08:49:48.965+0000', 'handler');
select pkg_patcher.p_merge_object_attr('9E7893F5D5114CFD8FAE3D45694ED62B', '2F3954CB3EAF443CB3D40FE7EB78B18E', '1695', 'true', '-1', '2020-06-11T08:49:48.965+0000', 'onlyicon');
select pkg_patcher.p_merge_object_attr('FD4245FDF0324F67B1721E201DE3BA62', '48CE1DF9590B41E9B8AF9ABF4B3EFA70', '20F0E7D0EB25421CBB24A625361926BB', '1', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-17T09:24:01.856+0000', 'uitype');
select pkg_patcher.p_merge_object_attr('65121CBED2E24C189003E0E08CA9A803', '9DEEB415991744B585D5D66B44D61362', '5F01393A5D014FF3A017C1D3F840D8E2', '45px', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-11T08:34:14.768+0000', 'height');
select pkg_patcher.p_merge_object_attr('06CAA844197F4827A151C465DE8A773D', 'B085536AE0754E7EBD6E37F4972D7C10', '6AC299E9D222440A83B2E721571B9A77', 'true', '-1', '2020-06-11T08:49:48.965+0000', 'onlyicon');
select pkg_patcher.p_merge_object_attr('5A5670F9ADEE40CDBF5E98F3CEBE1CE3', '0A7BD5B1D90C44B8904F6808D7217FC9', '939B5B0FDBB24DB08E935675A72676B7', 'home-docs', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-15T19:12:32.004+0000', 'defaultvalue');
select pkg_patcher.p_merge_object_attr('968B2197172541F8BA3CA46AEAF61053', '2F3954CB3EAF443CB3D40FE7EB78B18E', '992', 'star', '-1', '2020-06-11T08:49:48.965+0000', 'iconfont');
select pkg_patcher.p_merge_object_attr('94C5A8A502DC4530BA3CD5DB797B356B', '4BF66E79AD474510A4F48588473C0097', 'E359855F0DD2453682B50E28F681C865', '30%', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-17T08:02:08.512+0000', 'width');
select pkg_patcher.p_merge_object_attr('29A947E9A8564DB8B3501260942D4836', '4BF66E79AD474510A4F48588473C0097', 'F1E87EE3389B4347B0C67B596742F36D', '100%', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-17T09:06:14.413+0000', 'height');
select pkg_patcher.p_merge_object_attr('65D9826F4D904401A32CD0E4A5AFD35F', '877D85060B1B4688B3C973348E487CBC', '252CD650ED1549ED80F0201417F44920', '"HTML"', '-1', '2020-06-15T08:51:00.574+0000', 'typeiframe');
select pkg_patcher.p_merge_object_attr('8173D3ABEFE244159FA5BF6D93A17F22', '0ADBC859505D4651B936684A864DC34C', '2BE24312010A4711AF1DE65E17E5A3BD', '100%', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-11T12:02:15.430+0000', 'width');
select pkg_patcher.p_merge_object_attr('C0BE81F09AD84C2181C68F11324A3B63', '877D85060B1B4688B3C973348E487CBC', '8FFF734D4DBA414BE053809BA8C08F58', 'cv_app_info', '-1', '2020-06-15T08:51:00.574+0000', 'column');
select pkg_patcher.p_merge_object_attr('8723A74336AC4DE4BB055CBB9702D60A', '0ADBC859505D4651B936684A864DC34C', '93731877298F4BBF8A931752BB439B9E', '45px', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-11T12:01:53.521+0000', 'height');
select pkg_patcher.p_merge_object_attr('6C3D85EA57A44D2092DE632605EAA0A9', '3B8E28D4C0654DED977579351066A8E9', '140', 'onCloseWindowSilent', '-1', '2020-06-15T08:51:00.574+0000', 'handler');
select pkg_patcher.p_merge_object_attr('9E6F54C269F04835B04E179A3E876428', '3B8E28D4C0654DED977579351066A8E9', '154', 'true', '-1', '2020-06-15T08:51:00.574+0000', 'hidden');
select pkg_patcher.p_merge_object_attr('BD093D47DA0348F08BD838621138F0F0', '046E8E9C7ED641CD89726F6141D8168B', 'F1E87EE3389B4347B0C67B596742F36D', '100%', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-17T09:05:10.680+0000', 'height');
select pkg_patcher.p_merge_object_attr('8E57A53C993A4DF9BD40BF65A2BCA117', '2C014F2BF97A443994FFC147DA5A3C96', 'F379091F1CCF43808359B6496BBF6179', '100%', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-17T09:32:06.550+0000', 'height');
select pkg_patcher.p_merge_object_attr('8F4651553B824129B422C0B389974E5D', '7A93258A975244DEB5104E18994C058B', '1695', 'true', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-15T08:52:03.531+0000', 'onlyicon');
select pkg_patcher.p_merge_object_attr('390A4A02E8F94EB09C04C3C0BD1CBBE6', '7A93258A975244DEB5104E18994C058B', '24169', 'redirect/promo', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-15T08:50:16.032+0000', 'redirecturl');
select pkg_patcher.p_merge_object_attr('3A6FCF80D70E42719302A7B46F167349', '7A93258A975244DEB5104E18994C058B', '992', 'home', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-15T08:50:33.031+0000', 'iconfont');
select pkg_patcher.p_merge_object_attr('D3A6310E0C0345A7BEBD0E08E40ADA6A', 'BA632D5FA0C44447B37DEE7C4749CC73', '1695', 'true', '-1', '2020-06-15T08:49:16.464+0000', 'onlyicon');
select pkg_patcher.p_merge_object_attr('0FE0FE10CE504DD684C7BF77091B1009', 'BA632D5FA0C44447B37DEE7C4749CC73', '24169', 'g_sess_session ? "redirect/pages" : "redirect/auth"', '-1', '2020-06-15T08:49:16.464+0000', 'redirecturl');
select pkg_patcher.p_merge_object_attr('BF6E3AE77BC2484DABE68373F71647F4', 'BA632D5FA0C44447B37DEE7C4749CC73', '992', 'sign-in', '-1', '2020-06-15T08:49:16.464+0000', 'iconfont');
select pkg_patcher.p_merge_object_attr('7EB71C4DDE1341B28233BE3DE4405B78', '4EA909980F0942449E115F4BE0980AA0', '8FFBC8F0C42E4CC2A108DE0AABD1A5A3', '20%', '-1', '2020-06-11T08:51:21.902+0000', 'width');
select pkg_patcher.p_merge_object_attr('2E1BEEC2E3DD432AA181A55526974258', '4EA909980F0942449E115F4BE0980AA0', 'EC07783AE2E8459EBE2E6772E439D782', 'menu', '-1', '2020-06-11T08:51:21.902+0000', 'ckwindow');
select pkg_patcher.p_merge_object_attr('DC5FE0B26F5542038B6B3B902B62A5AA', '8B75939BE5054D009B2520870DAC3A04', '1033', 'about', '-1', '2020-06-15T08:51:32.549+0000', 'ckwindow');
select pkg_patcher.p_merge_object_attr('4A683F3FEA6E4F179170A4AE4CA1A86B', '8B75939BE5054D009B2520870DAC3A04', '140', 'onWindowOpen', '-1', '2020-06-15T08:51:32.549+0000', 'handler');
select pkg_patcher.p_merge_object_attr('42139C4F2FCD41E981BB31432C71DE0B', '8B75939BE5054D009B2520870DAC3A04', '1695', 'true', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-15T08:51:55.272+0000', 'onlyicon');
select pkg_patcher.p_merge_object_attr('DBEC556B332847C087D950382122A93D', '8B75939BE5054D009B2520870DAC3A04', '992', 'info-circle ', '-1', '2020-06-15T08:51:32.549+0000', 'iconfont');
select pkg_patcher.p_merge_object_attr('4BF1C09EA5194508BEF05F14F5B4CDC7', '1D5E2008386949CF880FE00EDF6DCF02', '1029', 'about', '-1', '2020-06-15T08:51:00.574+0000', 'ckwindow');
select pkg_patcher.p_merge_object_attr('08D32966E7E542639544B63DE01ADB44', '6CAD5516D17B40ECBD1CF9958DB4B7C7', '8FFBC8F0C42E4CC2A108DE0AABD1A5A3', '20%', '-1', '2020-06-15T08:53:34.617+0000', 'width');
select pkg_patcher.p_merge_object_attr('3825F1057F1043A78EAA0E9BE416EE5E', '6CAD5516D17B40ECBD1CF9958DB4B7C7', 'EC07783AE2E8459EBE2E6772E439D782', 'favorite', '-1', '2020-06-15T08:53:34.617+0000', 'ckwindow');
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('C99780A37AF74E98B26183D4A454328B', 'AB115A267226428A9B23F1E7BE09028D', '0A7BD5B1D90C44B8904F6808D7217FC9', 10, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-11T08:52:54.404+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('540F9C04453E4AEBB291B8E0ECE286F6', 'AB115A267226428A9B23F1E7BE09028D', '9DEEB415991744B585D5D66B44D61362', 10, 'C99780A37AF74E98B26183D4A454328B', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-11T08:52:54.404+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('CDD3012642F34465AF6C45F973AC732C', 'AB115A267226428A9B23F1E7BE09028D', '046E8E9C7ED641CD89726F6141D8168B', 30, 'C99780A37AF74E98B26183D4A454328B', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-11T08:52:54.404+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('DD85C628D7B14CF48A8F6E6D8743BAEA', 'AB115A267226428A9B23F1E7BE09028D', '4EA909980F0942449E115F4BE0980AA0', 110, 'C99780A37AF74E98B26183D4A454328B', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-11T08:52:54.404+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('4E675B899DE84C41B52985CA9D19CAD7', 'AB115A267226428A9B23F1E7BE09028D', '1D5E2008386949CF880FE00EDF6DCF02', 210, 'C99780A37AF74E98B26183D4A454328B', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-11T08:52:54.404+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('B514BE10C4F2441CADDC396381AFA3ED', 'AB115A267226428A9B23F1E7BE09028D', '6CAD5516D17B40ECBD1CF9958DB4B7C7', 310, 'C99780A37AF74E98B26183D4A454328B', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-11T08:52:54.404+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('DAE53A04F70E4199B6BF4C377C49940F', 'AB115A267226428A9B23F1E7BE09028D', '8F78CB94849A42DC800013765DF49E3B', 1, 'DD85C628D7B14CF48A8F6E6D8743BAEA', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-11T08:52:54.404+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('54F0F84675F7481A951B882DF7A54011', 'AB115A267226428A9B23F1E7BE09028D', '535E001C1A1E4C8C8535424D569D710A', 10, 'B514BE10C4F2441CADDC396381AFA3ED', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-11T08:52:54.404+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('C068FAF77FBF44EC81A78C6F426D1FDE', 'AB115A267226428A9B23F1E7BE09028D', 'B085536AE0754E7EBD6E37F4972D7C10', 10, '540F9C04453E4AEBB291B8E0ECE286F6', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-11T08:52:54.404+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('8DF4FA9536194C6FAF329ABE0DBE410D', 'AB115A267226428A9B23F1E7BE09028D', '4BF66E79AD474510A4F48588473C0097', 10, 'CDD3012642F34465AF6C45F973AC732C', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-11T08:52:54.404+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('E3F83D3AD75846B59D6AD793C0FE7004', 'AB115A267226428A9B23F1E7BE09028D', '0ADBC859505D4651B936684A864DC34C', 20, '540F9C04453E4AEBB291B8E0ECE286F6', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-11T08:52:54.404+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('A4917DB589544A728873BF1A8FEECE62', 'AB115A267226428A9B23F1E7BE09028D', '877D85060B1B4688B3C973348E487CBC', 20, '4E675B899DE84C41B52985CA9D19CAD7', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-11T08:52:54.404+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7A293ED5A8F848DF909CB9E1C0175F01', 'AB115A267226428A9B23F1E7BE09028D', '3B8E28D4C0654DED977579351066A8E9', 30, '4E675B899DE84C41B52985CA9D19CAD7', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-11T08:52:54.404+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('ED18B798EE574E63BF9753AD3216C09D', 'AB115A267226428A9B23F1E7BE09028D', 'B285428583D74A9E80179D4443EADFA7', 30, '540F9C04453E4AEBB291B8E0ECE286F6', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-11T08:52:54.404+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('027420C353034165B39FC19225F77F56', 'AB115A267226428A9B23F1E7BE09028D', '2C014F2BF97A443994FFC147DA5A3C96', 40, 'CDD3012642F34465AF6C45F973AC732C', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-11T08:52:54.404+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('052BCDF9BC9346C594CF18F8D364BEED', 'AB115A267226428A9B23F1E7BE09028D', 'A0F6F56A96314FD685755D278A212C93', 10, '027420C353034165B39FC19225F77F56', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-11T08:52:54.404+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7A5AF71DCB3149A098BB312DF012B141', 'AB115A267226428A9B23F1E7BE09028D', '48CE1DF9590B41E9B8AF9ABF4B3EFA70', 10, '8DF4FA9536194C6FAF329ABE0DBE410D', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-11T08:52:54.404+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('53CAC3EB7EA041B19E6A472C7B58BED3', 'AB115A267226428A9B23F1E7BE09028D', '2F3954CB3EAF443CB3D40FE7EB78B18E', 10, 'C068FAF77FBF44EC81A78C6F426D1FDE', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-11T08:52:54.404+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('20D20D5DD4774742AE45B74956C91318', 'AB115A267226428A9B23F1E7BE09028D', '7A93258A975244DEB5104E18994C058B', 50, 'ED18B798EE574E63BF9753AD3216C09D', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-11T08:52:54.404+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('323A33A9498340478AAC98060C05B8C0', 'AB115A267226428A9B23F1E7BE09028D', 'BA632D5FA0C44447B37DEE7C4749CC73', 100, 'ED18B798EE574E63BF9753AD3216C09D', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-11T08:52:54.404+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('D93A41DFD42E48379BDC45D4DFA28279', 'AB115A267226428A9B23F1E7BE09028D', '8B75939BE5054D009B2520870DAC3A04', 200, 'ED18B798EE574E63BF9753AD3216C09D', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-11T08:52:54.404+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
select pkg_patcher.p_merge_page_object_attr('41D164C0936247AB9B3082E7AEF46156', 'C99780A37AF74E98B26183D4A454328B', 'B4952B6F8DA34BEFB04D244268B674F1', 'cv_url === "docs"', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-11T08:53:08.107+0000', 'activerules');
select pkg_patcher.p_merge_page_object_attr('71C10B90ADC34D5083EF75843802D587', 'A4917DB589544A728873BF1A8FEECE62', '8FEE27121C844165E053809BA8C091E5', '[{"in": "g_sys_front_branch_date_time", "out": null}, {"in": "g_sys_front_branch_name", "out": null}, {"in": "g_sys_front_commit_id", "out": null}, {"in": "g_sys_lang", "out": null}]', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-15T08:58:48.046+0000', 'getglobaltostore');
update s_mt.t_page_object set ck_master='C99780A37AF74E98B26183D4A454328B' where ck_id='53CAC3EB7EA041B19E6A472C7B58BED3';
update s_mt.t_page_object set ck_master='C99780A37AF74E98B26183D4A454328B' where ck_id='D93A41DFD42E48379BDC45D4DFA28279';
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)
select t.ck_id, t.ck_d_lang, t.cr_namespace, t.cv_value, t.ck_user, t.ct_change::timestamp from (
    select '66eeff41c0c94c5ca52909fb9d97e0aa' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'О программе' as cv_value, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-26T00:00:00.000+0000' as ct_change
    union all
    select '5dd02c20f14e41bd9d02b27a529765a2' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Docs' as cv_value, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-06-11T08:37:45.858+0000' as ct_change
) as t 
 join s_mt.t_d_lang dl
 on t.ck_d_lang = dl.ck_id
on conflict on constraint cin_u_localization_1 do update set ck_id = excluded.ck_id, ck_d_lang = excluded.ck_d_lang, cr_namespace = excluded.cr_namespace, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
