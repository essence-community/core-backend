declare module "@ungate/nedb-multi" {
    export function NeDbProxy(port: number, host?: string): INeDb;
    export interface IHandlerNeDb {
        create(map: Map<string, any>);
    }
    export type callBack = (err: Error | null, obj?: any) => void;
    export interface IPersistence {
        compactDatafile();
        setAutocompactionInterval(num: number);
        stopAutocompaction();
    }
    export interface INeDb {
        loadDatabase(callBack): void;
        find(obj: any, callBack: callBack): void;
        findOne(obj: any, callBack: callBack): void;
        insert(obj: any, callBack: callBack): void;
        update(
            obj: any,
            obj2: any,
            opts: any | callBack,
            callBack?: callBack,
        ): void;
        remove(obj: any, obj2: any | callBack, callBack?: callBack): void;
        count(obj: any, callBack: callBack): void;
        persistence: IPersistence;
    }

    export = {
        HandlerNeDb: IHandlerNeDb,
        NeDbProxy,
    };
}
