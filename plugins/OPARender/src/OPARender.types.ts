import { IFile } from "@ungate/plugininf/lib/IContext";

export interface IOPARenderParams {
    fkType: "local" | "local_http" | "remote";
    fvPath?: string;
    fvUrl?: string;
    localPort?: number;
    fvPoliticPath: string;
    fvInputPath: string;
    fvDataPath: string;
    flBefore: boolean;
    flCachePolitics: boolean;
    flIdPoliticsKey?: string;
    flFinal: boolean;
}

export interface IOPAEval {
    eval(
        query: string[] | IFile[],
        data: string[] | IFile[],
        input: Record<string, any> | Record<string, any>[],
        queryId?: string,
    ): Promise<any>;
}
