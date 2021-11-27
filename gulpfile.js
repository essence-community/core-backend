const gulp = require("gulp");
const ts = require("gulp-typescript");
const fs = require("fs");
const path = require("path");
const { exec } = require("child_process");
const crypto = require("crypto");
const glob = require("glob");
const homeDir = __dirname;
const packageJson = JSON.parse(fs.readFileSync("./package.json"));
const serverJson = JSON.parse(fs.readFileSync("./server/package.json"));
const versionApp = fs.readFileSync("./VERSION").toString();
delete serverJson.devDependencies;
delete packageJson.devDependencies;
delete packageJson.workspaces;
packageJson.workspaces = ["libs/**", "server", "server/plugins/**/**"];
packageJson.main = "server/index.js";
delete packageJson.husky;
packageJson.scripts = {
    server: "nodemon",
    installSvc: "node server/installSvcWin.js",
};
const cpy = require("cpy");
const shasum = crypto.createHash("sha1");
const buf = Buffer.alloc(8);
crypto.randomFillSync(buf).toString("hex");
shasum.update(buf);

packageJson.nodemonConfig = {
    ignore: ["libs/**", "node_modules/**", "server/plugins/**"],
    env: {
        NLS_LANG: "American_America.UTF8",
        NLS_DATE_FORMAT: "dd.mm.yyyy",
        NLS_TIMESTAMP_FORMAT: 'dd.mm.yyyy"T"hh:mi:ss',
        SESSION_SECRET: shasum.digest("hex"),
    },
    ext: "js",
    delay: "10000",
    watch: false,
};

function list(val) {
    return val.toUpperCase().split(",");
}

function cmdExec(
    command,
    options = {
        env: process.env,
        cwd: __dirname,
    },
) {
    return new Promise((resolve, reject) => {
        exec(command, options, (error, stdout, stderr) => {
            if (error) {
                error.message += `\n${stdout ? stdout : ""}\n${
                    stderr ? stderr : ""
                }`;

                return reject(error);
            }
            resolve({
                stdout,
                stderr,
            });
        });
    });
}

const filterJson = (packageSrc, packageDest) => {
    const packageJson = JSON.parse(fs.readFileSync(packageSrc));
    delete packageJson.devDependencies;
    delete packageJson.workspaces;
    fs.writeFileSync(packageDest, JSON.stringify(packageJson, null, 4));
};
const contextPlugins = process.env.CONTEXT_PLUGINS
    ? list(process.env.CONTEXT_PLUGINS)
    : null;
const providerPlugins = process.env.PROVIDER_PLUGINS
    ? list(process.env.PROVIDER_PLUGINS)
    : null;
const dataPlugins = process.env.DATA_PLUGINS
    ? list(process.env.DATA_PLUGINS)
    : null;
const eventPlugins = process.env.EVENT_PLUGINS
    ? list(process.env.EVENT_PLUGINS)
    : null;
const schedulerPlugins = process.env.SCHEDULERS_PLUGINS
    ? list(process.env.SCHEDULERS_PLUGINS)
    : null;

exec('git log -n 1 --pretty="format:%h от %ai"', (err, stdout) => {
    packageJson.nodemonConfig.env.GATE_VERSION = `${versionApp.trim()} (${stdout.trim()})`;
});

const isDev = process.env.NODE_ENV === "development";

