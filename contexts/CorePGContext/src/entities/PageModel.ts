import { Column, Entity, PrimaryColumn } from "typeorm";

@Entity("tt_page")
export class PageModel {
    @PrimaryColumn({ name: "ck_id", comment: "Идентификатор" })
    id!: string;

    @Column({
        name: "cn_action",
        type: "integer",
        nullable: true,
        comment: "Действие",
    })
    action?: number;

    @Column({ name: "cv_name", nullable: false, comment: "Наименование" })
    name!: string;

    @Column({ name: "cv_url", nullable: true, comment: "URL" })
    url?: string;

    @Column({
        name: "cct_children",
        type: "text",
        nullable: false,
        comment: "Дочерние объекты",
        transformer: {
            to: (value: Record<string, any>[]) =>
                value ? JSON.stringify(value) : "[]",
            from: (value: string) => (value ? JSON.parse(value) : []),
        },
    })
    children!: Record<string, any>[];

    @Column({
        name: "cct_global_value",
        type: "text",
        nullable: false,
        comment: "Глобальные значения",
        transformer: {
            to: (value: Record<string, string>) =>
                value ? JSON.stringify(value) : "{}",
            from: (value: string) => (value ? JSON.parse(value) : {}),
        },
    })
    globalValue!: Record<string, string>;

    @Column({
        name: "cct_route",
        type: "text",
        nullable: false,
        comment: "Маршрут",
        transformer: {
            to: (value: Record<string, string>) =>
                value ? JSON.stringify(value) : "{}",
            from: (value: string) => (value ? JSON.parse(value) : {}),
        },
    })
    route!: Record<string, string>;
}
