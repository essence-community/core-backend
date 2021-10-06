import ISession from "./ISession";

export type TCallBack = (...args: any) => Promise<void>;

export type TEventMask = "change" | "beforechange";

export interface IMask {
    masked: boolean;
    mask(session?: ISession);
    unmask(session?: ISession);
    on(event: TEventMask, cl: TCallBack, scope?: any);
    un(event: TEventMask, cl: TCallBack, scope?: any);
    fireEvent(event: TEventMask, ...args: any);
    isEvent(event: TEventMask, cl: TCallBack): boolean;
}
