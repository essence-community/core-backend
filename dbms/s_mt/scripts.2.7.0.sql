--liquibase formatted sql
--changeset artemov_i:CORE-1482 dbms:postgresql
CREATE TABLE s_mt.t_view (
	ck_id varchar(100) NOT NULL,
	cv_description varchar(2000) NULL,
	cct_config jsonb NOT NULL DEFAULT '{}'::jsonb,
	cct_manifest jsonb NOT NULL DEFAULT '{}'::jsonb,
	cl_available smallint NOT NULL DEFAULT 1::smallint,
	ck_user varchar(150) NOT NULL,
	ct_change timestamptz(0) NOT NULL,
	CONSTRAINT cin_p_view PRIMARY KEY (ck_id),
	CONSTRAINT cin_c_view_1 CHECK (jsonb_typeof(cct_config) = 'object'::text),
	CONSTRAINT cin_c_view_2 CHECK (jsonb_typeof(cct_manifest) = 'object'::text)
);
COMMENT ON TABLE s_mt.t_view IS 'Представление';

-- Column comments

COMMENT ON COLUMN s_mt.t_view.ck_id IS 'Идентификатор/Наименование';
COMMENT ON COLUMN s_mt.t_view.cv_description IS 'Описание';
COMMENT ON COLUMN s_mt.t_view.cct_config IS 'Настройки';
COMMENT ON COLUMN s_mt.t_view.cct_manifest IS 'Настройки классов';
COMMENT ON COLUMN s_mt.t_view.cl_available IS 'Признак включения представления';
COMMENT ON COLUMN s_mt.t_view.ck_user IS 'Пользователь модифицирующи';
COMMENT ON COLUMN s_mt.t_view.ct_change IS 'Дата изменения';

