import { IOracleDBConfig } from "@ungate/plugininf/lib/db/oracle/OracleDB";
import { IParamsProvider } from "@ungate/plugininf/lib/NullProvider";

export interface IParamOracle extends IParamsProvider, IOracleDBConfig {
    core: boolean;
    old: boolean;
    defaultSchema?: string;
    preExecuteSql?: string;
    postExecuteSql?: string;
}
