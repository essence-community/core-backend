import { Column, Entity, PrimaryColumn } from "typeorm";

@Entity("tt_interface")
export class InterfaceModel {
    @PrimaryColumn({ name: "ck_id", comment: "Идентификатор" })
    id!: string;

    @Column({
        name: "cct_data",
        type: "text",
        nullable: false,
        comment: "Данные интерфейса",
        transformer: {
            to: (value: Record<string, any>) =>
                value ? JSON.stringify(value) : "{}",
            from: (value: string) => (value ? JSON.parse(value) : {}),
        },
    })
    data!: Record<string, any>;
}
