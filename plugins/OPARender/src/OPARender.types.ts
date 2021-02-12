import { IFile } from "@ungate/plugininf/lib/IContext";

export interface IOPARenderParams {
    fkType: "local" | "local_http" | "remote";
    fvPath?: string;
    fvUrl?: string;
    localPort?: number;
    fvPoliticPath: string;
    fvInputPath: string;
    fvDataPath?: string;
    fvQueryPath?: string;
    fvResultKeyPath?: string;
    flBefore: boolean;
    flCachePolitics: boolean;
    flIdPoliticsKey?: string;
    flFinal: boolean;
    fvPoliticDefault?: string;
    fvInputDefault?: string;
    fvDataDefault?: string;
    fvQueryDefault: string;
    fvResultPath: string;
}

export interface IOPAEval {
    eval(
        query: string[] | IFile[],
        data: string[] | IFile[],
        input: string | Record<string, any> | Record<string, any>[] | IFile,
        queryString: string,
        resultPath: string,
        queryId?: string,
    ): Promise<any>;
}
