import { Readable } from "stream";

/**
 * Created by artemov_i on 04.12.2018.
 */
export interface IMetaData {
    [key: string]:
        | string
        | string[]
        | number[]
        | number
        | Date
        | IMetaData
        | IMetaData[];
}
export interface IResultBase {
    type:
        | "break"
        | "success"
        | "false"
        | "error"
        | "file"
        | "binary"
        | "attachment";
    data?: Readable;
    metaData?: IMetaData;
}
export interface IResultWithData extends IResultBase {
    type: "success" | "false" | "error" | "file" | "binary" | "attachment";
    data: Readable;
}

export type IResult = IResultWithData | IResultBase;

export default IResult;
export interface IResultProvider {
    stream: Readable;
    type?: IResult["type"];
    metaData?: any;
}
