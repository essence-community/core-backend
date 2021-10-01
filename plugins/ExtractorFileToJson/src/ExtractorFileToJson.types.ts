export interface IPluginParams {
    cvTypeStorage: "riak" | "aws" | "dir";
    cvPath?: string;
    cvS3Bucket?: string;
    cvS3KeyId?: string;
    cvS3SecretKey?: string;
    cvRowSize: number;
    clS3ReadPublic: boolean;
    cvDir: string;
    cvDirColumn: string;
    cnRowSize: number;
    cvCsvDelimiter?: string;
}

export interface IJson {
    service: {
        cv_action: string;
    };
    data: {
        cv_file_guid?: string;
        [key: string]: any;
    };
}
