import {AfterQueryEvent, BeforeQueryEvent, EntitySubscriberInterface, EventSubscriber, InsertEvent, RecoverEvent, RemoveEvent, SoftRemoveEvent, TransactionCommitEvent, TransactionRollbackEvent, TransactionStartEvent, UpdateEvent} from "typeorm"
import {sendProcess} from "@ungate/plugininf/lib/util/ProcessSender";
import {toSession, toCache, toUser} from "@ungate/plugininf/lib/entries/map";
import {ObjectLiteral} from "typeorm";
import {SessionModel} from "@ungate/plugininf/lib/entries/SessionModel";
import {CacheModel} from "@ungate/plugininf/lib/entries/CacheModel";
import {UserModel} from "@ungate/plugininf/lib/entries/UserModel";

@EventSubscriber()
class SessionSubscriber implements EntitySubscriberInterface {

    constructor(private readonly contextName: string) {
    }
    /**
     * Called after entity is loaded.
     */
    afterLoad(entity: any) {
    }

    /**
     * Called before query execution.
     */
    beforeQuery(event: BeforeQueryEvent) {
    }

    /**
     * Called after query execution.
     */
    afterQuery(event: AfterQueryEvent) {
    }

    /**
     * Called before entity insertion.
     */
    beforeInsert(event: InsertEvent<any>) {
    }

    eventEntity(entity?: ObjectLiteral) {
        if (!entity) {
            return;
        }
        if (entity instanceof SessionModel) {
            sendProcess({
                target: "clusterAdmin",
                command: "sendServerAdminCmdAll",
                data: {
                    command: "saveSessCtl",
                    target: "cluster",
                    data: {
                        entity: toSession(entity),
                        table: "t_session",
                        context: this.contextName,
                    },
                },
            });
        }
        if (entity instanceof UserModel) {
            sendProcess({
                target: "clusterAdmin",
                command: "sendServerAdminCmdAll",
                data: {
                    command: "saveSessCtl",
                    target: "cluster",
                    data: {
                        entity: toUser(entity),
                        table: "t_user",
                        context: this.contextName,
                    },
                },
            });
        }
        if (entity instanceof CacheModel) {
            sendProcess({
                target: "clusterAdmin",
                command: "sendServerAdminCmdAll",
                data: {
                    command: "saveSessCtl",
                    target: "cluster",
                    data: {
                        entity: toCache(entity),
                        table: "t_cache",
                        context: this.contextName,
                    },
                },
            });
        }
    }
    /**
     * Called after entity insertion.
     */
    afterInsert(event: InsertEvent<any>) {
        this.eventEntity(event.entity);
    }

    /**
     * Called before entity update.
     */
    beforeUpdate(event: UpdateEvent<any>) {
    }

    /**
     * Called after entity update.
     */
    afterUpdate(event: UpdateEvent<any>) {
        this.eventEntity(event.databaseEntity);
    }

    /**
     * Called before entity removal.
     */
    beforeRemove(event: RemoveEvent<any>) {
    }

    /**
     * Called after entity removal.
     */
    afterRemove(event: RemoveEvent<any>) {
        this.eventEntity(event.databaseEntity);
    }

    /**
     * Called before entity removal.
     */
    beforeSoftRemove(event: SoftRemoveEvent<any>) {
    }

    /**
     * Called after entity removal.
     */
    afterSoftRemove(event: SoftRemoveEvent<any>) {
        this.eventEntity(event.databaseEntity);
    }

    /**
     * Called before entity recovery.
     */
    beforeRecover(event: RecoverEvent<any>) {
    }

    /**
     * Called after entity recovery.
     */
    afterRecover(event: RecoverEvent<any>) {
    }

    /**
     * Called before transaction start.
     */
    beforeTransactionStart(event: TransactionStartEvent) {
    }

    /**
     * Called after transaction start.
     */
    afterTransactionStart(event: TransactionStartEvent) {
    }

    /**
     * Called before transaction commit.
     */
    beforeTransactionCommit(event: TransactionCommitEvent) {
    }

    /**
     * Called after transaction commit.
     */
    afterTransactionCommit(event: TransactionCommitEvent) {
    }

    /**
     * Called before transaction rollback.
     */
    beforeTransactionRollback(event: TransactionRollbackEvent) {
    }

    /**
     * Called after transaction rollback.
     */
    afterTransactionRollback(event: TransactionRollbackEvent) {
    }
}

export const sessionSubscriber = (provider: string) => () => new SessionSubscriber(provider);
