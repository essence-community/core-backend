import ILocalDB from "@ungate/plugininf/lib/db/local/ILocalDB";
import PostgresDB from "@ungate/plugininf/lib/db/postgres";
import BreakException from "@ungate/plugininf/lib/errors/BreakException";
import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import ErrorGate from "@ungate/plugininf/lib/errors/ErrorGate";
import ICCTParams, { IParamsInfo } from "@ungate/plugininf/lib/ICCTParams";
import IContext from "@ungate/plugininf/lib/IContext";
import { IContextPluginResult } from "@ungate/plugininf/lib/IContextPlugin";
import IGlobalObject from "@ungate/plugininf/lib/IGlobalObject";
import IResult from "@ungate/plugininf/lib/IResult";
import ISession from "@ungate/plugininf/lib/ISession";
import Logger from "@ungate/plugininf/lib/Logger";
import NullContext from "@ungate/plugininf/lib/NullContext";
import ResultStream from "@ungate/plugininf/lib/stream/ResultStream";
import { initParams } from "@ungate/plugininf/lib/util/Util";
import { isObject } from "lodash";
import ICoreController from "./ICoreController";
import OfflineController from "./OfflineController";
import OnlineController from "./OnlineController";
const logger = Logger.getLogger("CoreContext");
const Mask = (global as IGlobalObject).maskgate;
const createTempTable = (global as IGlobalObject).createTempTable;

export interface ICoreParams extends ICCTParams {
    debug: boolean;
    defaultDepartmentQueryName: string;
    disableCache: boolean;
    disableCheckAccess: boolean;
    getSysSettings: string;
    metaResetQuery: string;
    modifyQueryName: string;
    pageMetaQueryName: string;
    pageMetaQueryNameNew: string;
    pageObjectsQueryName: string;
    versionApi: Record<string, "1" | "2" | "3">;
}

export default class CoreContext extends NullContext {
    public static getParamsInfo(): IParamsInfo {
        return {
            ...NullContext.getParamsInfo(),
            debug: {
                defaultValue: false,
                name: "Режим отладки",
                type: "boolean",
            },
            defaultDepartmentQueryName: {
                defaultValue: "ModifyDefaultDepartment",
                name: "Установка подразделения по умолчанию",
                type: "string",
            },
            disableCache: {
                defaultValue: false,
                name: "Признак отключения кэша",
                type: "boolean",
            },
            disableCheckAccess: {
                defaultValue: false,
                name: "Отключаем проверку доступа",
                type: "boolean",
            },
            getSysSettings: {
                defaultValue: "MTGetSysSettings",
                name: "Наименование запроса настроек",
                type: "string",
            },
            metaResetQuery: {
                defaultValue: "MetaResetCache",
                name: "Наименование запроса сброса кэша",
                type: "string",
            },
            modifyQueryName: {
                defaultValue: "Modify",
                name: "Наименование запроса на модификацию",
                type: "string",
            },
            pageMetaQueryName: {
                defaultValue: "GetMetamodelPage",
                name:
                    "Наименование запроса на возращение сформированой страницы",
                type: "string",
            },
            pageMetaQueryNameNew: {
                defaultValue: "GetMetamodelPage2.0",
                name:
                    "Наименование запроса на возращение сформированой страницы 2.0",
                type: "string",
            },
            pageObjectsQueryName: {
                defaultValue: "MTGetPageObjects",
                name: "Наименование запроса на возращение объектов страницы",
                type: "string",
            },
            ...PostgresDB.getParamsInfo(),
        };
    }

    public static accessDenied(): BreakException {
        return new BreakException({
            data: ResultStream([
                {
                    ck_id: "",
                    cv_error: {
                        513: [],
                    },
                },
            ]),
            type: "success",
        });
    }

