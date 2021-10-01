import { Store } from "express-session";
import ILocalDB from "./db/local/ILocalDB";
import IContext from "./IContext";
import IObjectParam from "./IObjectParam";
import ISession from "./ISession";
import { IUserData, ISessionData, IUserDbData } from "./ISession";

export interface ICreateSessionParam {
    context: IContext;
    idUser: string;
    nameProvider: string;
    userData: IUserData;
    sessionDuration?: number;
    sessionData: IObjectParam;
}

export interface ISessionStore extends Store {
    init(): Promise<void>;
    allSession(
        sessionId?: string | string[],
        isExpired?: boolean,
    ): Promise<{ [sid: string]: ISessionData } | null>;
}

export interface ICacheDb {
    ck_id: string;
    [key: string]: any;
}

export interface IAuthController {
    /**
     * Обновляем кеш о юзерах
     */
    updateHashAuth(): Promise<void>;
    /**
     * Добавляем пользователей в кэш
     * @param idUser индификатор пользователя
     * @param nameProvider наименование провайдера
     * @param data Данные пользователя
     */
    addUser(
        idUser: string,
        nameProvider: string,
        data: IUserData,
    ): Promise<void>;
    /**
     * Получаем данные о пользователе
     * @param idUser индификатор пользователя
     * @param nameProvider наименование провайдера
     */
    getDataUser(
        idUser: string,
        nameProvider: string,
        isAccessErrorNotFound?: boolean,
    ): Promise<IUserData | null>;
    /**
     * Создание сессии
     * @param idUser индификатор пользователя
     * @param nameProvider наименование провайдера
     * @param data данные пользователя
     * @param sessionDuration время жизни сессии в минутах
     */
    createSession(ICreateSessionParam): Promise<IUserData>;

    /**
     * Устаревание сессии
     * @param context {IContext}
     */
    logoutSession(context: IContext): Promise<void>;

    /**
     * Обновление информации у пользователя/пользователей
     * @param nameProvider наименование провайдера
     * @param ckUser индификатор пользовател
     */
    updateUserInfo(nameProvider?: string, ckUser?: string);
    /**
     * Локальная база пользователей
     * @returns user db
     */
    getUserDb(): ILocalDB<IUserDbData>;
    /**
     * Локальная база temp
     * @returns temp db
     */
    getCacheDb(): ILocalDB<ICacheDb>;

    getSessionStore(): ISessionStore;
    /**
     * Загрузка сессии
     * @param [sessionId]
     * @returns session
     */
    loadSession(
        gateContext?: IContext,
        sessionId?: string,
    ): Promise<ISession | null>;
}
