import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import ErrorGate from "@ungate/plugininf/lib/errors/ErrorGate";
import IParamsInfo from "@ungate/plugininf/lib/ICCTParams";
import IContext from "@ungate/plugininf/lib/IContext";
import IQuery, { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import NullSessProvider, {
    IAuthResult,
} from "@ungate/plugininf/lib/NullSessProvider";

export default class AuthMock extends NullSessProvider {
    public static getParamsInfo(): IParamsInfo {
        return {
            adminPassword: {
                description: "Пароль учетки администратора",
                name: "Пароль администратора",
                type: "password",
            },
            adminUser: {
                description: "Наименование учетки администратора",
                name: "Наименование администратора",
                type: "string",
            },
            viewUser: {
                description: "Наименование учетки просмотра",
                name: "Наименование просмотра",
                type: "string",
            },
        };
    }
    public async processAuth(
        context: IContext,
        query: IGateQuery,
    ): Promise<IAuthResult> {
        if (
            query.inParams.cv_login === this.params.adminUser &&
            query.inParams.cv_password === this.params.adminPassword
        ) {
            return {
                idUser: "1",
            };
        }
        if (query.inParams.cv_login === this.params.viewUser) {
            return {
                idUser: "2",
            };
        }
        throw new ErrorException(ErrorGate.AUTH_UNAUTHORIZED);
    }
    public async init(reload?: boolean): Promise<void> {
        const adminUser = {
            ca_actions: [
                453, 454, 455, 491, 492, 493, 494, 495, 496, 497, 498, 499, 500,
                501, 502, 503, 504, 505, 506, 507, 508, 509, 510, 511, 512, 513,
                514, 515, 516, 517, 518, 520, 521, 533, 534, 535, 536, 537, 538,
                539, 540, 541, 543, 544, 545, 546, 547, 548, 585, 586, 592, 593,
                594, 595, 596, 597, 608, 609, 610, 620, 621, 692, 693, 704, 705,
            ],
            ck_id: 1,
            cv_email: null,
            cv_login: this.params.adminUser,
            cv_name: this.params.adminUser,
            cv_patronymic: "",
            cv_surname: this.params.adminUser,
            type_auth_provider: 'AUTHMOCK',
        };
        const viewUser = {
            ca_actions: [491, 497, 499, 511, 515, 533, 704, 692, 503],
            ck_id: 2,
            cv_email: null,
            cv_login: this.params.viewUser,
            cv_name: "view",
            cv_patronymic: this.params.viewUser,
            cv_surname: this.params.viewUser,
            type_auth_provider: 'AUTHMOCK',
        };
        await this.sessCtrl.addUser(
            "" + adminUser.ck_id,
            this.name,
            adminUser,
        );
        await this.sessCtrl.addUser(
            "" + viewUser.ck_id,
            this.name,
            viewUser,
        );
        await this.sessCtrl.updateHashAuth();
        return;
    }
    public async initContext(
        context: IContext,
        query: IQuery,
    ): Promise<IQuery> {
        if (context.actionName !== "auth") {
            throw new ErrorException(ErrorGate.NOT_IMPLEMENTED);
        }
        return await super.initContext(context, query);
    }
}
