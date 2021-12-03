import { IFile } from "@ungate/plugininf/lib/IContext";
import { IEncoder, IEncoderParams } from "./Encoder.types";
import * as parser from "fast-xml-parser";
import * as he from "he";
import * as fs from "fs";

const Parser = parser.j2xParser;

export class XMLEncoder implements IEncoder {
    x2joptions: Partial<parser.X2jOptions>;
    j2xoptions: parser.J2xOptions;
    jsonToXmlParser: parser.j2xParser;
    params: IEncoderParams;
    constructor(params: IEncoderParams) {
        this.params = params;
        this.x2joptions = {
            attributeNamePrefix: "@_",
            attrNodeName: "attr", // default is 'false'
            textNodeName: "#text",
            ignoreAttributes: true,
            ignoreNameSpace: false,
            allowBooleanAttributes: false,
            parseNodeValue: true,
            parseAttributeValue: false,
            trimValues: true,
            cdataTagName: "__cdata", // default is 'false'
            cdataPositionChar: "\\c",
            parseTrueNumberOnly: false,
            arrayMode: false, // "strict"
            attrValueProcessor: (val, attrName) =>
                he.decode(val, { isAttributeValue: true }), // default is a=>a
            tagValueProcessor: (val, tagName) => he.decode(val), // default is a=>a
            stopNodes: ["parse-me-as-string"],
        };
        this.j2xoptions = {
            attributeNamePrefix: "@_",
            attrNodeName: "@", // default is false
            textNodeName: "#text",
            ignoreAttributes: true,
            cdataTagName: "__cdata", // default is false
            cdataPositionChar: "\\c",
            format: false,
            indentBy: "  ",
            supressEmptyNode: false,
            tagValueProcessor: (a) =>
                he.encode(`${a}`, { useNamedReferences: true }), // default is a=>a
            attrValueProcessor: (a) =>
                he.encode(`${a}`, {
                    isAttributeValue: false,
                    useNamedReferences: true,
                }), // default is a=>a
        };
        this.jsonToXmlParser = new Parser(this.j2xoptions);
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
                    fs.writeFileSync(newFile, this.jsonToXmlParser.parse(json));
                    fs.unlinkSync(file.path);
                    file.path = newFile;
                }),
            );
            return input as IFile[];
        }
        return this.jsonToXmlParser.parse(input);
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
                        JSON.stringify(parser.parse(xml, this.j2xoptions)),
                    );
                    fs.unlinkSync(file.path);
                    file.path = newFile;
                }),
            );
            return input as IFile[];
        }
        return parser.parse(input as string, this.j2xoptions);
    }
}
