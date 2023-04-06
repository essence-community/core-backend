import IContext from "@ungate/plugininf/lib/IContext";
import { IPluginRequestContext } from "@ungate/plugininf/lib/IPlugin";
import { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import NullPlugin from "@ungate/plugininf/lib/NullPlugin";
import { isEmpty } from "@ungate/plugininf/lib/util/Util";
import {TAction} from '@ungate/plugininf/lib/IContext';


export default class PQAddedDefaultPaginationAndFilter extends NullPlugin {
    /**
     * Данный метод вызывается после инициализацией запроса
     * @param gateContext
     * @returns {Promise}
     */
    public afterInitQueryPerform(
        gateContext: IContext,
        PRequestContext: IPluginRequestContext,
        query: IGateQuery,
    ): Promise<void> {
        return new Promise((resolve) => {
            if (gateContext.actionName !== "sql") {
                return resolve();
            }
            if (isEmpty(query.queryStr)) {
                return resolve();
            }
            query.applyMacro(
                "([\x5cs\x5cS]+)",
                "select \n" + 
                "  /*Pagination*/\n" + 
                "  count(1) over() as jn_total_cnt,\n" + 
                "  /*Data*/\n" + 
                "  t.*\n" + 
                "from (\n" + 
                "$1\n" +
                ") t\n" + 
                " where &FILTER\n" + 
                " order by &SORT\n" + 
                "offset &OFFSET rows\n" + 
                " fetch first &FETCH rows only\n",
            );
            if (gateContext.isDebugEnabled()) {
                gateContext.debug(
                    `${query.queryStr}`,
                );
            }
            return resolve();
        });
    }
}
