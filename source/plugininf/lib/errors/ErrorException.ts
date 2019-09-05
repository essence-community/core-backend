import ErrorGate, { IError } from "./ErrorGate";

export default class ErrorException extends Error {
    public result: IError;
    constructor(code: IError | number, nmError?: string) {
        let message;
        let result;
        if (typeof code === "object") {
            result = code;
            message = nmError || code.err_text;
        } else {
            result = ErrorGate.compileErrorResult(code, nmError);
            message = nmError;
        }
        super(message);
        this.name = "ErrorException";
        this.result = result;
    }
}
