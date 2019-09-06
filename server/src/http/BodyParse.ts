import IContextPlugin from "@ungate/plugininf/lib/IContextPlugin";
import Logger from "@ungate/plugininf/lib/Logger";
import { safePipe } from "@ungate/plugininf/lib/stream/Util";
import * as BodyParser from "body-parser";
import * as Multiparty from "multiparty";
import * as QueryString from "query-string";
import * as typeis from "type-is";
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

export default function BodyParse(gateContext: IContextPlugin) {
    const json = BodyParser.json({
        limit: gateContext.maxPostSize,
        type: ["application/json", "text/json"],
    });
    const xml = BodyParser.text({
        limit: gateContext.maxPostSize,
        type: ["application/xml", "text/xml", "application/soap+xml"],
    });
    const text = BodyParser.text({
        limit: gateContext.maxPostSize,
    });
    const urlencoded = BodyParser.urlencoded({
        extended: true,
        limit: gateContext.maxPostSize,
    });
    const raw = BodyParser.raw({
        limit: gateContext.maxPostSize,
    });

    return function bodyParser(req, res, next) {
        req.preParams = {
            ...req.params,
            ...QueryString.parse(req._parsedUrl.query),
        };

        if (req._body) {
            next();
            return;
        }

        req.body = req.body || {};

        // skip requests without bodies
        if (!typeis.hasBody(req)) {
            next();
            return;
        }

        // determine if request should be parsed
        if (shouldParse(req)) {
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
                    ...Object.entries(fields).reduce((obj, val) => {
                        obj[val[0].toLocaleLowerCase()] = val[1][0];
                        return obj;
                    }, {}),
                };
                req.body = files;
                return next();
            });
            return;
        }
        urlencoded(req, res, (err) => {
            if (err) {
                err.gateContext = gateContext;
                next(err);
                return;
            }
            if (req._body) {
                req.preParams = {
                    ...req.preParams,
                    ...req.body,
                };
                next();
                return;
            }
            json(req, res, (errjson) => {
                if (errjson) {
                    errjson.gateContext = gateContext;
                    next(errjson);
                    return;
                }
                if (req._body) {
                    req.body = JSON.stringify(req.body);
                    req.preParams.json = req.body;
                    next();
                    return;
                }
                xml(req, res, (errXml) => {
                    if (errXml) {
                        errXml.gateContext = gateContext;
                        next(errXml);
                        return;
                    }
                    if (req._body) {
                        req.preParams.xml = req.body;
                        next();
                        return;
                    }
                    text(req, res, (errText) => {
                        if (errText) {
                            errText.gateContext = gateContext;
                            next(errText);
                            return;
                        }
                        if (req._body) {
                            req.preParams.text = req.body;
                            next();
                            return;
                        }
                        raw(req, res, (errRaw) => {
                            if (errRaw) {
                                errRaw.gateContext = gateContext;
                                next(errRaw);
                                return;
                            }
                            if (req._body) {
                                req.preParams.raw = req.body;
                                next();
                                return;
                            }
                            next();
                        });
                    });
                });
            });
        });
    };
}
