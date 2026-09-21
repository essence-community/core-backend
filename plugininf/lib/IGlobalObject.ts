import {IMask} from "./IMask";

export default interface IGlobalObject {
    homedir: string;
    maskgate: IMask;
}
declare global {
    var homedir: string;
    var maskgate: IMask;
}
