import { questionReadline } from "./util";
import { cliOracle } from "./package/oracle";
import { cliPostgreSql } from "./package/postgres";

(async function cli() {
    switch (
        await questionReadline(
            "1 - DBMS PostgreSQL package\n2 - DBMS Oracle package\n(1):",
            "1",
        )
    ) {
        case "1":
            return cliPostgreSql();
        case "2":
            return cliOracle();
        default:
            break;
    }
})().then(
    () => {
        process.exit(0);
    },
    (err) => {
        // eslint-disable-next-line no-console
        console.error(err);
        process.exit(1);
    },
);
