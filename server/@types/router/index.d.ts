declare module "router" {
    import * as http from "http";
    export interface IRouterOptions {
        strict?: true | false;
        caseSensitive?: true | false;
        mergeParams?: true | false;
    }
    export interface IRequest extends http.IncomingMessage {
        params: IParam;
    }
    export type NextCallBack = (err?: Error) => void;
    export type RouterCallBack = (
        request: IRequest,
        response: http.ServerResponse,
        next?: NextCallBack,
        param?: any,
    ) => void;
    interface IRouter {
        (
            request: IRequest,
            response: http.ServerResponse,
            next?: NextCallBack,
        ): void;
        use(name: string | RouterCallBack, handle?: RouterCallBack): void;
        route(name: string): IRouter;
        param(param: string, handle: RouterCallBack): void;
        all(name: string | RouterCallBack, handle: RouterCallBack): void;
        get(name: string | RouterCallBack, handle?: RouterCallBack): void;
        post(name: string | RouterCallBack, handle?: RouterCallBack): void;
        put(name: string | RouterCallBack, handle?: RouterCallBack): void;
        head(name: string | RouterCallBack, handle?: RouterCallBack): void;
        delete(name: string | RouterCallBack, handle?: RouterCallBack): void;
        options(name: string | RouterCallBack, handle?: RouterCallBack): void;
        trace(name: string | RouterCallBack, handle?: RouterCallBack): void;
        copy(name: string | RouterCallBack, handle?: RouterCallBack): void;
        lock(name: string | RouterCallBack, handle?: RouterCallBack): void;
        mkcol(name: string | RouterCallBack, handle?: RouterCallBack): void;
        move(name: string | RouterCallBack, handle?: RouterCallBack): void;
        purge(name: string | RouterCallBack, handle?: RouterCallBack): void;
        propfind(name: string | RouterCallBack, handle?: RouterCallBack): void;
        proppatch(name: string | RouterCallBack, handle?: RouterCallBack): void;
        unlock(name: string | RouterCallBack, handle?: RouterCallBack): void;
        report(name: string | RouterCallBack, handle?: RouterCallBack): void;
        mkactivity(
            name: string | RouterCallBack,
            handle?: RouterCallBack,
        ): void;
        checkout(name: string | RouterCallBack, handle?: RouterCallBack): void;
        merge(name: string | RouterCallBack, handle?: RouterCallBack): void;
        notify(name: string | RouterCallBack, handle?: RouterCallBack): void;
        subscribe(name: string | RouterCallBack, handle?: RouterCallBack): void;
        unsubscribe(
            name: string | RouterCallBack,
            handle?: RouterCallBack,
        ): void;
        patch(name: string | RouterCallBack, handle?: RouterCallBack): void;
        search(name: string | RouterCallBack, handle?: RouterCallBack): void;
        connect(name: string | RouterCallBack, handle?: RouterCallBack): void;
    }
    function Router(options?: IRouterOptions): IRouter;
    export = Router;
}
