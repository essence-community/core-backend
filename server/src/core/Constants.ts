import IGlobalObject from "@ungate/plugininf/lib/IGlobalObject";
import { Constants as Constant } from "@ungate/plugininf/lib/Constants";
import * as moment from "moment-timezone";
import * as os from "os";
import * as path from "path";

const HOME_DIR: string =
    process.env.GATE_HOME_DIR || path.join(__dirname, "..");
(global as any as IGlobalObject).homedir = HOME_DIR;
class Constants extends Constant {
    /**
     * Число нод в кластере
     */
    public CLUSTER_NUM: number = process.env.GATE_CLUSTER_NUM
        ? parseInt(process.env.GATE_CLUSTER_NUM, 10)
        : os.cpus().length;
    /**
     * Http port of constants
     */
    public HTTP_PORT: number = process.env.GATE_HTTP_PORT
        ? parseInt(process.env.GATE_HTTP_PORT, 10)
        : 8080;
    /**
     * Local db of constants
     */
    public LOCAL_DB: string = (
        process.env.GATE_LOCAL_DB || "nedb"
    ).toLocaleLowerCase();
    public NEDB_MULTI_PORT: number = process.env.NEDB_MULTI_PORT
        ? parseInt(process.env.NEDB_MULTI_PORT, 10)
        : 33030;
    public NEDB_MULTI_HOST: string = process.env.NEDB_MULTI_HOST || "127.0.0.1";
    public NEDB_TEMP_DB: string =
        process.env.NEDB_TEMP_DB || path.join(os.tmpdir(), "db");

    public HOME_DIR: string = HOME_DIR;

    public CONTEXT_PLUGIN_DIR: string =
        process.env.CONTEXT_PLUGIN_DIR ||
        path.join(HOME_DIR, "plugins", "contexts");
    public PROVIDER_PLUGIN_DIR: string =
        process.env.PROVIDER_PLUGIN_DIR ||
        path.join(HOME_DIR, "plugins", "providers");
    public DATA_PLUGIN_DIR: string =
        process.env.DATA_PLUGIN_DIR || path.join(HOME_DIR, "plugins", "datas");
    public EVENT_PLUGIN_DIR: string =
        process.env.EVENT_PLUGIN_DIR ||
        path.join(HOME_DIR, "plugins", "events");
    public SCHEDULER_PLUGIN_DIR: string =
        process.env.SCHEDULER_PLUGIN_DIR ||
        path.join(HOME_DIR, "plugins", "schedulers");

    public PROPERTY_DIR: string =
        process.env.PROPERTY_DIR || path.join(HOME_DIR, "resources", "config");

    /** Время загрузки приложения */
    public APP_START_TIME = new Date().getTime();
    /** Сертификат кластера */
    public GATE_ADMIN_CLUSTER_CERT =
        process.env.GATE_ADMIN_CLUSTER_CERT ||
        path.join(HOME_DIR, "cert", "server.crt");
    /** Ключ кластера */
    public GATE_ADMIN_CLUSTER_KEY =
        process.env.GATE_ADMIN_CLUSTER_KEY ||
        path.join(HOME_DIR, "cert", "server.key");
    /** CA кластера */
    public GATE_ADMIN_CLUSTER_CA = process.env.GATE_ADMIN_CLUSTER_CA
        ? process.env.GATE_ADMIN_CLUSTER_CA
        : path.join(HOME_DIR, "cert", "ca.crt");
    /** Порт для внутренних сообщений */
    public GATE_ADMIN_CLUSTER_PORT = process.env.GATE_ADMIN_CLUSTER_PORT
        ? parseInt(process.env.GATE_ADMIN_CLUSTER_PORT, 10)
        : 43090;
    /** Наименование ноды */
    public GATE_NODE_NAME = process.env.GATE_NODE_NAME || os.hostname();
    /** Таймзона для преобразовании даты по умолчанию */
    public DEFAULT_TIMEZONE_DATE =
        process.env.GATE_DEFAULT_TIMEZONE_DATE || "Europe/Moscow";
}
const constants = new Constants();
Date.prototype.toJSON = function() {
    return moment(this)
        .clone()
        .tz(constants.DEFAULT_TIMEZONE_DATE)
        .format(constants.JSON_DATE_FORMAT);
};
export default constants;
