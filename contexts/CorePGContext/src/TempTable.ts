import {isObject, toString} from "lodash";
import {replaceNull} from "./Util";
import PostgresDB from "@ungate/plugininf/lib/db/postgres";
import {ICoreParams} from "./CoreContext";
import {IRufusLogger} from "@ungate/plugininf/lib/Logger";
import {IPropertyTempTable} from "./ICoreController";
import {isEmpty, debounce} from "@ungate/plugininf/lib/util/Util";
import {initProcess} from "@ungate/plugininf/lib/util/ProcessSender";
import {
    IPageData,
    IQueryData,
    IActionData,
    IModifyData,
    IMessageData,
    ISysSettingData,
} from "./CoreContext.types";
import {DataSource, In, ObjectLiteral, Repository} from "typeorm";
import {PageModel} from "./entities/PageModel";
import {QueryModel} from "./entities/QueryModel";
import {QueryCacheModel} from "./entities/QueryCacheModel";
import {ActionModel} from "./entities/ActionModel";
import {ModifyActionModel} from "./entities/ModifyActionModel";
import {ModifyModel} from "./entities/ModifyModel";
import {MessageModel} from "./entities/MessageModel";
import {SysSettingModel} from "./entities/SysSettingModel";
import {ObjectModel} from "./entities/ObjectModel";
import {
    fromAction,
    fromMessage,
    fromModify,
    fromModifyAction,
    fromPage,
    fromQuery,
    fromSysSetting,
} from "./entities/map";
import Constants from "@ungate/plugininf/lib/Constants";
import path from "path";
import {TypeOrmLogger} from "@ungate/plugininf/lib/db/TypeOrmLogger";

const MAX_TIME_WAIT = 5000;

