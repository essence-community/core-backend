import Logger from "../Logger";
const logger = Logger.getLogger("ProcessSender");
import * as MSG from "msgpack-lite";

export type TTarget =
    | "cluster"
    | "clusterAdmin"
    | "eventNode"
    | "localDbNode"
    | "schedulerNode"
    | "master";
export interface ISenderOption {
    target: TTarget;
    command: string;
    data?: any;
}
export interface ISenderOptions extends ISenderOption {
    data: any;
    id?: any;
    callback?: ISenderOption;
}
/**
 *
 * @param option Отправка сообщения
 * @param force
 */
export async function sendProcess(
    option: ISenderOptions,
    force: boolean = false,
) {
    if (!force) {
        option.id = process.pid;
    }
    if (logger.isDebugEnabled() && option.command !== "sendAllServerCallDb") {
        logger.debug(
            `Process send pid: ${process.pid} message ${JSON.stringify(
                option,
            )}`,
        );
    }
    if (process && process.send) {
        if (option.data) {
            option.data = MSG.encode(option.data);
        }
        process.send(option);
    }
}
/**
 *  Функция слушателя оповещений
 * @param controller
 * @param target
 */
export function initProcess(
    controller: any = {},
    target:
        | "cluster"
        | "clusterAdmin"
        | "eventNode"
        | "localDbNode"
        | "schedulerNode",
    isLogger = true,
) {
    process.on("message", async (message: ISenderOptions) => {
        if (
            isLogger &&
            logger.isTraceEnabled() &&
            message.target &&
            message.command !== "sendAllServerCallDb"
        ) {
            logger.trace(
                `Process target ${target} receive pid: ${
                    process.pid
                } message ${JSON.stringify(message)}`,
            );
        }
        if (
            message.target === target &&
            message.id !== process.pid &&
            controller[message.command]
        ) {
            if (
                "object" === typeof message.data &&
                message.data.type === "Buffer"
            ) {
                message.data = MSG.decode(Buffer.from(message.data.data));
            }
            const data = await controller[message.command].call(
                controller,
                message.data,
            );
            if (message.callback) {
                sendProcess({
                    ...message.callback,
                    data: {
                        ...message.callback.data,
                        ...data,
                    },
                });
            }
        }
    });
}
