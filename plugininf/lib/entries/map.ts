import {CacheModel} from "./CacheModel";
import {SessionModel} from "./SessionModel";
import {UserModel} from "./UserModel";

export const toSession = (entity: SessionModel) => {
    return {
        id: entity.id,
        data: entity.data,
        create: entity.create,
        change: entity.change,
        expire: entity.expire,
        user: entity.user,
        isDelete: entity.isDelete,
    };
};

export const toCache = (entity: CacheModel) => {
    return {
        id: entity.id,
        data: entity.data,
        create: entity.create,
        change: entity.change,
        user: entity.user,
    };
};

export const toUser = (entity: UserModel) => {
    return {
        id: entity.id,
        user: entity.user,
        login: entity.login,
        create: entity.create,
        change: entity.change,
        provider: entity.provider,
        data: entity.data,
    };
};

export const fromSession = (entity: Record<string, any>) => {
    const session = new SessionModel();
    session.id = entity.id;
    session.data = entity.data;
    session.create = entity.create;
    session.change = entity.change;
    session.expire = entity.expire;
    session.user = entity.user;
    session.isDelete = Boolean(entity.isDelete);
    return session;
};

export const fromCache = (entity: Record<string, any>) => {
    const cache = new CacheModel();
    cache.id = entity.id;
    cache.data = entity.data;
    cache.create = entity.create;
    cache.change = entity.change;
    cache.user = entity.user;
    return cache;
};

export const fromUser = (entity: Record<string, any>) => {
    const user = new UserModel();
    user.id = entity.id;
    user.user = entity.user;
    user.login = entity.login;
    user.create = entity.create;
    user.change = entity.change;
    user.provider = entity.provider;
    user.data = entity.data;
    return user;
};