import ICCTParams from "@ungate/plugininf/lib/ICCTParams";
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

export interface IJson {
    service: {
        cv_action: string;
    };
    data: {
        cv_file_guid?: string;
        [key: string]: any;
    };
}
