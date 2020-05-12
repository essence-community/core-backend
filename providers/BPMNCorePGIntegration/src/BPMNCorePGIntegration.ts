import PostgresDB from "@ungate/plugininf/lib/db/postgres/index";
import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import ErrorGate from "@ungate/plugininf/lib/errors/ErrorGate";
import ICCTParams, { IParamsInfo } from "@ungate/plugininf/lib/ICCTParams";
import IContext from "@ungate/plugininf/lib/IContext";
import IQuery, { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import { IResultProvider } from "@ungate/plugininf/lib/IResult";
import NullProvider from "@ungate/plugininf/lib/NullProvider";
import { initParams } from "@ungate/plugininf/lib/util/Util";
import { IParam } from "./BPMNCorePGIntegration.types";
import ResultStream from "@ungate/plugininf/lib/stream/ResultStream";

export default class BPMNCorePGIntegration extends NullProvider {
    public init(reload?: boolean): Promise<void> {
        return Promise.resolve();
    }
    public static getParamsInfo(): IParamsInfo {
        return {
            ...NullProvider.getParamsInfo(),
            ...PostgresDB.getParamsInfo(),
        };
    }
    public dataSource: PostgresDB;
    public params: IParam;
    constructor(name: string, params: ICCTParams) {
        super(name, params);
        this.params = {
            ...this.params,
            ...initParams(PostgresDB.getParamsInfo(), params),
        };
        this.dataSource = new PostgresDB(`${this.name}_provider`, {
            connectString: this.params.connectString,
            partRows: this.params.partRows,
            poolMax: this.params.poolMax,
            poolMin: this.params.poolMin,
            queryTimeout: this.params.queryTimeout,
        });
    }

    public async initContext(
        context: IContext,
        preQuery: IQuery,
    ): Promise<IQuery> {
        const query = await super.initContext(context, preQuery);
        const conn = await this.dataSource.getConnection();
        return conn
            .executeStmt(
                "select s.ck_id, s.cc_scenario, s.cn_action\n" +
                    "  from t_scenario s\n" +
                    " where lower(s.ck_id) = lower(:ck_query)",
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
                                const doc = data[0];
                                query.queryData = doc;
                                query.queryStr = doc.cc_scenario;
                                return resolve(query);
                            }
                            return reject(
                                new ErrorException(ErrorGate.NOTFOUND_QUERY),
                            );
                        });
                    }),
            );
    }

    public processSql(
        context: IContext,
        query: IGateQuery,
    ): Promise<IResultProvider> {
        return this.scenarioQuery(query);
    }
    public processDml(
        context: IContext,
        query: IGateQuery,
    ): Promise<IResultProvider> {
        return this.scenarioQuery(query);
    }

    /**
     * Последовательный вызов запросов
     * @param gateContext
     * @param query
     * @returns IResultProvider
     */
    public async scenarioQuery(query: IGateQuery): Promise<IResultProvider> {
        const scenario = JSON.parse(query.queryStr);

        return {
            stream: ResultStream([]),
        };
    }
}
