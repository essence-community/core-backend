import PostgresDB from "@ungate/plugininf/lib/db/postgres";
import BreakException from "@ungate/plugininf/lib/errors/BreakException";
import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import IContext from "@ungate/plugininf/lib/IContext";
import { IContextPluginResult } from "@ungate/plugininf/lib/IContextPlugin";
import IResult from "@ungate/plugininf/lib/IResult";
import ResultStream from "@ungate/plugininf/lib/stream/ResultStream";
import {
    filterFilesData,
    sortFilesData,
} from "@ungate/plugininf/lib/util/Util";
import CoreContext, { ICoreParams } from "./CoreContext";
import ICoreController from "./ICoreController";
import OfflineController from "./OfflineController";

export default class OnlineController implements ICoreController {
    public params: ICoreParams;
    public dataSource: PostgresDB;
    public name: string;
    private controller: OfflineController;
    private sysSettings =
        "select s.ck_id, s.cv_value, s.cv_description from s_mt.t_sys_setting s";
    constructor(name: string, dataSource: PostgresDB, params: ICoreParams) {
        this.dataSource = dataSource;
        this.params = params;
        this.name = name;
        this.controller = new OfflineController(
            this.name,
            this.dataSource,
            this.params,
        );
    }
    public async getSetting(gateContext: IContext): Promise<any> {
        const { js } = gateContext.params;
        return new Promise((resolve, reject) => {
            this.dataSource
                .executeStmt(
                    this.sysSettings,
                    null,
                    {},
                    {},
                    {
                        resultSet: true,
                    },
                )
                .then((res) => {
                    const data = [
                        {
                            ck_id: "core_gate_version",
                            cv_description: "Версия шлюза",
                            cv_value: gateContext.gateVersion,
                        },
                    ];
                    res.stream.on("data", (row) => {
                        data.push(row);
                    });
                    res.stream.on("end", () => {
                        if (js) {
                            const str =
                                "window.SETTINGS = " +
                                JSON.stringify(data) +
                                ";";
                            gateContext.response.writeHead(200, {
                                "content-length": Buffer.byteLength(str),
                                "content-type": "application/javascript",
                            });
                            gateContext.response.end(str);
                            reject(
                                new BreakException({
                                    data: ResultStream(
                                        data
                                            .sort(sortFilesData(gateContext))
                                            .filter(
                                                filterFilesData(gateContext),
                                            ),
                                    ),
                                    type: "break",
                                }),
                            );
                        } else {
                            reject(
                                new BreakException({
                                    data: ResultStream(
                                        data
                                            .sort(sortFilesData(gateContext))
                                            .filter(
                                                filterFilesData(gateContext),
                                            ),
                                    ),
                                    type: "success",
                                }),
                            );
                        }
                    });
                });
        });
    }
    public handleResult(
        gateContext: IContext,
        result: IResult,
    ): Promise<IResult> {
        return this.controller.handleResult(gateContext, result);
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
        const caActions = gateContext.session.data.ca_actions || [];
        return this.controller.onlineFindModify(
            gateContext,
            pageObject,
            caActions,
        );
    }
    public findPages(
        gateContext: IContext,
        ckPage: string,
        caActions: any[],
        version: "1" | "2" | "3",
    ): Promise<any> {
        return this.controller.onlineFindPages(
            gateContext,
            ckPage,
            caActions,
            version,
        );
    }
    public findQuery(
        gateContext: IContext,
        name: string,
    ): Promise<IContextPluginResult> {
        const caActions =
            (gateContext.session && gateContext.session.data.ca_actions) || [];
        const pageObject = (gateContext.params.page_object || "").toLowerCase();
        return this.controller.onlineFindQuery(name, pageObject, caActions);
    }

    public init(reload?: boolean): Promise<void> {
        return this.controller.init(reload);
    }
    public destroy(): Promise<void> {
        return this.controller.destroy();
    }
}
