import Logger from "../Logger";
const logger = Logger.getLogger("ProcessSender");
import MSG from "msgpack-lite";

export type TTarget =
    | "cluster"
    | "clusterAdmin"
    | "eventNode"
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
    doubleCluser?: boolean;
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
        if (option.callback && option.callback.data) {
            option.callback.data = MSG.encode(option.callback.data);
        }
        process.send(option);
    }
    if (option.doubleCluser) {
        sendProcess({
            target: "clusterAdmin",
            command: "sendServerAdminCmdAll",
            data: {
                command: option.command,
                target: option.target,
                data: option.data,
            },
        });
    }
}
/**
 *  Функция слушателя оповещений
 * @param controller
 * @param target
 */
export function initProcess(
    controller: Record<string, (data?: Record<string, any>) => Promise<any>>,
    target:
        TTarget,
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
                `Process target ${target} receive pid: ${process.pid
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
            const data = await controller[message.command](
                message.data,
            );
            if (message.callback) {
                if (message.callback.data) {
                    message.callback.data = MSG.decode(Buffer.from(message.callback.data.data));
                }
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