gulp.task("plugins", () => {
    const rows = [];
    const pluginsDir = path.join(homeDir, "plugins");
    fs.readdirSync(pluginsDir)
        .filter((file) =>
            dataPlugins && dataPlugins.length
                ? dataPlugins.includes(file.toUpperCase())
                : true,
        )
        .forEach((file) => {
            if (
                fs.existsSync(path.join(pluginsDir, file, "tsconfig.json")) &&
                fs.existsSync(path.join(pluginsDir, file, "package.json"))
            ) {
                const tsProject = ts.createProject(
                    path.join(pluginsDir, file, "tsconfig.json"),
                    {
                        removeComments: !isDev,
                        sourceMap: !isDev,
                    },
                );
                rows.push(
                    () =>
                        new Promise((resolve, reject) => {
                            gulp.src(
                                path.join(
                                    pluginsDir,
                                    file,
                                    "src",
                                    "**",
                                    "*.ts",
                                ),
                            )
                                .pipe(tsProject())
                                .pipe(
                                    gulp.dest(
                                        path.join(
                                            homeDir,
                                            "bin",
                                            "server",
                                            "plugins",
                                            "datas",
                                            file,
                                        ),
                                    ),
                                )
                                .on("end", () => {
                                    filterJson(
                                        path.join(
                                            pluginsDir,
                                            file,
                                            "package.json",
                                        ),
                                        path.join(
                                            homeDir,
                                            "bin",
                                            "server",
                                            "plugins",
                                            "datas",
                                            file,
                                            "package.json",
                                        ),
                                    );
                                    if (
                                        fs.existsSync(
                                            path.join(
                                                pluginsDir,
                                                file,
                                                "assets",
                                            ),
                                        )
                                    ) {
                                        cpy(
                                            ["**/*.*","**/*"],
                                            path.join(
                                                homeDir,
                                                "bin",
                                                "server",
                                                "plugins",
                                                "datas",
                                                file,
                                                "assets",
                                            ),
                                            {
                                                cwd: path.join(
                                                    pluginsDir,
                                                    file,
                                                    "assets",
                                                ),
                                                parents: true,
                                                dot: true,
                                            },
                                        ).then(resolve, reject);
                                        return;
                                    }
                                    resolve();
                                })
                                .on("error", (err) => reject(err));
                        }),
                );
            }
        });
    return rows.length
        ? rows.splice(1).reduce((res, val) => res.then(() => val()), rows[0]())
        : Promise.resolve();
});
gulp.task("contexts", () => {
    const rows = [];
    const pluginsDir = path.join(homeDir, "contexts");
    fs.readdirSync(pluginsDir)
        .filter((file) =>
            contextPlugins && contextPlugins.length
                ? contextPlugins.includes(file.toUpperCase())
                : true,
        )
        .forEach((file) => {
            if (
                fs.existsSync(path.join(pluginsDir, file, "tsconfig.json")) &&
                fs.existsSync(path.join(pluginsDir, file, "package.json"))
            ) {
                const tsProject = ts.createProject(
                    path.join(pluginsDir, file, "tsconfig.json"),
                    {
                        removeComments: !isDev,
                        sourceMap: !isDev,
                    },
                );
                rows.push(
                    () =>
                        new Promise((resolve, reject) => {
                            gulp.src(
                                path.join(
                                    pluginsDir,
                                    file,
                                    "src",
                                    "**",
                                    "*.ts",
                                ),
                            )
                                .pipe(tsProject())
                                .pipe(
                                    gulp.dest(
                                        path.join(
                                            homeDir,
                                            "bin",
                                            "server",
                                            "plugins",
                                            "contexts",
                                            file,
                                        ),
                                    ),
                                )
                                .on("end", () => {
                                    filterJson(
                                        path.join(
                                            pluginsDir,
                                            file,
                                            "package.json",
                                        ),
                                        path.join(
                                            homeDir,
                                            "bin",
                                            "server",
                                            "plugins",
                                            "contexts",
                                            file,
                                            "package.json",
                                        ),
                                    );
                                    if (
                                        fs.existsSync(
                                            path.join(
                                                pluginsDir,
                                                file,
                                                "assets",
                                            ),
                                        )
                                    ) {
                                        cpy(
                                            ["**/*.*","**/*"],
                                            path.join(
                                                homeDir,
                                                "bin",
                                                "server",
                                                "plugins",
                                                "contexts",
                                                file,
                                                "assets",
                                            ),
                                            {
                                                cwd: path.join(
                                                    pluginsDir,
                                                    file,
                                                    "assets",
                                                ),
                                                parents: true,
                                                dot: true,
                                            },
                                        ).then(resolve, reject);
                                        return;
                                    }
                                    resolve();
                                })
                                .on("error", (err) => reject(err));
                        }),
                );
            }
        });
    return rows.length
        ? rows.splice(1).reduce((res, val) => res.then(() => val()), rows[0]())
        : Promise.resolve();
});
gulp.task("events", () => {
    const rows = [];
    const pluginsDir = path.join(homeDir, "events");
    fs.readdirSync(pluginsDir)
        .filter((file) =>
            eventPlugins && eventPlugins.length
                ? eventPlugins.includes(file.toUpperCase())
                : true,
        )
        .forEach((file) => {
            if (
                fs.existsSync(path.join(pluginsDir, file, "tsconfig.json")) &&
                fs.existsSync(path.join(pluginsDir, file, "package.json"))
            ) {
                const tsProject = ts.createProject(
                    path.join(pluginsDir, file, "tsconfig.json"),
                    {
                        removeComments: !isDev,
                        sourceMap: !isDev,
                    },
                );
                rows.push(
                    () =>
                        new Promise((resolve, reject) => {
                            gulp.src(
                                path.join(
                                    pluginsDir,
                                    file,
                                    "src",
                                    "**",
                                    "*.ts",
                                ),
                            )
                                .pipe(tsProject())
                                .pipe(
                                    gulp.dest(
                                        path.join(
                                            homeDir,
                                            "bin",
                                            "server",
                                            "plugins",
                                            "events",
                                            file,
                                        ),
                                    ),
                                )
                                .on("end", () => {
                                    filterJson(
                                        path.join(
                                            pluginsDir,
                                            file,
                                            "package.json",
                                        ),
                                        path.join(
                                            homeDir,
                                            "bin",
                                            "server",
                                            "plugins",
                                            "events",
                                            file,
                                            "package.json",
                                        ),
                                    );
                                    if (
                                        fs.existsSync(
                                            path.join(
                                                pluginsDir,
                                                file,
                                                "assets",
                                            ),
                                        )
                                    ) {
                                        cpy(
                                            ["**/*.*","**/*"],
                                            path.join(
                                                homeDir,
                                                "bin",
                                                "server",
                                                "plugins",
                                                "events",
                                                file,
                                                "assets",
                                            ),
                                            {
                                                cwd: path.join(
                                                    pluginsDir,
                                                    file,
                                                    "assets",
                                                ),
                                                parents: true,
                                                dot: true,
                                            },
                                        ).then(resolve, reject);
                                        return;
                                    }
                                    resolve();
                                })
                                .on("error", (err) => reject(err));
                        }),
                );
            }
        });
    return rows.length
        ? rows.splice(1).reduce((res, val) => res.then(() => val()), rows[0]())
        : Promise.resolve();
});
gulp.task("schedulers", () => {
    const rows = [];
    const pluginsDir = path.join(homeDir, "schedulers");
    fs.readdirSync(pluginsDir)
        .filter((file) =>
            schedulerPlugins && schedulerPlugins.length
                ? schedulerPlugins.includes(file.toUpperCase())
                : true,
        )
        .forEach((file) => {
            if (
                fs.existsSync(path.join(pluginsDir, file, "tsconfig.json")) &&
                fs.existsSync(path.join(pluginsDir, file, "package.json"))
            ) {
                const tsProject = ts.createProject(
                    path.join(pluginsDir, file, "tsconfig.json"),
                    {
                        removeComments: !isDev,
                        sourceMap: !isDev,
                    },
                );
                rows.push(
                    () =>
                        new Promise((resolve, reject) => {
                            gulp.src(
                                path.join(
                                    pluginsDir,
                                    file,
                                    "src",
                                    "**",
                                    "*.ts",
                                ),
                            )
                                .pipe(tsProject())
                                .pipe(
                                    gulp.dest(
                                        path.join(
                                            homeDir,
                                            "bin",
                                            "server",
                                            "plugins",
                                            "schedulers",
                                            file,
                                        ),
                                    ),
                                )
                                .on("end", () => {
                                    filterJson(
                                        path.join(
                                            pluginsDir,
                                            file,
                                            "package.json",
                                        ),
                                        path.join(
                                            homeDir,
                                            "bin",
                                            "server",
                                            "plugins",
                                            "schedulers",
                                            file,
                                            "package.json",
                                        ),
                                    );
                                    if (
                                        fs.existsSync(
                                            path.join(
                                                pluginsDir,
                                                file,
                                                "assets",
                                            ),
                                        )
                                    ) {
                                        cpy(
                                            ["**/*.*","**/*"],
                                            path.join(
                                                homeDir,
                                                "bin",
                                                "server",
                                                "plugins",
                                                "schedulers",
                                                file,
                                                "assets",
                                            ),
                                            {
                                                cwd: path.join(
                                                    pluginsDir,
                                                    file,
                                                    "assets",
                                                ),
                                                parents: true,
                                                dot: true,
                                            },
                                        ).then(resolve, reject);
                                        return;
                                    }
                                    resolve();
                                })
                                .on("error", (err) => reject(err));
                        }),
                );
            }
        });
    return rows.length
        ? rows.splice(1).reduce((res, val) => res.then(() => val()), rows[0]())
        : Promise.resolve();
});
gulp.task("providers", () => {
    const rows = [];
    const pluginsDir = path.join(homeDir, "providers");
    fs.readdirSync(pluginsDir)
        .filter((file) =>
            providerPlugins && providerPlugins.length
                ? providerPlugins.includes(file.toUpperCase())
                : true,
        )
        .forEach((file) => {
            if (
                fs.existsSync(path.join(pluginsDir, file, "tsconfig.json")) &&
                fs.existsSync(path.join(pluginsDir, file, "package.json"))
            ) {
                const tsProject = ts.createProject(
                    path.join(pluginsDir, file, "tsconfig.json"),
                    {
                        removeComments: !isDev,
                        sourceMap: !isDev,
                    },
                );
                rows.push(
                    () =>
                        new Promise((resolve, reject) => {
                            gulp.src(
                                path.join(
                                    pluginsDir,
                                    file,
                                    "src",
                                    "**",
                                    "*.ts",
                                ),
                            )
                                .pipe(tsProject())
                                .pipe(
                                    gulp.dest(
                                        path.join(
                                            homeDir,
                                            "bin",
                                            "server",
                                            "plugins",
                                            "providers",
                                            file,
                                        ),
                                    ),
                                )
                                .on("end", () => {
                                    filterJson(
                                        path.join(
                                            pluginsDir,
                                            file,
                                            "package.json",
                                        ),
                                        path.join(
                                            homeDir,
                                            "bin",
                                            "server",
                                            "plugins",
                                            "providers",
                                            file,
                                            "package.json",
                                        ),
                                    );
                                    if (
                                        fs.existsSync(
                                            path.join(
                                                pluginsDir,
                                                file,
                                                "assets",
                                            ),
                                        )
                                    ) {
                                        cpy(
                                            ["**/*.*","**/*"],
                                            path.join(
                                                homeDir,
                                                "bin",
                                                "server",
                                                "plugins",
                                                "providers",
                                                file,
                                                "assets",
                                            ),
                                            {
                                                cwd: path.join(
                                                    pluginsDir,
                                                    file,
                                                    "assets",
                                                ),
                                                parents: true,
                                                dot: true,
                                            },
                                        ).then(resolve, reject);
                                        return;
                                    }
                                    resolve();
                                })
                                .on("error", (err) => reject(err));
                        }),
                );
            }
        });
    return rows.length
        ? rows.splice(1).reduce((res, val) => res.then(() => val()), rows[0]())
        : Promise.resolve();
});
gulp.task("server", () => {
    const rows = [];
    const serverDir = path.join(homeDir, "server");
    if (
        fs.existsSync(path.join(serverDir, "tsconfig.json")) &&
        fs.existsSync(path.join(serverDir, "package.json"))
    ) {
        const tsProject = ts.createProject(
            path.join(serverDir, "tsconfig.json"),
            {
                removeComments: !isDev,
                sourceMap: !isDev,
            },
        );
        rows.push(
            () =>
                new Promise((resolve, reject) => {
                    gulp.src(path.join(serverDir, "src", "**", "*.ts"))
                        .pipe(tsProject())
                        .pipe(gulp.dest(path.join(homeDir, "bin", "server")))
                        .on("end", () => {
                            if (fs.existsSync(path.join(serverDir, "assets"))) {
                                cpy(
                                    ["**/*.*","**/*"],
                                    path.join(
                                        homeDir,
                                        "bin",
                                        "server",
                                        "assets",
                                    ),
                                    {
                                        cwd: path.join(serverDir, "assets"),
                                        parents: true,
                                        dot: true,
                                    },
                                ).then(resolve, reject);
                                return;
                            }
                            resolve();
                        })
                        .on("error", (err) => reject(err));
                }),
        );
    }
    return rows.length
        ? rows.splice(1).reduce((res, val) => res.then(() => val()), rows[0]())
        : Promise.resolve();
});
gulp.task("plugininf", () => {
    const rows = [];
    const plugininfDir = path.join(homeDir, "plugininf");
    if (
        fs.existsSync(path.join(plugininfDir, "tsconfig.json")) &&
        fs.existsSync(path.join(plugininfDir, "package.json"))
    ) {
        const tsProject = ts.createProject(
            path.join(plugininfDir, "tsconfig.json"),
            {
                removeComments: !isDev,
                sourceMap: !isDev,
            },
        );
        rows.push(
            () =>
                new Promise((resolve, reject) => {
                    gulp.src(path.join(plugininfDir, "lib", "**", "*.ts"))
                        .pipe(tsProject())
                        .pipe(
                            gulp.dest(
                                path.join(
                                    homeDir,
                                    "bin",
                                    "libs",
                                    "plugininf",
                                    "lib",
                                ),
                            ),
                        )
                        .on("end", () => {
                            const pluginInfJson = JSON.parse(
                                fs.readFileSync(
                                    path.join(plugininfDir, "package.json"),
                                ),
                            );
                            delete pluginInfJson.devDependencies;
                            fs.writeFileSync(
                                path.join(
                                    homeDir,
                                    "bin",
                                    "libs",
                                    "plugininf",
                                    "package.json",
                                ),
                                JSON.stringify(pluginInfJson, null, 4),
                            );
                            resolve();
                        })
                        .on("error", (err) => reject(err));
                }),
        );
    }
    return rows.length
        ? rows.splice(1).reduce((res, val) => res.then(() => val()), rows[0]())
        : Promise.resolve();
});
gulp.task("libs", () => {
    const rows = [];
    const libsDir = path.join(homeDir, "libs");
    fs.readdirSync(libsDir).forEach((file) => {
        if (fs.existsSync(path.join(libsDir, file, "package.json"))) {
            rows.push(
                () =>
                    new Promise((resolve, reject) => {
                        if (
                            !fs.existsSync(
                                path.join(homeDir, "bin", "libs", file),
                            )
                        ) {
                            fs.mkdirSync(
                                path.join(homeDir, "bin", "libs", file),
                                {
                                    recursive: true,
                                },
                            );
                        }
                        cpy(["**/*.*","**/*"], path.join(homeDir, "bin", "libs", file), {
                            cwd: path.join(libsDir, file),
                            parents: true,
                            dot: true,
                        }).then(resolve, reject);
                    }),
            );
        }
    });
    return rows.length
        ? rows.splice(1).reduce((res, val) => res.then(() => val()), rows[0]())
        : Promise.resolve();
});

