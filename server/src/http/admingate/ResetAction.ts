import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import IContext from "@ungate/plugininf/lib/IContext";
import { sendProcess, TTarget } from "@ungate/plugininf/lib/util/ProcessSender";
import { isEmpty } from "@ungate/plugininf/lib/util/Util";
import Constants from "../../core/Constants";

export default async function resetAction(
    gateContext: IContext,
    column: string,
    command: string,
    target: TTarget,
    serverColumn: string = "ck_main",
) {
    if (isEmpty(gateContext.query.inParams.json)) {
        return Promise.reject(
            new ErrorException(
                -1,
                `Нет такого обработчика ${gateContext.queryName}`,
            ),
        );
    }
    const json = JSON.parse(gateContext.query.inParams.json || "{}");
    const serverName = json.service[serverColumn] || json.data[serverColumn];
    const cvName = json.data[column];
    if (!serverName || serverName === Constants.GATE_NODE_NAME) {
        sendProcess({
            command,
            data: {
                name: cvName,
                session: gateContext.session,
            },
            target,
        });
    } else {
        sendProcess({
            command: "sendServerAdminCmd",
            data: {
                command,
                data: {
                    name: cvName,
                    session: gateContext.session,
                },
                server: serverName,
                target,
            },
            target: "clusterAdmin",
        });
    }

    return [
        {
            ck_id: json.data.ck_id,
            cv_error: null,
        },
    ];
}