    public static decodeType(doc: any): string {
        switch (doc.cr_type) {
            case "select":
                return "sql";
            case "dml":
                return "dml";
            case "auth":
                return "auth";
            case "select_streaming":
                return "sql";
            case "dml_streaming":
                return "dml";
            case "file_download":
                return "file";
            case "file_upload":
                return "upload";
            case "report":
                return "sql";
            default:
                return "sql";
        }
    }
    public params: ICoreParams;
    private controller: ICoreController;
    private dataSource: PostgresDB;
    private dbUsers: ILocalDB;
    constructor(name: string, params: ICCTParams) {
        super(name, params);
        this.params = {
            ...this.params,
            ...initParams(CoreContext.getParamsInfo(), params),
        };
        this.dataSource = new PostgresDB(`${this.name}_context`, {
            connectString: this.params.connectString,
            partRows: this.params.partRows,
            poolMax: this.params.poolMax,
            queryTimeout: this.params.queryTimeout,
        });
        this.params.modifyQueryName = this.params.modifyQueryName.toLowerCase();
        this.params.pageMetaQueryName = this.params.pageMetaQueryName.toLowerCase();
        this.params.pageMetaQueryNameNew = this.params.pageMetaQueryNameNew.toLowerCase();
        this.params.defaultDepartmentQueryName = this.params.defaultDepartmentQueryName.toLowerCase();
        this.params.metaResetQuery = this.params.metaResetQuery.toLowerCase();
        this.params.pageObjectsQueryName = this.params.pageObjectsQueryName.toLowerCase();
        this.params.getSysSettings = this.params.getSysSettings.toLowerCase();
        this.params.versionApi = {
            [this.params.pageMetaQueryName]: "1",
            [this.params.pageObjectsQueryName]: "2",
            [this.params.pageMetaQueryNameNew]: "3",
        };
        if (this.params.disableCache) {
            this.controller = new OnlineController(
                name,
                this.dataSource,
                this.params as ICoreParams,
            );
        } else {
            this.controller = new OfflineController(
                name,
                this.dataSource,
                this.params as ICoreParams,
            );
        }
        Mask.on("beforechange", this.beforeMask, this);
    }

    public async init(reload?: boolean): Promise<void> {
        this.dbUsers = await createTempTable("tt_users");
        return this.controller.init(reload);
    }
    public initContext(gateContext: IContext): Promise<IContextPluginResult> {
        if (!gateContext.queryName) {
            // Проверяем присутствие обязательных параметров
            throw new ErrorException(ErrorGate.REQUIRED_PARAM);
        }
        const name = gateContext.queryName;
        switch (name) {
            case this.params.getSysSettings:
                return this.controller.getSetting(gateContext);
            case this.params.modifyQueryName:
                return this.controller.findModify(gateContext);
            case this.params.pageMetaQueryNameNew:
            case this.params.pageObjectsQueryName:
            case this.params.pageMetaQueryName:
                if (!gateContext.session) {
                    return Promise.reject(
                        new ErrorException(ErrorGate.REQUIRED_AUTH),
                    );
                }
                if (!gateContext.params.json) {
                    return Promise.reject(CoreContext.accessDenied());
                }
                const version = this.params.versionApi[name];
                const json = JSON.parse(gateContext.params.json || "{}");
                const caActions = gateContext.session.data.ca_actions || [];
                if (version !== "2" && (!json.filter || !json.filter.ck_page)) {
                    return Promise.reject(CoreContext.accessDenied());
                } else if (
                    version === "2" &&
                    (!json.filter || !json.filter.ck_parent)
                ) {
                    return Promise.reject(
                        new BreakException({
                            data: ResultStream([]),
                            type: "success",
                        }),
                    );
                }
                return this.controller.findPages(
                    gateContext,
                    version === "2"
                        ? json.filter.ck_parent
                        : json.filter.ck_page,
                    caActions,
                    version,
                );
            case this.params.defaultDepartmentQueryName:
                return this.modifyDefaultDepartment(gateContext);
            case this.params.metaResetQuery: {
                // Перезагружаем мета информацию
                if (!gateContext.session) {
                    throw new ErrorException(ErrorGate.REQUIRED_AUTH);
                }
                return new Promise((resolve, reject) => {
                    Mask.mask().then(() =>
                        this.init(true).then(
                            () =>
                                Mask.unmask(gateContext.session).then(() =>
                                    reject(
                                        new BreakException({
                                            data: ResultStream([
                                                {
                                                    ck_id: "",
                                                    cv_error: null,
                                                },
                                            ]),
                                            type: "success",
                                        }),
                                    ),
                                ),
                            (err) =>
                                Mask.unmask(gateContext.session).then(() =>
                                    reject(err),
                                ),
                        ),
                    );
                });
            }
            default:
                return this.controller.findQuery(gateContext, name);
        }
    }

