import { EventEmitter } from "events";
import IObjectParam from "../IObjectParam";
import { IResultProvider } from "../IResult";
import IOptions from "./IOptions";

type nameType = "oracle" | "postgresql";
class Connection extends EventEmitter {
    public name: nameType;
    private connection?: any;
    private DataSource: any;
    private isReleased: boolean = false;
    private isExecute: boolean = false;
    constructor(dataSource: any, name: nameType, connection?: any) {
        super();
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
    public async executeStmt(
        sql: string,
        inParam?: IObjectParam,
        outParam?: IObjectParam,
        options?: IOptions,
    ): Promise<IResultProvider> {
        let result = null;
        this.isExecute = true;
        try {
            result = await this.DataSource.executeStmt(
                sql,
                this.connection,
                inParam,
                outParam,
                options,
            );
        } finally {
            if (result) {
                result.stream.once("end", () => {
                    this.isExecute = false;
                    this.emit("finish");
                });
            } else {
                this.isExecute = false;
                this.emit("finish");
            }
        }
        return result;
    }
    public async release(): Promise<void> {
        if (this.isReleased) {
            return;
        }
        if (this.isExecute) {
            this.once("finish", () => {
                this.release();
            });
            return;
        }
        try {
            this.isExecute = true;
            await this.DataSource.onRelease(this.connection);
        } finally {
            this.isExecute = false;
            this.isReleased = true;
            this.emit("finish");
        }
        return;
    }
    public async close(): Promise<void> {
        if (this.isReleased) {
            return;
        }
        if (this.isExecute) {
            this.once("finish", () => {
                this.close();
            });
            return;
        }
        try {
            this.isExecute = true;
            await this.DataSource.onClose(this.connection);
        } finally {
            this.isExecute = false;
            this.isReleased = true;
            this.emit("finish");
        }
        return;
    }
    public async commit(): Promise<void> {
        if (this.isReleased) {
            return;
        }
        if (this.isExecute) {
            this.once("finish", () => {
                this.commit();
            });
            return;
        }
        this.isExecute = true;
        try {
            await this.DataSource.onCommit(this.connection);
        } finally {
            this.isExecute = false;
            this.emit("finish");
        }
        return;
    }
    public async rollback(): Promise<void> {
        if (this.isReleased) {
            return;
        }
        if (this.isExecute) {
            this.once("finish", () => {
                this.rollback();
            });
            return;
        }
        this.isExecute = true;
        try {
            await this.DataSource.onRollBack(this.connection);
        } finally {
            this.isExecute = false;
            this.emit("finish");
        }
        return;
    }
    public rollbackAndRelease(): Promise<void> {
        return this.rollback()
            .then(
                () => this.release(),
                () => this.release(),
            )
            .then(
                () => Promise.resolve(),
                () => Promise.resolve(),
            );
    }
    public rollbackAndClose(): Promise<void> {
        return this.rollback()
            .then(
                () => this.close(),
                () => this.close(),
            )
            .then(
                () => Promise.resolve(),
                () => Promise.resolve(),
            );
    }
}

export default Connection;
