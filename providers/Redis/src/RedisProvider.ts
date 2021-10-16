import NullProvider from "@ungate/plugininf/lib/NullProvider";
import IContext, { IFormData } from "@ungate/plugininf/lib/IContext";
import { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import { IResultProvider } from "@ungate/plugininf/lib/IResult";
import IParamsInfo from "@ungate/plugininf/lib/ICCTParams";
import { IParamsProvider } from "@ungate/plugininf/lib/NullProvider";
import { ClientOpts, createClient } from "redis";
import { initParams, isEmpty } from "@ungate/plugininf/lib/util/Util";
import ResultStream from "@ungate/plugininf/lib/stream/ResultStream";
import ICCTParams from "@ungate/plugininf/lib/ICCTParams";
import { IAuthController } from "@ungate/plugininf/lib/IAuthController";
import { parse } from "@ungate/plugininf/lib/parser/parser";
import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import { deepParam } from "@ungate/plugininf/lib/util/deepParam";

interface IProviderParam extends ClientOpts, IParamsProvider {}

function prepareQuery(
    query: IGateQuery,
    param: Record<string, any>,
): IQueryRedis {
    if (isEmpty(query.queryStr) && isEmpty(query.modifyMethod)) {
        throw new ErrorException(101, "Empty query string");
    }
    const parser = parse(query.queryStr || query.modifyMethod);

    const config = parser.runer({
        get: (key: string, isKeyEmpty: boolean) => {
            return param[key] || (isKeyEmpty ? "" : key);
        },
    }) as any;
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
            host: {
                name: "Хост",
                type: "string",
            },
            port: {
                name: "Port",
                type: "string",
            },
            path: {
                name: "UNIX Socket",
                type: "string",
            },
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
            db: {
                name: "Наименование бд",
                type: "string",
            },
            string_numbers: {
                name: "Перевод чисел в строки",
                type: "boolean",
            },
            return_buffers: {
                name: "Возрат буфера",
                type: "boolean",
            },
            detect_buffers: {
                name: "Обнаружение буферов",
                type: "boolean",
            },
            socket_keepalive: {
                name: "Включить keepalived",
                type: "boolean",
            },
            socket_initial_delay: {
                name: "Время ожидания инициализации сокета в мс",
                type: "integer",
            },
            no_ready_check: {
                name: "Выключаем проверку соединения",
                type: "boolean",
            },
            enable_offline_queue: {
                name: "Включаем офлайн очередь",
                type: "boolean",
            },
            retry_max_delay: {
                name: "Время для повторного вызова",
                type: "integer",
            },
            connect_timeout: {
                name: "Время ожидания подключения в мс",
                type: "integer",
            },
            prefix: {
                name: "Префикс ключей",
                type: "string",
            },
        };
        /* tslint:enable:object-literal-sort-keys */
    }
    public params: IProviderParam;
    constructor(
        name: string,
        params: ICCTParams,
        authController: IAuthController,
    ) {
        super(name, params, authController);
        this.params = initParams(RedisProvider.getParamsInfo(), this.params);
    }
    private getClient() {
        return createClient({
            host: this.params.host,
            port: this.params.port,
            path: this.params.path,
            url: this.params.url,
            string_numbers: this.params.string_numbers,
            return_buffers: this.params.return_buffers,
            detect_buffers: this.params.detect_buffers,
            socket_keepalive: this.params.socket_keepalive,
            socket_initial_delay: this.params.socket_initial_delay,
            no_ready_check: this.params.no_ready_check,
            enable_offline_queue: this.params.enable_offline_queue,
            retry_max_delay: this.params.retry_max_delay,
            connect_timeout: this.params.connect_timeout,
            max_attempts: this.params.max_attempts,
            retry_unfulfilled_commands: this.params.retry_unfulfilled_commands,
            auth_pass: this.params.auth_pass,
            password: this.params.password,
            db: this.params.db,
            family: this.params.family,
            prefix: this.params.prefix,
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
        const redisQuery = prepareQuery(query, param);
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
        client.end();
        return res;
    }
    public async init(reload?: boolean): Promise<void> {
        return;
    }
}
