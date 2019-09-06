import ICCTParams from "./ICCTParams";
import IEvents from "./IEvents";

export default abstract class NullEvent implements IEvents {
    public name: string;
    public params: ICCTParams;
    constructor(name: string, params: ICCTParams) {
        this.name = name;
        this.params = params;
    }
    public abstract init(reload?: boolean): Promise<void>;
    public async destroy(): Promise<void> {
        return;
    }
}
