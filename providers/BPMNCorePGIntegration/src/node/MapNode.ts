import { StartNode } from "./StartNode";
import { BaseNode } from "./BaseNode";
const node = {
    "start-event": StartNode,
};

export function mapNode({ bc, bcLinks, bcNodes }): BaseNode[] {
    return bcLinks
        .filter((link) => link.source === bc.id)
        .map((link) => bcNodes.find((bcNode) => bcNode.id === link.target))
        .map((bc) => new node[bc.type]({ bc, bcLinks, bcNodes }));
}
