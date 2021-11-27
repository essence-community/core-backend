import IResult from "@ungate/plugininf/lib/IResult";

export class BreakResult {
    constructor(public result: any, public type?: IResult["type"]) {}
}
