import { questionReadline } from "./util";
import { cliOracle } from "./package/oracle";
import { cliPostgreSql } from "./package/postgres";
import * as dotenv from "dotenv";
import { decryptPWCli, encryptPWCli } from "./package/PWOperation";

dotenv.config();

(async function cli() {
    switch (
        await questionReadline(
            "1 - DBMS PostgreSQL package\n2 - DBMS Oracle package\n3 - Encrypt password\n4 - Decrypt password\n(1):",
            "1",
        )
    ) {
        case "1":
            return cliPostgreSql();
        case "2":
            return cliOracle();
        case "3":
            return encryptPWCli();
        case "4":
            return decryptPWCli();
        default:
            break;
    }
})().then(
    () => {
        process.exit(0);
    },
    (err) => {
        /* tslint:disable:no-console */
        // eslint-disable-next-line no-console
        console.error(err?.isNotStackTrace ? err.message : err);
        process.exit(1);
    },
);
