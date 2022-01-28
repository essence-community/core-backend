import IGlobalObject from "@ungate/plugininf/lib/IGlobalObject";
import ISession from "@ungate/plugininf/lib/ISession";
import Logger from "@ungate/plugininf/lib/Logger";
import { debounce } from "@ungate/plugininf/lib/util/Util";
import { isFunction, isObject, noop } from "lodash";
import { IMask, TCallBack } from "@ungate/plugininf/lib/IMask";
const logger = Logger.getLogger("Mask");
interface IFObject {
    scope?: any;
    callback: TCallBack;
}

class BMask implements IMask {
    private maskFlag: boolean = false;
    // tslint:disable-next-line:variable-name
    private _events: {
        [key: string]: IFObject[];
    } = {};
    /**
     * Возращаем
     * @returns {boolean}
     */
    get masked() {
        return this.maskFlag;
    }

    private debounceMask = debounce((session?: ISession) => {
        const old = this.maskFlag;
        return this.fireEvent("beforechange", true, old, session)
            .then(() => {
                this.maskFlag = true;
                if (!old) {
                    return this.fireEvent("change", true, old, session);
                }
                return Promise.resolve();
            })
            .catch((err) => {
                logger.error(err);
                return Promise.resolve();
            });
    }, 200);

    /**
     * Включаем маску
     */
    public mask(session?: ISession) {
        this.debounceMask(session);
        return Promise.resolve();
    }

    /**
     * Включаем маску
     */
    public unmask(session?: ISession) {
        this.debounceMask.cancel();
        const old = this.maskFlag;
        return this.fireEvent("beforechange", false, old, session)
            .then(() => {
                this.maskFlag = false;
                if (old) {
                    return this.fireEvent("change", false, old, session);
                }
                return Promise.resolve();
            })
            .catch((err) => {
                logger.error(err);
                return Promise.resolve();
            });
    }

    /**
     * Принудительная установка маски
     * @param isMask
     */
    public setMask(isMask: boolean, session?: ISession) {
        const old = this.maskFlag;
        this.maskFlag = isMask;
        if (old !== isMask) {
            this.fireEvent("change", isMask, old, session).then(noop, noop);
        }
    }

    public isEvent(event, callback) {
        if (arguments.length !== 2 || !isFunction(callback)) {
            return false;
        }
        if (this._events[event]) {
            return (
                this._events[event].filter((fn) => fn.callback === callback)
                    .length > 0
            );
        }
        return false;
    }

    public on(event, callback, scope = null) {
        if (arguments.length < 2 || !isFunction(callback)) {
            return;
        }
        if (this._events[event]) {
            this._events[event].push({
                callback,
                scope,
            });
        } else {
            this._events[event] = [
                {
                    callback,
                    scope,
                },
            ];
        }
    }

    public un(event, callback) {
        if (arguments.length < 2 || !isFunction(callback)) {
            return;
        }
        if (this._events[event]) {
            this._events[event] = this._events[event].filter(
                (fn) => fn.callback !== callback,
            );
        }
    }

    public fireEvent(event, ...arg) {
        if (this._events[event]) {
            return this._events[event].reduce(
                (obj, val) =>
                    obj.then(() => {
                        const result = val.callback.call(val.scope, ...arg);
                        if (
                            isObject(result) &&
                            result.constructor.name === "Promise"
                        ) {
                            return result;
                        }
                        return result === false
                            ? Promise.reject()
                            : Promise.resolve();
                    }),
                Promise.resolve(),
            );
        }
        return Promise.resolve();
    }
}

const Mask = new BMask();
(global as any as IGlobalObject).maskgate = Mask;

export default Mask;
