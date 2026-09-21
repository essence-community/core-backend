import { Column, Entity, PrimaryColumn } from "typeorm";

@Entity("tt_object")
export class ObjectModel {
    @PrimaryColumn({ name: "ck_id", comment: "Идентификатор" })
    id!: string;

    @Column({
        name: "cn_action",
        type: "integer",
        nullable: true,
        comment: "Действие",
    })
    action?: number;

    @Column({
        name: "cct_json",
        type: "text",
        nullable: false,
        comment: "JSON",
        transformer: {
            to: (value: Record<string, any>[]) =>
                value ? JSON.stringify(value) : "[]",
            from: (value: string) => (value ? JSON.parse(value) : []),
        },
    })
    json!: Record<string, any>[];
}
