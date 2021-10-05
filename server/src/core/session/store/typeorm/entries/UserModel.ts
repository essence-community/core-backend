import { Column, Entity, PrimaryColumn } from "typeorm";
import { Audit } from "../../../../dao/Audit";

@Entity("t_user")
export class UserModel extends Audit {
    @PrimaryColumn({
        name: "ck_id",
        comment: "Идентификатор пользователя",
    })
    id: string;

    @Column({
        name: "ck_d_provider",
        nullable: false,
        comment: "Индетификатор провайдера",
    })
    provider: string;

    @Column({
        name: "cct_data",
        type: "text",
        nullable: false,
        comment: "Данные пользователя",
        transformer: {
            to: (value) => (value ? JSON.stringify(value) : "{}"),
            from: (value) => (value ? JSON.parse(value) : {}),
        },
    })
    data: Record<string, any> = {};
}
