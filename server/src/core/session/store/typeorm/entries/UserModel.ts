import { IUserData, IUserDbData } from "@ungate/plugininf/lib/ISession";
import { Column, Entity, PrimaryColumn } from "typeorm";
import { Audit } from "../../../../dao/Audit";

@Entity("t_user")
export class UserModel extends Audit implements IUserDbData {
    @PrimaryColumn({
        name: "ck_id",
        comment: "Идентификатор пользователя",
    })
    ["ck_id"]: string;

    @Column({
        name: "ck_d_provider",
        nullable: false,
        comment: "Индетификатор провайдера",
    })
    ["ck_d_provider"]: string;

    @Column({
        name: "cv_login",
        nullable: true,
        comment: "Логин",
    })
    ["cv_login"]: string;

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
    data: IUserData;
}
