import ICCTParams from "@ungate/plugininf/lib/ICCTParams";
import {Column, Entity, PrimaryColumn} from "typeorm";

@Entity("t_plugins")
export class PluginModel {
    @PrimaryColumn({name: "ck_id", comment: "Идентификатор"})
    id!: string;

    @Column({name: "cv_name", nullable: false, comment: "Наименование"})
    name!: string;

    @Column({
        name: "ck_context",
        nullable: true,
        comment: "Идентификатор контекста",
    })
    context?: string;

    @Column({
        name: "ck_d_provider",
        nullable: false,
        comment: "Идентификатор провайдера",
    })
    provider!: string;

    @Column({name: "cv_description", nullable: true, comment: "Описание"})
    description?: string;

    @Column({
        name: "ck_d_plugin",
        nullable: false,
        comment: "Идентификатор плагина",
    })
    plugin!: string;

    @Column({
        name: "cl_required",
        type: "integer",
        nullable: false,
        comment: "Обязательный",
        default: 0,
        transformer: {
            to: (value: boolean) => value ? 1 : 0,
            from: (value: number) => value === 1,
        },
    })
    isRequired!: boolean;

    @Column({
        name: "cl_default",
        type: "integer",
        nullable: false,
        comment: "По умолчанию",
        default: 0,
        transformer: {
            to: (value: boolean) => value ? 1 : 0,
            from: (value: number) => value === 1,
        },
    })
    isDefault!: boolean;

    @Column({
        name: "cn_order",
        type: "integer",
        nullable: false,
        comment: "Порядок",
    })
    order!: number;

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
