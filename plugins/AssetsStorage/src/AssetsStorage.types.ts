import { IFile } from "@ungate/plugininf/lib/IContext";

export interface IPluginParams {
    typeStorage: "riak" | "aws" | "dir";
    dirPath?: string;
    s3Url?: string;
    s3Bucket?: string;
    s3KeyId?: string;
    s3SecretKey?: string;
    s3ReadPublic?: boolean;
    dirDefault?: string;
    dirColumn?: string;
    finalOut: boolean;
    keyFilePath?: string;
}

export interface IStorage {
    saveFile(
        key: string,
        file: IFile,
        metaData?: Record<string, string>,
    ): Promise<void>;
    deletePath(key: string): Promise<void>;
    getFile(key: string): Promise<IFile>;
}
