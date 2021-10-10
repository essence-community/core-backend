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
(rl as any)._writeToOutput = function _writeToOutput(stringToWrite) {
    if (!(rl as any).stdoutMuted || (rl as any).questionStr == stringToWrite) {
        (rl as any).output.write(stringToWrite);
    } else {
        (rl as any).output.write("*");
    }   
  };
export const questionReadline = (
    question: string,
    defaultValue?: string,
    hidden = false,
): Promise<string | undefined> => {
    // eslint-disable-next-line compat/compat
    return new Promise((resolve) => {
        (rl as any).stdoutMuted = hidden;
        (rl as any).questionStr = question;
        readline.cursorTo(process.stdout, 0, 0);
        rl.question(question, (answer?: string) => {
            (rl as any).stdoutMuted = false;
            (rl as any).questionStr = null;
            if (hidden) {
                (rl as any).history = (rl as any).history.slice(1);
            }
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