    /**
     * Смена департамента по умолчанию
     * @param gateContext
     * @returns {*}
     */
    public async modifyDefaultDepartment(gateContext: IContext): Promise<any> {
        if (!gateContext.session) {
            return Promise.reject(new ErrorException(ErrorGate.REQUIRED_AUTH));
        }
        if (!gateContext.params.json) {
            return Promise.reject(CoreContext.accessDenied());
        }
        const json = JSON.parse(gateContext.params.json);
        return this.dbUsers
            .update(
                {
                    ck_id: `${gateContext.session.ck_id}:${gateContext.session.ck_d_provider}`,
                },
                {
                    $set: {
                        "data.ck_dept": json.data.ck_dept,
                        "data.cv_timezone": json.data.cv_timezone || "+03:00",
                    },
                },
            )
            .then(() =>
                Promise.reject(
                    new BreakException({
                        data: ResultStream([
                            {
                                ck_id: json.data.ck_dept,
                                cv_error: null,
                            },
                        ]),
                        type: "success",
                    }),
                ),
            );
    }

    public handleResult(
        gateContext: IContext,
        result: IResult,
    ): Promise<IResult> {
        return this.controller.handleResult(gateContext, result);
    }

    public async maskResult(): Promise<IResult> {
        const result = {
            data: ResultStream([
                {
                    ck_id: "",
                    cv_error: {
                        block: [
                            "Проводятся технические работы. Пожалуйста, подождите",
                        ],
                    },
                },
            ]),
            type: "success",
        };
        return result as IResult;
    }

    public destroy(): Promise<void> {
        Mask.un("beforechange", this.beforeMask, this);
        return this.controller.destroy();
    }

    private beforeMask(newFlag: boolean, oldFlag: boolean, session: ISession) {
        logger.debug(
            `Check mask new: ${newFlag} old: ${oldFlag} session: ${JSON.stringify(
                session,
            )} `,
        );
        return this.dataSource.open().then((conn) =>
            conn
                .executeStmt(
                    "select pkg_json_semaphore.f_modify_semaphore(:ck_id,\n" +
                        " :session,\n" +
                        " :json) as result;",
                    {
                        ...session,
                        json: JSON.stringify({
                            data: { ck_id: "GUI_blocked" },
                            service: { cv_action: newFlag ? "inc" : "dec" },
                        }),
                    },
                    {
                        result: null,
                    },
                    {
                        autoCommit: true,
                    },
                )
                .then(
                    (docs) =>
                        new Promise((resolv, reject) => {
                            const rows = [];
                            docs.stream.on("data", (chunk) => rows.push(chunk));
                            docs.stream.on("error", (err) => reject(err));
                            docs.stream.on("end", () => {
                                if (rows.length && rows[0].result) {
                                    try {
                                        const result = isObject(rows[0].result)
                                            ? rows[0].result
                                            : JSON.parse(rows[0].result);
                                        if (result.cv_error) {
                                            return reject(
                                                new BreakException({
                                                    data: ResultStream([
                                                        result,
                                                    ]),
                                                    type: "success",
                                                }),
                                            );
                                        }
                                    } catch (e) {
                                        return Promise.reject(e);
                                    }
                                    return resolv();
                                }
                                return resolv();
                            });
                        }),
                    (err) => {
                        logger.error(err);
                        return Promise.reject(err);
                    },
                ),
        );
    }
}
