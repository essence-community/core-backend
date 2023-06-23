import { TypeOrmLogger } from "../db/TypeOrmLogger";
import { IAuditServiceParam } from "./AuditService.types";
import { Connection, ConnectionManager } from "typeorm";
import IContext from "../IContext";
import { LogModel } from "./entries/LogModel";
import Logger from "../Logger";
import { IRufusLogger } from 'rufus';

export class AuditService {
    private params: IAuditServiceParam;
    private name: string;
    private logger: IRufusLogger;
    private connection: Connection;
    private isConnect = false;

    constructor(name: string, params: IAuditServiceParam) {
        this.params = params;
        this.name = name;
        this.logger = Logger.getLogger(`Audit.${name}`);
        const connectionManager = new ConnectionManager();
        this.connection = connectionManager.create({
                ...this.params,
                extra: this.params.extra
                    ? JSON.parse(this.params.extra)
                    : undefined,
                synchronize: false,
                ...(this.params.typeOrmExtra
                    ? JSON.parse(this.params.typeOrmExtra)
                    : {}),
                name: `audit_store_${this.name}`,
                logging: true,
                logger: new TypeOrmLogger(`Audit:${this.name}`),
                entities: [LogModel],
            });
        this.connection.connect()
        .then(() => this.isConnect = true)
        .catch((err) => {
            this.logger.error(err);
        });
    }

    save(context: IContext) {
        (this.isConnect ? Promise.resolve(this.connection) : this.connection.connect())
        .then((conn) => conn.getRepository(LogModel).save({
            requestId: context.hash,
            query: context.queryName,
            requestData: context.params,
            sessionData: context.request.session,
            user: context.session?.idUser,
            pageId: context.params["page_id"],
            pageObjectId: context.params["page_object"],
        })).catch((err) => {
            this.logger.error(err);
        });
    }
}