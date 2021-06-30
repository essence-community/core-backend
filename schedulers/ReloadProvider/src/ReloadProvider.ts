import ICCTParams, { IParamsInfo } from "@ungate/plugininf/lib/ICCTParams";
import NullScheduler from "@ungate/plugininf/lib/NullScheduler";
import { sendProcess } from "@ungate/plugininf/lib/util/ProcessSender";
import { initParams } from "@ungate/plugininf/lib/util/Util";

export default class ReloadProvider extends NullScheduler {
    public static getParamsInfo(): IParamsInfo {
        return {
            providerName: {
                name: "Наименование провайдера",
                required: true,
                type: "string",
            },
        };
    }
    constructor(
        name: string,
        params: ICCTParams,
        cron: string,
        isEnable: boolean,
    ) {
        super(name, params, cron, isEnable);
        this.params = initParams(ReloadProvider.getParamsInfo(), this.params);
    }
    public async init(reload?: boolean): Promise<void> {
        return;
    }
    public execute(): void {
        sendProcess({
            command: "reloadProvider",
            data: {
                name: this.params.providerName,
            },
            target: "cluster",
        });
    }
    public async destroy(): Promise<void> {
        return;
    }
}
