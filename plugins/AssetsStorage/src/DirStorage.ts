import { IFile } from "@ungate/plugininf/lib/IContext";
import * as fs from "fs";
import * as os from "os";
import * as path from "path";
import { IRufusLogger } from "rufus";
import { v4 as uuidv4 } from "uuid";
import { IPluginParams, IStorage } from "./AssetsStorage.types";

export class DirStorage implements IStorage {
    private params: IPluginParams;
    private logger: IRufusLogger;
    private UPLOAD_DIR: string = process.env.GATE_UPLOAD_DIR || os.tmpdir();
    constructor(params: IPluginParams, logger: IRufusLogger) {
        this.params = params;
        this.logger = logger;
        if (!fs.existsSync(this.params.dirPath)) {
            fs.mkdirSync(this.params.dirPath, {
                recursive: true,
            });
        }
    }
    /**
     * Сохраняем в папку
     * @param gateContext
     * @param json
     * @param val
     * @param query
     * @returns
     */
    public saveFile(
        key: string,
        file: IFile,
        metaData: Record<string, string> = {},
    ): Promise<void> {
        const prePath = key.startsWith("/") ? key : `/${key}`;
        return new Promise((resolve, reject) => {
            const dir = path.dirname(`${this.params.dirPath}${prePath}`);
            if (!fs.existsSync(dir)) {
                fs.mkdirSync(dir, {
                    recursive: true,
                });
            }
            fs.writeFileSync(
                `${this.params.dirPath}${prePath}.meta`,
                JSON.stringify({
                    ...metaData,
                    ...file,
                    ContentLength: file.size,
                    ContentType: file.headers["content-type"],
                }),
            );
            const ws = fs.createWriteStream(`${this.params.dirPath}${prePath}`);
            ws.on("error", (err) => reject(err));
            const buffer = fs.createReadStream(file.path);
            buffer.on("error", (err) => reject(err));
            buffer.on("end", () => resolve());
            buffer.pipe(ws);
            return;
        });
    }
    public deletePath(key: string): Promise<void> {
        const prePath = key.startsWith("/") ? key : `/${key}`;
        return new Promise((resolve, reject) => {
            const file = `${this.params.dirPath}${prePath}`;
            if (!fs.existsSync(file)) {
                return resolve();
            }
            fs.unlink(`${this.params.dirPath}${prePath}.meta`, (err) => {
                if (err) {
                    return reject(err);
                }
                fs.unlink(file, (errC) => {
                    if (errC) {
                        return reject(errC);
                    }
                    resolve();
                });
            });
        });
    }

    public getFile(key: string): Promise<IFile> {
        const prePath = key.startsWith("/") ? key : `/${key}`;
        return new Promise((resolve, reject) => {
            const readFile = fs.createReadStream(
                `${this.params.dirPath}${prePath}`,
            );
            const filePath = path.join(this.UPLOAD_DIR, uuidv4());
            const readMetaData = JSON.parse(
                fs
                    .readFileSync(`${this.params.dirPath}${prePath}.meta`)
                    .toString(),
            );
            readFile.on("error", (err) => reject(err));
            const writeFile = fs.createWriteStream(filePath);
            writeFile.on("error", (err) => reject(err));
            readFile.on("end", () => {
                resolve({
                    fieldName: "upload",
                    headers: {
                        "content-type": readMetaData.ContentType,
                    },
                    originalFilename: readMetaData.originalFilename,
                    path: filePath,
                    size: readMetaData.ContentLength,
                });
            });
            readFile.pipe(writeFile);
        });
    }
}
