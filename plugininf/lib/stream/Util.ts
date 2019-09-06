import * as http from "http";
import { isArray, noop } from "lodash";
import { Readable, Transform } from "stream";
type TStream = Transform | NodeJS.ReadWriteStream | Readable;
/**
 * Преобразуем поток в массив
 * @param stream {ReadStream} Поток
 */
export function ReadStreamToArray(stream: Readable): Promise<any[]> {
    return new Promise((resolve, reject) => {
        const res = [];
        stream.on("error", (err) => reject(err));
        stream.on("data", (chunk) => res.push(chunk));
        stream.on("end", () => resolve(res));
    });
}
/**
 * Pipe c передачей ошибки из одного потока в другой
 * @param input
 * @param transforms
 */
export function safePipe(
    input: Readable,
    transforms: TStream | TStream[],
): Readable {
    const arrStream = isArray(transforms) ? transforms : [transforms];
    return arrStream.reduce((stream, val) => {
        stream.on("error", (err) => val.emit("error", err));
        return stream.pipe(val as any);
    }, input);
}
/**
 * Обрываем передачу в случае ошибки в потоках
 * @param stream {ReadStream} Поток
 * @param response {WriteStream} Поток
 */
export function safeResponsePipe(
    stream: Readable,
    response: http.ServerResponse,
) {
    let isError = false;
    stream.on("error", () => {
        isError = true;
    });

    const prePushing = new Transform({
        transform(chunk, encoding, done) {
            done(null, chunk);
        },
    });
    function checkStream() {
        const data = prePushing.read();
        if (data) {
            prePushing.unshift(data);
        }
        setTimeout(() => {
            if (!isError) {
                prePushing.pipe(response);
            } else {
                prePushing.on("data", noop);
            }
        }, 0);
    }
    prePushing.once("readable", checkStream);
    stream.pipe(prePushing);
}
