import {Column, Entity, PrimaryColumn} from "typeorm";

@Entity("tt_query")
export class QueryModel {
    @PrimaryColumn({name: "ck_id", comment: "Идентификатор"})
    id!: string;

    @Column({name: "cc_query", type: "text", nullable: true, comment: "Запрос"})
    query?: string;

    @Column({
        name: "ck_provider",
        nullable: false,
        comment: "Идентификатор провайдера",
    })
    provider!: string;

    @Column({
        name: "cn_action",
        type: "integer",
        nullable: true,
        comment: "Действие",
    })
    action?: number;

    @Column({name: "cr_access", nullable: true, comment: "Доступ"})
    access?: string;

    @Column({name: "cr_type", nullable: true, comment: "Тип"})
    type?: string;

    @Column({name: "cr_cache", nullable: true, comment: "Кэш"})
    cache?: string;

    @Column({
        name: "cv_cache_key_param",
        type: "text",
        nullable: true,
        comment: "Параметры ключа кэша",
        transformer: {
            to: (value: string[]) => (value ? JSON.stringify(value) : "[]"),
            from: (value: string) => (value ? JSON.parse(value) : []),
        },
    })
    cacheKeyParam?: string[];
}
