import { mapNode } from "./MapNode";
import { IResultProvider } from "@ungate/plugininf/lib/IResult";

export abstract class BaseNode {
    public bc: Record<string, any>;
    public children: BaseNode[];
    constructor({ bc, bcNodes, bcLinks }) {
        this.bc = bc;
        this.children = mapNode({ bc, bcNodes, bcLinks });
    }

    public abstract async execute(): Promise<IResultProvider>;
}
