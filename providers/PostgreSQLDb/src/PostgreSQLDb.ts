import PostgresDB from "@ungate/plugininf/lib/db/postgres/index";
import ICCTParams, { IParamsInfo } from "@ungate/plugininf/lib/ICCTParams";
import IContext from "@ungate/plugininf/lib/IContext";
import { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import IQuery from "@ungate/plugininf/lib/IQuery";
import { IResultProvider } from "@ungate/plugininf/lib/IResult";
import NullProvider from "@ungate/plugininf/lib/NullProvider";
import { initParams, isEmpty } from "@ungate/plugininf/lib/util/Util";
import CorePG from "./CorePG";
import IPostgreSQLController from "./IPostgreSQLController";
import OldPG from "./OldPG";
import SimplePG from "./SimplePG";

export default class PostgreSQLDb extends NullProvider {
    public static getParamsInfo(): IParamsInfo {
        return {
            ...PostgresDB.getParamsInfo(),
            ...NullProvider.getParamsInfo(),
            core: {
                defaultValue: false,
                name: "Инициализация согласно проекту Core",
                type: "boolean",
            },
            old: {
                defaultValue: false,
                name: "Работа по аналогии Java json",
                type: "boolean",
            },
        };
    }
    public dataSource: PostgresDB;
    private controller: IPostgreSQLController;
    constructor(name: string, params: ICCTParams) {
        super(name, params);
        this.params = initParams(PostgreSQLDb.getParamsInfo(), params);
        this.dataSource = new PostgresDB(`${this.name}_provider`, {
            connectString: this.params.connectString,
            connectionTimeoutMillis: this.params.connectionTimeoutMillis,
            idleTimeoutMillis: this.params.idleTimeoutMillis,
            partRows: this.params.partRows,
            poolMax: this.params.poolMax,
            queryTimeout: this.params.queryTimeout,
        });
        if (params.core) {
            this.controller = new CorePG(
                this.name,
                this.params,
                this.dataSource,
            );
        } else if (params.old) {
            this.controller = new OldPG(
                this.name,
                this.params,
                this.dataSource,
            );
        } else {
            this.controller = new SimplePG(
                this.name,
                this.params,
                this.dataSource,
            );
        }
    }
    public processSql(
        context: IContext,
        query: IGateQuery,
    ): Promise<IResultProvider> {
        return this.controller.processSql(context, query);
    }
    public processDml(
        context: IContext,
        query: IGateQuery,
    ): Promise<IResultProvider> {
        return this.controller.processDml(context, query);
    }
    public async init(reload?: boolean): Promise<void> {
        if (this.dataSource.pool) {
            await this.dataSource.resetPool();
        }
        await this.dataSource.createPool();
        return this.controller.init();
    }
    public async initContext(
        context: IContext,
        query?: IQuery,
    ): Promise<IQuery> {
        const res = await super.initContext(context, query);
        context.connection = await this.controller.getConnection(context);
        if (!isEmpty(res.modifyMethod) && res.modifyMethod !== "_") {
            res.queryStr = `select ${res.modifyMethod}(:sess_ck_id, :sess_session, :json) as result`;
            return res;
        } else if (res.modifyMethod === "_") {
            return res;
        }
        if (!isEmpty(query.queryStr)) {
            return res;
        }
        return this.controller.initContext(context, res);
    }
}
