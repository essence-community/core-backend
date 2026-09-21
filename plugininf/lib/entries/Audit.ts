import { Column, CreateDateColumn, UpdateDateColumn } from "typeorm";

export class Audit {
    @CreateDateColumn({
        name: "ct_create",
        comment: "Аудит время создания записи",
    })
    create: Date;
    @UpdateDateColumn({
        name: "ct_change",
        comment: "Айдит время обновление записи",
    })
    change: Date;
    @Column({
        name: "ck_user",
        nullable: false,
        length: 100,
        default: () => "999999",
        comment: "Пользователь последний модифицирующий",
    })
    user: string;
}
