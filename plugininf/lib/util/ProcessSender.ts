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
) {
    process.on("message", async (message) => {
        if (
            logger.isDebugEnabled() &&
            (message as ISenderOptions).target &&
            (message as ISenderOptions).command !== "sendAllServerCallDb"
        ) {
            logger.debug(
                `Process target ${target} receive pid: ${
                    process.pid
                } message ${JSON.stringify(message)}`,
            );
        }
        if (
            (message as ISenderOptions).target === target &&
            (message as ISenderOptions).id !== process.pid &&
            controller[(message as ISenderOptions).command]
        ) {
            if ('object' === typeof (message as ISenderOptions).data && (message as ISenderOptions).data.type === 'Buffer') {
                (message as ISenderOptions).data = MSG.decode(Buffer.from((message as ISenderOptions).data.data));
            }
            const data = await controller[
                (message as ISenderOptions).command
            ].call(controller, (message as ISenderOptions).data);
            if ((message as ISenderOptions).callback) {
                sendProcess({
                    ...(message as ISenderOptions).callback,
                    data: {
                        ...(message as ISenderOptions).callback.data,
                        ...data,
                    },
                });
            }
        }
    });
}
