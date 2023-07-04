import ILocalDB from "@ungate/plugininf/lib/db/local/ILocalDB";
import OracleDB from "@ungate/plugininf/lib/db/oracle/index";
import BreakException from "@ungate/plugininf/lib/errors/BreakException";
import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import ErrorGate from "@ungate/plugininf/lib/errors/ErrorGate";
import IContext from "@ungate/plugininf/lib/IContext";
import IGlobalObject from "@ungate/plugininf/lib/IGlobalObject";
import IResult from "@ungate/plugininf/lib/IResult";
import Logger from "@ungate/plugininf/lib/Logger";
import ResultStream from "@ungate/plugininf/lib/stream/ResultStream";
import { safePipe } from "@ungate/plugininf/lib/stream/Util";
import {
    filterFilesData,
    isEmpty,
    sortFilesData,
} from "@ungate/plugininf/lib/util/Util";
import { noop, toString } from "lodash";
import { Transform } from "stream";
import CoreContext from "./CoreContext";
import { ICoreParams } from "./CoreContext";
import {
    IMessageData,
    ISysSettingData,
    IActionData,
    IModifyData,
    IQueryData,
    IPageData,
} from "./CoreContext.types";
import ICoreController from "./ICoreController";
const logger = Logger.getLogger("OfflineController");
const createTempTable = (global as any as IGlobalObject).createTempTable;

export interface ITempTable {
    dbPage: ILocalDB<IPageData>;
    dbQuery: ILocalDB<IQueryData>;
    dbQueryAction: ILocalDB<IActionData>;
    dbModify: ILocalDB<IModifyData>;
    dbModifyAction: ILocalDB<IActionData>;
    dbMessage: ILocalDB<IMessageData>;
    dbSysSettings: ILocalDB<ISysSettingData>;
}

export default class OfflineController implements ICoreController {
    public params: ICoreParams;
    public dataSource: OracleDB;
    public tempTable: ITempTable;
    public name: string;

