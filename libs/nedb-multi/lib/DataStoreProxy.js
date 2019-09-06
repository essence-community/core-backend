const method = require("./Method");
const constants = require("nedb-multi/lib/constants");
const PersistenceProxy = require("nedb-multi/lib/persistenceProxy");

exports.create = function create(socket) {
    class DataStoreProxy {
        constructor(options) {
            this.options = options;
            this.persistence = new PersistenceProxy(socket, options);
        }
    }

    // eslint-disable-next-line no-restricted-syntax
    for (const { name, supportsCursor } of constants.METHODS_DESCRIPTIONS) {
        DataStoreProxy.prototype[name] = method.create(
            socket,
            name,
            supportsCursor,
        );
    }

    return DataStoreProxy;
};
