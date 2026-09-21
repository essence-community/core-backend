import OracleDB from "@ungate/plugininf/lib/db/oracle";
import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import ErrorGate from "@ungate/plugininf/lib/errors/ErrorGate";
import ICCTParams, {IParamsInfo} from "@ungate/plugininf/lib/ICCTParams";
import IContext from "@ungate/plugininf/lib/IContext";
import {IContextPluginResult} from "@ungate/plugininf/lib/IContextPlugin";
import NullContext from "@ungate/plugininf/lib/NullContext";
import {initParams} from "@ungate/plugininf/lib/util/Util";
import {noop, pick} from "lodash";
import {ISessCtrl} from "@ungate/plugininf/lib/ISessCtrl";
import {DataSource, Repository} from "typeorm";
import {InterfaceModel} from "./entities/InterfaceModel";
import Constants from "@ungate/plugininf/lib/Constants";
import path from "path";
import {TypeOrmLogger} from "@ungate/plugininf/lib/db/TypeOrmLogger";

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
    private dbQuery!: Repository<InterfaceModel>;
    private ds!: DataSource;
    private dataSource: OracleDB;
    private caller: any;
    constructor(name: string, params: ICCTParams, sessCtrl: ISessCtrl) {
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
        this.dataSource = new OracleDB(
            `${this.name}_context`,
            pick(this.params, ...Object.keys(OracleDB.getParamsInfo())) as any,
        );
    }
    /**
     * Инициализация плагина
     * @param [reload]
     * @returns init
     */
    public async init(reload?: boolean): Promise<void> {
        if (!this.ds?.isInitialized) {
            this.ds = new DataSource({
                type: "better-sqlite3",
                enableWAL: true,
                database: path.join(Constants.TEMP_DB, `temp_${this.name}.db`),
                synchronize: true,
                logging: true,
                logger: new TypeOrmLogger(`${this.name}.TempTable`),
                entities: [InterfaceModel],
                prepareDatabase: (db) => {
                    db.pragma("journal_mode = WAL");
                    db.pragma("busy_timeout = 5000");
                },
            });
            await this.ds.initialize();
            this.dbQuery = this.ds.getRepository(InterfaceModel);
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
                undefined,
                undefined,
                undefined,
                {
                    resultSet: true,
                },
            )
            .then((res) => {
                return new Promise<void>((resolve, reject) => {
                    const data: any[] = [];
                    res.stream.on("error", (err) =>
                        reject(new Error(err.message)),
                    );
                    res.stream.on("data", (row) => {
                        data.push({
                            ...row,
                            ck_id: row.ck_id.toLowerCase(),
                        });
                    });
                    res.stream.on("end", async () => {
                        try {
                            await this.dbQuery.clear();
                            if (data.length) {
                                await this.dbQuery.save(
                                    data.map((row) => {
                                        const m = new InterfaceModel();
                                        m.id = row.ck_id;
                                        m.data = row;
                                        return m;
                                    }),
                                );
                            }
                            resolve();
                        } catch (err) {
                            reject(new Error((err as Error).message));
                        }
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
        const res = await this.dataSource.executeStmt(queryFindSql, undefined, {
            ck_query: gateContext.queryName,
        });
        const resultContext = await new Promise((resolve, reject) => {
            const data: any[] = [];
            res.stream.on("error", (err) => reject(new Error(err.message)));
            res.stream.on("data", (row) => {
                data.push({
                    ...row,
                    ck_id: row.ck_id.toLowerCase(),
                });
            });
            res.stream.on("end", () => {
                if (isSave) {
                    this.dbQuery
                        .save(
                            data.map((row) => {
                                const m = new InterfaceModel();
                                m.id = row.ck_id;
                                m.data = row;
                                return m;
                            }),
                        )
                        .then(noop, noop);
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
        return resultContext as IContextPluginResult;
    }

    /**
     * Запросы инициализируем из кэша
     * @param gateContext
     * @returns init context
     */
    private async offlineInitContext(
        gateContext: IContext,
    ): Promise<IContextPluginResult> {
        const found = await this.dbQuery.findOne({
            where: {id: gateContext.queryName},
        });
        const row = found?.data;
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
                    {cv_name: "result", outType: "DEFAULT"},
                    {cv_name: "cur_result", outType: "CURSOR"},
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
