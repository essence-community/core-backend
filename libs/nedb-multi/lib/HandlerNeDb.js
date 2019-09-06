/**
 * Created by artemov_i on 09.02.2018.
 */
const DataStore = require("nedb"),
    errio = require("errio"),
    Persistence = require("./Persistence"),
    utils = require("nedb-multi/lib/utils"),
    constants = require("nedb-multi/lib/constants"),
    MSG = require("msgpack-lite");

const replyCallback = (reply) => (...args) => {
    if (args[0] !== null) {
        args[0] = errio.stringify(args[0], {
            stack: true,
        }); // eslint-disable-line no-param-reassign
    }

    reply(...args);
};

const ensureIndex = (db, obj) =>
    new Promise((resolve, reject) => {
        db.ensureIndex(obj, (errChild) => {
            if (errChild) {
                return reject(errChild);
            }
            return resolve(null);
        });
    });

const replyBufer = (reply) => (...args) => {
    reply(MSG.encode(args));
};

exports.create = (dbsMap) => (
    options = {},
    method,
    bdataOnlyArgs,
    replyOrigin,
) => {
    const { filename } = options;
    const reply = replyBufer(replyOrigin);
    const dataOnlyArgs = MSG.decode(bdataOnlyArgs) || [];
    let db = dbsMap.get(filename);

    if (method === "loadDatabase" && !db) {
        db = new DataStore(options);
        db.persistence = new Persistence({
            db,
            nodeWebkitAppName: options.nodeWebkitAppName,
            afterSerialization: options.afterSerialization,
            beforeDeserialization: options.beforeDeserialization,
            corruptAlertThreshold: options.corruptAlertThreshold,
            persMethod: options.tempDb ? "yaml" : "toml",
        });
        db.nameBd = options.nameBd;
        db.tempDb = options.tempDb;
        db.indexs = options.indexs;
        dbsMap.set(filename, db);
        db.loadDatabase((...args) => {
            if (args[0] !== null) {
                return replyCallback(reply)(args[0]);
            }
            if (options && options.indexs) {
                const rows = options.indexs.map((obj) => ensureIndex(db, obj));
                return Promise.all(rows).then(
                    () => replyCallback(reply)(null),
                    (err) => replyCallback(reply)(err),
                );
            }
            return replyCallback(reply)(null);
        });
        return;
    } else if (!db) {
        reply(errio.stringify(new Error("Call loadDatabase() first.")));
        return;
    }

    if (method === constants.EXECUTE_CURSOR_PRIVATE) {
        const cursor = dataOnlyArgs[dataOnlyArgs.length - 1];
        utils.execCursor(cursor, db, replyCallback(reply));
    } else if (method === constants.PERSISTENCE_COMPACT_DATAFILE) {
        db.persistence.compactDatafile();
    } else if (method === constants.PERSISTENCE_SET_AUTOCOMPACTION_INTERVAL) {
        db.persistence.setAutocompactionInterval(...dataOnlyArgs);
    } else if (method === constants.PERSISTENCE_STOP_AUTOCOMPACTION) {
        db.persistence.stopAutocompaction();
    } else {
        db[method].call(db, ...dataOnlyArgs, replyCallback(reply));
    }
};
