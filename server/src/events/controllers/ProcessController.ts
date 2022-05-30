import PluginManager from "../../core/pluginmanager";

class ProcessController {
    public async init() {
        return;
    }
    public async callEventPlugin(data) {
        const plugin = PluginManager.getGateEvent(data.name);
        if (plugin && (plugin as any)[data.command]) {
            (plugin as any)[data.command](data);
        }
    }
}

export default new ProcessController();
