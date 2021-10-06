import NullContext from "@ungate/plugininf/lib/NullContext";
import IContext from "@ungate/plugininf//lib/IContext";
import { IContextPluginResult } from "@ungate/plugininf/lib/IContextPlugin";
import BreakException from "@ungate/plugininf/lib/errors/BreakException";
import IResult from "@ungate/plugininf/lib/IResult";
import { IParamsInfo } from "@ungate/plugininf/lib/ICCTParams";
import { initParams, isEmpty } from "@ungate/plugininf/lib/util/Util";
import { IAuthController } from "@ungate/plugininf/lib/IAuthController";
import ICCTParams from "@ungate/plugininf/lib/ICCTParams";
import { IContextParams } from "@ungate/plugininf/lib/IContextPlugin";
const Mask = global.maskgate;

interface IKubeProbeParams extends IContextParams {
    accessHeader: {
        name: string;
        value: string;
    }[];
}

export default class KubeProbe extends NullContext {
    public static getParamsInfo(): IParamsInfo {
        return {
            accessHeader: {
                type: "form_repeater",
                name: "Check access header",
                maxsize: 0,
                childs: {
                    name: {
                        type: "string",
                        name: "Name header",
                        required: true,
                    },
                    value: {
                        type: "string",
                        name: "Value",
                        required: true,
                    },
                },
            },
        };
    }

    public params: IKubeProbeParams;

    constructor(
        name: string,
        params: ICCTParams,
        authController: IAuthController,
    ) {
        super(name, params, authController);
        this.params = {
            ...this.params,
            ...initParams(KubeProbe.getParamsInfo(), this.params),
        };
        if (!isEmpty(this.params.accessHeader)) {
            const accessHeader = this.params.accessHeader.map(
                ({ name, value }) => ({
                    name: name.trim().toLowerCase(),
                    value,
                }),
            );
            this.checkAccessHeader = (context: IContext) => {
                let isAccess = false;
                accessHeader.forEach(({ name, value }) => {
                    if (context.request.headers[name] === value) {
                        isAccess = true;
                    } else {
                        isAccess = false;
                    }
                });

                return isAccess;
            };
        }
    }
    public async init(reload?: boolean): Promise<void> {
        return;
    }
    public checkAccessHeader = (_gateContext: IContext): boolean => {
        return true;
    };
    public initContext(gateContext: IContext): Promise<IContextPluginResult> {
        if (this.checkAccessHeader(gateContext)) {
            gateContext.request.session.destroy((err) => {
                if (err) {
                    this.logger.error(err);
                }
            });
            const probe = gateContext.params.probe;
            switch (probe) {
                case "startup": {
                    gateContext.response.writeHead(200, {
                        "content-type": "text/plain",
                    });
                    gateContext.response.end("started");
                    break;
                }
                case "liveness": {
                    gateContext.response.writeHead(200, {
                        "content-type": "text/plain",
                    });
                    gateContext.response.end("alive");
                    break;
                }
                case "readiness": {
                    if (Mask.masked) {
                        gateContext.response.writeHead(404, {
                            "content-type": "text/plain",
                        });
                        gateContext.response.end("not ready");
                    } else {
                        gateContext.response.writeHead(200, {
                            "content-type": "text/plain",
                        });
                        gateContext.response.end("ready");
                    }
                    break;
                }
                default: {
                    gateContext.response.writeHead(404, {
                        "content-type": "text/plain",
                    });
                    gateContext.response.end("not found method");
                    break;
                }
            }
            throw new BreakException({
                type: "break",
            });
        }
        gateContext.response.writeHead(401, {
            "content-type": "text/plain",
        });
        gateContext.response.end("Not auth");
        throw new BreakException({
            type: "break",
        } as IResult);
    }
    public destroy(): Promise<void> {
        return;
    }
}