    private sysSettings =
        "select s.ck_id, s.cv_value, s.cv_description from s_mt.t_sys_setting s";
    private pageSql =
        "select\n" +
        "    p.ck_id as ck_page,\n" +
        "    p.cv_url,\n" +
        "    pa.cn_action,\n" +
        "    p.cv_name,\n" +
        "    pkg_json.f_get_object(po.ck_id) as json\n" +
        "from\n" +
        "    s_mt.t_page p\n" +
        "left join s_mt.t_page_object po on\n" +
        "    p.ck_id = po.ck_page\n" +
        "join s_mt.t_page_action pa on\n" +
        "    pa.ck_page = p.ck_id\n" +
        "where\n" +
        "    ((pa.cr_type is not null\n" +
        "    and pa.cr_type = 'view')\n" +
        "    or pa.cr_type is null)\n" +
        "    and po.ck_parent is null\n" +
        "order by\n" +
        "    po.ck_page,\n" +
        "    po.cn_order\n";
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
    private pageFindSql =
        "select p.ck_id as ck_page, p.cv_url, p.cv_name, pa.cn_action, pkg_json.f_get_object(po.ck_id) as json\n" +
        "   from t_page p\n" +
        "   left join t_page_object po on p.ck_id = po.ck_page\n" +
        "   join t_page_action pa on pa.ck_page = p.ck_id\n" +
        "  where ((pa.cr_type is not null and pa.cr_type = 'view') or pa.cr_type is null) \n" +
        "   and po.ck_parent is null and (p.ck_id = :ck_page or p.cv_url = :ck_page) \n" +
        "   order by po.ck_page, po.cn_order";
    private queryFindSql =
        "select q.ck_id, q.ck_provider, q.cc_query, q.cr_type, q.cr_access, q.cn_action\n" +
        "from t_query q where lower(q.ck_id) = lower(:ck_query)";
    private modifyFindSql =
        "select po.ck_id, o.cv_modify, o.ck_provider\n" +
        "  from t_page_object po\n" +
        "  join t_page p\n" +
        "    on po.ck_page = p.ck_id\n" +
        "  join t_object o\n" +
        "    on po.ck_object = o.ck_id\n" +
        " where o.cv_modify is not null and lower(po.ck_id) = lower(:page_object)";
    constructor(name: string, dataSource: OracleDB, params: ICoreParams) {
        this.dataSource = dataSource;
        this.params = params;
        this.name = name;
    }
    public async getSetting(gateContext: IContext): Promise<any> {
        const { js } = gateContext.params;
        const json = JSON.parse(gateContext.params.json || "{}");
        const ckId = json.filter?.ck_id;
        if (ckId) {
            await this.loadSysSetting();
        }
        const data = await this.tempTable.dbSysSettings.find({});
        data.push({
            ck_id: "core_gate_version",
            cv_description: "Версия шлюза",
            cv_value: gateContext.gateVersion,
        });
        if (js) {
            const str = "window.SETTINGS = " + JSON.stringify(data) + ";";
            gateContext.response.writeHead(200, {
                "content-length": Buffer.byteLength(str),
                "content-type": "application/javascript",
            });
            gateContext.response.end(str);
            throw new BreakException({
                data: ResultStream(
                    data
                        .sort(sortFilesData(gateContext))
                        .filter(filterFilesData(gateContext)),
                ),
                type: "break",
            });
        } else {
            throw new BreakException({
                data: ResultStream(
                    data
                        .sort(sortFilesData(gateContext))
                        .filter(filterFilesData(gateContext))
                        .filter((obj) => !ckId || obj.ck_id === ckId),
                ),
                type: "success",
            });
        }
    }
    public findModify(gateContext: IContext): Promise<any> {
        if (!gateContext.session) {
            return Promise.reject(CoreContext.accessDenied());
        } else if (!gateContext.params.page_object) {
            return Promise.reject(
                new ErrorException(-1, 'Not found require param "page_object"'),
            );
        }
        const pageObject = (gateContext.params.page_object || "").toLowerCase();
        const caActions = gateContext.session.userData.ca_actions || [];
        return this.tempTable.dbModifyAction
            .findOne(
                {
                    $and: [
                        { ck_page_object: pageObject },
                        { cn_action: { $in: caActions } },
                    ],
                },
                this.params.disableCheckAccess,
            )
            .then(() =>
                this.tempTable.dbModify
                    .findOne(
                        {
                            ck_id: pageObject,
                        },
                        true,
                    )
                    .then((doc) => {
                        if (doc) {
                            const data = {
                                defaultActionName: "dml",
                                providerName: doc.ck_provider,
                                query: {
                                    extraOutParams: [
                                        {
                                            cv_name: "result",
                                            outType: "DEFAULT",
                                        },
                                        {
                                            cv_name: "cur_result",
                                            outType: "CURSOR",
                                        },
                                    ],
                                    modifyMethod: doc.cv_modify,
                                },
                            };
                            return Promise.resolve(data);
                        }
                        return this.onlineFindModify(
                            gateContext,
                            pageObject,
                            caActions,
                            true,
                        );
                    }),
            )
            .catch(() =>
                Promise.reject(
                    new BreakException({
                        data: ResultStream([
                            {
                                ck_id: "",
                                cv_error: {
                                    22: [],
                                },
                            },
                        ]),
                        type: "success",
                    }),
                ),
            );
    }
    /**
     * Поиск метода модификации и формирование запроса к бд
     * @param gateContext
     */
    public async onlineFindModify(
        gateContext: IContext,
        pageObject: any,
        caActions: any,
        isSave: boolean = false,
    ) {
        const isAccess = await this.tempTable.dbModifyAction.findOne(
            {
                $and: [
                    { ck_page_object: pageObject },
                    { cn_action: { $in: caActions } },
                ],
            },
            true,
        );
        if (isEmpty(isAccess) && !this.params.disableCheckAccess) {
            throw CoreContext.accessDenied();
        }
        const res = await this.dataSource.executeStmt(
            this.modifyFindSql,
            null,
            {
                page_object: pageObject,
            },
        );

        return new Promise((resolve, reject) => {
            const data = [];
            res.stream.on("error", (err) => reject(new Error(err.message)));
            res.stream.on("data", (row) => {
                data.push({
                    ck_id: row.ck_id.toLowerCase(),
                    ck_provider: row.ck_provider,
                    cv_modify: row.cv_modify,
                });
            });
            res.stream.on("end", () => {
                if (data.length) {
                    if (isSave) {
                        this.tempTable.dbQuery.insert(data).then(noop, noop);
                    }
                    const doc = data[0];
                    return resolve({
                        defaultActionName: "dml",
                        providerName: doc.ck_provider,
                        query: {
                            extraOutParams: [
                                {
                                    cv_name: "result",
                                    outType: "DEFAULT",
                                },
                                {
                                    cv_name: "cur_result",
                                    outType: "CURSOR",
                                },
                            ],
                            modifyMethod: doc.cv_modify,
                        },
                    });
                }
                return reject(
                    new BreakException({
                        data: ResultStream([
                            {
                                ck_id: "",
                                cv_error: {
                                    22: [],
                                },
                            },
                        ]),
                        type: "success",
                    }),
                );
            });
        });
    }

