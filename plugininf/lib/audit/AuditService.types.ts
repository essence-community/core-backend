export interface IAuditServiceParam {
    type: string;
    host: string;
    port: number;
    username?: string;
    password?: string;
    database?: string;
    typeOrmExtra?: string;
    extra?: string;
};