import * as crypto from "crypto";
import PostgresDB from "@ungate/plugininf/lib/db/postgres";
import BreakException from "@ungate/plugininf/lib/errors/BreakException";
import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import ErrorGate from "@ungate/plugininf/lib/errors/ErrorGate";
import IContext, { IParam } from "@ungate/plugininf/lib/IContext";
import { IContextPluginResult } from "@ungate/plugininf/lib/IContextPlugin";
import IResult from "@ungate/plugininf/lib/IResult";
import ResultStream from "@ungate/plugininf/lib/stream/ResultStream";
import {
    filterFilesData,
    sortFilesData,
    isEmpty,
} from "@ungate/plugininf/lib/util/Util";
import CoreContext, { ICoreParams } from "./CoreContext";
import ICoreController, { IPropertyContext } from "./ICoreController";
import { isObject, noop } from "lodash";
import { FIND_SYMBOL, replaceNull } from "./Util";
import { IRufusLogger } from "rufus";
import { safePipe } from "@ungate/plugininf/lib/stream/Util";
import { Transform } from "stream";
import { TempTable } from "./TempTable";
import { IPageData } from "./CoreContext.types";
import { deepParam } from "@ungate/plugininf/lib/util/deepParam";

export default class OnlineController implements ICoreController {
    public params: ICoreParams;
    public dataSource: PostgresDB;
    public name: string;
    public tempTable: TempTable;
    private sysSettings =
        "select s.ck_id, s.cv_value, s.cv_description from s_mt.t_sys_setting s";
    private pageFindSql =
        "with recursive temp_tree_page as (\n" + 
        "    select\n" + 
        "            p.ck_id,\n" + 
        "            p.ck_parent,\n" + 
        "            p.cv_url as cv_app_url,\n" + 
        "            p.cv_name as root,\n" + 
        "            jsonb_build_array(jsonb_build_object('cv_name', p.cv_name, 'ck_id', p.ck_id)) as cct_tree_path\n" + 
        "        from\n" + 
        "            s_mt.t_page p\n" + 
        "        where p.ck_parent is null and p.cr_type = 3\n" + 
        "    union all\n" + 
        "        select\n" + 
        "            p.ck_id,\n" + 
        "            p.ck_parent,\n" + 
        "            op.cv_app_url,\n" + 
        "            op.root,\n" + 
        "            op.cct_tree_path || jsonb_build_array(jsonb_build_object('cv_name', p.cv_name, 'ck_id', p.ck_id)) as cct_tree_path\n" + 
        "        from\n" + 
        "            temp_tree_page op\n" + 
        "        join s_mt.t_page p on\n" + 
        "            op.ck_id = p.ck_parent\n" + 
        ")\n" + 
        "select\n" + 
        "    p.ck_id as ck_page,\n" + 
        "    coalesce(nullif((\n" + 
        "        select\n" + 
        "            jsonb_agg(t.json ORDER BY t.cn_order) as children\n" + 
        "        from\n" + 
        "            (\n" + 
        "                select\n" + 
        "                    pp.ck_id,\n" + 
        "                    po.cn_order,\n" + 
        "                    pkg_json.f_get_object(po.ck_id)::jsonb as json\n" + 
        "                from\n" + 
        "                    t_page pp\n" + 
        "                join t_page_object po on\n" + 
        "                    pp.ck_id = po.ck_page\n" + 
        "                where po.ck_parent is null and po.ck_id is not null and pp.ck_id = p.ck_id \n" + 
        "            ) as t\n" + 
        "        )::text, '[null]'), '[]') as children,\n" + 
        "        coalesce((\n" + 
        "            select\n" + 
        "                jsonb_object_agg(pv.cv_name, pv.cv_value)\n" + 
        "            from\n" + 
        "                t_page_variable pv\n" + 
        "            where\n" + 
        "                pv.ck_page = p.ck_id\n" + 
        "        )::text, '{}') as global_value,\n" + 
        "    pav.cn_action as cn_action,\n" + 
        "    p.cv_url,\n" + 
        "    p.cv_name,\n" + 
        "    jsonb_build_object(\n" + 
        "    'ck_id', p.ck_id,\n" + 
        "    'ck_parent', p.ck_parent,\n" + 
        "    'cv_name', p.cv_name,\n" + 
        "    'cn_order', p.cn_order,\n" + 
        "    'cl_menu', p.cl_menu,\n" + 
        "    'cl_static', p.cl_static,\n" + 
        "    'cv_url', p.cv_url,\n" + 
        "    'ck_icon', p.ck_icon,\n" + 
        "    'ck_view', p.ck_view,\n" + 
        "    'cv_redirect_url', p.cv_redirect_url,\n" + 
        "    'cl_multi', p.cl_multi,\n" + 
        "    'cn_action_view', pav.cn_action,\n" + 
        "    'cn_action_edit', pae.cn_action,\n" + 
        "    'cv_icon_name', i.cv_name,\n" + 
        "    'cv_icon_font', i.cv_font,\n" + 
        "    'cv_app_url', ttp.cv_app_url,\n" + 
        "    'root', ttp.root,\n" + 
        "    'cct_tree_path', ttp.cct_tree_path,\n" + 
        "    'leaf', 'true'\n" + 
        "    ) || coalesce((select\n" + 
        "           jsonb_object_agg(tpa.ck_attr, pkg_json.f_decode_attr(tpa.cv_value, coalesce(da.ck_parent, a2.ck_d_data_type), tpa.ck_attr))\n" + 
        "           from\n" + 
        "               s_mt.t_page_attr tpa\n" + 
        "           join s_mt.t_attr a2 on a2.ck_id = tpa.ck_attr \n" +
        "           join s_mt.t_d_attr_data_type da on da.ck_id = a2.ck_d_data_type \n" +
        "           where\n" + 
        "               tpa.ck_page = p.ck_id)::text, '{}')::jsonb  as route \n" +
        "from\n" + 
        "    t_page p\n" + 
        "join temp_tree_page ttp \n" + 
        "    on ttp.ck_id = p.ck_id\n" + 
        "left join t_page_action pav on\n" + 
        "    pav.ck_page = p.ck_id and pav.cr_type = 'view'\n" + 
        "left join t_page_action pae on\n" + 
        "    pae.ck_page = p.ck_id and pae.cr_type = 'edit'\n" + 
        "left join t_icon i on\n" + 
        "    i.ck_id = p.ck_icon\n" +
        " where p.cr_type = 2 and (\n" +
        "                    p.ck_id = :ck_page\n" +
        "                or p.cv_url = :cv_url\n" +
        "                  )\n";
    private pageObjectFindSql =
        "select po.ck_id, pa.cn_action, pkg_json.f_get_object(po.ck_id) as json\n" +
        "   from t_page_object po\n" +
        "   join t_page p on p.ck_id = po.ck_page\n" +
        "   join t_page_action pa on pa.ck_page = p.ck_id\n" +
        "  where po.ck_id = :ck_page_object and ((pa.cr_type is not null and pa.cr_type = 'view') or pa.cr_type is null)\n";
    private queryFindSql =
        "select q.ck_id, q.ck_provider, q.cc_query, q.cr_type, q.cr_access, q.cn_action, q.cr_cache, q.cv_cache_key_param\n" +
        "   from t_query q where upper(q.ck_id) = upper(:ck_query)";
    private modifyFindSql =
        "select po.ck_id, o.cv_modify, o.ck_provider\n" +
        "  from t_page_object po\n" +
        "  join t_page p\n" +
        "    on po.ck_page = p.ck_id\n" +
        "  join t_object o\n" +
        "    on po.ck_object = o.ck_id\n" +
        " where o.cv_modify is not null and upper(po.ck_id) = upper(:page_object)";
    private isSave = false;
    public logger: IRufusLogger;