    public async findPages(
        gateContext: IContext,
        ckPage: string,
        caActions: any[],
    ): Promise<any> {
        const doc = await this.tempTable.dbPage.findOne(
            {
                $or: [
                    {
                        ck_id: ckPage,
                    },
                    {
                        cv_url: ckPage,
                    },
                ],
            },
            true,
        );
        if (doc) {
            if (isEmpty(doc.cn_action) || !caActions.includes(doc.cn_action)) {
                return Promise.reject(CoreContext.accessDenied());
            }
            return Promise.reject(
                new BreakException({
                    data: ResultStream(doc.json),
                    type: "success",
                }),
            );
        }
        return this.onlineFindPages(gateContext, ckPage, caActions, true);
    }
    public async findQuery(gateContext: IContext, name: string): Promise<any> {
        const caActions =
            (gateContext.session && gateContext.session.userData.ca_actions) ||
            [];
        const pageObject = (gateContext.params.page_object || "").toLowerCase();
        return this.tempTable.dbQuery
            .findOne(
                {
                    ck_id: name,
                },
                true,
            )
            .then(async (doc) => {
                if (doc) {
                    if (doc.cr_access === "po_session") {
                        const access =
                            await this.tempTable.dbQueryAction.findOne(
                                {
                                    $and: [
                                        { ck_page_object: pageObject },
                                        { cn_action: { $in: caActions } },
                                    ],
                                },
                                true,
                            );
                        if (
                            isEmpty(access) &&
                            !this.params.disableCheckAccess
                        ) {
                            throw CoreContext.accessDenied();
                        }
                    }
                    if (doc.cn_action && !caActions.includes(doc.cn_action)) {
                        throw CoreContext.accessDenied();
                    }
                    return {
                        defaultActionName: CoreContext.decodeType(doc),
                        providerName: doc.ck_provider,
                        query: {
                            extraOutParams: [
                                {
                                    cv_name: "result",
                                    outType: "DEFAULT",
                                },
                                {
                                    cv_name: "cur_result",
                                    outType: "CURSOR",
                                },
                                ...(doc.cr_type === "report"
                                    ? [
                                          {
                                              cv_name: "EXTRACT_META_DATA",
                                              outType: "DEFAULT",
                                          },
                                      ]
                                    : []),
                            ],
                            needSession: doc.cr_access !== "free",
                            queryData: doc,
                            queryStr: doc.cc_query,
                        },
                    };
                }
                return this.onlineFindQuery(name, pageObject, caActions, true);
            });
    }

