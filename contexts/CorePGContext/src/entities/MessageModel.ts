import {Column, Entity, PrimaryColumn} from "typeorm";

@Entity("tt_message")
export class MessageModel {
    @PrimaryColumn({name: "ck_id", comment: "Идентификатор"})
    id!: string;

    @Column({name: "cr_type", nullable: true, comment: "Тип"})
    type?: string;

    @Column({name: "cv_text", type: "text", nullable: true, comment: "Текст"})
    text?: string;
}
