import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import { IParamsInfo } from "@ungate/plugininf/lib/ICCTParams";
import IContext, { IFormData } from "@ungate/plugininf/lib/IContext";
import { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import { parse as parseSync } from "@ungate/plugininf/lib/parser/parser";
import { parse } from "@ungate/plugininf/lib/parser/parserAsync";
import { IResultProvider } from "@ungate/plugininf/lib/IResult";
import NullProvider, {
    IParamsProvider,
} from "@ungate/plugininf/lib/NullProvider";
import ResultStream from "@ungate/plugininf/lib/stream/ResultStream";
import * as grpc from "@grpc/grpc-js";
import * as protoLoader from "@grpc/proto-loader";
import { isEmpty } from "@ungate/plugininf/lib/util/Util";
import { deepParam } from "@ungate/plugininf/lib/util/deepParam";
import * as fs from "fs";
import * as path from "path";
import { v4 as uuid } from "uuid";
import Constant from "@ungate/plugininf/lib/Constants";

export interface IGRpcTransformProxyParam extends IParamsProvider {
    host: string;
    port: string;
    timeout: number;
    proto: string;
    cacheClient: boolean;
    channelOptions?: Record<string, any>;
    typeCredentials?: "insecure" | "ssl";
    credentialsSsl?: {
        rootCerts?: string | Buffer;
        privateKey?: string | Buffer;
        certChain?: string | Buffer;
        checkServerIdentity?: string;
    };
}

export interface IQueryConfig {
    package: string;
    service: string;
    method: string;
    args: any;
    streamResponse: boolean;
    streamRequest: boolean;
    channelOptions?: Record<string, any>;
    resultParse?: string;
    resultRowParse?: string;
}

export interface IServiceClient extends grpc.Client {
    [methodName: string]: any;
}

export default class GRpcTransformProxy extends NullProvider {
    public static getParamsInfo(): IParamsInfo {
        return {
            host: {
                name: "IP|DNS address",
                type: "string",
                required: true,
            },
            port: {
                name: "Port address",
                type: "integer",
                required: true,
            },
            proto: {
                name: "Proto body | Proto path",
                type: "long_string",
                required: true,
                description: "Path or String",
            },
            cacheClient: {
                name: "Cache init client",
                type: "boolean",
                defaultValue: true,
            },
            timeout: {
                defaultValue: 660,
                name: "Время ожидания внешнего сервиса в секундах",
                type: "integer",
            },
            channelOptions: {
                type: "long_string",
                name: "Extra chanel options default",
            },
            typeCredentials: {
                type: "combo",
                name: "Type credentials",
                defaultValue: "insecure",
                valueField: [{ in: "ck_id" }],
                displayField: "ck_id",
                setGlobal: [{ out: "g_type_credential" }],
                records: [{ ck_id: "insecure" }, { ck_id: "ssl" }],
            },
            credentialsSsl: {
                type: "form_nested",
                name: "SSL DATA",
                hidden: true,
                hiddenRules: 'g_type_credential!="ssl"',
                childs: {
                    rootCerts: {
                        type: "long_string",
                        name: "Root certification",
                        description: "Path or String",
                    },
                    privateKey: {
                        type: "long_string",
                        name: "Private key",
                        description: "Path or String",
                        required: true,
                    },
                    certChain: {
                        type: "long_string",
                        name: "Cert chain",
                        description: "Path or String",
                        required: true,
                    },
                    checkServerIdentity: {
                        type: "long_string",
                        name: "Check Server Identity",
                    },
                },
            },
        };
    }

    params: IGRpcTransformProxyParam;

    packageDefinition: protoLoader.PackageDefinition;
    grpcObject: grpc.GrpcObject;
    clients: {
        [key: string]: IServiceClient;
    } = {};

    channelCredentials: grpc.ChannelCredentials;

    public processSql(
        context: IContext,
        query: IGateQuery,
    ): Promise<IResultProvider> {
        return this.callRequest(context, query);
    }
    public processDml(
        context: IContext,
        query: IGateQuery,
    ): Promise<IResultProvider> {
        return this.callRequest(context, query);
    }
    public async init(reload?: boolean): Promise<void> {
        if (
            this.params.channelOptions &&
            typeof this.params.channelOptions === "string"
        ) {
            this.params.channelOptions = JSON.parse(this.params.channelOptions);
        }
        let file = this.params.proto;
        if (!fs.existsSync(this.params.proto)) {
            file = path.join(Constant.UPLOAD_DIR, `${uuid()}.proto`);
            fs.writeFileSync(file, this.params.proto);
        }
        this.channelCredentials = grpc.credentials.createInsecure();
        if (
            this.params.typeCredentials === "ssl" &&
            this.params.credentialsSsl
        ) {
            let opts;
            if (fs.existsSync(this.params.credentialsSsl.rootCerts)) {
                this.params.credentialsSsl.rootCerts = fs.readFileSync(
                    this.params.credentialsSsl.rootCerts,
                );
            } else if (
                typeof this.params.credentialsSsl.rootCerts === "string"
            ) {
                this.params.credentialsSsl.rootCerts = Buffer.from(
                    this.params.credentialsSsl.rootCerts,
                );
            }
            if (fs.existsSync(this.params.credentialsSsl.privateKey)) {
                this.params.credentialsSsl.privateKey = fs.readFileSync(
                    this.params.credentialsSsl.privateKey,
                );
            } else if (
                typeof this.params.credentialsSsl.privateKey === "string"
            ) {
                this.params.credentialsSsl.privateKey = Buffer.from(
                    this.params.credentialsSsl.privateKey,
                );
            }
            if (fs.existsSync(this.params.credentialsSsl.certChain)) {
                this.params.credentialsSsl.certChain = fs.readFileSync(
                    this.params.credentialsSsl.certChain,
                );
            } else if (
                typeof this.params.credentialsSsl.certChain === "string"
            ) {
                this.params.credentialsSsl.certChain = Buffer.from(
                    this.params.credentialsSsl.certChain,
                );
            }
            if (this.params.credentialsSsl.checkServerIdentity) {
                const parser = parseSync(
                    this.params.credentialsSsl.checkServerIdentity,
                );
                opts = {
                    checkServerIdentity: (hostname, cert) => {
                        const res = parser.runer<string | boolean>({
                            hostname,
                            cert,
                        });
                        if (typeof res === "string") {
                            return new Error(res);
                        }
                        if (typeof res === "boolean" && !res) {
                            return new Error("UnCheck Cert");
                        }
                        return;
                    },
                };
            }

            this.channelCredentials = grpc.credentials.createSsl(
                this.params.credentialsSsl.rootCerts,
                this.params.credentialsSsl.privateKey,
                this.params.credentialsSsl.certChain,
                opts,
            );
        }
        this.packageDefinition = await protoLoader.load(file, {
            keepCase: true,
            longs: String,
            enums: String,
            defaults: true,
            oneofs: true,
        });
        this.grpcObject = grpc.loadPackageDefinition(this.packageDefinition);
        return;
    }

    private extractFile(obj: Record<string, any>) {
        if (typeof obj !== "object") {
            return;
        }
        Object.entries(obj).forEach(([key, value]) => {
            if (
                typeof value === "object" &&
                value.originalFilename &&
                value.path
            ) {
                obj[key] = fs.readFileSync(value.path);
            } else if (Array.isArray(value)) {
                value.forEach((val) => this.extractFile(val));
            } else if (typeof value === "object") {
                this.extractFile(value);
            }
        });
    }

    public async callRequest(
        gateContext: IContext,
        query: IGateQuery,
    ): Promise<IResultProvider> {
        if (isEmpty(query.queryStr) && isEmpty(query.modifyMethod)) {
            throw new ErrorException(101, "Empty query string");
        }
        const parser = parse(query.queryStr || query.modifyMethod);
        const param = {
            jt_in_param:
                typeof gateContext.request.body === "object" &&
                (gateContext.request.body as IFormData).files
                    ? {
                          ...query.inParams,
                          ...(gateContext.request.body as IFormData).files,
                      }
                    : query.inParams,
            jt_request_header: gateContext.request.headers,
            jt_request_method: gateContext.request.method,
            jt_provider_params: this.params,
        };

        const config = await parser.runer<IQueryConfig>({
            get: (key: string, isKeyEmpty: boolean) => {
                return param[key] || (isKeyEmpty ? "" : key);
            },
        });
        if (gateContext.isDebugEnabled()) {
            gateContext.debug(
                `Request proxy config: ${JSON.stringify(config)}`,
            );
        }
        if (config.args) {
            (Array.isArray(config.args)
                ? config.args
                : [config.args]
            ).forEach((val) => this.extractFile(val));
        }
        const service = `${config.package}.${config.service}`;
        let client = this.clients[service];
        if (!client) {
            const sClass = deepParam(service, this.grpcObject);
            if (sClass) {
                let channelOptions;
                if (this.params.channelOptions) {
                    channelOptions = this.params.channelOptions;
                }
                if (config.channelOptions) {
                    channelOptions = {
                        ...(channelOptions ? channelOptions : {}),
                        ...config.channelOptions,
                    };
                }
                client = new sClass(
                    `${this.params.host}:${this.params.port}`,
                    this.channelCredentials,
                    channelOptions,
                );
                if (this.params.cacheClient) {
                    this.clients[service] = client;
                }
            }
        }

        if (!client) {
            throw new ErrorException(101, "Not found client");
        }

        const method = client[config.method];

        if (!method) {
            throw new ErrorException(101, "Not found method");
        }

        let result = await new Promise((resolve, reject) => {
            let call;
            let isExit = false;
            let timer = null;
            if (config.streamResponse) {
                const res = [];
                call =
                    config.args && !config.streamRequest
                        ? method.apply(
                              client,
                              Array.isArray(config.args)
                                  ? config.args
                                  : [config.args],
                          )
                        : method.call(client);
                call.on("data", (data) => res.push(data));
                call.on("error", (err) => {
                    isExit = true;
                    if (timer) {
                        clearTimeout(timer);
                        timer = null;
                    }
                    reject(err);
                });
                call.on("end", () => {
                    isExit = true;
                    if (timer) {
                        clearTimeout(timer);
                        timer = null;
                    }
                    resolve(res);
                });
                if (config.streamRequest) {
                    (Array.isArray(config.args)
                        ? config.args
                        : [config.args]
                    ).forEach((arg) => {
                        call.write(arg);
                    });
                    call.end();
                }
            } else {
                const args = [
                    ...(config.args
                        ? Array.isArray(config.args)
                            ? config.args
                            : [config.args]
                        : []),
                    (err, res) => {
                        isExit = true;
                        if (timer) {
                            clearTimeout(timer);
                            timer = null;
                        }
                        if (err) {
                            return reject(err);
                        }
                        resolve(res);
                    },
                ];
                call = method.apply(client, args);
            }
            timer = setTimeout(() => {
                if (call && !isExit) {
                    call.cancel();
                    return reject(new ErrorException(-1, "Timeout"));
                }
            }, this.params.timeout * 1000);
        });

        if (!Array.isArray(result)) {
            result = [result];
        }

        if (config.resultParse) {
            const responseParam = {
                ...param,
                jt_result: result,
            };
            const parserResult = parse(config.resultParse);

            result = parserResult.runer({
                get: (key: string, isKeyEmpty: boolean) => {
                    return responseParam[key] || (isKeyEmpty ? "" : key);
                },
            }) as any;
            if (!Array.isArray(result)) {
                result = [result];
            }
        }
        if (config.resultRowParse && Array.isArray(result)) {
            const parserRowResult = parse(config.resultRowParse);
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
        return {
            stream: ResultStream(result),
        };
    }
}
