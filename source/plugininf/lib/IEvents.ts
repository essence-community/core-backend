export default interface IEvents {
    init(reload?: boolean): Promise<void>;
    destroy(): Promise<void>;
}
