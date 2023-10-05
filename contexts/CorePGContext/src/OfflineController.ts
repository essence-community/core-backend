import PostgresDB from "@ungate/plugininf/lib/db/postgres";
import BreakException from "@ungate/plugininf/lib/errors/BreakException";
import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import ErrorGate from "@ungate/plugininf/lib/errors/ErrorGate";
import IContext from "@ungate/plugininf/lib/IContext";
import IResult from "@ungate/plugininf/lib/IResult";
import ResultStream from "@ungate/plugininf/lib/stream/ResultStream";
import {
    filterFilesData,
    isEmpty,
    sortFilesData,
} from "@ungate/plugininf/lib/util/Util";
import CoreContext from "./CoreContext";
import { ICoreParams } from "./CoreContext";
import ICoreController from "./ICoreController";
import OnlineController from "./OnlineController";
import { TempTable } from "./TempTable";
import { IPropertyContext } from "./ICoreController";
import { IRufusLogger } from "rufus";
import { FIND_SYMBOL } from "./Util";

export default class OfflineController implements ICoreController {
    public params: ICoreParams;
    public dataSource: PostgresDB;
    public tempTable: TempTable;
    public name: string;
    public logger: IRufusLogger;
    public controller: OnlineController;

    constructor(props: IPropertyContext) {
        const { dataSource, params, logger, name, tempTable } = props;
        this.dataSource = dataSource;
        this.params = params;
        this.name = name;
        this.logger = logger;
        this.tempTable = tempTable;
        this.controller = new OnlineController(props);
    }
    public async getSetting(gateContext: IContext): Promise<any> {
        const { js } = gateContext.params;
        const json = JSON.parse(gateContext.params.json || "{}");
        const ckId = json.filter?.ck_id;
        if (ckId) {
            await this.tempTable.loadSysSetting();
        }
        const data = await this.tempTable.dbSysSettings.find({});
        data.push({
            ck_id: "core_gate_version",
            cv_description: "Версия шлюза",
            cv_value: gateContext.gateVersion,
        });
        Object.entries(gateContext.request.headers).forEach(([key, value]) => {
            const keyUpper = key.toLocaleUpperCase();
            if (keyUpper.startsWith(this.params.headerPrefixSetting)) {
                data.push({
                    ck_id: `g_sys_header_${key.substring(this.params.headerPrefixSetting.length).replace(FIND_SYMBOL, "_")}`,
                    cv_description: `Header ${key}`,
                    cv_value: Array.isArray(value) ? JSON.stringify(value) : value,
                });
            }
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
    public async findObjectPage(gateContext: IContext): Promise<any> {
        const json = JSON.parse(gateContext.params.json || "{}");
        const ckPageObject = json.filter?.ck_page_object;
        const caActions = [
            this.params.anonymousAction,
            ...(gateContext.session?.userData.ca_actions || []),
        ];
        const row = await this.tempTable.dbObject.findOne(
            {
                ck_id: ckPageObject,
            },
            true,
        );
        if (!row) {
            return this.controller.findObjectPage(gateContext);
        }
        if (isEmpty(row.cn_action) || !caActions.includes(row.cn_action)) {
            throw gateContext.session
                ? CoreContext.accessDenied()
                : new ErrorException(ErrorGate.REQUIRED_AUTH);
        }
        throw new BreakException({
            data: ResultStream(row.json),
            type: "success",
        });
    }
    public findModify(gateContext: IContext): Promise<any> {
        if (!gateContext.session) {
            return Promise.reject(new ErrorException(ErrorGate.REQUIRED_AUTH));
        } else if (!gateContext.params.page_object) {
            return Promise.reject(
                new ErrorException(-1, 'Not found require param "page_object"'),
            );
        }
        const pageObject = (gateContext.params.page_object || "").toLowerCase();
        const caActions = [
            this.params.anonymousAction,
            ...(gateContext.session?.userData.ca_actions || []),
        ];
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
                        return this.controller.findModify(gateContext);
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
    public async findPages(
        gateContext: IContext,
        ckPage: string,
        caActions: any[],
        version: "1" | "2" | "3",
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
                throw gateContext.session
                    ? CoreContext.accessDenied()
                    : new ErrorException(ErrorGate.REQUIRED_AUTH);
            }
            if (version === "3") {
                throw new BreakException({
                    data: ResultStream([
                        {
                            children: doc.children,
                            global_value: doc.global_value,
                            route: doc.route,
                        },
                    ]),
                    type: "success",
                });
            }

            throw new BreakException({
                data: ResultStream(doc.children),
                type: "success",
            });
        }
        return this.controller.findPages(
            gateContext,
            ckPage,
            caActions,
            version,
        );
    }

    public async findQuery(gateContext: IContext, name: string): Promise<any> {
        const caActions = [
            this.params.anonymousAction,
            ...(gateContext.session?.userData.ca_actions || []),
        ];
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
                    if (doc.cr_access !== "free" && !gateContext.session) {
                        throw new ErrorException(ErrorGate.REQUIRED_AUTH);
                    }
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
                        metaData: this.params.disableCache ? {} : {
                            cache: doc.cr_cache,
                            cache_key_param: doc.cv_cache_key_param,
                        },
                    };
                }
                return this.controller.findQuery(gateContext, name);
            });
    }

    public async init(reload?: boolean): Promise<any> {
        const self = this;
        if (isEmpty(this.dataSource.pool)) {
            await this.dataSource.createPool();
        }
        return this.tempTable
            .initTempDb()
            .then(() =>
                Promise.all([
                    self.tempTable.loadPages(),
                    self.tempTable.loadQuery(),
                    self.tempTable.loadQueryCache(),
                    self.tempTable.loadQueryAction(),
                    self.tempTable.loadModify(),
                    self.tempTable.loadModifyAction(),
                    self.tempTable.loadMessage(),
                    self.tempTable.loadSysSetting(),
                ]),
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
        return this.controller.handleResult(gateContext, result);
    }

    public destroy(): Promise<void> {
        return this.controller.destroy();
    }
}
