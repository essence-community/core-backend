import PluginManager from "../../core/pluginmanager";

class ProcessController {
    public async init() {
        return;
    }
    public handlers: Record<string, (data?: Record<string, any>) => Promise<any>> = {
        callEventPlugin: this.callEventPlugin,
    };
    public async callEventPlugin(data?: Record<string, any>): Promise<any> {
        const plugin = PluginManager.getGateEvent(data?.name);
        if (plugin && (plugin as any)[data?.command]) {
            (plugin as any)[data?.command](data);
        }
    }
}

export default new ProcessController();
