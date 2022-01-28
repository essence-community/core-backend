import { isObject } from "lodash";
import { Readable } from "stream";
import IResult from "../IResult";
import ResultStream from "../stream/ResultStream";

export default class BreakException extends Error {
    public break: boolean = true;
    public resultData: IResult;
    constructor(type: string | IResult, data: Readable = ResultStream([])) {
        super();
        this.resultData = (
            isObject(type) ? type : { type: type as string, data }
        ) as IResult;
    }
}
