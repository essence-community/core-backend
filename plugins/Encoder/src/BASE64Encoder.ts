import { IFile } from "@ungate/plugininf/lib/IContext";
import * as fs from "fs";
import { IEncoder, IEncoderParams } from "./Encoder.types";

export class BASE64Encoder implements IEncoder {
    params: IEncoderParams;
    constructor(params: IEncoderParams) {
        this.params = params;
    }
    encode(
        input: Record<string, any> | Record<string, any>[] | IFile[],
    ): Promise<string | IFile[]> {
        throw new Error("Method not implemented.");
    }
    decode(
        input: string | IFile[],
    ): Promise<Record<string, any> | Record<string, any>[] | IFile[]> {
        throw new Error("Method not implemented.");
    }
    async encodeStr(input: string | IFile[]): Promise<string | IFile[]> {
        if (Array.isArray(input) && input[0] && input[0].path) {
            await Promise.all(
                (input as IFile[]).map(async (file) => {
                    const newFile = `${file.path}.encode_xml`;
                    const json = fs.readFileSync(file.path).toString("base64");
                    fs.writeFileSync(newFile, json);
                    file.path = newFile;
                }),
            );
            return input as IFile[];
        }
        return Buffer.from(input).toString("base64");
    }
    async decodeStr(input: string | IFile[]): Promise<string | IFile[]> {
        if (Array.isArray(input) && input[0] && input[0].path) {
            await Promise.all(
                (input as IFile[]).map(async (file) => {
                    const newFile = `${file.path}.decode_xml`;
                    const xml = Buffer.from(
                        fs.readFileSync(file.path).toString(),
                        "base64",
                    );
                    fs.writeFileSync(newFile, xml.toString("utf8"));
                    file.path = newFile;
                }),
            );
            return input as IFile[];
        }
        return Buffer.from(input as string, "base64").toString("utf8");
    }
}
