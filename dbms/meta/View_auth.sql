--liquibase formatted sql
--changeset patcher-core:View_auth dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_view(ck_id, cv_description, cct_config, cct_manifest, cl_available, ck_user, ct_change) VALUES ('auth', 'Essence Core Auth', '{"bc": {"type": "APPLICATION", "childs": [{"type": "KEYCLOCKAUTH", "ck_page_object": "4D1474D488C546666027FDEB18E443DF"}, {"type": "APP_BAR", "childs": [{"type": "EMPTY_SPACE", "width": "100%", "height": "45px", "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "Empty Space Left", "cn_order": 20, "ck_object": "9D66F83220F64A19A269B6609F3AD96C", "ck_parent": "C92F6E9D327F4E58AA4569B874027414", "cl_dataset": 0, "ck_page_object": "C5542D15E7874430BB883D8C26EA8D49", "cv_description": "Empty Space Left"}, {"type": "BTN_GROUP", "childs": [{"type": "BTN", "reqsel": false, "uitype": "1", "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "Button Profile", "handler": "onWindowOpen", "maxfile": 5242880, "ckwindow": "profile", "cn_order": 10, "iconfont": "user", "ck_master": "6CF66CAB76FE4361B98CA98B854EA3CD", "ck_object": "9B554144ED7E417CB734A98BC54B6A57", "ck_parent": "458B5B435D5748939CC6C94528D2E578", "filetypes": "doc,docx,pdf,zip,txt,ods,odt,xls,xlsx", "cl_dataset": 0, "cv_displayed": "e571d8599bc8466aac42ade8b1891e44", "iconfontname": "fa", "ck_page_object": "D0625BA848CD4CBD960D068A4A1444FC", "cv_description": "Профиль", "getmastervalue": [{"in": "ck_id", "out": "ck_id"}], "skipvalidation": false}, {"type": "BTN", "reqsel": false, "uitype": "1", "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "Button About", "handler": "onWindowOpen", "maxfile": 5242880, "ckwindow": "about", "cn_order": 15, "iconfont": "info-circle ", "ck_master": "6CF66CAB76FE4361B98CA98B854EA3CD", "ck_object": "4592873309F64CDDAF043B3DDC33623F", "ck_parent": "458B5B435D5748939CC6C94528D2E578", "filetypes": "doc,docx,pdf,zip,txt,ods,odt,xls,xlsx", "cl_dataset": 0, "cv_displayed": "66eeff41c0c94c5ca52909fb9d97e0aa", "iconfontname": "fa", "ck_page_object": "AF343CB7076E418FA17AE7A4906FC4AF", "cv_description": "О программе", "getmastervalue": [{"in": "ck_id", "out": "ck_id"}], "skipvalidation": false}], "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "Button Group Right", "cn_order": 30, "onlyicon": true, "ck_object": "9E5CBADBFA654AAC84517A35965051AF", "ck_parent": "C92F6E9D327F4E58AA4569B874027414", "cl_dataset": 0, "contentview": "hbox", "ck_page_object": "458B5B435D5748939CC6C94528D2E578", "cv_description": "Секция кнопок справа"}], "height": "45px", "uitype": "1", "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "App Bar Auth", "cn_order": 10, "position": "relative", "ck_object": "6B9A15FFDBA342BDA8F75A8BA5C6479B", "ck_parent": "6CF66CAB76FE4361B98CA98B854EA3CD", "cl_dataset": 0, "contentview": "hbox", "ck_page_object": "C92F6E9D327F4E58AA4569B874027414", "cv_description": "App Bar Auth"}, {"type": "AUTH_FORM", "childs": [{"type": "IFIELD", "column": "cv_login", "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "Field Test Login", "maxsize": "120", "cn_order": 10, "datatype": "text", "required": true, "ck_object": "0696257D24E0416A917652D79FBB175A", "ck_parent": "5500938489C0450CB6857F1D90DE611B", "cl_dataset": 0, "cv_displayed": "f4238b5aee4444adab02798144ff55cd", "ck_page_object": "0E6898C70DA644499832294504E17853", "cv_description": "Field Test Login"}, {"type": "IFIELD", "column": "cv_password", "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "Password", "maxsize": "120", "cn_order": 20, "datatype": "password", "required": true, "ck_object": "474EA962ECB7432ABD5B74F0B74C9066", "ck_parent": "5500938489C0450CB6857F1D90DE611B", "cl_dataset": 0, "cv_displayed": "e59a81c8ac1846679714fad756f39649", "ck_page_object": "6E5C634B7B5E4A28A5B24C5AF7AB46A2", "cv_description": "Password"}], "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "Auth Form", "cn_order": 20, "bottombtn": [{"type": "BTN", "reqsel": false, "uitype": "2", "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "Button Guest", "handler": "onLoginGuest", "maxfile": 5242880, "cn_order": 50, "ck_object": "4388AA3C394849579493D95D3C65768D", "ck_parent": "5500938489C0450CB6857F1D90DE611B", "filetypes": "doc,docx,pdf,zip,txt,ods,odt,xls,xlsx", "cl_dataset": 0, "hiddenrules": "g_sys_enable_guest_login === \"false\"", "cv_displayed": "15f4ab0a6b564c5db93e6a2b675769fb", "iconfontname": "fa", "ck_page_object": "C46B53C8A6E04B8987E2E91238C141E6", "cv_description": "Button Guest", "getmastervalue": [{"in": "ck_id", "out": "ck_id"}], "skipvalidation": false}, {"type": "BTN", "reqsel": false, "uitype": "1", "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "Button Login", "handler": "onLogin", "maxfile": 5242880, "cn_order": 60, "ck_object": "05AB63D5B84D4B428BA2DE618CEA0BDF", "ck_parent": "5500938489C0450CB6857F1D90DE611B", "filetypes": "doc,docx,pdf,zip,txt,ods,odt,xls,xlsx", "cl_dataset": 0, "cv_displayed": "82eafeb106eb41aaa205152471b1b7b6", "iconfontname": "fa", "ck_page_object": "7CE9025C54C34373A4A6BCF759032A4F", "cv_description": "Button Login", "getmastervalue": [{"in": "ck_id", "out": "ck_id"}], "skipvalidation": false}], "ck_modify": "modify", "ck_object": "C606EB2BBBD242629A47EB646BC2F7C8", "ck_parent": "6CF66CAB76FE4361B98CA98B854EA3CD", "cl_dataset": 1, "ck_page_object": "5500938489C0450CB6857F1D90DE611B", "cv_description": "Auth Form", "cv_helper_color": "red"}], "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "SYS Application - Auth", "cn_order": 5, "ck_modify": "modify", "ck_object": "070636806A2C4BA9AEEA69CD4CA94542", "cl_dataset": 1, "idproperty": "ck_id", "activerules": "cv_url === \"auth\" && !g_sess_session", "childwindow": [{"top": 45, "type": "WIN", "align": "right", "width": "30%", "childs": [{"type": "THEME_COMBO", "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "Theme", "cn_order": 10, "ck_modify": "modify", "ck_object": "373E92205BE8496EB457455E027AFC08", "ck_parent": "5D418155DA03479EB31812731C03F074", "cl_dataset": 1, "idproperty": "ck_id", "cv_displayed": "eb5f0456bee64d60ba3560e6f7a9f332", "ck_page_object": "7AC126BF206D4FE7966B0FEA832DD965", "cv_description": "Theme", "getmastervalue": [{"in": "ck_id", "out": "ck_id"}], "cv_helper_color": "red"}], "height": "100px", "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "Profile Drawer", "ckwindow": "profile", "cn_order": 110, "datatype": "DRAWER", "ck_object": "BAD549B89978443EB92F48D744EBBE3C", "ck_parent": "6CF66CAB76FE4361B98CA98B854EA3CD", "cl_dataset": 0, "ck_page_object": "5D418155DA03479EB31812731C03F074", "cv_description": "Profile Drawer"}, {"type": "WIN", "childs": [{"type": "IFRAME", "width": "100%", "column": "cv_app_info", "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "About IFrame", "autoload": true, "ck_query": "MTGetMainAppInfo", "cn_order": 20, "ck_modify": "modify", "ck_object": "D76C1A700D724EA6BD3C63AD53CAD036", "ck_parent": "4D1474D488C540B3A027FDEB18E443DF", "cl_dataset": 1, "idproperty": "ck_id", "typeiframe": "\"HTML\"", "noglobalmask": true, "ck_page_object": "89ABD2043F8A4B2D9B9B5ABD8AB45CDC", "cv_description": "About IFrame", "getmastervalue": [{"in": "ck_id", "out": "ck_id"}], "cv_helper_color": "yellow", "getglobaltostore": [{"in": "g_sys_front_branch_date_time"}, {"in": "g_sys_front_branch_name"}, {"in": "g_sys_front_commit_id"}, {"in": "g_sys_lang"}]}], "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "Window About", "wintype": "default", "ckwindow": "about", "cn_order": 120, "datatype": "WINDOW", "bottombtn": [{"type": "BTN", "hidden": true, "reqsel": false, "uitype": "1", "ck_page": "22D2F53FE7E24680917B85D9A95237BD", "cv_name": "Close Silent", "handler": "onCloseWindowSilent", "maxfile": 5242880, "cn_order": 30, "ck_object": "C3C9EDB3EE834A38B27641C71772644C", "ck_parent": "4D1474D488C540B3A027FDEB18E443DF", "filetypes": "doc,docx,pdf,zip,txt,ods,odt,xls,xlsx", "cl_dataset": 0, "iconfontname": "fa", "ck_page_object": "32FE580C5E244DDEB0BEC0CA9AC87521", "cv_description": "Close Silent", "getmastervalue": [{"in": "ck_id", "out": "ck_id"}], "skipvalidation": false}], "ck_object": "8EF4D90D8E944057B7409F3D8C1AD28B", "ck_parent": "6CF66CAB76FE4361B98CA98B854EA3CD", "cl_dataset": 0, "cv_displayed": "66eeff41c0c94c5ca52909fb9d97e0aa", "ck_page_object": "4D1474D488C540B3A027FDEB18E443DF", "cv_description": "О программе", "collectionvalues": "object"}], "redirecturl": "pages", "cl_is_master": 1, "defaultvalue": "home", "ck_page_object": "6CF66CAB76FE4361B98CA98B854EA3CD", "cv_description": "Приложение авторизации", "getmastervalue": [{"in": "ck_id", "out": "ck_id"}], "cv_helper_color": "red", "defaultvaluelocalization": "home"}}'::jsonb, '{}'::jsonb, 1, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-12-10T10:13:44.000+0000')  on conflict (ck_id) do update set cl_available = excluded.cl_available, cct_config = excluded.cct_config, cct_manifest = excluded.cct_manifest, cv_description = excluded.cv_description, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
