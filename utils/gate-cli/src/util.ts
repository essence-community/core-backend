import * as readline from "readline";
import * as fs from "fs";
import * as path from "path";

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
});

export function isEmpty(value: any, allowEmptyString = false) {
    return (
        value == null ||
        (allowEmptyString ? false : value === "") ||
        (Array.isArray(value) && value.length === 0)
    );
}

export function isTrue(val?: string) {
    switch (val ? val.trim().toLowerCase() : val) {
        case "yes":
        case "y":
        case "on":
        case "1":
            return true;
        default:
            return false;
    }
}

export function getDir(dir: string) {
    if (dir.startsWith(".")) {
        return path.resolve(process.cwd(), dir);
    }

    return path.resolve(dir);
}
export const deleteFolderRecursive = (pathDir: string) => {
    if (fs.existsSync(pathDir)) {
        if (fs.lstatSync(pathDir).isDirectory()) {
            fs.readdirSync(pathDir).forEach((file) => {
                const curPath = path.join(pathDir, file);

                if (fs.lstatSync(curPath).isDirectory()) {
                    // recursive
                    deleteFolderRecursive(curPath);
                } else {
                    // delete file
                    fs.unlinkSync(curPath);
                }
            });
            fs.rmdirSync(pathDir);

            return;
        }
        fs.unlinkSync(pathDir);
    }
};
export const questionReadline = (
    question: string,
    defaultValue?: string,
): Promise<string | undefined> => {
    // eslint-disable-next-line compat/compat
    return new Promise((resolve) => {
        rl.question(question, (answer?: string) => {
            if (
                isEmpty(answer ? answer.trim() : answer) &&
                !isEmpty(defaultValue)
            ) {
                return resolve(defaultValue);
            }

            return resolve(answer);
        });
    });
};
