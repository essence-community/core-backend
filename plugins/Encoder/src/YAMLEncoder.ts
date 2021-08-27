import { IFile } from "@ungate/plugininf/lib/IContext";
import { IEncoder, IEncoderParams } from "./Encoder.types";
import * as YAML from "js-yaml";
import * as fs from "fs";
export class YAMLEncoder implements IEncoder {
    params: IEncoderParams;
    constructor(params: IEncoderParams) {
        this.params = params;
    }
    encodeStr(input: string | IFile[]): Promise<string | IFile[]> {
        throw new Error("Method not implemented.");
    }
    decodeStr(input: string | IFile[]): Promise<string | IFile[]> {
        throw new Error("Method not implemented.");
    }
    async encode(
        input: Record<string, any> | Record<string, any>[] | IFile[],
    ): Promise<string | IFile[]> {
        if (Array.isArray(input) && input[0] && input[0].path) {
            await Promise.all(
                (input as IFile[]).map(async (file) => {
                    const newFile = `${file.path}.encode_yaml`;
                    const infile = JSON.parse(
                        fs.readFileSync(file.path).toString(),
                    );
                    fs.writeFileSync(newFile, YAML.dump(infile));
                    fs.unlinkSync(file.path);
                    file.path = newFile;
                }),
            );
            return input as IFile[];
        }
        return YAML.dump(input);
    }
    async decode(
        input: string | IFile[],
    ): Promise<Record<string, any> | Record<string, any>[] | IFile[]> {
        if (Array.isArray(input) && input[0] && input[0].path) {
            await Promise.all(
                (input as IFile[]).map(async (file) => {
                    const newFile = `${file.path}.decode_yaml`;
                    const infile = fs.readFileSync(file.path).toString();
                    fs.writeFileSync(
                        newFile,
                        JSON.stringify(YAML.load(infile)),
                    );
                    fs.unlinkSync(file.path);
                    file.path = newFile;
                }),
            );
            return input as IFile[];
        }
        return YAML.load(input);
    }
}
