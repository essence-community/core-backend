import ICCTParams from "@ungate/plugininf/lib/ICCTParams";
import {Column, Entity, PrimaryColumn} from "typeorm";

@Entity("t_schedulers")
export class SchedulerModel {
    @PrimaryColumn({name: "ck_id", comment: "Идентификатор"})
    id!: string;

    @Column({name: "cv_description", nullable: true, comment: "Описание"})
    description?: string;

    @Column({
        name: "cl_enable",
        type: "integer",
        nullable: false,
        comment: "Включен",
        default: 0,
        transformer: {
            to: (value: boolean) => value ? 1 : 0,
            from: (value: number) => value === 1,
        },
    })
    isEnabled!: boolean;

    @Column({
        name: "ck_d_plugin",
        nullable: false,
        comment: "Идентификатор плагина",
    })
    plugin!: string;

    @Column({name: "cv_cron", nullable: false, comment: "Cron"})
    cron!: string;

    @Column({
        name: "cct_params",
        type: "text",
        nullable: true,
        comment: "Параметры",
        transformer: {
            to: (value: ICCTParams) => value ? JSON.stringify(value) : "{}",
            from: (value: string) => value ? JSON.parse(value) : {},
        },
    })
    params?: ICCTParams;
}
