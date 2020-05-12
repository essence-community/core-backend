import { IPostgresDBConfig } from "@ungate/plugininf/lib/db/postgres/PostgresDB";
import { IParamsProvider } from "@ungate/plugininf/lib/NullProvider";
export interface IParam extends IPostgresDBConfig, IParamsProvider {}
