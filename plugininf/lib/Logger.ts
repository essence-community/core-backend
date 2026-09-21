import * as fs from "fs";
import * as path from "path";
import * as util from "util";
import pino from "pino";
import {createStream as createRotatingStream} from "rotating-file-stream";
import IGlobalObject from "./IGlobalObject";

export interface IRufusLogger {
    _handlers: any[];
    isEnabledFor(level: number): boolean;
    isDebugEnabled(): boolean;
    isTraceEnabled(): boolean;
    isWarnEnabled(): boolean;
    isInfoEnabled(): boolean;
    setLevel(lvl: string): void;
    addHandler(handle?: any): IRufusLogger;
    log(...args: any[]): void;
    notset(...args: any[]): void;
    verbose(...args: any[]): void;
    debug(...args: any[]): void;
    info(...args: any[]): void;
    warning(...args: any[]): void;
    warn(...args: any[]): void;
    error(...args: any[]): void;
    critical(...args: any[]): void;
    fatal(...args: any[]): void;
    trace(...args: any[]): void;
    child(...args: any[]): IRufusLogger;
}

const LEVEL_MAP: Record<string, pino.LevelWithSilent> = {
    NOTSET: "trace",
    VERBOSE: "trace",
    TRACE: "trace",
    DEBUG: "debug",
    INFO: "info",
    WARNING: "warn",
    WARN: "warn",
    ERROR: "error",
    CRITICAL: "fatal",
    FATAL: "fatal",
};

const pathConf =
    process.env.LOGGER_CONF ||
    path.join(
        (global as any as IGlobalObject).homedir || __dirname,
        "resources",
        "config",
        "logger.json",
    );

let root: pino.Logger = pino({level: "info"});
const children = new Map<string, pino.Logger>();

function toPinoLevel(lvl: string): pino.LevelWithSilent {
    return LEVEL_MAP[String(lvl).toUpperCase()] || "info";
}

function emit(logger: pino.Logger, level: pino.Level, args: any[]): void {
    if (!args.length) {
        return;
    }
    if (args[0] instanceof Error) {
        const err = args[0];
        const msg =
            args.length > 1 ? util.format(...args.slice(1)) : err.message;
        logger[level](err, msg);
        return;
    }
    logger[level](util.format(...args));
}

function wrap(name: string): IRufusLogger {
    const get = () => {
        let child = children.get(name);
        if (!child) {
            child = name ? root.child({name}) : root;
            children.set(name, child);
        }
        return child;
    };
    const self: IRufusLogger = {
        _handlers: [],
        isEnabledFor(level: number) {
            return get().levelVal <= level;
        },
        isDebugEnabled() {
            return get().isLevelEnabled("debug");
        },
        isTraceEnabled() {
            return get().isLevelEnabled("trace");
        },
        isWarnEnabled() {
            return get().isLevelEnabled("warn");
        },
        isInfoEnabled() {
            return get().isLevelEnabled("info");
        },
        setLevel(lvl: string) {
            get().level = toPinoLevel(lvl);
        },
        addHandler() {
            return self;
        },
        log(...args) {
            emit(get(), "info", args);
        },
        notset(...args) {
            emit(get(), "trace", args);
        },
        verbose(...args) {
            emit(get(), "trace", args);
        },
        trace(...args) {
            emit(get(), "trace", args);
        },
        debug(...args) {
            emit(get(), "debug", args);
        },
        info(...args) {
            emit(get(), "info", args);
        },
        warning(...args) {
            emit(get(), "warn", args);
        },
        warn(...args) {
            emit(get(), "warn", args);
        },
        error(...args) {
            emit(get(), "error", args);
        },
        critical(...args) {
            emit(get(), "fatal", args);
        },
        fatal(...args) {
            emit(get(), "fatal", args);
        },
        child() {
            return self;
        },
    };
    return self;
}

function parseSize(size: string): string {
    return String(size)
        .trim()
        .toUpperCase()
        .replace(/B$/, "")
        .replace(/IB$/, "");
}

function openStream(handler: any): NodeJS.WritableStream {
    if (!handler || !handler.file) {
        return process.stdout;
    }
    const file = handler.file;
    const dir = path.dirname(file);
    if (!fs.existsSync(dir)) {
        fs.mkdirSync(dir, {recursive: true});
    }
    if (handler.maxSize || /rotat/i.test(handler.class || "")) {
        return createRotatingStream(path.basename(file), {
            path: dir,
            size: parseSize(
                handler.maxSize || "30M",
            ) as `${number}${"B" | "K" | "M" | "G"}`,
            maxFiles: parseInt(handler.maxFile, 10) || 30,
        });
    }
    return pino.destination({dest: file, mkdir: true, sync: false}) as any;
}

function applyConfig(json: any): void {
    const handlers = json.handlers || {};
    const rootCfg = (json.loggers && json.loggers.root) || {};
    const handlerNames: string[] =
        rootCfg.handlers && rootCfg.handlers.length
            ? rootCfg.handlers
            : Object.keys(handlers);
    const streams = handlerNames
        .map((name) => handlers[name] ? [handlers[name]] : rootCfg.handlers)
        .filter(Boolean)
        .flat()
        .map((handler) => ({
            level: toPinoLevel(handler.level || "info") as pino.Level,
            stream: openStream(handler),
        }));
    children.clear();
    root = pino(
        {
            level: toPinoLevel(rootCfg.level || "info"),
            timestamp: pino.stdTimeFunctions.isoTime,
        },
        streams.length ? pino.multistream(streams) : process.stdout,
    );
}

class Logger {
    public static loadConfig(): void {
        if (!fs.existsSync(pathConf)) {
            applyConfig({
                handlers: {console: {}},
                loggers: {root: {level: "INFO", handlers: ["console"]}},
            });
            return;
        }
        try {
            applyConfig(JSON.parse(fs.readFileSync(pathConf, "utf8")));
        } catch (err) {
            console.error("Ошибка инициализации настроек логера", err);
            applyConfig({
                handlers: {console: {}},
                loggers: {root: {level: "INFO", handlers: ["console"]}},
            });
        }
    }

    public static getRootLogger(): IRufusLogger {
        return wrap("");
    }

    public static getLogger(str: string): IRufusLogger {
        return wrap(str);
    }
}

if (fs.existsSync(pathConf)) {
    fs.watch(pathConf, () => Logger.loadConfig());
}
Logger.loadConfig();
Logger.getLogger("Logger").info("Init Logger");

export default Logger;