export class TempTable {
    private sysSettings =
        "select s.ck_id, s.cv_value, s.cv_description from s_mt.t_sys_setting s\n" +
        "  union all\n" +
        "select 'cache_date' as ck_id, TO_CHAR(now(),'YYYY-MM-DD\"T\"HH24:MI') as cv_value, 'Дата кэширования' as cv_description";
    private pageSql =
        "with recursive temp_tree_page as (\n" +
        "    select\n" +
        "            p.ck_id,\n" +
        "            p.ck_parent,\n" +
        "            p.cv_url as cv_app_url,\n" +
        "            p.cv_name as root,\n" +
        "            jsonb_build_array(jsonb_build_object('cv_name', p.cv_name, 'ck_id', p.ck_id)) as cct_tree_path\n" +
        "        from\n" +
        "            s_mt.t_page p\n" +
        "        where p.ck_parent is null and p.cr_type = 3\n" +
        "    union all\n" +
        "        select\n" +
        "            p.ck_id,\n" +
        "            p.ck_parent,\n" +
        "            op.cv_app_url,\n" +
        "            op.root,\n" +
        "            op.cct_tree_path || jsonb_build_array(jsonb_build_object('cv_name', p.cv_name, 'ck_id', p.ck_id)) as cct_tree_path\n" +
        "        from\n" +
        "            temp_tree_page op\n" +
        "        join s_mt.t_page p on\n" +
        "            op.ck_id = p.ck_parent\n" +
        ")\n" +
        "select\n" +
        "    p.ck_id as ck_page,\n" +
        "    coalesce(nullif((\n" +
        "        select\n" +
        "            jsonb_agg(t.json ORDER BY t.cn_order) as children\n" +
        "        from\n" +
        "            (\n" +
        "                select\n" +
        "                    pp.ck_id,\n" +
        "                    po.cn_order,\n" +
        "                    pkg_json.f_get_object(po.ck_id)::jsonb as json\n" +
        "                from\n" +
        "                    t_page pp\n" +
        "                join t_page_object po on\n" +
        "                    pp.ck_id = po.ck_page\n" +
        "                where po.ck_parent is null and po.ck_id is not null and pp.ck_id = p.ck_id \n" +
        "            ) as t\n" +
        "        )::text, '[null]'), '[]') as children,\n" +
        "        coalesce((\n" +
        "            select\n" +
        "                jsonb_object_agg(pv.cv_name, pv.cv_value)\n" +
        "            from\n" +
        "                t_page_variable pv\n" +
        "            where\n" +
        "                pv.ck_page = p.ck_id\n" +
        "        )::text, '{}') as global_value,\n" +
        "    pav.cn_action as cn_action,\n" +
        "    p.cv_url,\n" +
        "    p.cv_name,\n" +
        "    jsonb_build_object(\n" +
        "    'ck_id', p.ck_id,\n" +
        "    'ck_parent', p.ck_parent,\n" +
        "    'cv_name', p.cv_name,\n" +
        "    'cn_order', p.cn_order,\n" +
        "    'cl_menu', p.cl_menu,\n" +
        "    'cl_static', p.cl_static,\n" +
        "    'cv_url', p.cv_url,\n" +
        "    'ck_icon', p.ck_icon,\n" +
        "    'ck_view', p.ck_view,\n" +
        "    'cv_redirect_url', p.cv_redirect_url,\n" +
        "    'cl_multi', p.cl_multi,\n" +
        "    'cn_action_view', pav.cn_action,\n" +
        "    'cn_action_edit', pae.cn_action,\n" +
        "    'cv_icon_name', i.cv_name,\n" +
        "    'cv_icon_font', i.cv_font,\n" +
        "    'cv_app_url', ttp.cv_app_url,\n" +
        "    'root', ttp.root,\n" +
        "    'cct_tree_path', ttp.cct_tree_path,\n" +
        "    'leaf', 'true'\n" +
        "    ) || coalesce((select\n" +
        "           jsonb_object_agg(tpa.ck_attr, pkg_json.f_decode_attr(tpa.cv_value, coalesce(da.ck_parent, a2.ck_d_data_type), tpa.ck_attr))\n" +
        "           from\n" +
        "               s_mt.t_page_attr tpa\n" +
        "           join s_mt.t_attr a2 on a2.ck_id = tpa.ck_attr \n" +
        "           join s_mt.t_d_attr_data_type da on da.ck_id = a2.ck_d_data_type \n" +
        "           where\n" +
        "               tpa.ck_page = p.ck_id)::text, '{}')::jsonb  as route \n" +
        "from\n" +
        "    t_page p\n" +
        "join temp_tree_page ttp \n" +
        "    on ttp.ck_id = p.ck_id\n" +
        "left join t_page_action pav on\n" +
        "    pav.ck_page = p.ck_id and pav.cr_type = 'view'\n" +
        "left join t_page_action pae on\n" +
        "    pae.ck_page = p.ck_id and pae.cr_type = 'edit'\n" +
        "left join t_icon i on\n" +
        "    i.ck_id = p.ck_icon\n" +
        " where p.cr_type = 2\n";
    private querySql =
        "select q.ck_id, q.ck_provider, q.cc_query, q.cr_type, q.cr_access, q.cn_action, q.cr_cache, q.cv_cache_key_param\n" +
        "from t_query q";
    private queryActionSql =
        "select distinct\n" +
        "       po.ck_id,\n" +
        "       pa.cn_action\n" +
        "  from t_page_object po\n" +
        "  join t_page p on p.ck_id = po.ck_page\n" +
        "  join t_page_action pa on pa.ck_page = p.ck_id\n" +
        " where pa.cr_type = 'view'\n" +
        " order by po.ck_id, pa.cn_action";
    private modifySql =
        "select po.ck_id, o.cv_modify, o.ck_provider\n" +
        "  from t_page_object po\n" +
        "  join t_page p\n" +
        "    on po.ck_page = p.ck_id\n" +
        "  join t_object o\n" +
        "    on po.ck_object = o.ck_id\n" +
        " where o.cv_modify is not null";
    private modifyActionSql =
        "select distinct\n" +
        "       po.ck_id,\n" +
        "       pa.cn_action\n" +
        "  from t_page_object po\n" +
        "  join t_page p on p.ck_id = po.ck_page\n" +
        "  join t_page_action pa on pa.ck_page = p.ck_id\n" +
        " where pa.cr_type = 'edit'\n" +
        " order by po.ck_id, pa.cn_action";
    private messageSql =
        "select m.ck_id,\n" +
        "       m.cr_type,\n" +
        "       m.cv_text\n" +
        "  from t_message m\n" +
        " order by m.ck_id asc";
    public dbPage!: Repository<PageModel>;
    public dbQuery!: Repository<QueryModel>;
    public dbQueryCache!: Repository<QueryCacheModel>;
    public dbQueryAction!: Repository<ActionModel>;
    public dbModify!: Repository<ModifyModel>;
    public dbModifyAction!: Repository<ModifyActionModel>;
    public dbMessage!: Repository<MessageModel>;
    public dbSysSettings!: Repository<SysSettingModel>;
    public dbObject!: Repository<ObjectModel>;
    private ds!: DataSource;
    private dataSource: PostgresDB;
    public params: ICoreParams;
    public logger: IRufusLogger;
    public name: string;
    public caches = ["all", "back"];

