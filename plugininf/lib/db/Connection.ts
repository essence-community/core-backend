import IObjectParam from "../IObjectParam";
import { IResultProvider } from "../IResult";
import IOptions from "./IOptions";

type nameType = "oracle" | "postgresql";
class Connection {
    public name: nameType;
    private connection?: any;
    private DataSource: any;
    private isReleased: boolean = false;
    constructor(dataSource: any, name: nameType, connection?: any) {
        this.name = name;
        this.DataSource = dataSource;
        this.connection = connection;
    }
    public getCurrentConnection() {
        return this.connection;
    }
    public getNewConnection() {
        return this.DataSource.getConnection();
    }
    public executeStmt(
        sql: string,
        inParam?: IObjectParam,
        outParam?: IObjectParam,
        options?: IOptions,
    ): Promise<IResultProvider> {
        return this.DataSource.executeStmt(
            sql,
            this.connection,
            inParam,
            outParam,
            options,
        );
    }
    public async release(): Promise<void> {
        if (this.isReleased) {
            return;
        }
        await this.DataSource.onRelease(this.connection);
        this.isReleased = true;
        return;
    }
    public async close(): Promise<void> {
        if (this.isReleased) {
            return;
        }
        await this.DataSource.onClose(this.connection);
        this.isReleased = true;
        return;
    }
    public async commit(): Promise<void> {
        if (this.isReleased) {
            return;
        }
        return this.DataSource.onCommit(this.connection);
    }
    public async rollback(): Promise<void> {
        if (this.isReleased) {
            return;
        }
        return this.DataSource.onRollBack(this.connection);
    }
    public rollbackAndRelease(): Promise<void> {
        return this.rollback()
            .then(() => this.release(), () => this.release())
            .then(() => Promise.resolve(), () => Promise.resolve());
    }
    public rollbackAndClose(): Promise<void> {
        return this.rollback()
            .then(() => this.close(), () => this.close())
            .then(() => Promise.resolve(), () => Promise.resolve());
    }
}

export default Connection;
