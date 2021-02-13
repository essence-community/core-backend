import { IFile } from "@ungate/plugininf/lib/IContext";

export interface IEncoder {
    encode(
        input: Record<string, any> | Record<string, any>[] | IFile[],
    ): Promise<string | IFile[]>;
    decode(
        input: string | IFile[],
    ): Promise<Record<string, any> | Record<string, any>[] | IFile[]>;
    encodeStr(input: string | IFile[]): Promise<string | IFile[]>;
    decodeStr(input: string | IFile[]): Promise<string | IFile[]>;
}
