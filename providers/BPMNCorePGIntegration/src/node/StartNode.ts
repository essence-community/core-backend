import { BaseNode } from "./BaseNode";

export class StartNode extends BaseNode {
    public execute() {
        return this.children[0].execute();
    }
}
