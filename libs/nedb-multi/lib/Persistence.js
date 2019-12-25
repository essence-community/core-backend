/**
 * Handle every persistence-related task
 * The interface Datastore expects to be implemented is
 * * Persistence.loadDatabase(callback) and callback has signature err
 * * Persistence.persistNewState(newDocs, callback) where newDocs is an array of documents and callback has signature err
 */

const storage = require("nedb/lib/storage"),
    TOML = require("@iarna/toml"),
    YAML = require("js-yaml"),
    noop = require("lodash/noop"),
    isArray = require("lodash/isArray"),
    path = require("path"),
    customUtils = require("nedb/lib/customUtils"),
    Index = require("nedb/lib/indexes");

const noopfn = (s) => s;

const isEmpty = (value, allowEmptyString = false) =>
    value == null ||
    (allowEmptyString ? false : value === "") ||
    (isArray(value) && value.length === 0);

class Persistence {
    /**
     * Create a new Persistence object for database options.db
     * @param {Datastore} options.db
     * @param {Boolean} options.nodeWebkitAppName Optional, specify the name of your NW app if you want options.filename to be relative to the directory where
     *                                            Node Webkit stores application data such as cookies and local storage (the best place to store data in my opinion)
     */
    constructor(options) {
        let i;
        let j;
        let randomString;

        this.db = options.db;
        this.persMethod = options.persMethod;
        this.inMemoryOnly = this.db.inMemoryOnly;
        this.filename = this.db.filename;
        this.corruptAlertThreshold =
            options.corruptAlertThreshold !== undefined
                ? options.corruptAlertThreshold
                : 0.1;

        if (
            !this.inMemoryOnly &&
            this.filename &&
            this.filename.charAt(this.filename.length - 1) === "~"
        ) {
            throw new Error(
                "The datafile name can't end with a ~, which is reserved for crash safe backup files",
            );
        }

        // After serialization and before deserialization hooks with some basic sanity checks
        if (options.afterSerialization && !options.beforeDeserialization) {
            throw new Error(
                "Serialization hook defined but deserialization hook undefined, cautiously refusing to start NeDB to prevent dataloss",
            );
        }
        if (!options.afterSerialization && options.beforeDeserialization) {
            throw new Error(
                "Serialization hook undefined but deserialization hook defined, cautiously refusing to start NeDB to prevent dataloss",
            );
        }
        this.afterSerialization = options.afterSerialization || noopfn;
        this.beforeDeserialization = options.beforeDeserialization || noopfn;
        for (i = 1; i < 30; i += 1) {
            for (j = 0; j < 10; j += 1) {
                randomString = customUtils.uid(i);
                if (
                    this.beforeDeserialization(
                        this.afterSerialization(randomString),
                    ) !== randomString
                ) {
                    throw new Error(
                        "beforeDeserialization is not the reverse of afterSerialization, cautiously refusing to start NeDB to prevent dataloss",
                    );
                }
            }
        }
    }

    /**
     * Check if a directory exists and create it on the fly if it is not the case
     * cb is optional, signature: err
     */
    ensureDirectoryExists(dir, cb) {
        const callback = cb || noop;
        storage.mkdirp(dir, (err) => callback(err));
    }

    /**
     * Return the path the datafile if the given filename is relative to the directory where Node Webkit stores
     * data for this application. Probably the best place to store data
     */
    getNWAppFilename(appName, relativeFilename) {
        let home;

        switch (process.platform) {
            case "win32":
            case "win64":
                home = process.env.LOCALAPPDATA || process.env.APPDATA;
                if (!home) {
                    throw new Error(
                        "Couldn't find the base application data folder",
                    );
                }
                home = path.join(home, appName);
                break;
            case "darwin":
                home = process.env.HOME;
                if (!home) {
                    throw new Error(
                        "Couldn't find the base application data directory",
                    );
                }
                home = path.join(
                    home,
                    "Library",
                    "Application Support",
                    appName,
                );
                break;
            case "linux":
                home = process.env.HOME;
                if (!home) {
                    throw new Error(
                        "Couldn't find the base application data directory",
                    );
                }
                home = path.join(home, ".config", appName);
                break;
            default:
                throw new Error(
                    `Can't use the Node Webkit relative path for platform ${
                        process.platform
                    }`,
                );
        }

        return path.join(home, "nedb-data", relativeFilename);
    }

