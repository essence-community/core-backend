import * as fs from "fs";
import * as os from "os";
import * as path from "path";
import { IRufusLogger } from "rufus";
import { Readable } from "stream";
import { uuid } from "uuidv4";
import { IFile, IPluginParams } from "./Patcher.types";
export class DirStorage {
    private params: IPluginParams;
    private logger: IRufusLogger;
    private UPLOAD_DIR: string =
        process.env.GATE_UPLOAD_DIR || os.tmpdir() || "/tmp";
    constructor(params: IPluginParams, logger: IRufusLogger) {
        this.params = params;
        this.logger = logger;
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
        buffer: Buffer | Readable,
        content: string,
        metaData: Record<string, string> = {},
        size: number = (buffer as Readable).pipe
            ? Buffer.byteLength(buffer as Buffer)
            : undefined,
    ): Promise<void> {
        const prePath = key.startsWith("/") ? key : `/${key}`;
        return new Promise((resolve, reject) => {
            const dir = path.dirname(`${this.params.cvPath}${prePath}`);
            if (!fs.existsSync(dir)) {
                fs.mkdirSync(dir, {
                    recursive: true,
                });
            }
            fs.writeFileSync(
                `${this.params.cvPath}${prePath}.meta`,
                JSON.stringify({
                    ...metaData,
                    ContentLength: size,
                    ContentType: content,
                }),
            );
            if ((buffer as Readable).pipe) {
                const ws = fs.createWriteStream(
                    `${this.params.cvPath}${prePath}`,
                );
                ws.on("error", (err) => reject(err));
                (buffer as Readable).on("error", (err) => reject(err));
                (buffer as Readable).on("end", () => resolve());
                (buffer as Readable).pipe(ws);
                return;
            }
            fs.writeFile(`${this.params.cvPath}${prePath}`, buffer, (err) => {
                if (err) {
                    reject(err);
                }
                resolve();
            });
        });
    }
    public deletePath(key: string): Promise<void> {
        const prePath = key.startsWith("/") ? key : `/${key}`;
        return new Promise((resolve, reject) => {
            const file = `${this.params.cvPath}${prePath}`;
            if (!fs.existsSync(file)) {
                return resolve();
            }
            fs.unlink(file, (err) => {
                if (err) {
                    return reject(err);
                }
                resolve();
            });
        });
    }

    public getFile(key: string): Promise<IFile> {
        const prePath = key.startsWith("/") ? key : `/${key}`;
        return new Promise((resolve, reject) => {
            const readMetaData = JSON.parse(
                fs
                    .readFileSync(`${this.params.cvPath}${prePath}.meta`)
                    .toString(),
            );
            resolve({
                fieldName: "upload",
                headers: {
                    "content-type": readMetaData.ContentType,
                },
                originalFilename: readMetaData.originalFilename,
                path: `${this.params.cvPath}${prePath}`,
                size: readMetaData.ContentLength,
            });
        });
    }
}