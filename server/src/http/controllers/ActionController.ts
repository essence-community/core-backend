import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import ErrorGate from "@ungate/plugininf/lib/errors/ErrorGate";
import IContext, { IFormData } from "@ungate/plugininf/lib/IContext";
import IProvider from "@ungate/plugininf/lib/IProvider";
import { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import IResult from "@ungate/plugininf/lib/IResult";
import NullSessProvider from "@ungate/plugininf/lib/NullSessProvider";
import ResultStream from "@ungate/plugininf/lib/stream/ResultStream";
import { ReadStreamToArray } from "@ungate/plugininf/lib/stream/Util";
import { isEmpty } from "@ungate/plugininf/lib/util/Util";
import * as fs from "fs";
import { forEach, noop } from "lodash";
import Constants from "../../core/Constants";
import PluginController, { IPlugins } from "./PluginController";

interface IActionOptions {
    gateContext: IContext;
    provider: IProvider;
    plugins: IPlugins[];
    query: IGateQuery;
}

class ActionController {
    public execute(options: IActionOptions): Promise<IResult> {
        switch (options.gateContext.actionName) {
            case "sql":
                return this.handlerSql(options);
            case "dml":
                return this.handlerDml(options);
            case "auth":
                return this.handlerAuth(options);
            case "file":
                return this.handlerFile(options);
            case "upload":
                return this.handlerUpload(options);
            case "getfile":
                return this.handlerGetFile(options);
            default:
                throw new ErrorException(ErrorGate.NOT_IMPLEMENTED);
        }
    }
    private async handlerAuth({
        gateContext,
        provider,
        plugins,
        query,
    }: IActionOptions): Promise<IResult> {
        let session;
        if (gateContext.request.method.toUpperCase() !== "POST") {
            throw new ErrorException(ErrorGate.REQUIRED_POST);
        }
        const resPlugin = await PluginController.applyPluginBeforeSession(
            gateContext,
            plugins,
        );
        if (resPlugin) {
            session =
                await gateContext.gateContextPlugin.sessCtrl.createSession(
                    {
                        context: gateContext,
                        idUser: resPlugin.idUser,
                        nameProvider: `plugin_${resPlugin.namePlugin}`,
                        userData: resPlugin.dataUser,
                        sessionData: resPlugin.sessionData,
                    },
                );
        }
        if (!session) {
            const data = await (provider as NullSessProvider).processAuth(
                gateContext,
                query,
            );
            if (gateContext.connection) {
                const conn = gateContext.connection;
                try {
                    await conn.commit();
                    await conn.release();
                } catch (e) {
                    conn.release().then(noop, noop);
                    gateContext.error(e);
                }
            }
            if (!data || isEmpty(data.idUser)) {
                throw new ErrorException(ErrorGate.AUTH_UNAUTHORIZED);
            }
            if (
                await PluginController.applyPluginBeforeSaveSession(
                    gateContext,
                    plugins,
                    data,
                )
            ) {
                session = await (provider as NullSessProvider).createSession({
                    context: gateContext,
                    idUser: data.idUser,
                    userData: data.dataUser as any,
                    sessionData: data.sessionData,
                });
            }
        }
        if (!session) {
            throw new ErrorException(ErrorGate.AUTH_UNAUTHORIZED);
        }
        gateContext.debug(`Success authorization: ${JSON.stringify(session)}`);
        return {
            data: ResultStream([session]),
            type: "success",
        };
    }
    private handlerDml({
        gateContext,
        provider,
        query,
    }: IActionOptions): Promise<IResult> {
        gateContext.trace("Process Dml");
        return new Promise((resolve, reject) => {
            provider
                .processDml(gateContext, query)
                .then((data) => {
                    if (
                        Object.prototype.hasOwnProperty.call(
                            query.outParams,
                            "EXTRACT_META_DATA",
                        )
                    ) {
                        gateContext.metaData = isEmpty(data.metaData)
                            ? {}
                            : {
                                  columnsBc: data.metaData,
                              };
                    }
                    resolve({
                        type: data.type || "success",
                        data: data.stream,
                    });
                })
                .catch((err) => {
                    gateContext.error(
                        `${gateContext.queryName}, Dml.processDml(${query.queryStr}): ${err.message}`,
                        err,
                    );
                    return reject(err);
                });
        });
    }
    private handlerSql({
        gateContext,
        provider,
        query,
    }: IActionOptions): Promise<IResult> {
        gateContext.trace("Process Sql");
        return new Promise((resolve, reject) => {
            provider
                .processSql(gateContext, query)
                .then((data) => {
                    if (
                        Object.prototype.hasOwnProperty.call(
                            query.outParams,
                            "EXTRACT_META_DATA",
                        )
                    ) {
                        gateContext.metaData = isEmpty(data.metaData)
                            ? {}
                            : {
                                  columnsBc: data.metaData,
                              };
                    }
                    resolve({
                        type: data.type || "success",
                        data: data.stream,
                    });
                })
                .catch((err) => {
                    gateContext.error(
                        `${gateContext.queryName}, Sql.processSql(${query.queryStr}): ${err.message}`,
                        err,
                    );
                    return reject(err);
                });
        });
    }
    private handlerFile({
        gateContext,
        provider,
        query,
    }: IActionOptions): Promise<IResult> {
        gateContext.trace("Process File");
        return new Promise((resolve, reject) => {
            provider
                .processDml(gateContext, query)
                .then((data) => {
                    resolve({
                        type: data.type || "attachment",
                        data: data.stream,
                    });
                })
                .catch((err) => {
                    gateContext.error(
                        `${gateContext.queryName}, File.processFile(${query.queryStr}): ${err.message}`,
                        err,
                    );
                    return reject(err);
                });
        });
    }
    private handlerUpload({
        gateContext,
        provider,
        query,
    }: IActionOptions): Promise<IResult> {
        gateContext.trace("Process Upload");
        const result = [];
        if (
            typeof gateContext.request.body !== "object" ||
            !(gateContext.request.body as IFormData).files
        ) {
            return Promise.reject(
                new ErrorException(ErrorGate.UPLOAD_FORM_ENCTYPE),
            );
        }
        forEach((gateContext.request.body as IFormData).files, (value, key) => {
            if (value && value.length) {
                result.push(
                    value.reduce(
                        (prom, val) =>
                            prom.then((arr) => {
                                query.inParams[key] = provider.fileInParams(
                                    fs.readFileSync(val.path, null),
                                );
                                query.inParams[
                                    `${key}${Constants.UPLOAD_FILE_NAME_SUFFIX}`
                                ] = val.originalFilename;
                                query.inParams[
                                    `${key}${Constants.UPLOAD_FILE_MIMETYPE_SUFFIX}`
                                ] = val.headers["content-type"];
                                return provider
                                    .processDml(gateContext, query)
                                    .then((data) =>
                                        ReadStreamToArray(data.stream),
                                    )
                                    .then(async (res) => arr.concat(res));
                            }),
                        Promise.resolve([]),
                    ),
                );
            }
        });
        return Promise.all(result)
            .then(
                async (arr) =>
                    ({
                        data: ResultStream(
                            arr && arr.length
                                ? arr.reduce((ar, val) => [...ar, ...val], [])
                                : [],
                        ),
                        type: "success",
                    } as IResult),
            )
            .catch((err) => {
                gateContext.error(
                    `${gateContext.queryName},` +
                        ` Upload.processDml(${query.queryStr}): ${err.message}`,
                    err,
                );
                throw err;
            });
    }
    private handlerGetFile({
        gateContext,
        provider,
        query,
    }: IActionOptions): Promise<IResult> {
        gateContext.trace("Process GetFile");
        return new Promise((resolve, reject) => {
            provider
                .processDml(gateContext, query)
                .then((data) => {
                    resolve({ type: data.type || "file", data: data.stream });
                })
                .catch((err) => {
                    gateContext.error(
                        `${gateContext.queryName},` +
                            ` GetFile.processDml(${query.queryStr}): ${err.message}`,
                        err,
                    );
                    return reject(err);
                });
        });
    }
}

export default new ActionController();