gulp.task("winsvc", async () => {
    return cpy(["**/*.*","**/*"], path.join(homeDir, "bin", "server"), {
        cwd: path.join(homeDir, "winsvc"),
        parents: true,
        dot: true,
    });
});

gulp.task("cert", async () => {
    return cpy(["**/*.*","**/*"], path.join(homeDir, "bin", "server", "cert"), {
        cwd: path.join(homeDir, "cert"),
        parents: true,
        dot: true,
    });
});

gulp.task("packageJson", async () => {
    fs.writeFileSync(
        path.join(homeDir, "bin", "package.json"),
        JSON.stringify(packageJson, null, 4),
    );
    fs.writeFileSync(
        path.join(homeDir, "bin", "server", "package.json"),
        JSON.stringify(serverJson, null, 4),
    );
    fs.writeFileSync(
        path.join(homeDir, "bin", "yarn.lock"),
        fs.readFileSync(path.join(homeDir, "yarn.lock")),
    );
});

gulp.task("tslint:fix:all", async () => {
    const files = (
        await new Promise((resolve, reject) => {
            glob("**/tsconfig.json", (err, files) => {
                if (err) {
                    return reject(err);
                }
                return resolve(files);
            });
        })
    ).filter(
        (file) =>
            file.indexOf("bin") === -1 && file.indexOf("node_modules") === -1,
    );
    return files.slice(1).reduce(
        (promise, file) => {
            return promise.then(() =>
                cmdExec(`yarn tslint --project "${file}" --fix`).then(
                    ({ stdout, stderr }) => {
                        console.log(stdout);
                        if (stderr) {
                            console.error(stderr);
                        }
                        return;
                    },
                ),
            );
        },
        cmdExec(`yarn tslint --project "${files[0]}" --fix`).then(
            ({ stdout, stderr }) => {
                console.log(stdout);
                if (stderr) {
                    console.error(stderr);
                }
                return;
            },
        ),
    );
});

gulp.task(
    "all",
    gulp.series(
        gulp.series(
            "server",
            "providers",
            "schedulers",
            "contexts",
            "plugins",
            "events",
            "libs",
            "plugininf",
            "cert",
            "winsvc",
        ),
        "packageJson",
    ),
);
