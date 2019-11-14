import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import ErrorGate from "@ungate/plugininf/lib/errors/ErrorGate";
import ICCTParams, { IParamsInfo } from "@ungate/plugininf/lib/ICCTParams";
import IContext from "@ungate/plugininf/lib/IContext";
import IQuery from "@ungate/plugininf/lib/IQuery";
import { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import { IResultProvider } from "@ungate/plugininf/lib/IResult";
import NullProvider from "@ungate/plugininf/lib/NullProvider";
import ResultStream from "@ungate/plugininf/lib/stream/ResultStream";
import { isEmpty } from "@ungate/plugininf/lib/util/Util";
import { initParams } from "@ungate/plugininf/lib/util/Util";
import AdminAction from "./AdminAction";
import AdminModify from "./AdminModify";

export = class AdminGate extends NullProvider {
    public static getParamsInfo(): IParamsInfo {
        return {
            ...NullProvider.getParamsInfo(),
            cctBuckets: {
                name: "Настройки хранилища",
                type: "string",
            },
            cvRiakUrl: {
                name: "Ссылка на riak",
                type: "string",
            },
        };
    }
    private adminAction: AdminAction;
    private adminModify: AdminModify;
    constructor(name: string, params: ICCTParams) {
        super(name, params);
        this.params = initParams(AdminGate.getParamsInfo(), params);
        this.adminAction = new AdminAction(name, this.params);
        this.adminModify = new AdminModify(name, this.params);
    }
    public async processSql(
        context: IContext,
        query: IGateQuery,
    ): Promise<IResultProvider> {
        let result = [];
        if (context.queryName === "modify") {
            result = await this.adminModify.checkModify(context, query);
        }
        if (this.adminAction.handlers[context.queryName]) {
            result = await this.adminAction.handlers[context.queryName].call(
                this.adminAction,
                context,
                query,
            );
        }
        return {
            stream: ResultStream(result),
        };
    }
    public async processDml(
        context: IContext,
        query: IGateQuery,
    ): Promise<IResultProvider> {
        let result = [];
        if (context.queryName === "modify") {
            result = await this.adminModify.checkModify(context, query);
        }
        if (this.adminAction.handlers[context.queryName]) {
            result = await this.adminAction.handlers[context.queryName].call(
                this.adminAction,
                context,
                query,
            );
        }
        return {
            stream: ResultStream(result),
        };
    }
    public async initContext(context: IContext, query: IQuery) {
        const res = await super.initContext(context, query);
        if (
            context.queryName !== "modify" &&
            isEmpty(this.adminAction.handlers[context.queryName])
        ) {
            throw new ErrorException(ErrorGate.NOTFOUND_QUERY);
        }
        if (context.queryName === "modify") {
            res.queryStr = res.modifyMethod;
        }
        return res;
    }
    public async init(reload?: boolean): Promise<void> {
        await this.adminAction.init();
        await this.adminModify.init();
    }
};
