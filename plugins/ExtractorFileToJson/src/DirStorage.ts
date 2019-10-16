import * as fs from "fs";
import * as Path from "path";
import { IRufusLogger } from "rufus";
import { IPluginParams } from "./ExtractorFileToJson.types";
export class DirStorage {
    private params: IPluginParams;
    private logger: IRufusLogger;
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
        path: string,
        buffer: any,
        content: string,
        size: number = Buffer.byteLength(buffer),
    ): Promise<void> {
        const prePath = path.startsWith("/") ? path : `/${path}`;
        return new Promise((resolve, reject) => {
            const dir = Path.dirname(`${this.params.cvPath}${prePath}`);
            if (!fs.existsSync(dir)) {
                fs.mkdirSync(dir, {
                    recursive: true,
                });
            }
            if (buffer.pipe) {
                const ws = fs.createWriteStream(
                    `${this.params.cvPath}${prePath}`,
                );
                ws.on("error", (err) => reject(err));
                buffer.on("error", (err) => reject(err));
                buffer.on("end", () => resolve());
                buffer.pipe(ws);
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
    public deletePath(path: string): Promise<void> {
        const prePath = path.startsWith("/") ? path : `/${path}`;
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
}