    constructor({dataSource, params, logger, name}: IPropertyTempTable) {
        this.dataSource = dataSource;
        this.params = params;
        this.logger = logger;
        this.name = name;
        initProcess(
            {
                reloadPageCache: debounce(async () => {
                    if (process.env.UNGATE_HTTP_ID !== "1") {
                        return;
                    }
                    Promise.all([
                        this.loadPages(),
                        this.loadQuery(),
                        this.loadQueryCache(),
                        this.loadQueryAction(),
                        this.loadModify(),
                        this.loadModifyAction(),
                        this.loadMessage(),
                        this.loadSysSetting(),
                    ]).catch((err) => logger.error(err));
                }, MAX_TIME_WAIT) as any,
            },
            "cluster",
        );
    }

    private async replaceAll<T extends ObjectLiteral>(
        repo: Repository<T>,
        rows: T[],
    ): Promise<void> {
        await repo.clear();
        if (rows.length) {
            await repo.save(rows);
        }
    }

    public loadSysSetting(): Promise<void> {
        return this.dataSource
            .executeStmt(
                this.sysSettings,
                undefined,
                undefined,
                undefined,
                {
                    resultSet: true,
                },
            )
            .then(
                (res) =>
                    new Promise((resolve, reject) => {
                        const data: ISysSettingData[] = [];
                        res.stream.on("data", (row) => {
                            data.push(row);
                            if (row.ck_id === "g_sys_anonymous_action") {
                                this.params.anonymousAction = parseInt(
                                    row.cv_value,
                                    10,
                                );
                            }
                        });
                        res.stream.on("end", async () => {
                            try {
                                await this.replaceAll(
                                    this.dbSysSettings,
                                    data.map(fromSysSetting),
                                );
                                resolve();
                            } catch (e) {
                                reject(e);
                            }
                        });
                    }),
            );
    }
    /*
     * Поиск сообщения
     * @param {Array} ck_error Список ошибок
     * @param {Object} options Дополнительные параметры
     * @returns {*}
     */
    public findMessage(ckError: any[] = [], options: {cr_type?: string} = {}) {
        if (!ckError.length) {
            return Promise.resolve(0);
        }
        return this.dbMessage.count({
            where: {
                id: In(ckError),
                ...(options.cr_type ? {type: options.cr_type} : {}),
            },
        });
    }

