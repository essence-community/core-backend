import {Column, Entity, PrimaryColumn} from "typeorm";

@Entity("t_servers")
export class ServerModel {
    @PrimaryColumn({name: "ck_id", comment: "Идентификатор"})
    id!: string;

    @Column({name: "cv_description", nullable: true, comment: "Описание"})
    description?: string;

    @Column({name: "cv_ip", nullable: false, comment: "IP"})
    ip!: string;

    @Column({
        name: "cn_port",
        type: "integer",
        nullable: true,
        comment: "Порт",
    })
    port?: number;
}
