import { Column, Entity, PrimaryColumn } from "typeorm";
import { Audit } from "../../../../dao/Audit";

@Entity("t_cache")
export class CacheModel extends Audit {
    @PrimaryColumn({
        name: "ck_id",
        comment: "Идентификатор",
    })
    ["ck_id"]: string;

    @Column({
        name: "cct_data",
        type: "text",
        nullable: false,
        comment: "Данные",
        transformer: {
            to: (value) => (value ? JSON.stringify(value) : "{}"),
            from: (value) => (value ? JSON.parse(value) : {}),
        },
    })
    data: Record<string, any> = {};
}
