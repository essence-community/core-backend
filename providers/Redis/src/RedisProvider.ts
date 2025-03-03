import NullProvider from "@ungate/plugininf/lib/NullProvider";
import IContext, { IFormData } from "@ungate/plugininf/lib/IContext";
import { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import { IResultProvider } from "@ungate/plugininf/lib/IResult";
import IParamsInfo from "@ungate/plugininf/lib/ICCTParams";
import { IParamsProvider } from "@ungate/plugininf/lib/NullProvider";
import { RedisClientOptions, createClient } from "redis";
import { initParams, isEmpty } from "@ungate/plugininf/lib/util/Util";
import ResultStream from "@ungate/plugininf/lib/stream/ResultStream";
import ICCTParams from "@ungate/plugininf/lib/ICCTParams";
import { ISessCtrl } from "@ungate/plugininf/lib/ISessCtrl";
import { parse } from "@ungate/plugininf/lib/parser/parserAsync";
import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import { deepParam } from "@ungate/plugininf/lib/util/deepParam";

interface IProviderParam extends RedisClientOptions, IParamsProvider {
    extra?: string;
}

async function prepareQuery(
    query: IGateQuery,
    param: Record<string, any>,
): Promise<IQueryRedis> {
    if (isEmpty(query.queryStr) && isEmpty(query.modifyMethod)) {
        throw new ErrorException(101, "Empty query string");
    }
    const parser = parse(query.queryStr || query.modifyMethod);

    const config = await parser.runer<IQueryRedis>({
        get: (key: string, isKeyEmpty: boolean) => {
            return param[key] || (isKeyEmpty ? "" : key);
        },
    });
    return config;
}

interface IQueryRedis {
    command: string;
    args: any[];
    resultPath?: string;
    resultParse?: string;
    resultRowParse?: string;
}

export class RedisProvider extends NullProvider {
    public static getParamsInfo(): IParamsInfo {
        /* tslint:disable:object-literal-sort-keys */
        return {
            url: {
                description:
                    "[redis[s]:]//[[user][:password@]][host][:port][/db-number][?db=db-number[&password=bar[&option=value]]]",
                name: "Url",
                type: "string",
            },
            password: {
                name: "Пароль",
                type: "password",
            },
            username: {
                name: "Пользователь",
                type: "string",
            },
            extra: {
                name: "Доп настройки",
                type: "long_string",
                defaultValue: "{}"
            },
        };
        /* tslint:enable:object-literal-sort-keys */
    }
    public params: IProviderParam;
    constructor(
        name: string,
        params: ICCTParams,
        sessCtrl: ISessCtrl,
    ) {
        super(name, params, sessCtrl);
        this.params = initParams(RedisProvider.getParamsInfo(), this.params);
    }
    private getClient() {
        return createClient({
            ...(this.params.extra ? JSON.parse(this.params.extra) : {}),
            url: this.params.url,
            password: this.params.password,
            username: this.params.username,
        });
    }
    public async processSql(
        context: IContext,
        query: IGateQuery,
    ): Promise<IResultProvider> {
        return this.processDml(context, query);
    }
    public async processDml(
        context: IContext,
        query: IGateQuery,
    ): Promise<IResultProvider> {
        const param = {
            jt_in_param:
                typeof context.request.body === "object" &&
                (context.request.body as IFormData).files
                    ? {
                          ...query.inParams,
                          ...(context.request.body as IFormData).files,
                      }
                    : query.inParams,
            jt_request_header: context.request.headers,
            jt_request_method: context.request.method,
            jt_provider_params: this.params,
        };
        const redisQuery = await prepareQuery(query, param);
        const client = this.getClient();
        const command =
            isEmpty(redisQuery.command) || isEmpty(redisQuery.command.trim())
                ? false
                : redisQuery.command.trim().toUpperCase();
        if (!command || !client[command]) {
            throw new Error("Method not implemented.");
        }
        this.log.trace("Redis Param %j", redisQuery);
        const res: IResultProvider = await new Promise((resolve, reject) => {
            client[command](redisQuery.args, (err, val) => {
                if (err) {
                    return reject(err);
                }
                let result = Array.isArray(val) ? val : [val];
                if (redisQuery.resultPath) {
                    const data = deepParam(redisQuery.resultPath, val);
                    result = Array.isArray(data) ? data : [data];
                }
                if (redisQuery.resultParse) {
                    const responseParam = {
                        ...param,
                        jt_result: result,
                    };
                    const parserResult = parse(redisQuery.resultParse);

                    result = parserResult.runer({
                        get: (key: string, isKeyEmpty: boolean) => {
                            return (
                                responseParam[key] || (isKeyEmpty ? "" : key)
                            );
                        },
                    }) as any;
                    if (!Array.isArray(result)) {
                        result = [result];
                    }
                }
                if (redisQuery.resultRowParse && Array.isArray(result)) {
                    const parserRowResult = parse(redisQuery.resultRowParse);
                    const responseParam = {
                        ...param,
                        jt_result: result,
                    };
                    result = result.map((item, index) => {
                        const rowParam = {
                            ...responseParam,
                            jt_result_row: item,
                            jt_result_row_index: index,
                        };
                        return parserRowResult.runer({
                            get: (key: string, isKeyEmpty: boolean) => {
                                return rowParam[key] || (isKeyEmpty ? "" : key);
                            },
                        });
                    });
                }

                return resolve({
                    stream: ResultStream(result),
                });
            });
        });
        return res;
    }
    public async init(reload?: boolean): Promise<void> {
        return;
    }
}
