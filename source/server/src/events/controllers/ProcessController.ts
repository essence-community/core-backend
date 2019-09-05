import PluginManager from "../../core/pluginmanager";

class ProcessController {
    public async init() {
        return;
    }
    public async eventNotification(data) {
        const plugin = PluginManager.getGateEvent(data.name);
        if (plugin && (plugin as any).eventNotification) {
            (plugin as any).eventNotification(data.users);
        }
    }
}

export default new ProcessController();
