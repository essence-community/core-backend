import { isString } from "lodash";
import * as moment from "moment";
import ErrorException from "./errors/ErrorException";
import ErrorGate from "./errors/ErrorGate";
import { IParamsInfo } from "./ICCTParams";
import ICCTParams from "./ICCTParams";
import IContext from "./IContext";
import IGlobalObject, { IAuthController } from "./IGlobalObject";
import IObjectParam from "./IObjectParam";
import IQuery, { IGateQuery } from "./IQuery";
import { IResultProvider } from "./IResult";
import ISession from "./ISession";
import NullProvider from "./NullProvider";
import { IParamsProvider } from "./NullProvider";
import { isEmpty } from "./util/Util";

export interface IAuthResult {
    ck_user: string;
    data?: IObjectParam;
}
export interface IAuthProviderParam extends IParamsProvider {
    onlySession: boolean;
    sessionDuration: number;
}
export default abstract class NullAuthProvider extends NullProvider {
    public static getParamsInfo(): IParamsInfo {
        return {
            ...NullProvider.getParamsInfo(),
            onlySession: {
                defaultValue: false,
                name: "Возвращаем только полученую сессию",
                type: "boolean",
            },
            sessionDuration: {
                defaultValue: 60,
                name: "Время жизни сессии в минутах по умолчанию 60 минут",
                type: "integer",
            },
        };
    }
    public params: IAuthProviderParam;
    public isAuth: boolean = true;
    public authController: IAuthController;
    constructor(name: string, params: ICCTParams) {
        super(name, params);
        this.authController = ((global as any) as IGlobalObject).authController;
    }
    public async beforeSession(
        context: IContext,
        sessionId?: string,
    ): Promise<ISession | void> {
        return;
    }
    public async afterSession(
        context: IContext,
        sessionId?: string,
        session?: ISession,
    ): Promise<ISession> {
        return session;
    }
    public abstract processAuth(
        context: IContext,
        query: IGateQuery,
    ): Promise<IAuthResult>;
    public processSql(
        context: IContext,
        query: IGateQuery,
    ): Promise<IResultProvider> {
        throw new ErrorException(ErrorGate.UNSUPPORTED_METHOD);
    }
    public processDml(
        context: IContext,
        query: IGateQuery,
    ): Promise<IResultProvider> {
        throw new ErrorException(ErrorGate.UNSUPPORTED_METHOD);
    }
    public fileInParams(file: Buffer) {
        return file;
    }
    public dateInParams(date: string) {
        return moment(date).toDate();
    }
    public arrayInParams(val: any[]) {
        return val;
    }
    public async createSession(
        idUser: string,
        data: IObjectParam = {},
        sessionDuration: number = this.params.sessionDuration || 60,
        isAccessErrorNotFound: boolean = false,
    ): Promise<IObjectParam> {
        if (isEmpty(idUser)) {
            throw new ErrorException(ErrorGate.AUTH_DENIED);
        }
        if (data.ca_actions) {
            data.ca_actions = isString(data.ca_actions)
                ? JSON.parse(data.ca_actions)
                : data.ca_actions;
        }
        const dataUser = await this.authController.getDataUser(
            idUser,
            this.name,
            isAccessErrorNotFound,
        );
        const session = await this.authController.createSession(
            idUser,
            this.name,
            { ...dataUser, ...data },
            sessionDuration,
        );
        return this.params.onlySession ? { session: session.session } : session;
    }
    public async destroy(): Promise<void> {
        return;
    }
    public abstract init(reload?: boolean): Promise<void>;
    public async initContext(
        context: IContext,
        query: IQuery = {},
    ): Promise<IQuery> {
        if (context.actionName === "auth") {
            query.needSession = false;
        }
        return query;
    }
}
