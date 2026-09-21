import {Store} from "express-session-fork";
import IContext from "./IContext";
import IObjectParam from "./IObjectParam";
import ISession from "./ISession";
import {IUserData, ISessionData} from "./ISession";
import {Repository} from "typeorm";
import {CacheModel} from "./entries/CacheModel";
import {SessionModel} from "./entries/SessionModel";
import {UserModel} from "./entries/UserModel";

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
    ): Promise<{[sid: string]: ISessionData} | null>;
}

export interface ICacheDb {
    ck_id: string;
    [key: string]: any;
}

export interface ISessCtrl {
    /**
     * Обновляем кеш о юзерах
     */
    updateHashAuth(): Promise<void>;
    /**
     * Добавляем пользователей в кэш
     * @param idUser индификатор пользователя
     * @param nameProvider наименование провайдера
     * @param data Данные пользователя
     * @param login Логин пользоаптеля если есть
     */
    addUser(
        idUser: string,
        nameProvider: string,
        data: IUserData,
        login?: string,
        isEvent?: boolean,
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
    createSession(param: ICreateSessionParam): Promise<IUserData>;

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
    updateUserInfo(nameProvider?: string, ckUser?: string): Promise<void>;
    /**
     * Локальная база пользователей
     * @returns user db
     */
    getUserStore(): Repository<UserModel>;
    /**
     * Локальная база temp
     * @returns temp db
     */
    getCacheStore(): Repository<CacheModel>;

    /**
     * Локальная база сессий
     * @returns session db
     */
    getSessionStore(): Repository<SessionModel>;

    /**
     * Получаем express session store
     * @returns express session store
     */
    getExpressSessionStore(): Store;
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
