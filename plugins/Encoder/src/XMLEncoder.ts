import { IFile } from "@ungate/plugininf/lib/IContext";
import { IEncoder, IEncoderParams } from "./Encoder.types";
import {XMLParser, X2jOptions, XMLBuilder, XmlBuilderOptions} from "fast-xml-parser";
import * as he from "he";
import * as fs from "fs";

export class XMLEncoder implements IEncoder {
    x2joptions: Partial<X2jOptions>;
    j2xoptions: XmlBuilderOptions;
    jsonToXmlParser: XMLBuilder;
    xmlToJsonParser: XMLParser;
    params: IEncoderParams;
    constructor(params: IEncoderParams) {
        this.params = params;
        this.x2joptions = {
            attributeNamePrefix: "@_",
            textNodeName: "#text",
            ignoreAttributes: true,
            allowBooleanAttributes: false,
            parseAttributeValue: false,
            trimValues: true,
            tagValueProcessor: (val, tagName) => he.decode(val), // default is a=>a
            stopNodes: ["parse-me-as-string"],
        };
        this.j2xoptions = {
            attributeNamePrefix: "@_",
            textNodeName: "#text",
            ignoreAttributes: true,
            format: false,
            indentBy: "  ",
            tagValueProcessor: (a) =>
                he.encode(`${a}`, { useNamedReferences: true }), // default is a=>a
        };
        this.jsonToXmlParser = new XMLBuilder(this.j2xoptions);
        this.xmlToJsonParser = new XMLParser(this.x2joptions);
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
                    const newFile = `${file.path}.encode_xml`;
                    const json = JSON.parse(
                        fs.readFileSync(file.path).toString(),
                    );
                    fs.writeFileSync(newFile, this.jsonToXmlParser.build(json));
                    fs.unlinkSync(file.path);
                    file.path = newFile;
                }),
            );
            return input as IFile[];
        }
        return this.jsonToXmlParser.build(input);
    }
    async decode(
        input: string | IFile[],
    ): Promise<Record<string, any> | Record<string, any>[] | IFile[]> {
        if (Array.isArray(input) && input[0] && input[0].path) {
            await Promise.all(
                (input as IFile[]).map(async (file) => {
                    const newFile = `${file.path}.decode_xml`;
                    const xml = fs.readFileSync(file.path).toString();
                    fs.writeFileSync(
                        newFile,
                        JSON.stringify(this.xmlToJsonParser.parse(xml, this.j2xoptions)),
                    );
                    fs.unlinkSync(file.path);
                    file.path = newFile;
                }),
            );
            return input as IFile[];
        }
        return this.xmlToJsonParser.parse(input as string, this.j2xoptions);
    }
}
