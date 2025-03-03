/**
 * Created by artemov_i on 04.12.2018.
 */
import { IRequest } from "@ungate/plugininf/lib/IContext";
import Logger from "@ungate/plugininf/lib/Logger";
import {
    initProcess,
    sendProcess,
} from "@ungate/plugininf/lib/util/ProcessSender";
import * as compression from "compression";
import * as cors from "cors";
import * as http from "http";
import helmet from "helmet";
import { noop } from "lodash";
import * as Router from "router";
import * as expressSession from "express-session-fork";
import Constants from "../core/Constants";
import PluginManager from "../core/pluginmanager/PluginManager";
import IContextConfig from "../core/property/IContextConfig";
import Property from "../core/property/Property";
import RequestContext from "../core/request/RequestContext";
import BodyParse from "./BodyParse";
import MainController from "./controllers/MainController";
import NotificationController from "./controllers/NotificationController";
import ProcessController from "./controllers/ProcessController";
import ResultController from "./controllers/ResultController";
import { initParams } from "@ungate/plugininf/lib/util/Util";
import NullContext from "@ungate/plugininf/lib/NullContext";
import { IContextParams } from "@ungate/plugininf/lib/IContextPlugin";
import { GateSession } from "../core/session/GateSession";
import { CreateJsonStream } from "@ungate/plugininf/lib/stream/ResultStream";
const log = Logger.getLogger("HttpServer");

class HttpServer {
    private route: any;

    /**
     * Инициализация машрутов
     */
    public async initRoute () {
        this.route = Router();
        this.route.use(compression());
        const contextDb = await Property.getContext();
        const contexts = await contextDb.find({});
        await Promise.all(
            contexts.map(async (obj) => {
                const doc = obj as IContextConfig;
                const gateContext = PluginManager.getGateContext(doc.ck_id);
                const params: IContextParams = initParams(
                    NullContext.getParamsInfo(),
                    gateContext.params,
                );
                const route = Router({
                    mergeParams: true,
                });
                this.route.use(doc.cv_path, route);
                const sessionConf = {
                    name: "essence.sid",
                    ...(params.paramSession || {}),
                    store: gateContext.sessCtrl.getSessionStore(),
                    secret: GateSession.sha1(
                        `${gateContext.name}_cookie_${Constants.SESSION_SECRET}`,
                    ),
                };
                sessionConf.cookie.maxAge *= 1000;
                route.use(expressSession(sessionConf as any));
                route.use(BodyParse(gateContext));
                if (params.enableCors) {
                    route.use(cors(params.cors));
                }
                if (params.enableHelmet) {
                    route.use(helmet(params.helmet));
                }
                route.all("/", (req, res) => {
                    MainController.execute(
                        new RequestContext(req as IRequest, res, gateContext),
                    ).then(noop, (err) => log.trace(err));
                });
            }),
        );
    }

    /**
     * Запуск сервера
     */
    public async start (): Promise<any> {
        await PluginManager.initGate();
        await this.initRoute();
        await MainController.init();
        await ProcessController.init();
        initProcess(ProcessController, "cluster");
        // tslint:disable-next-line:no-shadowed-variable
        const HttpServer = http.createServer((req, res) => {
            this.route(req, res, (err) => {
                if (err) {
                    log.warn(err);
                }
                if (err && err.gateContext) {
                    ResultController.responseCheck(
                        new RequestContext(
                            req as IRequest,
                            res,
                            err.gateContext,
                        ),
                        null,
                        err,
                    );
                    return;
                }
                const stream = CreateJsonStream({
                    err_code: 404,
                    err_text: "is not an implemented route",
                    metaData: { responseTime: 0.0 },
                    success: false,
                });
                res.writeHead(404, {
                    "Content-Type": Constants.JSON_CONTENT_TYPE,
                });
                stream.pipe(res);
            });
        });
        HttpServer.timeout = 86400000;
        HttpServer.setTimeout(86400000);
        await NotificationController.init(HttpServer);

        HttpServer.listen(Constants.HTTP_PORT);
    }
}
const server = new HttpServer();
server.start().then(
    () => {
        sendProcess({
            command: "startedCluster",
            data: {},
            target: "master",
        });
        log.info("HTTP server started!");
    },
    (err) => {
        if (err) {
            log.error(`HTTP Server fail start\n${err.message}`, err);
        }
        process.exit(1);
    },
);

export default server;
