import IContextPlugin from "@ungate/plugininf/lib/IContextPlugin";
import Logger from "@ungate/plugininf/lib/Logger";
import { safePipe } from "@ungate/plugininf/lib/stream/Util";
import {
    json as Json,
    text as Text,
    urlencoded as Urlencoded,
    raw as Raw,
} from "body-parser";
import * as Multiparty from "multiparty";
import * as QueryString from "qs";
import typeis from "type-is";
import * as zlib from "zlib";
import Constants from "../core/Constants";
const logger = Logger.getLogger("BodyParse");

function typeChecker(type) {
    return function checkType(req) {
        return Boolean(typeis(req, type));
    };
}

const shouldParse = typeChecker("multipart/form-data");

/**
 * Get the content stream of the request.
 *
 * @param {object} req
 * @param {function} debug
 * @param {boolean} [inflate=true]
 * @return {object}
 * @api private
 */

function contentStream(req) {
    const encoding = (
        req.headers["content-encoding"] || "identity"
    ).toLowerCase();
    const length = req.headers["content-length"];
    let stream;

    switch (encoding) {
        case "deflate":
            stream = zlib.createInflate();
            safePipe(req, stream);
            break;
        case "gzip":
            stream = zlib.createGunzip();
            safePipe(req, stream);
            break;
        case "identity":
            stream = req;
            stream.length = length;
            break;
        default:
            throw new Error('unsupported content encoding "' + encoding + '"');
    }

    return stream;
}

function applyJsonBody(req) {
    const body = req.body;
    if (
        body &&
        typeof body === "object" &&
        !Array.isArray(body) &&
        (body.query != null ||
            body.action != null ||
            body.session != null ||
            body.json != null)
    ) {
        req.preParams = {
            ...req.preParams,
            ...body,
        };
        if (
            req.preParams.json != null &&
            typeof req.preParams.json !== "string"
        ) {
            req.preParams.json = JSON.stringify(req.preParams.json);
        }
    } else {
        req.preParams.json =
            typeof body === "string" ? body : JSON.stringify(body);
    }
    if (typeof req.body !== "string") {
        req.body = JSON.stringify(req.body);
    }
}

function parseMultipart(req, gateContext, next) {
    req._body = true;
    const form = new Multiparty.Form({
        maxFilesSize: gateContext.maxFileSize,
        uploadDir: Constants.UPLOAD_DIR,
    });
    form.parse(contentStream(req), (err, fields, files) => {
        if (err) {
            logger.error(err.message, err);
            const error = new Error("No valid upload");
            error.stack = err.stack;
            return next({
                ...error,
                gateContext,
            });
        }
        req.preParams = {
            ...req.preParams,
            ...Object.entries(fields).reduce(
                (obj, val) => {
                    obj[val[0].toLocaleLowerCase()] = val?.[1]?.[0];
                    return obj;
                },
                {} as Record<string, any>,
            ),
        };
        req.body = { fields, files };
        return next();
    });
}

export default function BodyParse(gateContext: IContextPlugin) {
    const parsers = [
        {
            parse: Urlencoded({
                extended: true,
                limit: gateContext.maxPostSize,
            }),
            apply: (req) => {
                req.preParams = {
                    ...req.preParams,
                    ...req.body,
                };
            },
        },
        {
            parse: Json({
                limit: gateContext.maxPostSize,
                type: ["application/json", "text/json"],
            }),
            apply: applyJsonBody,
        },
        {
            parse: Text({
                limit: gateContext.maxPostSize,
                type: ["application/xml", "text/xml", "application/soap+xml"],
            }),
            apply: (req) => {
                req.preParams.xml = req.body;
            },
        },
        {
            parse: Text({
                limit: gateContext.maxPostSize,
            }),
            apply: (req) => {
                req.preParams.text = req.body;
            },
        },
        {
            parse: Raw({
                limit: gateContext.maxPostSize,
            }),
            apply: (req) => {
                req.preParams.raw = req.body;
            },
        },
    ];

    return function bodyParser(req, res, next) {
        req.preParams = {
            ...req.params,
            ...QueryString.parse(req._parsedUrl.query),
        };

        if (req.body) {
            next();
            return;
        }

        if (!typeis.hasBody(req)) {
            next();
            return;
        }

        if (shouldParse(req)) {
            parseMultipart(req, gateContext, next);
            return;
        }

        const tryParse = (index: number) => {
            if (index >= parsers.length) {
                next();
                return;
            }
            const { parse, apply } = parsers[index];
            parse(req, res, (err) => {
                if (err) {
                    err.gateContext = gateContext;
                    next(err);
                    return;
                }
                if (req.body) {
                    apply(req);
                    next();
                    return;
                }
                tryParse(index + 1);
            });
        };
        tryParse(0);
    };
}
