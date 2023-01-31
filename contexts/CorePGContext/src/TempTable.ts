import ILocalDB from "@ungate/plugininf/lib/db/local/ILocalDB";
import { isObject, toString } from "lodash";
import { replaceNull } from "./Util";
import PostgresDB from "@ungate/plugininf/lib/db/postgres";
import { ICoreParams } from "./CoreContext";
import { IRufusLogger } from "rufus";
import IGlobalObject from "@ungate/plugininf/lib/IGlobalObject";
import { IPropertyContext } from "./ICoreController";
import { isEmpty, debounce } from "@ungate/plugininf/lib/util/Util";
import { initProcess } from "@ungate/plugininf/lib/util/ProcessSender";
import {
    IPageData,
    IQueryData,
    IActionData,
    IModifyData,
    IMessageData,
    ISysSettingData,
    IObjectData,
} from "./CoreContext.types";
const createTempTable = (global as any as IGlobalObject).createTempTable;

const MAX_TIME_WAIT = 5000;

export class TempTable {
    private sysSettings =
        "select s.ck_id, s.cv_value, s.cv_description from s_mt.t_sys_setting s";
    private pageSql =
        "select\n" +
        "    t.ck_page,\n" +
        "    t.cv_url,\n" +
        "    t.cv_name,\n" +
        "    t.cn_action,\n" +
        "    jsonb_agg(t.json ORDER BY t.cn_order) as children,\n" +
        "    (\n" +
        "        select\n" +
        "            jsonb_object_agg(pv.cv_name, pv.cv_value)\n" +
        "        from\n" +
        "            s_mt.t_page_variable pv\n" +
        "        where\n" +
        "            pv.ck_page = t.ck_page\n" +
        "    ) as global_value\n" +
        "from\n" +
        "    (\n" +
        "        select\n" +
        "            p.ck_id as ck_page,\n" +
        "            p.cv_url,\n" +
        "            p.cv_name,\n" +
        "            po.cn_order,\n" +
        "            pa.cn_action,\n" +
        "            pkg_json.f_get_object(po.ck_id)::jsonb as json\n" +
        "        from\n" +
        "            t_page p\n" +
        "        left join t_page_object po on\n" +
        "            p.ck_id = po.ck_page\n" +
        "        join t_page_action pa on\n" +
        "            pa.ck_page = p.ck_id\n" +
        "        where\n" +
        "            pa.cr_type is not null\n" +
        "            and pa.cr_type = 'view'\n" +
        "            and po.ck_parent is null\n" +
        "        order by\n" +
        "            po.ck_page,\n" +
        "            po.cn_order\n" +
        "    ) as t\n" +
        "group by\n" +
        "    t.ck_page,\n" +
        "    t.cv_url,\n" +
        "    t.cv_name,\n" +
        "    t.cn_action\n";
    private querySql =
        "select q.ck_id, q.ck_provider, q.cc_query, q.cr_type, q.cr_access, q.cn_action\n" +
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
    public dbPage: ILocalDB<IPageData>;
    public dbQuery: ILocalDB<IQueryData>;
    public dbQueryAction: ILocalDB<IActionData>;
    public dbModify: ILocalDB<IModifyData>;
    public dbModifyAction: ILocalDB<IActionData>;
    public dbMessage: ILocalDB<IMessageData>;
    public dbSysSettings: ILocalDB<ISysSettingData>;
    public dbObject: ILocalDB<IObjectData>;
    private dataSource: PostgresDB;
    public params: ICoreParams;
    public logger: IRufusLogger;
    public name: string;

    constructor({ dataSource, params, logger, name }: IPropertyContext) {
        this.dataSource = dataSource;
        this.params = params;
        this.logger = logger;
        this.name = name;
        initProcess({
            reloadPageCache: debounce(() => {
                if (process.env.UNGATE_HTTP_ID !== "1") {
                    return;
                }
                Promise.all([
                    this.loadPages(),
                    this.loadQuery(),
                    this.loadQueryAction(),
                    this.loadModify(),
                    this.loadModifyAction(),
                    this.loadMessage(),
                    this.loadSysSetting(),
                ]).catch((err) => logger.error(err));
            }, MAX_TIME_WAIT)
        }, "cluster");
    }

