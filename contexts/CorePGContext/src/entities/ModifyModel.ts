import { Column, Entity, PrimaryColumn } from "typeorm";

@Entity("tt_modify")
export class ModifyModel {
    @PrimaryColumn({ name: "ck_id", comment: "Идентификатор" })
    id!: string;

    @Column({
        name: "ck_provider",
        nullable: false,
        comment: "Идентификатор провайдера",
    })
    provider!: string;

    @Column({ name: "cv_modify", nullable: false, comment: "Метод модификации" })
    modify!: string;
}
