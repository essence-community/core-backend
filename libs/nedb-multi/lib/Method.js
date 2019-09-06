const rpc = require("./Rpc");
const utils = require("nedb-multi/lib/utils");
const Cursor = require("./Cursor");

exports.create = function create(socket, name, supportsCursor) {
    return function method(...args) {
        if (supportsCursor && !utils.endsWithCallback(args)) {
            return new Cursor(socket, this.options, args);
        }

        return rpc(socket, this.options, name, args);
    };
};