    constructor({
        dataSource,
        params,
        logger,
        name,
        tempTable,
    }: IPropertyContext) {
        this.dataSource = dataSource;
        this.params = params;
        this.name = name;
        this.logger = logger;
        this.tempTable = tempTable;
        this.isSave = !this.params.disableCache;
    }
    public findObjectPage(gateContext: IContext): Promise<any> {
        const json = JSON.parse(gateContext.params.json || "{}");
        const ckPageObject = json.filter?.ck_page_object;
        const caActions = [
            this.params.anonymousAction,
            ...(gateContext.session?.userData.ca_actions || []),
        ];
        return new Promise((resolve, reject) => {
            this.dataSource
                .executeStmt(
                    this.pageObjectFindSql,
                    null,
                    {
                        ck_page_object: ckPageObject,
                    },
                    {},
                    {
                        resultSet: true,
                    },
                )
                .then((res) => {
                    const data = [];
                    res.stream.on("data", (row) => {
                        data.push({
                            ...row,
                            cn_action:
                                row.cn_action && parseInt(row.cn_action, 10),
                            json: [
                                isObject(row.json)
                                    ? row.json
                                    : JSON.parse(row.json, replaceNull),
                            ],
                        });
                    });
                    res.stream.on("end", () => {
                        if (data.length === 0) {
                            return reject(CoreContext.accessDenied());
                        }
                        const [row] = data;
                        if (this.isSave) {
                            this.tempTable.dbObject
                                .insert(data)
                                .then(noop, noop);
                        }
                        if (
                            isEmpty(row.cn_action) ||
                            !caActions.includes(row.cn_action)
                        ) {
                            return gateContext.session
                                ? reject(CoreContext.accessDenied())
                                : reject(
                                      new ErrorException(
                                          ErrorGate.REQUIRED_AUTH,
                                      ),
                                  );
                        }
                        return reject(
                            new BreakException({
                                data: ResultStream(row.json),
                                type: "success",
                            }),
                        );
                    });
                });
        });
    }
    public async getSetting(gateContext: IContext): Promise<any> {
        const { js } = gateContext.params;
        const json = JSON.parse(gateContext.params.json || "{}");
        const ckId = json.filter?.ck_id;
        return new Promise((resolve, reject) => {
            this.dataSource
                .executeStmt(
                    this.sysSettings,
                    null,
                    {},
                    {},
                    {
                        resultSet: true,
                    },
                )
                .then(async (res) => {
                    const data = [
                        {
                            ck_id: "core_gate_version",
                            cv_description: "Версия шлюза",
                            cv_value: gateContext.gateVersion,
                        },
                    ];
                    const cacheData = await this.tempTable.dbSysSettings.findOne({
                        ck_id: 'cache_date',
                    }, true);
                    if (cacheData) {
                        data.push(cacheData);
                    }
                    Object.entries(gateContext.request.headers).forEach(([key, value]) => {
                        const keyUpper = key.toLocaleUpperCase();
                        if (keyUpper.startsWith(this.params.headerPrefixSetting)) {
                            data.push({
                                ck_id: `g_sys_header_${key.substring(this.params.headerPrefixSetting.length).replace(FIND_SYMBOL, "_")}`,
                                cv_description: `Header ${key}`,
                                cv_value: Array.isArray(value) ? JSON.stringify(value) : value,
                            });
                        }
                    });
                    res.stream.on("data", (row) => {
                        data.push(row);
                    });
                    res.stream.on("end", () => {
                        if (js) {
                            const str =
                                "window.SETTINGS = " +
                                JSON.stringify(data) +
                                ";";
                            gateContext.response.writeHead(200, {
                                "content-length": Buffer.byteLength(str),
                                "content-type": "application/javascript",
                            });
                            gateContext.response.end(str);
                            reject(
                                new BreakException({
                                    data: ResultStream(
                                        data
                                            .sort(sortFilesData(gateContext))
                                            .filter(
                                                filterFilesData(gateContext),
                                            ),
                                    ),
                                    type: "break",
                                }),
                            );
                        } else {
                            reject(
                                new BreakException({
                                    data: ResultStream(
                                        data
                                            .sort(sortFilesData(gateContext))
                                            .filter(
                                                filterFilesData(gateContext),
                                            )
                                            .filter(
                                                (obj) =>
                                                    !ckId || obj.ck_id === ckId,
                                            ),
                                    ),
                                    type: "success",
                                }),
                            );
                        }
                    });
                });
        });
    }
    public handleResult(
        gateContext: IContext,
        result: IResult,
    ): Promise<IResult> {
        const self = this;
        if (result.type === "error") {
            return new Promise((resolve, reject) => {
                const data = [];
                result.data.on("error", (err) =>
                    reject(new Error(err.message)),
                );
                result.data.on("data", (row) => data.push(row));
                result.data.on("end", () => {
                    const doc = data[0];
                    let res;
                    if (doc.err_code > 0) {
                        res = {
                            data: ResultStream(data),
                            type: "error",
                        };
                    } else if (doc.err_text) {
                      res = {
                            data: ResultStream([
                                {
                                    ck_id: "",
                                    jt_message: {
                                      error: [[doc.err_text]],
                                    },
                                },
                            ]),
                            type: "success",
                        };
                    } else {
                        res = {
                            data: ResultStream([
                                {
                                    ck_id: "",
                                    cv_error: {
                                        512: [],
                                    },
                                    ...(this.params.debug
                                        ? {
                                              cv_stack_trace:
                                                  doc.err_text ||
                                                  JSON.stringify(doc),
                                          }
                                        : {}),
                                },
                            ]),
                            type: "success",
                        };
                    }
                    return resolve(res as IResult);
                });
            });
        } else if (result.type !== "success") {
            return Promise.resolve(result);
        }
        const data = [];
        const isCache = this.tempTable.caches.includes(gateContext.metaData.cache as string) && !this.params.disableCache;
        if (gateContext.connection) {
            const rTransform = new Transform({
                readableObjectMode: true,
                writableObjectMode: true,
                transform(chunk, encode, callback) {
                    if (
                        !isEmpty(chunk.cv_error) ||
                        !isEmpty(chunk.jt_form_message)
                    ) {
                        const cvErrors = [
                            ...(isEmpty(chunk.cv_error)
                                ? []
                                : Object.keys(chunk.cv_error)),
                            ...(isEmpty(chunk.jt_form_message)
                                ? []
                                : Object.entries(chunk.jt_form_message).reduce(
                                      (arr, [, values]) => {
                                          return [
                                              ...arr,
                                              ...Object.keys(values),
                                          ];
                                      },
                                      [],
                                  )),
                        ];
                        if (
                            chunk.jt_form_message &&
                            cvErrors.includes("error")
                        ) {
                            gateContext.connection
                                .rollback()
                                .then(() => callback(null, chunk))
                                .catch((err) => {
                                    gateContext.warn(err.message, err);
                                    callback(null, chunk);
                                    return Promise.resolve();
                                });
                            return;
                        }
                        self.tempTable
                            .findMessage(cvErrors, {
                                cr_type: "error",
                            })
                            .then((errors) => {
                                if (errors) {
                                    gateContext.connection
                                        .rollback()
                                        .then(() => callback(null, chunk))
                                        .catch((err) => {
                                            gateContext.warn(err.message, err);
                                            callback(null, chunk);
                                            return Promise.resolve();
                                        });
                                    return;
                                }
                                callback(null, chunk);
                            });
                    } else if (
                        !isEmpty(chunk.jt_message) &&
                        !isEmpty(chunk.jt_message.error)
                    ) {
                        gateContext.connection
                            .rollback()
                            .then(() => callback(null, chunk))
                            .catch((err) => {
                                gateContext.warn(err.message, err);
                                callback(null, chunk);
                                return Promise.resolve();
                            });
                    } else {
                        if (isCache) {
                            data.push(chunk);
                        }
                        callback(null, chunk);
                    }
                    rTransform._transform = ((childChunk, _encode, cb) => {
                        if (isCache) {
                            data.push(childChunk);
                        }
                        cb(null, childChunk);
                    }).bind(rTransform);
                },
            });
            result.data = safePipe(result.data, rTransform);
        } else if (isCache) {
            result.data = safePipe(result.data, new Transform({
                readableObjectMode: true,
                writableObjectMode: true,
                transform(chunk, encode, callback) {
                    data.push(chunk);
                    callback(null, chunk);
                }
            }));
        }
        if (isCache) {
            result.data.once('end', () => {
                const param = (gateContext.metaData?.cache_key_param as string[] || []).reduce((res, value) => {
                    const found = deepParam(value, gateContext.params);
                    res.push(found);
                    return res;
                }, []) || [];
                const shasum = crypto.createHash("sha1");
                shasum.update(JSON.stringify(param));
                this.tempTable.dbQueryCache.insert({
                    ck_id: `${gateContext.queryName}_${shasum.digest("hex")}`,
                    cct_data: data,
                }).catch((err) => this.logger.error(err));
            });
        }
        return Promise.resolve(result);
    }
    public async findModify(gateContext: IContext): Promise<any> {
        if (!gateContext.session) {
            return Promise.reject(new ErrorException(ErrorGate.REQUIRED_AUTH));
        } else if (!gateContext.params.page_object) {
            return Promise.reject(
                new ErrorException(-1, 'Not found require param "page_object"'),
            );
        }
        const pageObject = (gateContext.params.page_object || "").toLowerCase();
        const caActions = [
            this.params.anonymousAction,
            ...(gateContext.session?.userData.ca_actions || []),
        ];
        const isAccess = await this.tempTable.dbModifyAction.findOne(
            {
                $and: [
                    { ck_page_object: pageObject },
                    { cn_action: { $in: caActions } },
                ],
            },
            true,
        );
        if (isEmpty(isAccess) && !this.params.disableCheckAccess) {
            throw CoreContext.accessDenied();
        }
        const res = await this.dataSource.executeStmt(
            this.modifyFindSql,
            null,
            {
                page_object: pageObject,
            },
        );

        return new Promise((resolve, reject) => {
            const data = [];
            res.stream.on("error", (err) => reject(new Error(err.message)));
            res.stream.on("data", (row) => {
                data.push({
                    ck_id: row.ck_id.toLowerCase(),
                    ck_provider: row.ck_provider,
                    cv_modify: row.cv_modify,
                });
            });
            res.stream.on("end", () => {
                if (data.length) {
                    if (this.isSave) {
                        this.tempTable.dbQuery.insert(data).then(noop, noop);
                    }
                    const doc = data[0];
                    return resolve({
                        defaultActionName: "dml",
                        providerName: doc.ck_provider,
                        query: {
                            extraOutParams: [
                                {
                                    cv_name: "result",
                                    outType: "DEFAULT",
                                },
                                {
                                    cv_name: "cur_result",
                                    outType: "CURSOR",
                                },
                            ],
                            modifyMethod: doc.cv_modify,
                        },
                    });
                }
                return reject(
                    new BreakException({
                        data: ResultStream([
                            {
                                ck_id: "",
                                cv_error: {
                                    22: [],
                                },
                            },
                        ]),
                        type: "success",
                    }),
                );
            });
        });
    }
    public findPages(
        gateContext: IContext,
        ckPage: string,
        caActions: any[],
        version: "1" | "2" | "3",
    ): Promise<any> {
        return this.dataSource
            .executeStmt(this.pageFindSql, null, {
                ck_page: ckPage,
                cv_url: ckPage,
            })
            .then(
                (res) =>
                    new Promise((resolve, reject) => {
                        const data: Record<string, IPageData> = {};
                        res.stream.on("error", (err) =>
                            reject(new Error(err.message)),
                        );
                        res.stream.on("data", (row) => {
                            try {
                                const children = Array.isArray(row.children)
                                    ? row.children
                                    : JSON.parse(row.children, replaceNull);
                                data[row.ck_page] = {
                                    ck_id: row.ck_page,
                                    cn_action:
                                        row.cn_action &&
                                        parseInt(row.cn_action, 10),
                                    cv_name: row.cv_name,
                                    cv_url: row.cv_url,
                                    children,
                                    route: isObject(row.route)
                                        ? row.route
                                        : JSON.parse(
                                            row.route || "{}",
                                        ),
                                    global_value: isObject(row.global_value)
                                        ? row.global_value
                                        : JSON.parse(
                                              row.global_value || "{}",
                                          ),
                                };
                                if (
                                    children.length === 1 &&
                                    isEmpty(children[0])
                                ) {
                                    children.length = 0;
                                }
                            } catch (e) {
                                this.logger.error(
                                    `Error parse: ${row.json} ${e.message}`,
                                    e,
                                );
                            }
                        });
                        res.stream.on("end", () => {
                            let page: IPageData = null;
                            Object.entries(data).some((arr) => {
                                if (
                                    arr[0] === ckPage ||
                                    arr[1].cv_url === ckPage
                                ) {
                                    page = arr[1];
                                    return true;
                                }
                            });
                            if (!page) {
                                if (version === "2") {
                                    return reject(
                                        new BreakException({
                                            data: ResultStream([]),
                                            type: "success",
                                        }),
                                    );
                                }
                                return reject(CoreContext.accessDenied());
                            }
                            if (this.isSave) {
                                this.tempTable.dbPage
                                    .insert(Object.values(data))
                                    .then(noop, noop);
                            }
                            if (
                                isEmpty(page.cn_action) ||
                                !caActions.includes(page.cn_action)
                            ) {
                                return gateContext.session
                                    ? reject(CoreContext.accessDenied())
                                    : reject(
                                          new ErrorException(
                                              ErrorGate.REQUIRED_AUTH,
                                          ),
                                      );
                            }
                            if (version === "3") {
                                return reject(
                                    new BreakException({
                                        data: ResultStream([
                                            {
                                                children: page.children,
                                                global_value: page.global_value,
                                                route: page.route,
                                            },
                                        ]),
                                        type: "success",
                                    }),
                                );
                            }
                            return reject(
                                new BreakException({
                                    data: ResultStream(page.children),
                                    type: "success",
                                }),
                            );
                        });
                    }),
            );
    }
    public findQuery(
        gateContext: IContext,
        name: string,
    ): Promise<IContextPluginResult> {
        const caActions = [
            this.params.anonymousAction,
            ...(gateContext.session?.userData.ca_actions || []),
        ];
        const pageObject = (gateContext.params.page_object || "").toLowerCase();
        return this.dataSource
            .executeStmt(this.queryFindSql, null, { ck_query: name })
            .then(
                (res) =>
                    new Promise((resolve, reject) => {
                        const data = [];
                        res.stream.on("error", (err) =>
                            reject(new Error(err.message)),
                        );
                        res.stream.on("data", (row) => {
                            data.push({
                                cc_query: row.cc_query,
                                ck_id: row.ck_id.toLowerCase(),
                                ck_provider: row.ck_provider,
                                cn_action:
                                    row.cn_action &&
                                    parseInt(row.cn_action, 10),
                                cr_access: row.cr_access,
                                cr_type: row.cr_type,
                                cr_cache: row.cr_cache,
                                cv_cache_key_param: row.cv_cache_key_param ? JSON.parse(row.cv_cache_key_param) : [],
                            });
                        });
                        res.stream.on("end", async () => {
                            if (data.length) {
                                if (this.isSave) {
                                    this.tempTable.dbQuery
                                        .insert(data)
                                        .then(noop, noop);
                                }
                                const [doc] = data;
                                if (
                                    doc.cr_access !== "free" &&
                                    !gateContext.session
                                ) {
                                    return reject(
                                        new ErrorException(
                                            ErrorGate.REQUIRED_AUTH,
                                        ),
                                    );
                                }
                                if (doc.cr_access === "po_session") {
                                    const access =
                                        await this.tempTable.dbQueryAction.findOne(
                                            {
                                                $and: [
                                                    {
                                                        ck_page_object:
                                                            pageObject,
                                                    },
                                                    {
                                                        cn_action: {
                                                            $in: caActions,
                                                        },
                                                    },
                                                ],
                                            },
                                            true,
                                        );
                                    if (
                                        isEmpty(access) &&
                                        !this.params.disableCheckAccess
                                    ) {
                                        return reject(
                                            CoreContext.accessDenied(),
                                        );
                                    }
                                }
                                if (
                                    doc.cn_action &&
                                    !caActions.includes(doc.cn_action)
                                ) {
                                    return reject(CoreContext.accessDenied());
                                }
                                return resolve({
                                    defaultActionName:
                                        CoreContext.decodeType(doc),
                                    providerName: doc.ck_provider,
                                    query: {
                                        extraOutParams: [
                                            {
                                                cv_name: "result",
                                                outType: "DEFAULT",
                                            },
                                            {
                                                cv_name: "cur_result",
                                                outType: "CURSOR",
                                            },
                                            ...(doc.cr_type === "report"
                                                ? [
                                                      {
                                                          cv_name:
                                                              "EXTRACT_META_DATA",
                                                          outType: "DEFAULT",
                                                      },
                                                  ]
                                                : []),
                                        ],
                                        needSession: doc.cr_access !== "free",
                                        queryData: doc,
                                        queryStr: doc.cc_query,
                                    },
                                    metaData: this.params.disableCache ? {} : {
                                        cache: doc.cr_cache,
                                        cache_key_param: doc.cv_cache_key_param,
                                    },
                                });
                            }
                            return reject(
                                new ErrorException(ErrorGate.NOTFOUND_QUERY),
                            );
                        });
                    }),
            );
    }

    public async init(reload?: boolean): Promise<any> {
        const self = this;
        if (isEmpty(this.dataSource.pool)) {
            await this.dataSource.createPool();
        }
        return this.tempTable
            .initTempDb()
            .then(() =>
                Promise.all([
                    self.tempTable.loadQueryCache(),
                    self.tempTable.loadQueryAction(),
                    self.tempTable.loadModifyAction(),
                    self.tempTable.loadMessage(),
                    self.tempTable.loadSysSetting(),
                ]),
            );
    }
    public destroy(): Promise<void> {
        return this.dataSource.resetPool();
    }
}