INSERT INTO s_mt.t_view
(ck_id, cv_description, cct_config, cct_manifest, cl_available, ck_user, ct_change)
VALUES('system', 'Essence Core View', '{}'::jsonb, '{}'::jsonb, 1::smallint, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-12-10 13:13:44.489');

COMMENT ON COLUMN s_mt.t_page.cr_type IS '0 - модуль, 1 - каталог, 2 - страница, 3 - приложение';
ALTER TABLE s_mt.t_page DROP CONSTRAINT cin_c_page_1;
ALTER TABLE s_mt.t_page ADD CONSTRAINT cin_c_page_1 CHECK (cr_type in (0,1,2,3));
ALTER TABLE s_mt.t_page ADD CONSTRAINT cin_c_page_2 CHECK (ck_parent <> ck_id);
ALTER TABLE s_mt.t_page ADD ck_view varchar(100) NOT NULL DEFAULT 'system';
COMMENT ON COLUMN s_mt.t_page.ck_view IS 'Представление';
ALTER TABLE s_mt.t_page ADD CONSTRAINT cin_r_page_3 FOREIGN KEY (ck_view) REFERENCES s_mt.t_view(ck_id);
ALTER TABLE s_mt.t_page ADD CONSTRAINT cin_c_page_3 CHECK (cv_url = lower(cv_url) and cv_url ~ '^[a-zа-я\-_0-9]+$');
DROP INDEX s_mt.cin_i_page_2;
CREATE UNIQUE INDEX cin_i_page_1 ON s_mt.t_page (ck_view,lower(cv_url));
ALTER TABLE s_mt.t_class ADD ck_view varchar(100) NOT NULL DEFAULT 'system';
COMMENT ON COLUMN s_mt.t_class.ck_view IS 'Представление';
ALTER TABLE s_mt.t_class ADD CONSTRAINT cin_r_class_1 FOREIGN KEY (ck_view) REFERENCES s_mt.t_view(ck_id);
ALTER TABLE s_mt.t_module ADD ck_view varchar(100) NOT NULL DEFAULT 'system';
COMMENT ON COLUMN s_mt.t_module.ck_view IS 'Представление';
ALTER TABLE s_mt.t_module ADD CONSTRAINT cin_r_module_1 FOREIGN KEY (ck_view) REFERENCES s_mt.t_view(ck_id);

--changeset artemov_i:CORE-1482-1 dbms:postgresql
CREATE TABLE s_mt.t_page_attr (
	ck_id varchar(32) NOT NULL, -- ИД атрибута
	ck_page varchar(32) NOT NULL, -- ИД страницы
	ck_attr varchar(255) NOT NULL, -- ИД атрибута (имя)
	cv_value text NULL, -- Значение атрибута
	ck_user varchar(150) NOT NULL, -- ИД пользователя
	ct_change timestamptz NOT NULL, -- Дата последнего изменения
	CONSTRAINT cin_c_page_attr_1 UNIQUE (ck_page, ck_attr),
	CONSTRAINT cin_p_page_attr PRIMARY KEY (ck_id),
	CONSTRAINT cin_r_page_attr_1 FOREIGN KEY (ck_page) REFERENCES s_mt.t_page(ck_id),
	CONSTRAINT cin_r_page_attr_2 FOREIGN KEY (ck_attr) REFERENCES s_mt.t_attr(ck_id)
);
CREATE INDEX cin_i_page_attr_1 ON s_mt.t_page_attr USING btree (ck_attr);
CREATE INDEX cin_i_page_attr_2 ON s_mt.t_page_attr USING btree (ck_page);
CREATE UNIQUE INDEX cin_u_page_attr_1 ON s_mt.t_page_attr USING btree (ck_page, ck_attr);
COMMENT ON TABLE s_mt.t_page_attr IS 'Атрибуты страницы';

-- Column comments

COMMENT ON COLUMN s_mt.t_page_attr.ck_id IS 'ИД атрибута страницы';
COMMENT ON COLUMN s_mt.t_page_attr.ck_page IS 'ИД страницы';
COMMENT ON COLUMN s_mt.t_page_attr.ck_attr IS 'ИД атрибута (имя)';
COMMENT ON COLUMN s_mt.t_page_attr.cv_value IS 'Значение атрибута';
COMMENT ON COLUMN s_mt.t_page_attr.ck_user IS 'ИД пользователя';
COMMENT ON COLUMN s_mt.t_page_attr.ct_change IS 'Дата последнего изменения';

--changeset artemov_i:CORE-1482-2 dbms:postgresql
INSERT INTO s_mt.t_page (ck_id, ck_parent, cr_type, cv_name, cn_order, cl_static, cv_url, ck_icon, ck_user, ct_change, cl_menu, ck_view)VALUES('FF7C023ADAD940A397E46F3BBD4A5AD6', null, 3, 'b749ad285f72426bbdfda8d89d181444', 1, 1, 'pages', '101', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-12-11T11:51:12.282+0000', 0, 'system') on conflict (ck_id) do update set ck_parent = excluded.ck_parent, cr_type = excluded.cr_type, cv_name = excluded.cv_name, cn_order = excluded.cn_order, cl_static = excluded.cl_static, cv_url = excluded.cv_url, ck_icon = excluded.ck_icon, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_menu = excluded.cl_menu;
update s_mt.t_page
set ck_parent='FF7C023ADAD940A397E46F3BBD4A5AD6'
where ck_parent is null and cr_type <> 3;
INSERT INTO s_mt.t_view
(ck_id, cv_description, cct_config, cct_manifest, cl_available, ck_user, ct_change)
VALUES('auth', 'Essence Core Auth', '{}'::jsonb, '{}'::jsonb, 1::smallint, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-12-10 13:13:44.489');

--changeset artemov_i:CORE-1482-3 dbms:postgresql
INSERT INTO s_mt.t_sys_setting
(ck_id, cv_value, ck_user, ct_change, cv_description)
VALUES('g_sys_view_url', '/view_module', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-12-15 02:54:25.693', 'Контекст получения представлений');

--changeset artemov_i:CORE-1482-4 dbms:postgresql
UPDATE s_mt.t_view
SET cv_description='Essence Core View', cct_config='{"bc": {"type": "APPLICATION", "childs": [{"type": "APP_BAR", "childs": [{"type": "BTN_GROUP", "childs": [{"type": "BTN", "reqsel": false, "uitype": "1", "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "Button Favorite", "handler": "onWindowOpen", "maxfile": 5242880, "ckwindow": "favorite", "cn_order": 10, "iconfont": "star", "onlyicon": true, "ck_master": "65930512A12E4A35A160BD54F842F7EC", "ck_object": "1671E9323E6B4360B4BBC6C9F71A28C5", "ck_parent": "FEA537389C5D4FB6A7198D4AEBBB8C20", "filetypes": "doc,docx,pdf,zip,txt,ods,odt,xls,xlsx", "cl_dataset": 0, "iconfontname": "fa", "ck_page_object": "B10F29BD3C3C48A38C5A63FFD3E3F73E", "cv_description": "Открытие закладок", "getmastervalue": [{"in": "ck_id", "out": "ck_id"}], "skipvalidation": false}, {"type": "BTN", "reqsel": false, "uitype": "1", "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "Button Menu", "handler": "onWindowOpen", "maxfile": 5242880, "ckwindow": "menu", "cn_order": 20, "iconfont": "bars", "onlyicon": true, "ck_master": "65930512A12E4A35A160BD54F842F7EC", "ck_object": "A185D67C726B4F94B2BE8B7498C77007", "ck_parent": "FEA537389C5D4FB6A7198D4AEBBB8C20", "filetypes": "doc,docx,pdf,zip,txt,ods,odt,xls,xlsx", "cl_dataset": 0, "iconfontname": "fa", "ck_page_object": "CC63BED692E1447D8707E236811F1B28", "cv_description": "Открытие меню", "getmastervalue": [{"in": "ck_id", "out": "ck_id"}], "skipvalidation": false}], "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "Button Group Left", "cn_order": 1010, "onlyicon": true, "ck_object": "9B040EDC793248AEB0781362E344FAFF", "ck_parent": "00A0BBA1AC0E482CA06922E181B1BF87", "cl_dataset": 0, "contentview": "hbox", "ck_page_object": "FEA537389C5D4FB6A7198D4AEBBB8C20", "cv_description": "Секция кнопок слева"}, {"type": "OPEN_PAGE_TABS", "width": "100%", "height": "45px", "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "Open Page Tabs", "cn_order": 1030, "ck_object": "F059305E6B164D50B275F87A55547564", "ck_parent": "00A0BBA1AC0E482CA06922E181B1BF87", "cl_dataset": 0, "contentview": "hbox", "ck_page_object": "2977C544FD5F43CF871F06D7F79D1701", "cv_description": "Вкладки открытых страниц"}, {"type": "BTN_GROUP", "childs": [{"type": "BADGE_BTN", "childs": [{"type": "BTN", "reqsel": false, "uitype": "1", "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "Button Notification", "handler": "onWindowOpen", "maxfile": 5242880, "ckwindow": "notification", "cn_order": 1, "iconfont": "bell", "onlyicon": true, "ck_master": "65930512A12E4A35A160BD54F842F7EC", "ck_object": "BA17F793927F4BE2B347B7D47C2291B5", "ck_parent": "37310A515FD942D383A9DC04FC590743", "filetypes": "doc,docx,pdf,zip,txt,ods,odt,xls,xlsx", "cl_dataset": 0, "cv_displayed": "7bea912b05a4424f8938c02b0b3ccc41", "iconfontname": "fa", "ck_page_object": "84D475A35A0E4B45A5C7DA3F5B927459", "cv_description": "Оповещение", "getmastervalue": [{"in": "ck_id", "out": "ck_id"}], "skipvalidation": false}], "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "Badge", "cn_order": 5, "position": "inside", "ck_object": "3A88723253BB48568C00E40E6F41D4C7", "ck_parent": "91F0EE9592194D9EB727918D639309D3", "getglobal": "gSysNoReadSnack", "cl_dataset": 0, "ck_page_object": "37310A515FD942D383A9DC04FC590743", "cv_description": "Badge"}, {"type": "BTN", "reqsel": false, "uitype": "1", "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "Button Profile", "handler": "onWindowOpen", "maxfile": 5242880, "ckwindow": "profile", "cn_order": 10, "iconfont": "user", "ck_master": "65930512A12E4A35A160BD54F842F7EC", "ck_object": "7FA517E4996741638F0DF0BC9B9DCB3A", "ck_parent": "91F0EE9592194D9EB727918D639309D3", "filetypes": "doc,docx,pdf,zip,txt,ods,odt,xls,xlsx", "cl_dataset": 0, "cv_displayed": "e571d8599bc8466aac42ade8b1891e44", "iconfontname": "fa", "ck_page_object": "C881478D7F5F435685763F3BDF851BE5", "cv_description": "Профиль", "getmastervalue": [{"in": "ck_id", "out": "ck_id"}], "skipvalidation": false}, {"type": "BTN", "reqsel": false, "uitype": "1", "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "Button About", "handler": "onWindowOpen", "maxfile": 5242880, "ckwindow": "about", "cn_order": 15, "iconfont": "info-circle ", "ck_master": "65930512A12E4A35A160BD54F842F7EC", "ck_object": "AC3FAE070F6A4ADAA0AD7093406CAB40", "ck_parent": "91F0EE9592194D9EB727918D639309D3", "filetypes": "doc,docx,pdf,zip,txt,ods,odt,xls,xlsx", "cl_dataset": 0, "cv_displayed": "66eeff41c0c94c5ca52909fb9d97e0aa", "iconfontname": "fa", "ck_page_object": "F51F997D51F94F1BAF72786CF8AF2C33", "cv_description": "О программе", "getmastervalue": [{"in": "ck_id", "out": "ck_id"}], "skipvalidation": false}], "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "Button Group Right", "cn_order": 1040, "onlyicon": true, "ck_object": "0311C12DCA0F48F6A1A7457243DC0A22", "ck_parent": "00A0BBA1AC0E482CA06922E181B1BF87", "cl_dataset": 0, "contentview": "hbox", "ck_page_object": "91F0EE9592194D9EB727918D639309D3", "cv_description": "Секция кнопок справа"}], "height": "45px", "uitype": "1", "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "App Bar Panel", "cn_order": 10, "position": "relative", "ck_object": "03669E62AAED445F870D7F643D3BF7AE", "ck_parent": "65930512A12E4A35A160BD54F842F7EC", "cl_dataset": 0, "contentview": "hbox", "ck_page_object": "00A0BBA1AC0E482CA06922E181B1BF87", "cv_description": "Панель для навигациии"}, {"type": "PAGES", "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "Pages", "cn_order": 20, "ck_object": "3D83EAE658204E3BAABFF7B287819156", "ck_parent": "65930512A12E4A35A160BD54F842F7EC", "cl_dataset": 0, "ck_page_object": "9810E230A88048709EFF7745A101B0F7", "cv_description": "Список отображаемых страниц"}], "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "SYS Applications - Pages", "ck_query": "MTRoute", "cn_order": 10, "ck_modify": "modify", "ck_object": "94E486331F324BBC9495ACEDD9002A1B", "cl_dataset": 1, "idproperty": "ck_id", "activerules": "g_sess_session && !(g_sys_anonymous_action in g_sess_ca_actions)", "childwindow": [{"top": 45, "type": "WIN", "align": "left", "width": "20%", "childs": [{"type": "PAGES_TREE", "uitype": "3", "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "Pages Tree", "cn_order": 1, "ck_object": "2CCCAB777F9B478395E40B5FCDA640C0", "ck_parent": "2F6875A504824EB89A4120C1B82A37E2", "cl_dataset": 0, "ck_page_object": "75DB5D6460344833B3F3C9D2569EB3CC", "cv_description": "Дерево страниц"}], "height": "100%", "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "Drawer Menu", "ckwindow": "menu", "cn_order": 110, "datatype": "DRAWER", "ck_object": "E900506D12B84B59BBCCD2D2DB73635B", "ck_parent": "65930512A12E4A35A160BD54F842F7EC", "cl_dataset": 0, "ck_page_object": "2F6875A504824EB89A4120C1B82A37E2", "cv_description": "Drawer для меню"}, {"top": 45, "type": "WIN", "align": "right", "width": "30%", "childs": [{"type": "NOTIFICATION_PANEL", "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "Notification", "cn_order": 1, "ck_object": "4C7CB2419FE84553BB26E7BEC59FF891", "ck_parent": "79757F962C8B450082238FD9EF3CD483", "cl_dataset": 0, "ck_page_object": "4F0EB4908EC04095A49F71CEB9F999CD", "cv_description": "Оповещения"}], "height": "100%", "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "Drawer Notification", "ckwindow": "notification", "cn_order": 120, "datatype": "DRAWER", "ck_object": "56CCF799C987470FB333A6FDB00C288A", "ck_parent": "65930512A12E4A35A160BD54F842F7EC", "cl_dataset": 0, "ck_page_object": "79757F962C8B450082238FD9EF3CD483", "cv_description": "Оповещения"}, {"top": 45, "type": "WIN", "align": "left", "width": "20%", "childs": [{"type": "FAVORITE_PAGES", "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "Favorite Pages", "cn_order": 1, "ck_object": "CB8B58540BD24901BB46F7AB56D74482", "ck_parent": "3CA2BDF49E6D4BDF8189BC4B84E3E4AC", "cl_dataset": 0, "ck_page_object": "1E511CE8C82A40A1AD22DC1CE2714B7E", "cv_description": "Избранные страницы"}], "height": "100%", "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "Favorite Pages", "ckwindow": "favorite", "cn_order": 130, "datatype": "DRAWER", "ck_object": "A7BB08AC747549C9B5EDC9C539AC16FF", "ck_parent": "65930512A12E4A35A160BD54F842F7EC", "cl_dataset": 0, "ck_page_object": "3CA2BDF49E6D4BDF8189BC4B84E3E4AC", "cv_description": "Избранные страницы"}, {"type": "WIN", "childs": [{"type": "IFRAME", "width": "100%", "column": "cv_app_info", "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "About IFrame", "autoload": true, "ck_query": "MTGetMainAppInfo", "cn_order": 20, "ck_modify": "modify", "ck_object": "DBE6880484954457998A5460187C834D", "ck_parent": "AEBFD1081020467C90987EB3028C12EC", "cl_dataset": 1, "idproperty": "ck_id", "typeiframe": "\"HTML\"", "noglobalmask": true, "ck_page_object": "9CF3C6CBEF0341EEAE0DE0D4DBB45870", "cv_description": "About IFrame", "getmastervalue": [{"in": "ck_id", "out": "ck_id"}], "cv_helper_color": "yellow", "getglobaltostore": [{"in": "g_sys_front_branch_date_time"}, {"in": "g_sys_front_branch_name"}, {"in": "g_sys_front_commit_id"}, {"in": "g_sys_lang"}]}], "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "Window About", "wintype": "default", "ckwindow": "about", "cn_order": 140, "datatype": "WINDOW", "bottombtn": [{"type": "BTN", "hidden": true, "reqsel": false, "uitype": "1", "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "Close Silent", "handler": "onCloseWindowSilent", "maxfile": 5242880, "cn_order": 30, "ck_object": "377ED25E244A4FE9B2DD4398FCD86549", "ck_parent": "AEBFD1081020467C90987EB3028C12EC", "filetypes": "doc,docx,pdf,zip,txt,ods,odt,xls,xlsx", "cl_dataset": 0, "iconfontname": "fa", "ck_page_object": "0F57A2D536154EC5BA344A3FC802B6DD", "cv_description": "Close Silent", "getmastervalue": [{"in": "ck_id", "out": "ck_id"}], "skipvalidation": false}], "ck_object": "DFB76FB13899446BAEBEBB04512C37EE", "ck_parent": "65930512A12E4A35A160BD54F842F7EC", "cl_dataset": 0, "cv_displayed": "66eeff41c0c94c5ca52909fb9d97e0aa", "ck_page_object": "AEBFD1081020467C90987EB3028C12EC", "cv_description": "О программе", "collectionvalues": "object"}, {"top": 45, "type": "WIN", "align": "right", "width": "20%", "childs": [{"type": "PAGER", "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "Pager Menu Profile", "ck_query": "GetMetamodelPage", "cn_order": 40, "ck_modify": "modify", "ck_object": "8D9279245C364B3995587FC85C13B8CB", "ck_parent": "CD76D99C35E64C37BC5F6E99F7FA4D62", "cl_dataset": 1, "idproperty": "ck_id", "defaultvalue": "1875398035771", "ck_page_object": "337E1A651AA145DB9E141E6EACFC9DF1", "cv_description": "Pager Menu Profile", "getmastervalue": [{"in": "ck_id", "out": "ck_id"}], "cv_helper_color": "yellow"}, {"type": "TOOL_BAR", "align": "right", "childs": [{"type": "BTN", "reqsel": false, "uitype": "1", "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "BTN Logout", "handler": "onLogout", "maxfile": 5242880, "cn_order": 1, "ck_master": "65930512A12E4A35A160BD54F842F7EC", "ck_object": "86DE34B2847E454580F3A8788A67FCED", "ck_parent": "4B5624F16CE1486C8A309A33B0B75D0C", "filetypes": "doc,docx,pdf,zip,txt,ods,odt,xls,xlsx", "cl_dataset": 0, "cv_displayed": "059b75f33380455c9b26f28635e955c2", "iconfontname": "fa", "ck_page_object": "EF7FB73D53AC4E58BDECEBFE8C2CBADD", "cv_description": "Выход", "getmastervalue": [{"in": "ck_id", "out": "ck_id"}], "skipvalidation": false}], "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "Btn Bar", "cn_order": 100, "ck_object": "313E882AFAB2483596F876F0885A25D3", "ck_parent": "CD76D99C35E64C37BC5F6E99F7FA4D62", "cl_dataset": 0, "contentview": "hbox", "ck_page_object": "4B5624F16CE1486C8A309A33B0B75D0C", "cv_description": "Бар с кнопками"}], "height": "300px", "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "Drawer Profile", "ckwindow": "profile", "cn_order": 150, "datatype": "DRAWER", "ck_object": "657939F173D74C82AD9AD159CF546320", "ck_parent": "65930512A12E4A35A160BD54F842F7EC", "cl_dataset": 0, "ck_page_object": "CD76D99C35E64C37BC5F6E99F7FA4D62", "cv_description": "Drawer профиля"}], "redirecturl": "auth", "cl_is_master": 1, "defaultvalue": "home", "ck_page_object": "65930512A12E4A35A160BD54F842F7EC", "cv_description": "Приложение - pages", "getmastervalue": [{"in": "ck_id", "out": "ck_id"}], "cv_helper_color": "yellow", "defaultvaluelocalization": "home"}}', cct_manifest='{}', cl_available=1, ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2020-12-10 13:13:44.000'
WHERE ck_id='system';
UPDATE s_mt.t_view
SET cv_description='Essence Core Auth', cct_config='{"bc": {"type": "APPLICATION", "childs": [{"type": "APP_BAR", "childs": [{"type": "EMPTY_SPACE", "width": "100%", "height": "45px", "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "Empty Space Left", "cn_order": 20, "ck_object": "9D66F83220F64A19A269B6609F3AD96C", "ck_parent": "C92F6E9D327F4E58AA4569B874027414", "cl_dataset": 0, "ck_page_object": "C5542D15E7874430BB883D8C26EA8D49", "cv_description": "Empty Space Left"}, {"type": "BTN_GROUP", "childs": [{"type": "BTN", "reqsel": false, "uitype": "1", "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "Button Profile", "handler": "onWindowOpen", "maxfile": 5242880, "ckwindow": "profile", "cn_order": 10, "iconfont": "user", "ck_master": "6CF66CAB76FE4361B98CA98B854EA3CD", "ck_object": "9B554144ED7E417CB734A98BC54B6A57", "ck_parent": "458B5B435D5748939CC6C94528D2E578", "filetypes": "doc,docx,pdf,zip,txt,ods,odt,xls,xlsx", "cl_dataset": 0, "cv_displayed": "e571d8599bc8466aac42ade8b1891e44", "iconfontname": "fa", "ck_page_object": "D0625BA848CD4CBD960D068A4A1444FC", "cv_description": "Профиль", "getmastervalue": [{"in": "ck_id", "out": "ck_id"}], "skipvalidation": false}, {"type": "BTN", "reqsel": false, "uitype": "1", "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "Button About", "handler": "onWindowOpen", "maxfile": 5242880, "ckwindow": "about", "cn_order": 15, "iconfont": "info-circle ", "ck_master": "6CF66CAB76FE4361B98CA98B854EA3CD", "ck_object": "4592873309F64CDDAF043B3DDC33623F", "ck_parent": "458B5B435D5748939CC6C94528D2E578", "filetypes": "doc,docx,pdf,zip,txt,ods,odt,xls,xlsx", "cl_dataset": 0, "cv_displayed": "66eeff41c0c94c5ca52909fb9d97e0aa", "iconfontname": "fa", "ck_page_object": "AF343CB7076E418FA17AE7A4906FC4AF", "cv_description": "О программе", "getmastervalue": [{"in": "ck_id", "out": "ck_id"}], "skipvalidation": false}], "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "Button Group Right", "cn_order": 30, "onlyicon": true, "ck_object": "9E5CBADBFA654AAC84517A35965051AF", "ck_parent": "C92F6E9D327F4E58AA4569B874027414", "cl_dataset": 0, "contentview": "hbox", "ck_page_object": "458B5B435D5748939CC6C94528D2E578", "cv_description": "Секция кнопок справа"}], "height": "45px", "uitype": "1", "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "App Bar Auth", "cn_order": 10, "position": "relative", "ck_object": "6B9A15FFDBA342BDA8F75A8BA5C6479B", "ck_parent": "6CF66CAB76FE4361B98CA98B854EA3CD", "cl_dataset": 0, "contentview": "hbox", "ck_page_object": "C92F6E9D327F4E58AA4569B874027414", "cv_description": "App Bar Auth"}, {"type": "AUTH_FORM", "childs": [{"type": "IFIELD", "column": "cv_login", "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "Field Test Login", "maxsize": "120", "cn_order": 10, "datatype": "text", "required": true, "ck_object": "0696257D24E0416A917652D79FBB175A", "ck_parent": "5500938489C0450CB6857F1D90DE611B", "cl_dataset": 0, "cv_displayed": "f4238b5aee4444adab02798144ff55cd", "ck_page_object": "0E6898C70DA644499832294504E17853", "cv_description": "Field Test Login"}, {"type": "IFIELD", "column": "cv_password", "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "Password", "maxsize": "120", "cn_order": 20, "datatype": "password", "required": true, "ck_object": "474EA962ECB7432ABD5B74F0B74C9066", "ck_parent": "5500938489C0450CB6857F1D90DE611B", "cl_dataset": 0, "cv_displayed": "e59a81c8ac1846679714fad756f39649", "ck_page_object": "6E5C634B7B5E4A28A5B24C5AF7AB46A2", "cv_description": "Password"}], "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "Auth Form", "cn_order": 20, "bottombtn": [{"type": "BTN", "reqsel": false, "uitype": "2", "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "Button Guest", "handler": "onLoginGuest", "maxfile": 5242880, "cn_order": 50, "ck_object": "4388AA3C394849579493D95D3C65768D", "ck_parent": "5500938489C0450CB6857F1D90DE611B", "filetypes": "doc,docx,pdf,zip,txt,ods,odt,xls,xlsx", "cl_dataset": 0, "hiddenrules": "g_sys_enable_guest_login === \"false\"", "cv_displayed": "15f4ab0a6b564c5db93e6a2b675769fb", "iconfontname": "fa", "ck_page_object": "C46B53C8A6E04B8987E2E91238C141E6", "cv_description": "Button Guest", "getmastervalue": [{"in": "ck_id", "out": "ck_id"}], "skipvalidation": false}, {"type": "BTN", "reqsel": false, "uitype": "1", "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "Button Login", "handler": "onLogin", "maxfile": 5242880, "cn_order": 60, "ck_object": "05AB63D5B84D4B428BA2DE618CEA0BDF", "ck_parent": "5500938489C0450CB6857F1D90DE611B", "filetypes": "doc,docx,pdf,zip,txt,ods,odt,xls,xlsx", "cl_dataset": 0, "cv_displayed": "82eafeb106eb41aaa205152471b1b7b6", "iconfontname": "fa", "ck_page_object": "7CE9025C54C34373A4A6BCF759032A4F", "cv_description": "Button Login", "getmastervalue": [{"in": "ck_id", "out": "ck_id"}], "skipvalidation": false}], "ck_modify": "modify", "ck_object": "C606EB2BBBD242629A47EB646BC2F7C8", "ck_parent": "6CF66CAB76FE4361B98CA98B854EA3CD", "cl_dataset": 1, "ck_page_object": "5500938489C0450CB6857F1D90DE611B", "cv_description": "Auth Form", "cv_helper_color": "red"}], "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "SYS Application - Auth", "cn_order": 5, "ck_modify": "modify", "ck_object": "070636806A2C4BA9AEEA69CD4CA94542", "cl_dataset": 1, "idproperty": "ck_id", "activerules": "cv_url === \"auth\" && !g_sess_session", "childwindow": [{"top": 45, "type": "WIN", "align": "right", "width": "30%", "childs": [{"type": "THEME_COMBO", "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "Theme", "cn_order": 10, "ck_modify": "modify", "ck_object": "373E92205BE8496EB457455E027AFC08", "ck_parent": "5D418155DA03479EB31812731C03F074", "cl_dataset": 1, "idproperty": "ck_id", "cv_displayed": "eb5f0456bee64d60ba3560e6f7a9f332", "ck_page_object": "7AC126BF206D4FE7966B0FEA832DD965", "cv_description": "Theme", "getmastervalue": [{"in": "ck_id", "out": "ck_id"}], "cv_helper_color": "red"}], "height": "100px", "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "Profile Drawer", "ckwindow": "profile", "cn_order": 110, "datatype": "DRAWER", "ck_object": "BAD549B89978443EB92F48D744EBBE3C", "ck_parent": "6CF66CAB76FE4361B98CA98B854EA3CD", "cl_dataset": 0, "ck_page_object": "5D418155DA03479EB31812731C03F074", "cv_description": "Profile Drawer"}, {"type": "WIN", "childs": [{"type": "IFRAME", "width": "100%", "column": "cv_app_info", "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "About IFrame", "autoload": true, "ck_query": "MTGetMainAppInfo", "cn_order": 20, "ck_modify": "modify", "ck_object": "D76C1A700D724EA6BD3C63AD53CAD036", "ck_parent": "4D1474D488C540B3A027FDEB18E443DF", "cl_dataset": 1, "idproperty": "ck_id", "typeiframe": "\"HTML\"", "noglobalmask": true, "ck_page_object": "89ABD2043F8A4B2D9B9B5ABD8AB45CDC", "cv_description": "About IFrame", "getmastervalue": [{"in": "ck_id", "out": "ck_id"}], "cv_helper_color": "yellow", "getglobaltostore": [{"in": "g_sys_front_branch_date_time"}, {"in": "g_sys_front_branch_name"}, {"in": "g_sys_front_commit_id"}, {"in": "g_sys_lang"}]}], "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "Window About", "wintype": "default", "ckwindow": "about", "cn_order": 120, "datatype": "WINDOW", "bottombtn": [{"type": "BTN", "hidden": true, "reqsel": false, "uitype": "1", "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "Close Silent", "handler": "onCloseWindowSilent", "maxfile": 5242880, "cn_order": 30, "ck_object": "C3C9EDB3EE834A38B27641C71772644C", "ck_parent": "4D1474D488C540B3A027FDEB18E443DF", "filetypes": "doc,docx,pdf,zip,txt,ods,odt,xls,xlsx", "cl_dataset": 0, "iconfontname": "fa", "ck_page_object": "32FE580C5E244DDEB0BEC0CA9AC87521", "cv_description": "Close Silent", "getmastervalue": [{"in": "ck_id", "out": "ck_id"}], "skipvalidation": false}], "ck_object": "8EF4D90D8E944057B7409F3D8C1AD28B", "ck_parent": "6CF66CAB76FE4361B98CA98B854EA3CD", "cl_dataset": 0, "cv_displayed": "66eeff41c0c94c5ca52909fb9d97e0aa", "ck_page_object": "4D1474D488C540B3A027FDEB18E443DF", "cv_description": "О программе", "collectionvalues": "object"}], "redirecturl": "pages", "cl_is_master": 1, "defaultvalue": "home", "ck_page_object": "6CF66CAB76FE4361B98CA98B854EA3CD", "cv_description": "Приложение авторизации", "getmastervalue": [{"in": "ck_id", "out": "ck_id"}], "cv_helper_color": "red", "defaultvaluelocalization": "home"}}', cct_manifest='{}', cl_available=1, ck_user='4fd05ca9-3a9e-4d66-82df-886dfa082113', ct_change='2020-12-10 13:13:44.000'
WHERE ck_id='auth';

--changeset artemov_i:feature-new-order runOnChange:true dbms:postgresql
INSERT INTO s_mt.t_d_attr_data_type(ck_id, cv_description, cl_extra, ck_user, ct_change)VALUES('order', 'Массив сортировки', 0, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-02-24T07:55:27.000+0000') on conflict (ck_id) do update set cv_description = excluded.cv_description, cl_extra = excluded.cl_extra, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_attr(ck_id, cv_description, ck_attr_type, ck_d_data_type, cv_data_type_extra, ck_user, ct_change)VALUES('order', 'Список сортировок', 'basic', 'order', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-02-24T11:28:59.221+0000') on conflict (ck_id) do update set cv_description = excluded.cv_description, ck_attr_type = excluded.ck_attr_type, ck_d_data_type = excluded.ck_d_data_type, cv_data_type_extra = excluded.cv_data_type_extra, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_class_attr
(ck_id, ck_class, ck_attr, cv_value, ck_user, ct_change, cl_required, cv_data_type_extra, cl_empty)
VALUES('27125FC36A9F49EBBA6D12C06E03BADD', '31', 'order', NULL, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-02-24 14:38:38.594', 1, NULL, 0) on conflict (ck_id) DO NOTHING;
INSERT INTO s_mt.t_class_attr
(ck_id, ck_class, ck_attr, cv_value, ck_user, ct_change, cl_required, cv_data_type_extra, cl_empty)
VALUES('03FFC6D5E3B942F088207B303A682156', '8', 'order', NULL, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-02-24 14:38:38.594', 1, NULL, 0) on conflict (ck_id) DO NOTHING;
INSERT INTO s_mt.t_class_attr
(ck_id, ck_class, ck_attr, cv_value, ck_user, ct_change, cl_required, cv_data_type_extra, cl_empty)
VALUES('44A5055717FC433288657994DCD6C959', '38', 'order', '[{"property": "1", "direction": "ASC"}]', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-02-24 14:38:38.594', 1, NULL, 0) on conflict (ck_id) DO NOTHING;
INSERT INTO s_mt.t_class_attr
(ck_id, ck_class, ck_attr, cv_value, ck_user, ct_change, cl_required, cv_data_type_extra, cl_empty)
VALUES('3CF0F399ACAE44BCA107569978030ED5', '11', 'order', NULL, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-02-24 17:12:29.539', 1, NULL, 0) on conflict (ck_id) DO NOTHING;
INSERT INTO s_mt.t_class_attr
(ck_id, ck_class, ck_attr, cv_value, ck_user, ct_change, cl_required, cv_data_type_extra, cl_empty)
VALUES('7FFFE17BDB674DAE982ED090F2920EA6', '77', 'order', NULL, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-02-24 17:12:29.539', 1, NULL, 0) on conflict (ck_id) DO NOTHING;
INSERT INTO s_mt.t_class_attr
(ck_id, ck_class, ck_attr, cv_value, ck_user, ct_change, cl_required, cv_data_type_extra, cl_empty)
VALUES('A2AE5586766D42DCA61FEED2F1E446BF', '10', 'order', NULL, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-02-24 17:12:29.539', 1, NULL, 0) on conflict (ck_id) DO NOTHING;
INSERT INTO s_mt.t_class_attr
(ck_id, ck_class, ck_attr, cv_value, ck_user, ct_change, cl_required, cv_data_type_extra, cl_empty)
VALUES('2AB537369F704B52AFDCD7A953DDA39F', '9', 'order', NULL, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-02-24 17:12:29.539', 1, NULL, 0) on conflict (ck_id) DO NOTHING;
INSERT INTO s_mt.t_class_attr
(ck_id, ck_class, ck_attr, cv_value, ck_user, ct_change, cl_required, cv_data_type_extra, cl_empty)
VALUES('2A46DF47A5904C0694FBF101449DC2A3', '17', 'order', NULL, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-02-24 17:12:29.539', 1, NULL, 0) on conflict (ck_id) DO NOTHING;
INSERT INTO s_mt.t_class_attr
(ck_id, ck_class, ck_attr, cv_value, ck_user, ct_change, cl_required, cv_data_type_extra, cl_empty)
VALUES('BEF3AFAE35FE4FECA4BE6FF9E52B1E8E', '36', 'order', NULL, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-02-24 17:12:29.539', 1, NULL, 0) on conflict (ck_id) DO NOTHING;
INSERT INTO s_mt.t_class_attr
(ck_id, ck_class, ck_attr, cv_value, ck_user, ct_change, cl_required, cv_data_type_extra, cl_empty)
VALUES('B45847E1BC93408E858A0C270A691814', '37', 'order', '[{"property": "1", "direction": "ASC"}]', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-02-24 14:38:38.594', 1, NULL, 0) on conflict (ck_id) DO NOTHING;
INSERT INTO s_mt.t_class_attr
(ck_id, ck_class, ck_attr, cv_value, ck_user, ct_change, cl_required, cv_data_type_extra, cl_empty)
VALUES('D2D45548114E43F2A738BB88EA4915CA', '18', 'order', NULL, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2021-02-24 14:38:38.594', 1, NULL, 0) on conflict (ck_id) DO NOTHING;

UPDATE
    s_mt.t_class_attr tca4
SET
    cv_value = jsonb_build_array(jsonb_build_object('property', tca.cv_value, 'direction', coalesce(tca2.cv_value, 'ASC')))
from
    s_mt.t_class_attr tca
join s_mt.t_class_attr tca3
    on tca.ck_class = tca3.ck_class and tca3.ck_attr = 'order'
left join s_mt.t_class_attr tca2 
    on tca.ck_class = tca2.ck_class and tca2.ck_attr = 'orderdirection'
where
    tca.ck_attr = 'orderproperty' and tca.cv_value is not null and tca3.ck_id = tca4.ck_id;

UPDATE
    s_mt.t_object_attr toa3
SET
     ck_class_attr = tca2.ck_id,
     cv_value = jsonb_build_array(jsonb_build_object('property', toa.cv_value, 'direction', UPPER(coalesce(toa2.cv_value, 'ASC'))))
from
    s_mt.t_object_attr toa
join s_mt.t_class_attr tca 
    on toa.ck_class_attr = tca.ck_id and tca.ck_attr = 'orderproperty'
join s_mt.t_class_attr tca2 
    on tca.ck_class = tca2.ck_class and tca2.ck_attr = 'order'
join s_mt.t_class_attr tca3 
    on tca.ck_class = tca3.ck_class and tca3.ck_attr = 'orderdirection'
left join s_mt.t_object_attr toa2
    on toa2.ck_object = toa.ck_object and toa2.ck_class_attr = tca3.ck_id 
where
     toa.cv_value is not null and toa3.ck_id = toa.ck_id;

UPDATE
    s_mt.t_page_object_attr toa3
SET
     ck_class_attr = tca2.ck_id,
     cv_value = jsonb_build_array(jsonb_build_object('property', toa.cv_value, 'direction', UPPER(coalesce(toa2.cv_value, 'ASC'))))
from
    s_mt.t_page_object_attr toa
join s_mt.t_class_attr tca 
    on toa.ck_class_attr = tca.ck_id and tca.ck_attr = 'orderproperty'
join s_mt.t_class_attr tca2 
    on tca.ck_class = tca2.ck_class and tca2.ck_attr = 'order'
join s_mt.t_class_attr tca3 
    on tca.ck_class = tca3.ck_class and tca3.ck_attr = 'orderdirection'
left join s_mt.t_page_object_attr toa2
    on toa2.ck_page_object = toa.ck_page_object and toa2.ck_class_attr = tca3.ck_id 
where
     toa.cv_value is not null and toa3.ck_id = toa.ck_id;

delete from s_mt.t_page_object_attr tpoa 
where tpoa.ck_class_attr in (select ck_id from s_mt.t_class_attr where ck_attr in ('orderproperty', 'orderdirection'));

delete from s_mt.t_object_attr toa 
where toa.ck_class_attr in (select ck_id from s_mt.t_class_attr where ck_attr in ('orderproperty', 'orderdirection'));

delete from s_mt.t_class_attr where ck_attr in ('orderproperty', 'orderdirection');

UPDATE
    s_mt.t_object_attr toa3
SET
     ck_class_attr = tca2.ck_id,
     cv_value = jsonb_build_array(jsonb_build_object('property', toa.cv_value, 'direction', 'ASC'))
from
    s_mt.t_object_attr toa
join s_mt.t_class_attr tca 
    on toa.ck_class_attr = tca.ck_id and tca.ck_attr = 'sortcolumn'
join s_mt.t_class_attr tca2 
    on tca.ck_class = tca2.ck_class and tca2.ck_attr = 'order'
where
     toa.cv_value is not null and toa3.ck_id = toa.ck_id;

UPDATE
    s_mt.t_page_object_attr toa3
SET
     ck_class_attr = tca2.ck_id,
     cv_value = jsonb_build_array(jsonb_build_object('property', toa.cv_value, 'direction', 'ASC'))
from
    s_mt.t_page_object_attr toa
join s_mt.t_class_attr tca 
    on toa.ck_class_attr = tca.ck_id and tca.ck_attr = 'sortcolumn'
join s_mt.t_class_attr tca2 
    on tca.ck_class = tca2.ck_class and tca2.ck_attr = 'order'
where
     toa.cv_value is not null and toa3.ck_id = toa.ck_id;

delete from s_mt.t_page_object_attr tpoa 
where tpoa.ck_class_attr in (select ck_id from s_mt.t_class_attr where ck_attr in ('sortcolumn'));

delete from s_mt.t_object_attr toa 
where toa.ck_class_attr in (select ck_id from s_mt.t_class_attr where ck_attr in ('sortcolumn'));

delete from s_mt.t_class_attr where ck_attr in ('sortcolumn');
