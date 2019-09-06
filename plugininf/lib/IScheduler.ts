import ICCTParams from "./ICCTParams";

/**
 * Created by artemov_i on 04.12.2018.
 */

export default interface IScheduler {
    init(reload?: boolean): Promise<void>;
    enable(): void;
    disable(): void;
    execute(): void;
    destroy(): Promise<void>;
}
