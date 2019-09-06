declare module "activedirectory" {
    interface IGroup {
        [key: string]: any;
    }
    interface IUser extends IGroup {
        isMemberOf(groupName: string): boolean;
    }
    interface IExtraOptions {
        tlsOptions?: any; // additrional tls options(see ldapjs for more information)
        socketPath?: string; // If you're running an LDAP server over a Unix Domain Socket, use this.
        log?: any; // You can optionally pass in a bunyan instance the client will use to acquire a logger.The client logs all messages at the trace level.
        timeout?: number; // How long the client should let operations live for before timing out. Default is Infinity.
        idleTimeout?: number; //How long the client should wait before timing out on TCP connections. Default is up to the OS.
        bindDN?: string; //The DN all connections should be bound as.
        bindCredentials?: any; //The credentials to use with bindDN.
        scope?: "base" | "one" | "sub"; // One of base, one, or sub. Defaults to base.
        filter?: string; // A string version of an LDAP filter (see below), or a programatically constructed Filter object. Defaults to (objectclass=*).
        attributes?: any; // attributes to select and return (if these are set, the server will return only these attributes). Defaults to the empty set, which means all attributes.
        sizeLimit?: number; // the maximum number of entries to return. Defaults to 0 (unlimited).
        timeLimit?: number; // the maximum amount of time the server should take in responding, in seconds. Defaults to 10. Lots of servers will ignore this.
    }
    interface IActiveDirectoryConfig extends IExtraOptions {
        baseDN: string;
        url: string; // a valid LDAP url.
        username?: string;
        password?: string;
    }
    interface IResultFind {
        groups?: IGroup[];
        users?: IUser[];
        others?: IGroup[];
    }
    export = class ActiveDirectory {
        constructor(config: IActiveDirectoryConfig);
        authenticate(
            login: string,
            password: string,
            callBack: (err: any, isAuth: boolean) => void,
        ): void;
        isUserMemberOf(
            name: string,
            member: string,
            callBack: (err: any, isMember: boolean) => void,
        ): void;
        isUserMemberOf(
            opts: IExtraOptions,
            name: string,
            member: string,
            callBack: (err: any, isMember: boolean) => void,
        ): void;
        groupExists(
            name: string,
            callBack: (err: any, isExists: boolean) => void,
        ): void;
        groupExists(
            opts: IExtraOptions,
            name: string,
            callBack: (err: any, isExists: boolean) => void,
        ): void;
        userExists(
            name: string,
            callBack: (err: any, isExists: boolean) => void,
        ): void;
        userExists(
            opts: IExtraOptions,
            name: string,
            callBack: (err: any, isExists: boolean) => void,
        ): void;
        getUsersForGroup(
            name: string,
            callBack: (err: any, users?: IUser[]) => void,
        ): void;
        getUsersForGroup(
            opts: IExtraOptions,
            name: string,
            callBack: (err: any, users?: IUser[]) => void,
        ): void;
        getGroupMembershipForUser(
            name: string,
            callBack: (err: any, groups?: IGroup[]) => void,
        ): void;
        getGroupMembershipForUser(
            opts: IExtraOptions,
            name: string,
            callBack: (err: any, groups?: IGroup[]) => void,
        ): void;
        getGroupMembershipForGroup(
            name: string,
            callBack: (err: any, groups?: IGroup[]) => void,
        ): void;
        getGroupMembershipForGroup(
            opts: IExtraOptions,
            name: string,
            callBack: (err: any, groups?: IGroup[]) => void,
        ): void;
        find(
            opts: IExtraOptions,
            callBack: (err: any, res: IResultFind) => void,
        ): void;
        find(
            filter: string,
            callBack: (err: any, res: IResultFind) => void,
        ): void;
        findDeletedObjects(
            opts: IExtraOptions,
            callBack: (err: any, arr?: any[]) => void,
        ): void;
        findUser(
            opts: IExtraOptions,
            callBack: (err: any, user?: IUser) => void,
        ): void;
        findUser(
            name: string,
            callBack: (err: any, user?: IUser) => void,
        ): void;
        findGroup(
            opts: IExtraOptions,
            callBack: (err: any, group?: IGroup) => void,
        ): void;
        findGroup(
            name: string,
            callBack: (err: any, group?: IGroup) => void,
        ): void;
        findUsers(
            opts: IExtraOptions,
            callBack: (err: any, users?: IUser[]) => void,
        ): void;
        findUsers(
            name: string,
            callBack: (err: any, users?: IUser[]) => void,
        ): void;
        findGroups(
            opts: IExtraOptions,
            callBack: (err: any, groups?: IGroup[]) => void,
        ): void;
        findGroups(
            name: string,
            callBack: (err: any, groups?: IGroup[]) => void,
        ): void;
        getRootDSE(
            url: string,
            arr: string[],
            callBack: (err: any, result?: any) => void,
        ): void;
    };
}
