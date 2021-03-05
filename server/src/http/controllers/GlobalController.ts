import IGlobalObject from "@ungate/plugininf/lib/IGlobalObject";
import GateSession from "../../core/session/GateSession";
import NotificationController from "./NotificationController";

export default function () {
    ((global as any) as IGlobalObject).authController = {
        addUser: GateSession.addUser.bind(GateSession),
        createSession: GateSession.createSession.bind(GateSession),
        getDataUser: GateSession.getDataUser.bind(GateSession),
        getUserDb: GateSession.getUserDb.bind(GateSession),
        loadSession: GateSession.loadSession.bind(GateSession),
        updateHashAuth: GateSession.updateHashAuth.bind(GateSession),
        updateUserInfo: NotificationController.updateUserInfo.bind(
            NotificationController,
        ),
    };
}
