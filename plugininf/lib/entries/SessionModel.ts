import {Column, Entity, PrimaryColumn} from "typeorm";
import {Audit} from "./Audit";

@Entity("t_session")
export class SessionModel extends Audit {
    @PrimaryColumn({
        name: "ck_id",
        comment: "Идентификатор сессии",
    })
    id!: string;

    @Column({
        name: "cct_data",
        type: "text",
        nullable: false,
        comment: "Данные сессии",
        transformer: {
            to: (value) => (value ? JSON.stringify(value) : "{}"),
            from: (value) => (value ? JSON.parse(value) : {}),
        },
    })
    data: Record<string, any> = {};

    @Column({
        name: "ct_expire",
        nullable: false,
        comment: "Дата истечения сессии",
    })
    expire!: Date;

    @Column({
        name: "cl_delete",
        type: "integer",
        nullable: true,
        comment: "Признак удаления",
        default: 0,
        transformer: {
            to: (value: boolean) => value ? 1 : 0,
            from: (value: number) => value === 1,
        },
    })
    isDelete!: boolean;
}