    /**
     * Кэширование всех страниц
     */
    public loadPages(): Promise<void> {
        return this.dataSource
            .executeStmt(
                this.pageSql,
                undefined,
                undefined,
                undefined,
                {
                    resultSet: true,
                },
            )
            .then(
                (res) =>
                    new Promise((resolve, reject) => {
                        const data: Record<string, IPageData> = {};
                        res.stream.on("error", (err) =>
                            reject(new Error(err.message)),
                        );
                        res.stream.on("data", (row) => {
                            try {
                                const children = Array.isArray(row.children)
                                    ? row.children
                                    : JSON.parse(row.children, replaceNull);
                                data[row.ck_page] = {
                                    ck_id: row.ck_page,
                                    cn_action:
                                        row.cn_action &&
                                        parseInt(row.cn_action, 10),
                                    cv_name: row.cv_name,
                                    cv_url: row.cv_url,
                                    children,
                                    route: isObject(row.route)
                                        ? row.route
                                        : JSON.parse(row.route || "{}"),
                                    global_value: isObject(row.global_value)
                                        ? row.global_value
                                        : JSON.parse(row.global_value || "{}"),
                                };
                                if (
                                    children.length === 1 &&
                                    isEmpty(children[0])
                                ) {
                                    children.length = 0;
                                }
                            } catch (e: any) {
                                this.logger.error(
                                    `Error parse: ${row.json} ${e.message}`,
                                    e,
                                );
                            }
                        });
                        res.stream.on("end", async () => {
                            try {
                                await this.replaceAll(
                                    this.dbPage,
                                    Object.values(data).map(fromPage),
                                );
                                resolve();
                            } catch (e: any) {
                                reject(e);
                            }
                        });
                    }),
            );
    }

    /**
     * Кэширование все запросов
     */
    public loadMessage(): Promise<void> {
        return this.dataSource
            .executeStmt(
                this.messageSql,
                undefined,
                undefined,
                undefined,
                {
                    resultSet: true,
                },
            )
            .then(
                (res) =>
                    new Promise((resolve, reject) => {
                        const data: IMessageData[] = [];
                        res.stream.on("error", (err) =>
                            reject(new Error(err.message)),
                        );
                        res.stream.on("data", (row) => {
                            try {
                                data.push({
                                    ck_id: toString(row.ck_id),
                                    cr_type: row.cr_type,
                                    cv_text: row.cv_text,
                                } as any);
                            } catch (e: any) {
                                this.logger.error(
                                    `Error parse: ${row.json} ${e.message}`,
                                    e,
                                );
                            }
                        });
                        res.stream.on("end", async () => {
                            try {
                                await this.replaceAll(
                                    this.dbMessage,
                                    data.map(fromMessage),
                                );
                                resolve();
                            } catch (e: any) {
                                reject(e);
                            }
                        });
                    }),
            );
    }

    /**
     * Кэширование все запросов
     */
    public loadQuery(): Promise<void> {
        return this.dataSource
            .executeStmt(
                this.querySql,
                undefined,
                undefined,
                undefined,
                {
                    resultSet: true,
                },
            )
            .then(
                (res) =>
                    new Promise((resolve, reject) => {
                        const data: IQueryData[] = [];
                        res.stream.on("error", (err) =>
                            reject(new Error(err.message)),
                        );
                        res.stream.on("data", (row) => {
                            data.push({
                                cc_query: row.cc_query,
                                ck_id: row.ck_id.toLowerCase(),
                                ck_provider: row.ck_provider,
                                cn_action:
                                    row.cn_action &&
                                    parseInt(row.cn_action, 10),
                                cr_access: row.cr_access,
                                cr_type: row.cr_type,
                                cr_cache: row.cr_cache,
                                cv_cache_key_param: row.cv_cache_key_param
                                    ? JSON.parse(row.cv_cache_key_param)
                                    : [],
                            });
                        });
                        res.stream.on("end", async () => {
                            try {
                                await this.replaceAll(
                                    this.dbQuery,
                                    data.map(fromQuery),
                                );
                                resolve();
                            } catch (e: any) {
                                reject(e);
                            }
                        });
                    }),
            );
    }

    /**
     * Кэширование все запросов
     */
    public loadQueryCache(): Promise<void> {
        return this.dbQueryCache.clear();
    }

