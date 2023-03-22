import IOptions from "@ungate/plugininf/lib/db/IOptions";
import PostgresDB from "@ungate/plugininf/lib/db/postgres/index";
import { IPostgresDBConfig } from "@ungate/plugininf/lib/db/postgres/PostgresDB";
import BreakException from "@ungate/plugininf/lib/errors/BreakException";
import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import ErrorGate from "@ungate/plugininf/lib/errors/ErrorGate";
import ICCTParams, { IParamsInfo } from "@ungate/plugininf/lib/ICCTParams";
import IContext from "@ungate/plugininf/lib/IContext";
import IObjectParam from "@ungate/plugininf/lib/IObjectParam";
import IQuery, { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import { IResultProvider } from "@ungate/plugininf/lib/IResult";
import NullProvider, {
    IParamsProvider,
} from "@ungate/plugininf/lib/NullProvider";
import ResultStream from "@ungate/plugininf/lib/stream/ResultStream";
import { initParams } from "@ungate/plugininf/lib/util/Util";
import { isEmpty } from "@ungate/plugininf/lib/util/Util";
import { isObject, noop, pick } from "lodash";
import * as request from "request";
import * as URL from "url";
import { ISessCtrl } from "@ungate/plugininf/lib/ISessCtrl";

interface IResultSequence {
    res?: IResultProvider;
    row?: any;
    params: IObjectParam;
}

interface IIntegrationParams extends IPostgresDBConfig, IParamsProvider {
    proxy?: string;
    timeout?: number;
}

export default class CoreIntegration extends NullProvider {
    public static getParamsInfo(): IParamsInfo {
        return {
            ...PostgresDB.getParamsInfo(),
            proxy: {
                name: "Прокси сервер",
                type: "string",
            },
            timeout: {
                name: "Время ожидания внешнего сервиса",
                type: "integer",
            },
        };
    }
    public dataSource: PostgresDB;
    public params: IIntegrationParams;
    constructor(
        name: string,
        params: ICCTParams,
        sessCtrl: ISessCtrl,
    ) {
        super(name, params, sessCtrl);
        this.params = initParams(CoreIntegration.getParamsInfo(), this.params);
        this.dataSource = new PostgresDB(`${this.name}_provider`, pick(this.params, ...Object.keys(PostgresDB.getParamsInfo())) as any);
    }

    public async initContext(
        context: IContext,
        preQuery: IQuery,
    ): Promise<IQuery> {
        const query = await super.initContext(context, preQuery);
        const conn = await this.dataSource.getConnection();
        try {
            context.connection = conn;
            if (query.queryStr) {
                query.extraOutParams.push({
                    cv_name: "result",
                    outType: "DEFAULT",
                });
                query.extraOutParams.push({
                    cv_name: "cur_result",
                    outType: "CURSOR",
                });
                const inParam: any = {};
                if (context.session) {
                    inParam.sess_session = context.session.session;
                    Object.keys(context.session.userData).forEach((key) => {
                        inParam[`sess_${key}`] = context.session.userData[key];
                    });
                }
                return conn
                    .executeStmt(
                        query.queryStr,
                        {
                            ck_query: context.queryName,
                            ...context.params,
                            ...inParam,
                        },
                        {
                            cur_result: "",
                            result: "",
                        },
                    )
                    .then(
                        (res) =>
                            new Promise((resolve, reject) => {
                                const data = [];
                                res.stream.on("error", (err) => reject(err));
                                res.stream.on("data", (chunk) =>
                                    data.push(chunk),
                                );
                                res.stream.on("end", () => {
                                    if (data.length) {
                                        const doc = data[0];
                                        query.queryData.querys = data;
                                        query.queryStr = doc.cc_request;
                                        return resolve(query);
                                    }
                                    return reject(
                                        new ErrorException(
                                            ErrorGate.NOTFOUND_QUERY,
                                        ),
                                    );
                                });
                            }),
                    );
            }
            return conn
                .executeStmt(
                    "with recursive ot_interface as (\n" +
                        "select\n" +
                        "    i.ck_id,\n" +
                        "    i.ck_d_interface,\n" +
                        "    i.ck_d_provider,\n" +
                        "    i.cc_request,\n" +
                        "    i.cc_response,\n" +
                        "    i.cn_action,\n" +
                        "    i.cv_url_request,\n" +
                        "    i.cv_url_response,\n" +
                        "    i.cv_description,\n" +
                        "    1 as lvl,\n" +
                        "    i.ck_parent\n" +
                        "from\n" +
                        "    s_it.t_interface i\n" +
                        "where\n" +
                        "    lower(i.ck_id) = lower(:ck_query)\n" +
                        "union all\n" +
                        "select\n" +
                        "    i.ck_id,\n" +
                        "    i.ck_d_interface,\n" +
                        "    i.ck_d_provider,\n" +
                        "    i.cc_request,\n" +
                        "    i.cc_response,\n" +
                        "    i.cn_action,\n" +
                        "    i.cv_url_request,\n" +
                        "    i.cv_url_response,\n" +
                        "    i.cv_description,\n" +
                        "    oi.lvl + 1 as lvl,\n" +
                        "    i.ck_parent\n" +
                        "from\n" +
                        "    s_it.t_interface i\n" +
                        "join ot_interface oi on\n" +
                        "    oi.ck_id = i.ck_parent )\n" +
                        "select\n" +
                        "    ck_id,\n" +
                        "    ck_d_interface,\n" +
                        "    ck_d_provider,\n" +
                        "    cc_request,\n" +
                        "    cc_response,\n" +
                        "    cn_action,\n" +
                        "    cv_url_request,\n" +
                        "    cv_url_response,\n" +
                        "    cv_description,\n" +
                        "    ck_parent\n" +
                        "from\n" +
                        "    ot_interface\n" +
                        "order by\n" +
                        "    lvl desc\n",
                    {
                        ck_query: context.queryName,
                    },
                    {
                        cur_result: "",
                        result: "",
                    },
                )
                .then(
                    (res) =>
                        new Promise((resolve, reject) => {
                            const data = [];
                            res.stream.on("error", (err) => reject(err));
                            res.stream.on("data", (chunk) => data.push(chunk));
                            res.stream.on("end", () => {
                                if (data.length) {
                                    const [doc] = data;
                                    query.queryData.querys = data;
                                    query.queryStr = doc.cc_request;
                                    return resolve(query);
                                }
                                return reject(
                                    new ErrorException(
                                        ErrorGate.NOTFOUND_QUERY,
                                    ),
                                );
                            });
                        }),
                );
        } catch (err) {
            await conn.rollbackAndRelease().then(() => Promise.reject(err));
        }
        return query;
    }

    public processSql(
        context: IContext,
        query: IGateQuery,
    ): Promise<IResultProvider> {
        return this.sequenceQuery(context, query);
    }
    public processDml(
        context: IContext,
        query: IGateQuery,
    ): Promise<IResultProvider> {
        return this.sequenceQuery(context, query);
    }

    /**
     * Последовательный вызов запросов
     * @param gateContext
     * @param query
     * @returns IResultProvider
     */
    public sequenceQuery(
        gateContext: IContext,
        query: IGateQuery,
    ): Promise<IResultProvider> {
        return query.queryData.querys
            .slice(1)
            .reduce(
                (current, queryData) =>
                    current.then((res) => {
                        if (res.res) {
                            return Promise.resolve(res);
                        }
                        return this.processIntegration(
                            gateContext,
                            queryData,
                            {
                                resultSet: this.getResultSet(
                                    queryData.ck_d_interface,
                                ),
                            },
                            { ...res.params, ...query.inParams },
                        );
                    }),
                this.processIntegration(
                    gateContext,
                    query.queryData.querys[0],
                    {
                        resultSet: this.getResultSet(
                            query.queryData.querys[0].ck_d_interface,
                        ),
                    },
                    query.inParams,
                ),
            )
            .then(
                async (res) => {
                    return res.row
                        ? { stream: ResultStream([res.row]) }
                        : res.res;
                },
                async (err) => {
                    gateContext.connection.rollbackAndRelease().then(noop);
                    throw err;
                },
            );
    }

    public getResultSet(name: string): boolean {
        switch (name) {
            case "select":
            case "streamselect":
                return true;
            default:
                return false;
        }
    }

    public async init(reload?: boolean): Promise<void> {
        if (this.dataSource.pool) {
            await this.dataSource.resetPool();
        }
        await this.dataSource.createPool();
    }

    private async processIntegration(
        gateContext: IContext,
        queryData: IObjectParam,
        opt: IOptions,
        inParams: IObjectParam = {},
    ): Promise<IResultSequence> {
        if (gateContext.isDebugEnabled()) {
            gateContext.debug(
                `step db cc_request sql: ${queryData.cc_request}` +
                    `\ninParam: ${JSON.stringify(
                        inParams,
                    )}\noutParam: ${JSON.stringify(
                        gateContext.query.outParams,
                    )}`,
            );
        }
        let executeRes = await gateContext.connection.executeStmt(
            queryData.cc_request,
            inParams,
            gateContext.query.outParams,
            {
                ...opt,
                autoCommit: false,
            },
        );
        let result = await this.checkResult(
            gateContext,
            inParams,
            executeRes,
            queryData.cv_url_request,
        );
        if (!result.res && queryData.cc_response) {
            const responseInParams = this.prepareParams({
                ...inParams,
                ...result.params,
            });
            if (gateContext.isDebugEnabled()) {
                gateContext.debug(
                    `step db cc_response sql: ${
                        queryData.cc_response
                    }\ninParam: ${JSON.stringify(responseInParams)}` +
                        `\noutParam: ${JSON.stringify(
                            gateContext.query.outParams,
                        )}`,
                );
            }
            executeRes = await gateContext.connection.executeStmt(
                queryData.cc_response,
                responseInParams,
                gateContext.query.outParams,
                {
                    ...opt,
                    autoCommit: false,
                },
            );
            result = await this.checkResult(
                gateContext,
                responseInParams,
                executeRes,
                queryData.cv_url_response,
            );
        }
        return result;
    }

    /**
     * Обработка результата
     * @param data
     * @returns {*}
     */
    private checkResult(
        gateContext: IContext,
        params: IObjectParam,
        executeRes: IResultProvider,
        url?: string,
    ): Promise<IResultSequence> {
        const result = {
            params,
            res: executeRes,
        };
        const stream = executeRes.stream;
        return new Promise((resolve, reject) => {
            stream.on("error", reject);
            stream.on("readable", onReadable);
            const self = this;
            function onReadable() {
                stream.removeListener("readable", onReadable);
                const chunk = stream.read();
                if (chunk && chunk.result) {
                    self.request(gateContext, chunk, result, url).then(
                        (res) => {
                            stream.on("data", noop);
                            resolve(res);
                        },
                        (err) => {
                            stream.on("data", noop);
                            reject(err);
                        },
                    );
                } else {
                    if (chunk) {
                        stream.unshift(chunk);
                    }
                    resolve(result);
                }
            }
        });
    }
    /**
     * Вызов внешнего сервиса или возрат сообщения
     * @param gateContext
     * @param row
     * @param result
     * @param [url]
     * @returns request
     */
    private async request(
        gateContext: IContext,
        row: any,
        result: IResultSequence,
        url?: string,
    ): Promise<IResultSequence> {
        let param: any = {};
        try {
            param = JSON.parse(row.result) || {};
        } catch (e) {
            gateContext.error(`${row.result}\n${e.message}`, e);
            throw e;
        }

        if (param.cv_error) {
            throw new BreakException({
                data: ResultStream([param]),
                type: "success",
            });
        } else if (url) {
            return new Promise((resolve, reject) => {
                const urlDB = URL.parse(url);
                const length = isEmpty(param.body)
                    ? 0
                    : Buffer.byteLength(param.body);
                const method = param.method
                    ? param.method.toUpperCase()
                    : "POST";
                const headers = Object.assign(
                    method === "GET"
                        ? {}
                        : {
                              "Content-Length": length,
                              "Content-Type": "application/json",
                          },
                    isEmpty(param.headers) ? {} : param.headers,
                );
                const params: request.Options = {
                    body: param.body,
                    headers,
                    method,
                    timeout: this.params.timeout ? this.params.timeout : 660000,
                    url: URL.format(urlDB),
                };
                if (this.params.proxy) {
                    params.proxy = this.params.proxy;
                }
                if (gateContext.isDebugEnabled()) {
                    gateContext.debug(
                        `step request params: ${JSON.stringify(params)}`,
                    );
                }
                request(params, (err, res, bodyResponse) => {
                    if (err) {
                        gateContext.error(
                            `Error query ${gateContext.queryName} request ${this.name} params ${param}`,
                            err,
                        );
                        return reject(
                            new ErrorException(
                                -1,
                                "Ошибка вызова внешнего сервиса",
                            ),
                        );
                    }
                    if (gateContext.isDebugEnabled()) {
                        gateContext.debug(
                            `step response body: ${bodyResponse}\nheaders: ${JSON.stringify(
                                res.headers,
                            )}`,
                        );
                    }
                    if (bodyResponse) {
                        return resolve({
                            params: {
                                ...result.params,
                                ...param,
                                headers_response: res.headers,
                                json_response: isObject(bodyResponse)
                                    ? JSON.stringify(bodyResponse)
                                    : bodyResponse,
                            },
                        });
                    }
                });
            });
        }
        return {
            params: {
                ...result.params,
                ...param,
            },
            row,
        };
    }

    /**
     * Преобразуем параметры
     * @param params
     * @returns {{}}
     */
    private prepareParams(params: IObjectParam = {}): IObjectParam {
        return Object.entries(params).reduce((obj, arr) => {
            obj[arr[0]] = isObject(arr[1]) ? JSON.stringify(arr[1]) : arr[1];
            return obj;
        }, {});
    }
}
