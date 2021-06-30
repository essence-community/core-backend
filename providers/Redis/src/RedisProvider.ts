import NullProvider from "@ungate/plugininf/lib/NullProvider";
import IContext from "@ungate/plugininf/lib/IContext";
import { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import { IResultProvider } from "@ungate/plugininf/lib/IResult";
import IParamsInfo from "@ungate/plugininf/lib/ICCTParams";
import { IParamsProvider } from "@ungate/plugininf/lib/NullProvider";
import { ClientOpts, RedisClient, createClient } from "redis";
import { initParams } from "@ungate/plugininf/lib/util/Util";
import ResultStream from "@ungate/plugininf/lib/stream/ResultStream";
import ICCTParams from "@ungate/plugininf/lib/ICCTParams";
import { IAuthController } from "@ungate/plugininf/lib/IAuthController";

interface IProviderParam extends ClientOpts, IParamsProvider {}

function deepFind(obj, paths) {
    let current = obj;

    for (const val of paths) {
        if (current[val] === undefined || current[val] === null) {
            return current;
        }
        current = current[val];
    }
    return current;
}

function escapeValue(value: any): any {
    return typeof value === "string"
        ? value
              .replace(/\n/g, "\\n")
              .replace(/\'/g, "\\'")
              .replace(/\"/g, '\\"')
              .replace(/\&/g, "\\&")
              .replace(/\r/g, "\\r")
              .replace(/\t/g, "\\t")
              .replace(/\f/g, "\\f")
        : value;
}

function prepareQuery(query: IGateQuery): IQueryRedis {
    const json = JSON.parse(query.inParams.json || "{}");
    return JSON.parse(
        query.queryStr.replace(/\{([\w\.]+?)\}/gi, (_, key) => {
            if (key.indexOf(".") === -1) {
                return escapeValue(query.inParams[key] || key);
            }

            return escapeValue(deepFind(json, key.split(".")));
        }),
    );
}

interface IQueryRedis {
    command: string;
    args: string[];
    path_res?: string;
    result_eval?: string;
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
        const redisQuery = prepareQuery(query);
        const client = this.getClient();
        if (!client[redisQuery.command.toUpperCase()]) {
            throw new Error("Method not implemented.");
        }
        const res: IResultProvider = await new Promise((resolve, reject) => {
            client[redisQuery.command.toUpperCase()](
                redisQuery.args,
                (err, val) => {
                    if (err) {
                        return reject(err);
                    }
                    if (redisQuery.result_eval) {
                        const res = new Function(
                            "result",
                            redisQuery.result_eval,
                        );
                        return resolve({
                            stream: ResultStream(res(val)),
                        });
                    }
                    if (redisQuery.path_res) {
                        const res = deepFind(
                            val,
                            redisQuery.path_res.split("."),
                        );
                        return resolve({
                            stream: ResultStream(res),
                        });
                    }
                    return resolve({
                        stream: ResultStream(val),
                    });
                },
            );
        });
        client.end();
        return res;
    }
    public async processDml(
        context: IContext,
        query: IGateQuery,
    ): Promise<IResultProvider> {
        const redisQuery = prepareQuery(query);
        const client = this.getClient();
        if (!client[redisQuery.command.toUpperCase()]) {
            throw new Error("Method not implemented.");
        }
        const res: IResultProvider = await new Promise((resolve, reject) => {
            client[redisQuery.command.toUpperCase()](
                redisQuery.args,
                (err, val) => {
                    if (err) {
                        return reject(err);
                    }
                    if (redisQuery.path_res) {
                        const res = deepFind(
                            val,
                            redisQuery.path_res.split("."),
                        );
                        return resolve({
                            stream: ResultStream(res),
                        });
                    }
                    return resolve({
                        stream: ResultStream(val),
                    });
                },
            );
        });
        client.end();
        return res;
    }
    public async init(reload?: boolean): Promise<void> {
        return;
    }
}
