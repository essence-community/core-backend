import IGlobalObject from "@ungate/plugininf/lib/IGlobalObject";
import * as moment from "moment-timezone";
import * as os from "os";
import * as path from "path";

const HOME_DIR: string =
    process.env.GATE_HOME_DIR || path.join(__dirname, "..");
((global as any) as IGlobalObject).homedir = HOME_DIR;
class Constants {
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
     * Папка куда сохраниются передаваемые файлы
     */
    public UPLOAD_DIR: string = path.join(
        process.env.GATE_UPLOAD_DIR || os.tmpdir(),
        "upload_ungate",
    );
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
    /**
     * Формат даты по умолчанию
     */
    public JSON_DATE_FORMAT = "YYYY-MM-DDTHH:mm:ss";

    /** Рабочая кодировка для json */
    public JSON_ENCODING = "utf-8";

    /** MIME-тип для json */
    public JSON_CONTENT_TYPE = "application/json; charset=utf-8";

    /** MIME-тип для xml */
    public XML_CONTENT_TYPE = "application/xml; charset=utf-8";

    /** MIME-тип по умолчанию; возвращаемый */
    public FILE_CONTENT_TYPE = "application/octet-stream";

    // Зарезирвированные параметры шлюза

    /** Вид запроса (действия) */
    public ACTION_PARAM = "action";
    /** Имя запроса (nm_query в wd_sqlstore) */
    public QUERYNAME_PARAM = "query";
    /** Схема (макрос &schema или имя схемы для подключения/переключения) */
    public SCHEMA_PARAM = "schema";
    /** Сессионный ключ */
    public SESSION_PARAM = "session";
    /** Изменение Content-type для ответа */
    public RESPONSE_CONTENT_TYPE = "answerContentType";
    /** Изменение Content-disposition для ответа на запрос файла */
    public RESPONSE_CONTENT_DISPOSITION = "answerContentDisposition";
    /** Префикс параметра с паролем */
    public PASSWORD_PARAM_PREFIX = "pwd";
    /** Имя или список через разделитель (запятая) имен плагинов для предварительной обработки */
    public PLUGIN_PARAM = "plugin";
    /** Наименование провайдера */
    public PROVIDER_PARAM = "provider";
    /** Префикс сессионного параметра */
    public SESSION_PARAM_PREFIX = "sess_";
    /** Префикс для выходного параметра (не входит в имя параметра запроса к БД) */
    public OUT_PARAM_PREFIX = "out_";
    /** Префикс для параметра с типом дата (входит в имя параметра запроса к БД) */
    public DATE_PARAM_PREFIX: ["dt_", "cd_", "ct_"];
    /** Параметр, возвращающий информацию о неуспешной авторизации в запросе-авторизации */
    public AUTH_NOT_AUTH_PARAM = "not_authorized";
    /** Префикс для авторизационного параметра, который не попадает в сессию */
    public AUTH_NO_SESSION_PREFIX = "ns_";
    /** Параметр возвращающий данные для отправки клиенту в запросе-плагине */
    public PLUGIN_OUTPUT_PARAM = "output";
    /** Колонка с именем возвращаемого файла */
    public FILE_NAME_COLUMN = "filename";
    /** Колонка с mime-типом возвращаемого файла */
    public FILE_MIME_COLUMN = "filetype";
    /** Колонка с данными возвращаемого файла */
    public FILE_DATA_COLUMN = "filedata";
    /** Суффикс параметра с именем закачиваемого файла */
    public UPLOAD_FILE_NAME_SUFFIX = "_name";
    /** Суффикс параметра с именем закачиваемого файла */
    public UPLOAD_FILE_MIMETYPE_SUFFIX = "_type";
    // Возвращаемые данные при ошибке загрузки файла
    /** Имя файла, который будет отправлен клиенту при ошибке обработки action=file */
    public ERROR_FILE_NAME = "error.txt";
    /** MIME-тип файла, который будет отправлен клиенту при ошибке обработки action=file */
    public ERROR_FILE_MIME = "text/plain";
    /** Список зарезервированных параметров */
    public RESERVED_PARAMS: string[];
    /** Список зарезервированных параметров */
    public GATE_VERSION: string = process.env.GATE_VERSION || "1.25.0";
    /** Рандомная соль */
    public HASH_SALT: string = "";
    /** Наименование запроса получения сессии */
    public QUERY_GETSESSIONDATA: string = "getsessiondata";
    /** Сервис выхода */
    public QUERY_LOGOUT = "logout";

    constructor() {
        this.RESERVED_PARAMS = [
            this.ACTION_PARAM,
            this.QUERYNAME_PARAM,
            this.SESSION_PARAM,
            this.RESPONSE_CONTENT_TYPE,
            this.RESPONSE_CONTENT_DISPOSITION,
            this.PROVIDER_PARAM,
        ];
    }
}
const constants = new Constants();
Date.prototype.toJSON = function () {
    return moment(this)
        .clone()
        .tz("Etc/GMT-3")
        .format(constants.JSON_DATE_FORMAT);
};
export default constants;
