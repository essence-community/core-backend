import { IPostgresDBConfig } from "@ungate/plugininf/lib/db/postgres/PostgresDB";
import { IParamsProvider } from "@ungate/plugininf/lib/NullProvider";

export interface IParamPg extends IParamsProvider, IPostgresDBConfig {
    core: boolean;
    old: boolean;
    preExecuteSql?: string;
    postExecuteSql?: string;
}
