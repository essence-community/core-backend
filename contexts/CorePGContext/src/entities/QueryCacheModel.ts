import { Column, Entity, PrimaryColumn } from "typeorm";

@Entity("tt_query_cache")
export class QueryCacheModel {
    @PrimaryColumn({ name: "ck_id", comment: "Идентификатор" })
    id!: string;

    @Column({
        name: "cct_data",
        type: "text",
        nullable: false,
        comment: "Данные",
        transformer: {
            to: (value: Record<string, any>[]) =>
                value ? JSON.stringify(value) : "[]",
            from: (value: string) => (value ? JSON.parse(value) : []),
        },
    })
    data!: Record<string, any>[];
}