    /**
     * Кэширование все доступов к запросам
     */
    public loadQueryAction(): Promise<void> {
        return this.dataSource
            .executeStmt(
                this.queryActionSql,
                undefined,
                undefined,
                undefined,
                {
                    resultSet: true,
                },
            )
            .then(
                (res) =>
                    new Promise((resolve, reject) => {
                        const data: IActionData[] = [];
                        res.stream.on("error", (err) =>
                            reject(new Error(err.message)),
                        );
                        res.stream.on("data", (row) => {
                            data.push({
                                ck_id: `${row.ck_id}:${row.cn_action}`,
                                ck_page_object: row.ck_id.toLowerCase(),
                                cn_action:
                                    row.cn_action &&
                                    parseInt(row.cn_action, 10),
                            });
                        });
                        res.stream.on("end", async () => {
                            try {
                                await this.replaceAll(
                                    this.dbQueryAction,
                                    data.map(fromAction),
                                );
                                resolve();
                            } catch (e: any) {
                                reject(e);
                            }
                        });
                    }),
            );
    }

    /**
     * Кэширование все методов модификации
     */
    public loadModify(): Promise<void> {
        return this.dataSource
            .executeStmt(
                this.modifySql,
                undefined,
                undefined,
                undefined,
                {
                    resultSet: true,
                },
            )
            .then(
                (res) =>
                    new Promise((resolve, reject) => {
                        const data: IModifyData[] = [];
                        res.stream.on("error", (err) =>
                            reject(new Error(err.message)),
                        );
                        res.stream.on("data", (row) => {
                            data.push({
                                ck_id: row.ck_id.toLowerCase(),
                                ck_provider: row.ck_provider,
                                cv_modify: row.cv_modify,
                            });
                        });
                        res.stream.on("end", async () => {
                            try {
                                await this.replaceAll(
                                    this.dbModify,
                                    data.map(fromModify),
                                );
                                resolve();
                            } catch (e: any) {
                                reject(e);
                            }
                        });
                    }),
            );
    }

    /**
     * Кэширование все доступов методов модификации
     */
    public loadModifyAction(): Promise<void> {
        return this.dataSource
            .executeStmt(
                this.modifyActionSql,
                undefined,
                undefined,
                undefined,
                {
                    resultSet: true,
                },
            )
            .then(
                (res) =>
                    new Promise((resolve, reject) => {
                        const data: IActionData[] = [];
                        res.stream.on("data", (row) => {
                            data.push({
                                ck_id: `${row.ck_id}:${row.cn_action}`,
                                ck_page_object: row.ck_id.toLowerCase(),
                                cn_action:
                                    row.cn_action &&
                                    parseInt(row.cn_action, 10),
                            });
                        });
                        res.stream.on("end", async () => {
                            try {
                                await this.replaceAll(
                                    this.dbModifyAction,
                                    data.map(fromModifyAction),
                                );
                                resolve();
                            } catch (e) {
                                reject(e);
                            }
                        });
                    }),
            );
    }
    public async initTempDb() {
        if (this.ds?.isInitialized) {
            await this.ds.destroy();
        }
        this.ds = new DataSource({
            type: "better-sqlite3",
            enableWAL: true,
            database: path.join(Constants.TEMP_DB, `temp_${this.name}.db`),
            synchronize: true,
            logging: true,
            logger: new TypeOrmLogger(`${this.name}.TempTable`),
            entities: [
                PageModel,
                QueryModel,
                QueryCacheModel,
                ActionModel,
                ModifyActionModel,
                ModifyModel,
                MessageModel,
                SysSettingModel,
                ObjectModel,
            ],
        });
        await this.ds.initialize();
        this.dbPage = this.ds.getRepository(PageModel);
        this.dbQuery = this.ds.getRepository(QueryModel);
        this.dbQueryCache = this.ds.getRepository(QueryCacheModel);
        this.dbQueryAction = this.ds.getRepository(ActionModel);
        this.dbObject = this.ds.getRepository(ObjectModel);
        this.dbModify = this.ds.getRepository(ModifyModel);
        this.dbModifyAction = this.ds.getRepository(ModifyActionModel);
        this.dbMessage = this.ds.getRepository(MessageModel);
        this.dbSysSettings = this.ds.getRepository(SysSettingModel);
    }
}
