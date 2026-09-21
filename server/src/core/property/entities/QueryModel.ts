import {IInParamArray, IOutParamArray} from "@ungate/plugininf/lib/IQuery";
import {Column, Entity, PrimaryColumn} from "typeorm";

@Entity("t_query")
export class QueryModel {
    @PrimaryColumn({name: "ck_id", comment: "Идентификатор"})
    id!: string;

    @Column({name: "cv_name", nullable: false, comment: "Наименование"})
    name!: string;

    @Column({
        name: "ck_d_context",
        nullable: false,
        comment: "Идентификатор контекста",
    })
    context!: string;

    @Column({
        name: "ck_d_provider",
        nullable: false,
        comment: "Идентификатор провайдера",
    })
    provider!: string;

    @Column({name: "cv_text", type: "text", nullable: true, comment: "Текст"})
    text?: string;

    @Column({name: "cv_description", nullable: true, comment: "Описание"})
    description?: string;

    @Column({
        name: "cct_in_params",
        type: "text",
        nullable: true,
        comment: "Входные параметры",
        transformer: {
            to: (value: IInParamArray[]) => value ? JSON.stringify(value) : "{}",
            from: (value: string) => value ? JSON.parse(value) : [],
        },
    })
    inParams?: IInParamArray[];

    @Column({
        name: "cct_out_params",
        type: "text",
        nullable: true,
        comment: "Выходные параметры",
        transformer: {
            to: (value: IOutParamArray[]) => value ? JSON.stringify(value) : "{}",
            from: (value: string) => value ? JSON.parse(value) : [],
        },
    })
    outParams?: IOutParamArray[];
}
