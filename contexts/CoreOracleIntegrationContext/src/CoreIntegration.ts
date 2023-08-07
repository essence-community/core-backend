import ILocalDB from "@ungate/plugininf/lib/db/local/ILocalDB";
import OracleDB from "@ungate/plugininf/lib/db/oracle";
import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import ErrorGate from "@ungate/plugininf/lib/errors/ErrorGate";
import ICCTParams, { IParamsInfo } from "@ungate/plugininf/lib/ICCTParams";
import IContext from "@ungate/plugininf/lib/IContext";
import { IContextPluginResult } from "@ungate/plugininf/lib/IContextPlugin";
import IGlobalObject from "@ungate/plugininf/lib/IGlobalObject";
import NullContext from "@ungate/plugininf/lib/NullContext";
import { initParams } from "@ungate/plugininf/lib/util/Util";
import { noop, pick } from "lodash";
import { ISessCtrl } from "@ungate/plugininf/lib/ISessCtrl";
const createTempTable = (global as any as IGlobalObject).createTempTable;

const querySql = "select q.* from t_interface q";
const queryFindSql =
    "select q.* from t_interface q where upper(q.ck_id) = upper(:ck_query)";

export default class CoreOracleIntegration extends NullContext {
    public static getParamsInfo(): IParamsInfo {
        return {
            ...OracleDB.getParamsInfo(),
            disableCache: {
                defaultValue: false,
                name: "Признак отключения кэша",
                type: "boolean",
            },
        };
    }
    private dbQuery: ILocalDB<Record<string, any>>;
    private dataSource: OracleDB;
    private caller: any;
    constructor(
        name: string,
        params: ICCTParams,
        sessCtrl: ISessCtrl,
    ) {
        super(name, params, sessCtrl);
        this.params = initParams(
            CoreOracleIntegration.getParamsInfo(),
            this.params,
        );
        if (this.params.disableCache) {
            this.caller = this.onlineInitContext;
        } else {
            this.caller = this.offlineInitContext;
        }
        this.dataSource = new OracleDB(`${this.name}_context`, pick(this.params, ...Object.keys(OracleDB.getParamsInfo())) as any);
    }
    /**
     * Инициализация плагина
     * @param [reload]
     * @returns init
     */
    public async init(reload?: boolean): Promise<void> {
        if (!this.dbQuery) {
            this.dbQuery = await createTempTable(
                `tt_core_integration_${this.name}`,
            );
        }
        if (this.dataSource.pool) {
            await this.dataSource.resetPool();
        }
        await this.dataSource.createPool();
        return this.loadQuery();
    }
    /**
     * Инициализация контекста вызова
     * @param gateContext
     * @returns context
     */
    public initContext(gateContext: IContext): Promise<IContextPluginResult> {
        return this.caller.call(this, gateContext);
    }
    /**
     * Уничтожение плагина
     * @returns destroy
     */
    public async destroy(): Promise<void> {
        if (this.dataSource.pool) {
            await this.dataSource.resetPool();
        }
    }
    /**
     * Кэширование все запросов
     * @param force
     */
    private loadQuery(): Promise<any> {
        return this.dataSource
            .executeStmt(
                querySql,
                null,
                {},
                {},
                {
                    resultSet: true,
                },
            )
            .then((res) => {
                return new Promise<void>((resolve, reject) => {
                    const data = [];
                    res.stream.on("error", (err) =>
                        reject(new Error(err.message)),
                    );
                    res.stream.on("data", (row) => {
                        data.push({
                            ...row,
                            ck_id: row.ck_id.toLowerCase(),
                        });
                    });
                    res.stream.on("end", () => {
                        this.dbQuery.insert(data).then(
                            () => resolve(),
                            (err) => reject(new Error(err.message)),
                        );
                    });
                });
            });
    }
    /**
     * Запросы инициализируем из базы
     * @param gateContext
     * @returns init context
     */
    private async onlineInitContext(
        gateContext: IContext,
        isSave: boolean = false,
    ): Promise<IContextPluginResult> {
        const res = await this.dataSource.executeStmt(queryFindSql, null, {
            ck_query: gateContext.queryName,
        });
        const resultContext = await new Promise((resolve, reject) => {
            const data = [];
            res.stream.on("error", (err) => reject(new Error(err.message)));
            res.stream.on("data", (row) => {
                data.push({
                    ...row,
                    ck_id: row.ck_id.toLowerCase(),
                });
            });
            res.stream.on("end", () => {
                if (isSave) {
                    this.dbQuery.insert(data).then(noop, noop);
                }
                if (data.length) {
                    const row = data[0];
                    const result: IContextPluginResult = {
                        defaultActionName: this.getAction(row.ck_d_interface),
                        metaData: {
                            in_params: {
                                ...gateContext.params,
                                json: gateContext.params.json
                                    ? JSON.parse(gateContext.params.json)
                                    : undefined,
                            },
                        },
                        providerName: row.ck_d_provider,
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
                            needSession: row.ck_d_interface !== "auth",
                            queryData: row,
                            queryStr:
                                "select i.*\n" +
                                "  from s_it.t_interface i\n" +
                                " start with upper(i.ck_id) = upper(:ck_query)\n" +
                                "connect by i.ck_id = prior i.ck_parent\n" +
                                " order by level desc",
                        },
                    };
                    if (
                        row.ck_d_interface !== "auth" &&
                        gateContext.actionName !== "auth" &&
                        !this.checkAccess(gateContext, row.cn_action)
                    ) {
                        return reject(
                            new ErrorException(ErrorGate.AUTH_DENIED),
                        );
                    }
                    return resolve(result);
                }
                return reject(new ErrorException(ErrorGate.NOTFOUND_QUERY));
            });
        });
        return resultContext;
    }

    /**
     * Запросы инициализируем из кэша
     * @param gateContext
     * @returns init context
     */
    private async offlineInitContext(
        gateContext: IContext,
    ): Promise<IContextPluginResult> {
        const row = await this.dbQuery.findOne(
            {
                ck_id: gateContext.queryName,
            },
            true,
        );
        if (!row) {
            return this.onlineInitContext(gateContext, true);
        }
        const result: IContextPluginResult = {
            defaultActionName: this.getAction(row.ck_d_interface),
            metaData: {
                in_params: {
                    ...gateContext.params,
                    json: gateContext.params.json
                        ? JSON.parse(gateContext.params.json)
                        : undefined,
                },
            },
            providerName: row.ck_d_provider,
            query: {
                extraOutParams: [
                    { cv_name: "result", outType: "DEFAULT" },
                    { cv_name: "cur_result", outType: "CURSOR" },
                ],
                needSession: row.ck_d_interface !== "auth",
                queryData: row,
                queryStr:
                    row.ck_d_interface === "auth"
                        ? row.cc_request
                        : "select i.*\n" +
                          "  from s_it.t_interface i\n" +
                          " start with upper(i.ck_id) = upper(:ck_query)\n" +
                          "connect by i.ck_id = prior i.ck_parent\n" +
                          " order by level desc",
            },
        };
        if (
            row.ck_d_interface !== "auth" &&
            gateContext.actionName !== "auth" &&
            !this.checkAccess(gateContext, row.cn_action)
        ) {
            throw new ErrorException(ErrorGate.AUTH_DENIED);
        }
        return result;
    }
    /**
     * Проверка доступа
     * @returns {boolean}
     */
    private checkAccess(gateContext: IContext, cnAction: number) {
        if (
            gateContext.session &&
            gateContext.session.userData.ca_actions.includes(cnAction)
        ) {
            return true;
        }
        return false;
    }
    /**
     * Определение экшена
     * @param name
     * @returns
     */
    private getAction(name: string) {
        switch (name) {
            case "select":
            case "streamselect":
                return "sql";
            case "dml":
            case "streamdml":
                return "dml";
            case "auth":
                return "auth";
            case "file":
            case "file_download":
                return "file";
            case "upload":
            case "file_upload":
                return "upload";
            default:
                return "sql";
        }
    }
}
