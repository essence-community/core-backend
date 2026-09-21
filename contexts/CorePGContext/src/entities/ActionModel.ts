import { Column, Entity, PrimaryColumn } from "typeorm";

@Entity("tt_query_action")
export class ActionModel {
    @PrimaryColumn({ name: "ck_id", comment: "Идентификатор" })
    id!: string;

    @Column({
        name: "ck_page_object",
        nullable: false,
        comment: "Идентификатор объекта страницы",
    })
    pageObject!: string;

    @Column({
        name: "cn_action",
        type: "integer",
        nullable: true,
        comment: "Действие",
    })
    action?: number;
}
