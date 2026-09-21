import {AfterQueryEvent, BeforeQueryEvent, EntitySubscriberInterface, EventSubscriber, InsertEvent, RecoverEvent, RemoveEvent, SoftRemoveEvent, TransactionCommitEvent, TransactionRollbackEvent, TransactionStartEvent, UpdateEvent} from "typeorm"
import {IPropertyLoaded} from "./Property.types"
import {ContextModel} from "./entities/ContextModel";
import {ProviderModel} from "./entities/ProviderModel";
import {PluginModel} from "./entities/PluginModel";
import {ServerModel} from "./entities/ServerModel";
import {QueryModel} from "./entities/QueryModel";
import {EventModel} from "./entities/EventModel";
import {SchedulerModel} from "./entities/SchedulerModel";
import {sendProcess} from "@ungate/plugininf/lib/util/ProcessSender";
import {toContext, toProvider, toPlugin, toQuery, toServer, toEvent, toScheduler} from "./map";
import {ObjectLiteral} from "typeorm";
import Property from "./Property";

export const propertyLoaded: IPropertyLoaded = {
    context: false,
    providers: false,
    plugins: false,
    query: false,
    server: false,
    event: false,
    scheduler: false,
};

@EventSubscriber()
export class PropertySubscriber implements EntitySubscriberInterface {
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
        if (entity instanceof ContextModel && propertyLoaded.context) {
            Property.handlers.saveContext();
            sendProcess({
                target: "clusterAdmin",
                command: "sendServerAdminCmdAll",
                data: {
                    command: "savePropertyEntity",
                    target: "master",
                    data: {
                        entity: toContext(entity),
                        table: "t_context",
                    },
                },
            });
        }
        if (entity instanceof ProviderModel && propertyLoaded.providers) {
            Property.handlers.saveProviders();
            sendProcess({
                target: "clusterAdmin",
                command: "sendServerAdminCmdAll",
                data: {
                    command: "savePropertyEntity",
                    target: "master",
                    data: {
                        entity: toProvider(entity),
                        table: "t_providers",
                    },
                },
            });
        }
        if (entity instanceof PluginModel && propertyLoaded.plugins) {
            Property.handlers.savePlugins();
            sendProcess({
                target: "clusterAdmin",
                command: "sendServerAdminCmdAll",
                data: {
                    command: "savePropertyEntity",
                    target: "master",
                    data: {
                        entity: toPlugin(entity),
                        table: "t_plugins",
                    },
                },
            });
        }
        if (entity instanceof QueryModel && propertyLoaded.query) {
            Property.handlers.saveQuery();
            sendProcess({
                target: "clusterAdmin",
                command: "sendServerAdminCmdAll",
                data: {
                    command: "savePropertyEntity",
                    target: "master",
                    data: {
                        entity: toQuery(entity),
                        table: "t_query",
                    },
                },
            });
        }
        if (entity instanceof ServerModel && propertyLoaded.server) {
            Property.handlers.saveServers();
            sendProcess({
                target: "clusterAdmin",
                command: "sendServerAdminCmdAll",
                data: {
                    command: "savePropertyEntity",
                    target: "master",
                    data: {
                        entity: toServer(entity),
                        table: "t_servers",
                    },
                },
            });
        }
        if (entity instanceof EventModel && propertyLoaded.event) {
            Property.handlers.saveEvents();
            sendProcess({
                target: "clusterAdmin",
                command: "sendServerAdminCmdAll",
                data: {
                    command: "savePropertyEntity",
                    target: "master",
                    data: {
                        entity: toEvent(entity),
                        table: "t_events",
                    },
                },
            });
        }
        if (entity instanceof SchedulerModel && propertyLoaded.scheduler) {
            Property.handlers.saveSchedulers();
            sendProcess({
                target: "clusterAdmin",
                command: "sendServerAdminCmdAll",
                data: {
                    command: "savePropertyEntity",
                    target: "master",
                    data: {
                        entity: toScheduler(entity),
                        table: "t_schedulers",
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