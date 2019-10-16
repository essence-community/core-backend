import ICCTParams from "@ungate/plugininf/lib/ICCTParams";

export interface IFile {
    /**
     * same as name - the field name for this file
     */
    fieldName: string;
    /**
     * the filename that the user reports for the file
     */
    originalFilename: string;
    /**
     * the absolute path of the uploaded file on disk
     */
    path: string;
    /**
     * the HTTP headers that were sent along with this file
     */
    headers: any;
    /**
     * size of the file in bytes
     */
    size: number;
}

export interface IFiles {
    [key: string]: IFile[];
}
export interface IPluginParams extends ICCTParams {
    cvTypeStorage?: "riak" | "aws" | "dir";
    cvPath?: string;
    cvS3Bucket?: string;
    cvS3KeyId?: string;
    cvS3SecretKey?: string;
    cvRowSize: number;
    clS3ReadPublic: boolean;
    cvDir: string;
    cvDirColumn: string;
}
