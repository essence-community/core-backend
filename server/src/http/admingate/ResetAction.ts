import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import IContext from "@ungate/plugininf/lib/IContext";
import { sendProcess, TTarget } from "@ungate/plugininf/lib/util/ProcessSender";
import { isEmpty } from "@ungate/plugininf/lib/util/Util";

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
    
    sendProcess({
        command: "sendServerAdminCmd",
        data: {
            command,
            data: {
                name: cvName,
                nameContext: json.data["ck_context"],
                session: gateContext.session,
            },
            server: serverName,
            target,
        },
        target: "clusterAdmin",
    });

    setTimeout(() => {
        sendProcess({
            command,
            data: {
                name: cvName,
                nameContext: json.data["ck_context"],
                session: gateContext.session,
            },
            target,
        });
    }, 500);

    return [
        {
            ck_id: json.data.ck_id,
            cv_error: null,
        },
    ];
}