    public onlineFindPages(
        gateContext: IContext,
        ckPage: string,
        caActions: any[],
        isSave: boolean = false,
    ) {
        const self = this;
        return this.dataSource
            .executeStmt(this.pageFindSql, null, {
                ck_page: ckPage,
            })
            .then(
                (res) =>
                    new Promise((resolve, reject) => {
                        const data: Record<string, IPageData> = {};
                        res.stream.on("error", (err) =>
                            reject(new Error(err.message)),
                        );
                        res.stream.on("data", (row) => {
                            try {
                                if (data[row.ck_page]) {
                                    data[row.ck_page].json.push(
                                        JSON.parse(row.json, self.replaceNull),
                                    );
                                } else {
                                    data[row.ck_page] = {
                                        ck_id: row.ck_page,
                                        cn_action:
                                            row.cn_action &&
                                            parseInt(row.cn_action, 10),
                                        cv_name: row.cv_name,
                                        cv_url: row.cv_url,
                                        json:
                                            row.json && row.json !== "{}"
                                                ? [
                                                      JSON.parse(
                                                          row.json,
                                                          self.replaceNull,
                                                      ),
                                                  ]
                                                : [],
                                    };
                                }
                            } catch (e) {
                                logger.error(
                                    `Error parse: ${row.json} ${e.message}`,
                                    e,
                                );
                            }
                        });
                        res.stream.on("end", () => {
                            const page = data[ckPage];
                            if (!page) {
                                if (
                                    gateContext.queryName ===
                                    this.params.pageObjectsQueryName
                                ) {
                                    return reject(
                                        new BreakException({
                                            data: ResultStream([]),
                                            type: "success",
                                        }),
                                    );
                                }
                                return reject(CoreContext.accessDenied());
                            }
                            if (isSave) {
                                this.tempTable.dbPage
                                    .insert(Object.values(data))
                                    .then(noop, noop);
                            }
                            if (
                                isEmpty(page.cn_action) ||
                                !caActions.includes(page.cn_action)
                            ) {
                                return reject(CoreContext.accessDenied());
                            }
                            return reject(
                                new BreakException({
                                    data: ResultStream(page.json),
                                    type: "success",
                                }),
                            );
                        });
                    }),
            );
    }