    /**
     * Persist cached database
     * This serves as a compaction function since the cache always contains only the number of documents in the collection
     * while the data file is append-only so it may grow larger
     * @param {Function} cb Optional callback, signature: err
     */
    persistCachedDatabase(cb) {
        const callback = cb || noop;
        let toPersist = "";

        if (this.inMemoryOnly) {
            return callback(null);
        }

        if (this.db.getAllData().length) {
            if (this.persMethod === "toml") {
                toPersist += TOML.stringify({
                    data: this.db.getAllData().map((obj) => {
                        const newObject = {
                            ...obj,
                            ck_id: obj._id || obj.ck_id,
                        };
                        delete newObject._id;
                        return newObject;
                    }),
                });
            } else if (this.persMethod === "yaml") {
                toPersist += YAML.dump(this.db.getAllData());
            }
        }

        Object.keys(this.db.indexes).forEach((fieldName) => {
            // The special _id index is managed by datastore.js, the others need to be persisted
            if (fieldName !== "_id") {
                if (this.persMethod === "toml") {
                    toPersist += TOML.stringify({
                        data: [
                            {
                                $$indexCreated: {
                                    fieldName,
                                    unique: this.db.indexes[fieldName].unique,
                                    sparse: this.db.indexes[fieldName].sparse,
                                    expireAfterSeconds: this.db.indexes[
                                        fieldName
                                    ].expireAfterSeconds,
                                },
                            },
                        ],
                    });
                } else if (this.persMethod === "yaml") {
                    toPersist += YAML.dump([
                        {
                            $$indexCreated: {
                                fieldName,
                                unique: this.db.indexes[fieldName].unique,
                                sparse: this.db.indexes[fieldName].sparse,
                                expireAfterSeconds: this.db.indexes[fieldName]
                                    .expireAfterSeconds,
                            },
                        },
                    ]);
                }
            }
        });

        storage.crashSafeWriteFile(this.filename, toPersist, (err) => {
            if (err) {
                return callback(err);
            }
            this.db.emit("compaction.done");
            return callback(null);
        });
        return undefined;
    }

    /**
     * Queue a rewrite of the datafile
     */
    compactDatafile() {
        this.db.executor.push({
            this: this,
            fn: this.persistCachedDatabase,
            arguments: [],
        });
    }

    /**
     * Set automatic compaction every interval ms
     * @param {Number} interval in milliseconds, with an enforced minimum of 5 seconds
     */
    setAutocompactionInterval(interval) {
        const minInterval = 5000,
            realInterval = Math.max(interval || 0, minInterval);

        this.stopAutocompaction();

        this.autocompactionIntervalId = setInterval(() => {
            this.compactDatafile();
        }, realInterval);
    }

    /**
     * Stop autocompaction (do nothing if autocompaction was not running)
     */
    stopAutocompaction() {
        if (this.autocompactionIntervalId) {
            clearInterval(this.autocompactionIntervalId);
        }
    }

    /**
     * Persist new state for the given newDocs (can be insertion, update or removal)
     * Use an append-only format
     * @param {Array} newDocs Can be empty if no doc was updated/removed
     * @param {Function} cb Optional, signature: err
     */
    persistNewState(newDocs, cb) {
        const callback = cb || noop;
        let toPersist = "";

        // In-memory only datastore
        if (this.inMemoryOnly) {
            return callback(null);
        }

        if (this.persMethod === "toml") {
            toPersist += TOML.stringify({
                data: newDocs.map((obj) => {
                    const newObject = {
                        ...obj,
                        ck_id: obj._id || obj.ck_id,
                    };
                    delete newObject._id;
                    return newObject;
                }),
            });
        } else if (this.persMethod === "yaml") {
            toPersist += YAML.dump(newDocs);
        }

        if (newDocs.length === 0 || toPersist.length === 0) {
            return callback(null);
        }

        storage.appendFile(this.filename, toPersist, "utf8", (err) =>
            callback(err),
        );
        return undefined;
    }

