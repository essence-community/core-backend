import js from "@eslint/js";
import { defineConfig, globalIgnores } from "eslint/config";
import prettier from "eslint-config-prettier";
import globals from "globals";

const gateGlobals = {
    pathgate: "readonly",
    pathgatedb: "readonly",
    pathgatecore: "readonly",
    pathgateplugins: "readonly",
    flagscmd: "readonly",
    pathgateactions: "readonly",
    pathgateproviders: "readonly",
    pathgateconfplugins: "readonly",
    pathgateschedulers: "readonly",
};

export default defineConfig(
    globalIgnores([
        "**/node_modules/**",
        ".yarn/**",
        "bin/**",
        "**/bin/**",
        "coverage/**",
        "dbms/**",
        "dbms_*/**",
        "template/**",
        "libs/**",
        "cert/**",
        "openapi/**",
        "plugins/Patcher/assets/**",
        "utils/gate-cli/lib/**",
        "utils/gate-cli/publish/**",
        "**/*.ts",
    ]),
    {
        files: ["**/*.{js,mjs,cjs}"],
        extends: [js.configs.recommended, prettier],
        languageOptions: {
            ecmaVersion: 2022,
            sourceType: "commonjs",
            globals: {
                ...globals.node,
                ...gateGlobals,
            },
        },
        rules: {
            "max-len": [
                "error",
                {
                    code: 200,
                    ignoreComments: true,
                    ignoreTrailingComments: true,
                    ignoreUrls: true,
                    ignoreRegExpLiterals: true,
                },
            ],
            "no-unused-vars": [
                "error",
                { argsIgnorePattern: "^_", varsIgnorePattern: "^_" },
            ],
        },
    },
    {
        files: ["**/*.mjs"],
        languageOptions: {
            sourceType: "module",
        },
    },
);
