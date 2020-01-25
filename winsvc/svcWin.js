const fs = require("fs");
const nodemon = require("nodemon/lib");
const cli = require("nodemon/lib/cli");
const path = require("path");
const notify = require("update-notifier");

const options = cli.parse(process.argv);

nodemon(options);

const pkg = JSON.parse(
    fs
        .readFileSync(path.join(__dirname, "..", "package.json"))
        .toString("utf-8"),
);

if (pkg.version.indexOf("0.0.0") !== 0 && options.noUpdateNotifier !== true) {
    notify({ pkg }).notify();
}
