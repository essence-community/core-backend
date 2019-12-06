/**
 * Created by artemov_i on 09.02.2018.
 */
const axon = require("axon"),
    proxy = require("./DataStoreProxy");

module.exports = (port, host) => {
    const reqSocket = axon.socket("req");
    if (host) {
        if (host.startsWith("unix:") || host.startsWith("tcp:")) {
            reqSocket.connect(host);
        } else {
            reqSocket.connect(port, host);
        }
    } else {
        reqSocket.connect(port);
    }
    return proxy.create(reqSocket);
};