    public onlineFindQuery(
        name: string,
        pageObject: any,
        caActions,
        isSave: boolean = false,
    ) {
        return this.dataSource
            .executeStmt(this.queryFindSql, null, { ck_query: name })
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
                            if (data.length) {
                                if (isSave) {
                                    this.tempTable.dbQuery
                                        .insert(data)
                                        .then(noop, noop);
                                }
                                const [doc] = data;
                                if (doc.cr_access === "po_session") {
                                    const access =
                                        await this.tempTable.dbQueryAction.findOne(
                                            {
                                                $and: [
                                                    {
                                                        ck_page_object:
                                                            pageObject,
                                                    },
                                                    {
                                                        cn_action: {
                                                            $in: caActions,
                                                        },
                                                    },
                                                ],
                                            },
                                            true,
                                        );
                                    if (
                                        isEmpty(access) &&
                                        !this.params.disableCheckAccess
                                    ) {
                                        return reject(
                                            CoreContext.accessDenied(),
                                        );
                                    }
                                }
                                if (
                                    doc.cn_action &&
                                    !caActions.includes(doc.cn_action)
                                ) {
                                    return reject(CoreContext.accessDenied());
                                }
                                return resolve({
                                    defaultActionName:
                                        CoreContext.decodeType(doc),
                                    providerName: doc.ck_provider,
                                    query: {
                                        extraOutParams: [
                                            {
                                                cv_name: "result",
                                                outType: "DEFAULT",
                                            },
                                            {
                                                cv_name: "cur_result",
                                                outType: "CURSOR",
                                            },
                                            ...(doc.cr_type === "report"
                                                ? [
                                                      {
                                                          cv_name:
                                                              "EXTRACT_META_DATA",
                                                          outType: "DEFAULT",
                                                      },
                                                  ]
                                                : []),
                                        ],
                                        needSession: doc.cr_access !== "free",
                                        queryData: doc,
                                        queryStr: doc.cc_query,
                                    },
                                });
                            }
                            return reject(
                                new ErrorException(ErrorGate.NOTFOUND_QUERY),
                            );
                        });
                    }),
            );
    }

    public async init(reload?: boolean): Promise<any> {
        const self = this;
        if (isEmpty(this.dataSource.pool)) {
            await this.dataSource.createPool();
        }
        return this.initTempDb().then(() =>
            Promise.all(
                this.params.disableCache
                    ? [
                          self.loadQueryAction(),
                          self.loadModifyAction(),
                          self.loadMessage(),
                      ]
                    : [
                          self.loadPages(),
                          self.loadQuery(),
                          self.loadQueryAction(),
                          self.loadModify(),
                          self.loadModifyAction(),
                          self.loadMessage(),
                      ],
            ),
        );
    }

    /**
     * Конечная обработка результата
     * @param gateContext
     * @param result
     * @returns result
     */
    public handleResult(
        gateContext: IContext,
        result: IResult,
    ): Promise<IResult> {
        const self = this;
        if (result.type === "error") {
            return new Promise((resolve, reject) => {
                const data = [];
                result.data.on("error", (err) =>
                    reject(new Error(err.message)),
                );
                result.data.on("data", (row) => data.push(row));
                result.data.on("end", () => {
                    const doc = data[0];
                    let res;
                    if (doc.err_code > 0) {
                        res = {
                            data: ResultStream(data),
                            type: "error",
                        };
                    } else if (doc.err_text) {
                        res = {
                            data: ResultStream([
                                {
                                    ck_id: "",
                                    jt_message: {
                                      error: [[doc.err_text]],
                                    },
                                },
                            ]),
                            type: "success",
                        };
                    } else {
                        res = {
                            data: ResultStream([
                                {
                                    ck_id: "",
                                    cv_error: {
                                        512: [],
                                    },
                                    ...(this.params.debug
                                        ? {
                                              cv_stack_trace:
                                                  doc.err_text ||
                                                  JSON.stringify(doc),
                                          }
                                        : {}),
                                },
                            ]),
                            type: "success",
                        };
                    }
                    return resolve(res as IResult);
                });
            });
        } else if (result.type !== "success") {
            return Promise.resolve(result);
        }
        if (gateContext.connection) {
            const rTransform = new Transform({
                readableObjectMode: true,
                writableObjectMode: true,
                transform(chunk, encode, callback) {
                    if (!isEmpty(chunk.cv_error)) {
                        self.findMessage(Object.keys(chunk.cv_error), {
                            cr_type: "error",
                        }).then((errors) => {
                            if (errors) {
                                gateContext.connection
                                    .rollback()
                                    .then(() => callback(null, chunk))
                                    .catch((err) => {
                                        gateContext.warn(err.message, err);
                                        callback(null, chunk);
                                        return Promise.resolve();
                                    });
                                return;
                            }
                            callback(null, chunk);
                        });
                    } else {
                        callback(null, chunk);
                    }
                },
            });
            result.data = safePipe(result.data, rTransform);
        }
        return Promise.resolve(result);
    }

    public destroy(): Promise<void> {
        return this.dataSource.resetPool();
    }
    /*
     * Поиск сообщения
     * @param {Array} ck_error Список ошибок
     * @param {Object} options Дополнительные параметры
     * @returns {*}
     */
    private findMessage(ckError = [], options = {}) {
        return this.tempTable.dbMessage.count({
            $and: [{ ck_id: { $in: ckError } }, options],
        });
    }

    /**
     * Кэширование всех страниц
     */
    private loadPages() {
        const self = this;
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
                    new Promise<void>((resolve, reject) => {
                        const data: Record<string, IPageData> = {};
                        res.stream.on("error", (err) =>
                            reject(new Error(err.message)),
                        );
                        res.stream.on("data", (row) => {
                            try {
                                if (data[row.ck_page]) {
                                    data[row.ck_page].json.push(
                                        JSON.parse(row.json, self.replaceNull),
                                    );
                                } else {
                                    data[row.ck_page] = {
                                        ck_id: row.ck_page,
                                        cn_action:
                                            row.cn_action &&
                                            parseInt(row.cn_action, 10),
                                        cv_name: row.cv_name,
                                        cv_url: row.cv_url,
                                        json:
                                            row.json && row.json !== "{}"
                                                ? [
                                                      JSON.parse(
                                                          row.json,
                                                          self.replaceNull,
                                                      ),
                                                  ]
                                                : [],
                                    };
                                }
                            } catch (e) {
                                logger.error(
                                    `Error parse: ${row.json} ${e.message}`,
                                    e,
                                );
                            }
                        });
                        res.stream.on("end", () => {
                            this.tempTable.dbPage
                                .insert(Object.values(data))
                                .then(
                                    () => resolve(),
                                    (err) => reject(err),
                                );
                        });
                    }),
            );
    }

    /**
     * Кэширование все запросов
     */
    private loadMessage() {
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
                    new Promise<void>((resolve, reject) => {
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
                                logger.error(
                                    `Error parse: ${row.json} ${e.message}`,
                                    e,
                                );
                            }
                        });
                        res.stream.on("end", () => {
                            this.tempTable.dbMessage.insert(data).then(
                                () => resolve(),
                                (err) => reject(err),
                            );
                        });
                    }),
            );
    }

    /**
     * Кэширование все запросов
     */
    private loadQuery() {
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
                    new Promise<void>((resolve, reject) => {
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
                        res.stream.on("end", () => {
                            this.tempTable.dbQuery.insert(data).then(
                                async () => {
                                    await this.loadSysSetting();
                                    resolve();
                                },
                                (err) => reject(err),
                            );
                        });
                    }),
            );
    }

    /**
     * Кэширование все доступов к запросам
     */
    private loadQueryAction() {
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
                    new Promise<void>((resolve, reject) => {
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
                        res.stream.on("end", () => {
                            this.tempTable.dbQueryAction.insert(data).then(
                                () => resolve(),
                                (err) => reject(err),
                            );
                        });
                    }),
            );
    }

    /**
     * Кэширование все методов модификации
     */
    private loadModify() {
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
                    new Promise<void>((resolve, reject) => {
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
                        res.stream.on("end", () => {
                            this.tempTable.dbModify.insert(data).then(
                                () => resolve(),
                                (err) => reject(err),
                            );
                        });
                    }),
            );
    }

    /**
     * Кэширование все доступов методов модификации
     */
    private loadModifyAction() {
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
                    new Promise<void>((resolve, reject) => {
                        const data = [];
                        res.stream.on("data", (row) => {
                            data.push({
                                ck_id: `${row.ck_id}_${row.cn_action}`,
                                ck_page_object: row.ck_id.toLowerCase(),
                                cn_action:
                                    row.cn_action &&
                                    parseInt(row.cn_action, 10),
                            });
                        });
                        res.stream.on("end", () => {
                            this.tempTable.dbModifyAction.insert(data).then(
                                () => resolve(),
                                (err) => reject(err),
                            );
                        });
                    }),
            );
    }

    private loadSysSetting() {
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
                    new Promise<void>((resolve, reject) => {
                        const data = [];
                        res.stream.on("data", (row) => {
                            data.push(row);
                        });
                        res.stream.on("end", () => {
                            this.tempTable.dbSysSettings.insert(data).then(
                                () => resolve(),
                                (err) => reject(err),
                            );
                        });
                    }),
            );
    }

    /**
     * Удаляем атрибуты которые null
     * @param key
     * @param value
     * @returns {*}
     * @private
     */
    private replaceNull(key: string, value: any) {
        if (value === null) {
            return undefined;
        }
        return value;
    }
    private async initTempDb() {
        const dbPage = await createTempTable<any>(`tt_page_${this.name}`);
        const dbQuery = await createTempTable<any>(`tt_query_${this.name}`);
        const dbQueryAction = await createTempTable<any>(
            `tt_query_action_${this.name}`,
        );
        const dbModify = await createTempTable<any>(`tt_modify_${this.name}`);
        const dbModifyAction = await createTempTable<any>(
            `tt_modify_action_${this.name}`,
        );
        const dbMessage = await createTempTable<any>(`tt_message_${this.name}`);
        const dbSysSettings = await createTempTable<any>(
            `tt_sys_settings_${this.name}`,
        );
        this.tempTable = {
            dbMessage,
            dbModify,
            dbModifyAction,
            dbPage,
            dbQuery,
            dbQueryAction,
            dbSysSettings,
        };
        return Promise.resolve();
    }
}
