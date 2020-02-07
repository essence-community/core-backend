const fs = require("fs");
const { Service } = require("node-windows");
const path = require("path");

const props = {};
if (fs.existsSync(path.join(__dirname, "..", ".env.svc"))) {
    const propStr = fs
        .readFileSync(path.join(__dirname, "..", ".env.svc"))
        .toString("utf-8");
    propStr.split(/[\r\n]*/).forEach((row) => {
        const [key, val] = row.split("=");
        props[key] = val;
    });
}
const env = [];
const envName = [
    "LOGGER_CONF",
    "GATE_HOME_DIR",
    "GATE_CLUSTER_NUM",
    "GATE_HTTP_PORT",
    "GATE_UPLOAD_DIR",
    "NEDB_MULTI_PORT",
    "NEDB_MULTI_HOST",
    "NEDB_TEMP_DB",
    "CONTEXT_PLUGIN_DIR",
    "PROVIDER_PLUGIN_DIR",
    "DATA_PLUGIN_DIR",
    "EVENT_PLUGIN_DIR",
    "SCHEDULER_PLUGIN_DIR",
    "PROPERTY_DIR",
    "GATE_ADMIN_CLUSTER_CERT",
    "GATE_ADMIN_CLUSTER_KEY",
    "GATE_ADMIN_CLUSTER_CA",
    "GATE_ADMIN_CLUSTER_PORT",
    "GATE_NODE_NAME",
];

envName.forEach((name) => {
    const val = props[name] || process.env[name];
    if (val) {
        env.push({
            name,
            value: val,
        });
    }
});

const svc = new Service({
    description: "Json gate, project CORE",
    env,
    name: "gate_core",
    script: path.join(__dirname, "svcWin.js"),
});

svc.on("install", () => {
    svc.start();
});

svc.install();
