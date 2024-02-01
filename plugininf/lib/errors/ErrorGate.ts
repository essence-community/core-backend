import IObjectParam from "../IObjectParam";

export interface IError {
    err_code: number;
    err_id: string;
    err_text: string;
    metaData: IObjectParam;
    success: false;
}
class ErrorGate {
    /** Сигнал о прекращении дальнейшей обработки : (никуда не выводится) */
    public get ABORT_PROCESSING_ERROR() {
        return this.compileErrorResult(0, "");
    }
    /** Ошибка: отсутствует обязательный параметр */
    public get REQUIRED_PARAM() {
        return this.compileErrorResult(
            101,
            "Required jsonGate parameter not found or unsupported action or not found provider",
        );
    }
    /** Ошибка: запрос должен выполняться через метод POST */
    public get REQUIRED_POST() {
        return this.compileErrorResult(
            102,
            "Specified action requires POST request",
        );
    }
    /** Ошибка: запрос не реализован */
    public get NOT_IMPLEMENTED() {
        return this.compileErrorResult(103, "Specified action not implemented");
    }
    /** Ошибка: вызываемый запрос не найден в БД */
    public get NOTFOUND_QUERY() {
        return this.compileErrorResult(104, "Specified query not found");
    }
    /** Ошибка: не поддерживаемого метода http */
    public get UNSUPPORTED_METHOD() {
        return this.compileErrorResult(105, "Unsupported method");
    }
    /** Ошибка: не поддерживаемого метода http */
    public get UNSUPPORTED_CONTENT_TYPE() {
        return this.compileErrorResult(106, "Unsupported Content-Type");
    }
    /** Ошибка: запрос требует аутентификации, не указана или указана устаревшая сессия */
    public get REQUIRED_AUTH() {
        return this.compileErrorResult(
            201,
            "Session not found, specified query requires authentication",
        );
    }
    /** Ошибка: для данного запроса обязательно указание схемы */
    public get REQUIRED_SCHEMA() {
        return this.compileErrorResult(
            105,
            "Schema parameter not found, specified query requires schema",
        );
    }
    /** Ошибка: не удалось сменить схему на указанную */
    public get FAILED_ALTER_SCHEMA() {
        return this.compileErrorResult(
            202,
            "Schema alteration failed, query execution not performed",
        );
    }
    /** Ошибка: схема не существует */
    public get INVALID_SCHEMA() {
        return this.compileErrorResult(207, "Specified schema does not exists");
    }
    /** Ошибка: не удалось авторизоваться */
    public get AUTH_UNAUTHORIZED() {
        return this.compileErrorResult(401, "Unauthorized");
    }
    /** Ошибка: не доступа*/
    public get AUTH_DENIED() {
        return this.compileErrorResult(203, "Access denied");
    }
    public get AUTH_CALL_REMOTE() {
        return this.compileErrorResult(208, "Error call remote service");
    }
    /** Ошибка: не удалось инициализировать сессию */
    public get AUTH_SESSION() {
        return this.compileErrorResult(204, "Session initialization error");
    }
    /** Ошибка: запрос плагина вернул некорректные данные */
    public get INVALID_PLUGIN_RESULT() {
        return this.compileErrorResult(
            205,
            "Unexpected result of plugin call, no output data found",
        );
    }
    /** Ошибка: запрос файла вернул некорректные данные */
    public get INVALID_FILE_RESULT() {
        return this.compileErrorResult(
            206,
            "Unexpected result of file select, no file info found",
        );
    }
    /** Ошибка: файл слишком большой чтобы быть загруженным */
    public get FILE_ROW_SIZE() {
        return this.compileErrorResult(
            110,
            "Unexpected result of file select, to many rows",
        );
    }
    /** Ошибка: файл слишком большой чтобы быть загруженным */
    public get FILE_SIZE() {
        return this.compileErrorResult(
            106,
            "Invalid length of file, can't download files over 2Gb",
        );
    }
    /** Ошибка: для закачки файла требуется multipart запрос */
    public get UPLOAD_FORM_ENCTYPE() {
        return this.compileErrorResult(
            107,
            "Form should be of enctype multipart/form-data for the file uploads",
        );
    }
    /** Ошибка: закачка файла возможна только с запросами типа alter session */
    public get UPLOAD_NO_NEW_DBCONN() {
        return this.compileErrorResult(
            108,
            "Upload can't be performed with such type of query : (kd_type != 1)",
        );
    }
    /** Ошибка: произвольная ошибка плагина : compileErrorResult(может использоваться плагином) */
    public get PLUGIN_ERROR() {
        return this.compileErrorResult(300, "Any plugin error");
    }
    /** Ошибка: указанный плагин не найден : compileErrorResult(например, не указан в конфигурации) */
    public get PLUGIN_NOT_FOUND() {
        return this.compileErrorResult(301, "Specified plugin not found");
    }
    public REDIRECT_MESSAGE(url: string) {
        return this.compileErrorResult(302, url);
    }
    /** Ошибка: указанный плагин не найден : compileErrorResult(например, не указан в конфигурации) */
    public get JSON_PARSE() {
        return this.compileErrorResult(400, "Not valid json");
    }
    /** Ошибка: указанный плагин не найден : compileErrorResult(например, не указан в конфигурации) */
    public get MAINTENANCE_WORK() {
        return this.compileErrorResult(
            401,
            "Now going maintenance work, please wait",
        );
    }
    /** Компиляция ошибки */
    public compileErrorResult(code: number, nmError: string): IError {
        return {
            err_code: code,
            err_id: "",
            err_text: nmError,
            metaData: {},
            success: false,
        };
    }
}

export default new ErrorGate();