    public loadSysSetting(): Promise<void> {
        return this.dataSource
            .executeStmt(
                this.sysSettings,
                null,
                {},
                {},
                {
                    resultSet: true,
                },
            )
            .then(
                (res) =>
                    new Promise((resolve, reject) => {
                        const data = [];
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
                                await this.dbSysSettings.remove(
                                    {},
                                    { multi: true },
                                );
                                await this.dbSysSettings.insert(data).then(
                                    () => resolve(),
                                    (err) => reject(err),
                                );
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
    public findMessage(ckError = [], options = {}) {
        return this.dbMessage.count({
            $and: [{ ck_id: { $in: ckError } }, options],
        });
    }

    /**
     * Кэширование всех страниц
     */
    public loadPages(): Promise<void> {
        return this.dataSource
            .executeStmt(
                this.pageSql,
                null,
                {},
                {},
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
                                    global_value: isObject(row.global_value)
                                        ? row.global_value
                                        : JSON.parse(
                                              row.global_value || "{}",
                                              replaceNull,
                                          ),
                                };
                                if (
                                    children.length === 1 &&
                                    isEmpty(children[0])
                                ) {
                                    children.length = 0;
                                }
                            } catch (e) {
                                this.logger.error(
                                    `Error parse: ${row.json} ${e.message}`,
                                    e,
                                );
                            }
                        });
                        res.stream.on("end", async () => {
                            try {
                                await this.dbPage.remove({}, { multi: true });
                                await this.dbPage
                                    .insert(Object.values(data))
                                    .then(
                                        () => resolve(),
                                        (err) => reject(err),
                                    );
                            } catch (e) {
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
                null,
                {},
                {},
                {
                    resultSet: true,
                },
            )
            .then(
                (res) =>
                    new Promise((resolve, reject) => {
                        const data = [];
                        res.stream.on("error", (err) =>
                            reject(new Error(err.message)),
                        );
                        res.stream.on("data", (row) => {
                            try {
                                data.push({
                                    ck_id: toString(row.ck_id),
                                    cr_type: row.cr_type,
                                    cv_text: row.cv_text,
                                });
                            } catch (e) {
                                this.logger.error(
                                    `Error parse: ${row.json} ${e.message}`,
                                    e,
                                );
                            }
                        });
                        res.stream.on("end", async () => {
                            try {
                                await this.dbMessage.remove(
                                    {},
                                    { multi: true },
                                );
                                await this.dbMessage.insert(data).then(
                                    () => resolve(),
                                    (err) => reject(err),
                                );
                            } catch (e) {
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
                null,
                {},
                {},
                {
                    resultSet: true,
                },
            )
            .then(
                (res) =>
                    new Promise((resolve, reject) => {
                        const data = [];
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
                            });
                        });
                        res.stream.on("end", async () => {
                            try {
                                await this.dbQuery.remove({}, { multi: true });
                                await this.dbQuery.insert(data).then(
                                    () => resolve(),
                                    (err) => reject(err),
                                );
                            } catch (e) {
                                reject(e);
                            }
                        });
                    }),
            );
    }

    /**
     * Кэширование все доступов к запросам
     */
    public loadQueryAction(): Promise<void> {
        return this.dataSource
            .executeStmt(
                this.queryActionSql,
                null,
                {},
                {},
                {
                    resultSet: true,
                },
            )
            .then(
                (res) =>
                    new Promise((resolve, reject) => {
                        const data = [];
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
                                await this.dbQueryAction.remove(
                                    {},
                                    { multi: true },
                                );
                                await this.dbQueryAction.insert(data).then(
                                    () => resolve(),
                                    (err) => reject(err),
                                );
                            } catch (e) {
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
                null,
                {},
                {},
                {
                    resultSet: true,
                },
            )
            .then(
                (res) =>
                    new Promise((resolve, reject) => {
                        const data = [];
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
                                await this.dbModify.remove({}, { multi: true });
                                await this.dbModify.insert(data).then(
                                    () => resolve(),
                                    (err) => reject(err),
                                );
                            } catch (e) {
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
                null,
                {},
                {},
                {
                    resultSet: true,
                },
            )
            .then(
                (res) =>
                    new Promise((resolve, reject) => {
                        const data = [];
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
                                await this.dbModifyAction.remove(
                                    {},
                                    { multi: true },
                                );
                                await this.dbModifyAction.insert(data).then(
                                    () => resolve(),
                                    (err) => reject(err),
                                );
                            } catch (e) {
                                reject(e);
                            }
                        });
                    }),
            );
    }
    public async initTempDb() {
        this.dbPage = await createTempTable(`tt_page_${this.name}`);
        this.dbQuery = await createTempTable(`tt_query_${this.name}`);
        this.dbQueryAction = await createTempTable(
            `tt_query_action_${this.name}`,
        );
        this.dbObject = await createTempTable(`tt_object_${this.name}`);
        this.dbModify = await createTempTable(`tt_modify_${this.name}`);
        this.dbModifyAction = await createTempTable(
            `tt_modify_action_${this.name}`,
        );
        this.dbMessage = await createTempTable(`tt_message_${this.name}`);
        this.dbSysSettings = await createTempTable(
            `tt_sys_settings_${this.name}`,
        );
        return Promise.resolve();
    }
}