    /**
     * From a database's raw data, return the corresponding
     * machine understandable collection
     */
    treatRawData(rawData) {
        let data = { data: [] };
        const dataById = {},
            tdata = [],
            indexes = {},
            // Last line of every data file is usually blank so not really corrupt
            corruptItems = -1;

        if (!isEmpty(rawData)) {
            if (this.persMethod === "toml") {
                data = TOML.parse(rawData);
                data.data = data.data.map((obj) => ({
                    ...obj,
                    _id: obj.ck_id,
                }));
            } else if (this.persMethod === "yaml") {
                data = { data: YAML.load(rawData) };
            }
        }

        data.data.forEach((doc) => {
            if (doc._id) {
                if (doc.$$deleted === true) {
                    delete dataById[doc._id];
                } else {
                    dataById[doc._id] = doc;
                }
            } else if (
                doc.$$indexCreated &&
                doc.$$indexCreated.fieldName !== undefined
            ) {
                indexes[doc.$$indexCreated.fieldName] = doc.$$indexCreated;
            } else if (typeof doc.$$indexRemoved === "string") {
                delete indexes[doc.$$indexRemoved];
            }
        });

        // A bit lenient on corruption
        if (
            data.length > 0 &&
            corruptItems / data.length > this.corruptAlertThreshold
        ) {
            throw new Error(
                `More than ${Math.floor(
                    100 * this.corruptAlertThreshold,
                )}% of the data file is corrupt, ` +
                    "the wrong beforeDeserialization hook may be used. Cautiously refusing to start NeDB to prevent dataloss",
            );
        }

        Object.keys(dataById).forEach((k) => {
            tdata.push(dataById[k]);
        });

        return {
            data: tdata,
            indexes,
        };
    }

    /**
     * Load the database
     * 1) Create all indexes
     * 2) Insert all data
     * 3) Compact the database
     * This means pulling data out of the data file or creating it if it doesn't exist
     * Also, all data is persisted right away, which has the effect of compacting the database file
     * This operation is very quick at startup for a big collection (60ms for ~10k docs)
     * @param {Function} cb Optional callback, signature: err
     */
    loadDatabase(cb) {
        const callback = cb || noop;

        this.db.resetIndexes();

        // In-memory only datastore
        if (this.inMemoryOnly) {
            return callback(null);
        }

        new Promise((resolve, reject) => {
            this.ensureDirectoryExists(path.dirname(this.filename), (err) => {
                if (err) {
                    return reject(err);
                }
                storage.ensureDatafileIntegrity(this.filename, (err2) => {
                    if (err2) {
                        return reject(err2);
                    }
                    storage.readFile(this.filename, "utf8", (err3, rawData) => {
                        let treatedData;
                        if (err3) {
                            return reject(err3);
                        }

                        try {
                            treatedData = this.treatRawData(rawData);
                        } catch (e) {
                            return reject(e);
                        }

                        // Recreate all indexes in the datafile
                        Object.keys(treatedData.indexes).forEach((key) => {
                            this.db.indexes[key] = new Index(
                                treatedData.indexes[key],
                            );
                        });

                        // Fill cached database (i.e. all indexes) with data
                        try {
                            this.db.resetIndexes(treatedData.data);
                        } catch (e) {
                            // Rollback any index which didn't fail
                            this.db.resetIndexes();
                            return reject(e);
                        }

                        this.db.persistence.persistCachedDatabase((error) => {
                            if (error) {
                                return reject(error);
                            }
                            return resolve();
                        });
                        return undefined;
                    });
                    return undefined;
                });
                return undefined;
            });
        })
            .then(() => {
                this.db.executor.processBuffer();
                callback(null);
            })
            .catch((err) => callback(err));
        return undefined;
    }
}

// Interface
module.exports = Persistence;
