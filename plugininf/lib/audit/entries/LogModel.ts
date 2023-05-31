import { Column, CreateDateColumn, Entity, PrimaryGeneratedColumn, UpdateDateColumn } from "typeorm";

@Entity("t_log")
export class LogModel {
    @PrimaryGeneratedColumn("uuid", {
        name: "ck_id",
        comment: "Идентификатор",
    })
    id: string;

    @Column({
        name: "ck_request",
        comment: "Идентификатор запроса",
    })
    requestId: string;

    @Column({
        name: "ck_query",
        nullable: true,
        comment: "Наименование запроса",
    })
    query: string;

    @Column({
        name: "cct_request_data",
        type: "text",
        nullable: false,
        comment: "Данные запроса",
        transformer: {
            to: (value) => (value ? JSON.stringify(value) : "{}"),
            from: (value) => (value ? JSON.parse(value) : {}),
        },
    })
    requestData: Record<string, any> = {};

    @Column({
        name: "cct_session_data",
        type: "text",
        nullable: false,
        comment: "Данные сессии",
        transformer: {
            to: (value) => (value ? JSON.stringify(value) : '{}'),
            from: (value) => (value ? JSON.parse(value) : {}),
        },
    })
    sessionData?: Record<string, any> = {};

    @Column({
        name: "ck_page",
        nullable: true,
        comment: "Идентификатор страницы",
    })
    pageId?: string;

    @Column({
        name: "ck_page_object",
        nullable: true,
        comment: "Идентификатор объекта",
    })
    pageObjectId?: string;

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
        nullable: true,
        length: 100,
        default: () => "999999",
        comment: "Пользователь последний модифицирующий",
    })
    user?: string;
}
