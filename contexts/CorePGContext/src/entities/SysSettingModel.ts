import {Column, Entity, PrimaryColumn} from "typeorm";

@Entity("tt_sys_settings")
export class SysSettingModel {
    @PrimaryColumn({name: "ck_id", comment: "Идентификатор"})
    id!: string;

    @Column({name: "cv_value", nullable: true, comment: "Значение"})
    value?: string;

    @Column({name: "cv_description", nullable: true, comment: "Описание"})
    description?: string;
}
