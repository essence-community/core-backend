import * as fs from "fs";
import * as crypto from "crypto";
import { isEmpty, questionReadline } from "../util";
import * as cu from "./cryptoUtil";

export class Constants {
    /** PW для шифрования пароля */
    public PW_KEY_SECRET: string;
    /** SALT для шифрования пароля */
    public PW_SALT_SECRET: string =
        process.env.ESSENCE_PW_SALT ||
        "bf359e3e7beb05473be3b0acb8e36adb597b9e34";

    public DEFAULT_ALG = process.env.ESSENCE_PW_DEFAULT_ALG || "aes-256-cbc";

    /** PW Key RSA для шифрования пароля */
    public PW_RSA_SECRET: string;
    public PW_RSA_SECRET_PASSPHRASE: string;

    public isUseEncrypt = false;

    constructor() {
        let isUseEncrypt = false;
        if (process.env.ESSENCE_PW_KEY_SECRET) {
            if (fs.existsSync(process.env.ESSENCE_PW_KEY_SECRET)) {
                this.PW_KEY_SECRET = fs
                    .readFileSync(process.env.ESSENCE_PW_KEY_SECRET)
                    .toString();
            } else {
                this.PW_KEY_SECRET = process.env.ESSENCE_PW_KEY_SECRET;
            }
            if (process.env.ESSENCE_PW_SALT) {
                if (fs.existsSync(process.env.ESSENCE_PW_SALT)) {
                    this.PW_SALT_SECRET = fs
                        .readFileSync(process.env.ESSENCE_PW_SALT)
                        .toString();
                } else {
                    this.PW_SALT_SECRET = process.env.ESSENCE_PW_SALT;
                }
            }
            isUseEncrypt = true;
        }
        if (process.env.ESSENCE_PW_RSA) {
            if (fs.existsSync(process.env.ESSENCE_PW_RSA)) {
                this.PW_RSA_SECRET = fs
                    .readFileSync(process.env.ESSENCE_PW_RSA)
                    .toString();
            } else {
                this.PW_RSA_SECRET = process.env.ESSENCE_PW_RSA;
            }
            if (process.env.ESSENCE_PW_RSA_PASSPHRASE) {
                if (fs.existsSync(process.env.ESSENCE_PW_RSA_PASSPHRASE)) {
                    this.PW_RSA_SECRET_PASSPHRASE = fs
                        .readFileSync(process.env.ESSENCE_PW_RSA_PASSPHRASE)
                        .toString();
                } else {
                    this.PW_RSA_SECRET_PASSPHRASE =
                        process.env.ESSENCE_PW_RSA_PASSPHRASE;
                }
            }
            isUseEncrypt = true;
        }
        if (!process.env.ESSENCE_PW_DEFAULT_ALG) {
            if (this.PW_RSA_SECRET) {
                this.DEFAULT_ALG = "privatekey";
            } else {
                this.DEFAULT_ALG = "aes-256-gcm";
            }
        }
        this.isUseEncrypt = isUseEncrypt;
    }
}
export const Constant = new Constants();
function decryptAes(
    type: crypto.CipherCCMTypes | crypto.CipherGCMTypes,
    data: string,
): string {
    const key = cu.getKeyFromPassword(
        type,
        Constant.PW_KEY_SECRET,
        Constant.PW_SALT_SECRET,
    );
    return cu.decrypt(type, data, key);
}

function decryptUseKey(data: string): string {
    return crypto
        .privateDecrypt(
            {
                key: Constant.PW_RSA_SECRET,
                passphrase: Constant.PW_RSA_SECRET_PASSPHRASE,
            },
            Buffer.from(data, "hex"),
        )
        .toString();
}

export function encryptAes(
    type: crypto.CipherCCMTypes | crypto.CipherGCMTypes,
    data: string,
): string {
    if (!Constant.PW_KEY_SECRET) {
        throw new Error(
            "Not found key, need init environment ESSENCE_PW_KEY_SECRET",
        );
    }
    const key = cu.getKeyFromPassword(
        type,
        Constant.PW_KEY_SECRET,
        Constant.PW_SALT_SECRET,
    );

    return cu.encrypt(type, data, key);
}

export function encryptUseKey(data: string): string {
    if (!Constant.PW_RSA_SECRET) {
        throw new Error(
            "Not found private key, need init environment ESSENCE_PW_RSA",
        );
    }
    return crypto
        .publicEncrypt(
            {
                key: Constant.PW_RSA_SECRET,
                passphrase: Constant.PW_RSA_SECRET_PASSPHRASE,
            },
            Buffer.from(data),
        )
        .toString("hex");
}

export function encryptPassword(
    data: string,
    type: string = Constant.DEFAULT_ALG,
): string {
    if (!Constant.isUseEncrypt) {
        throw new Error("Not init environment");
    }
    switch (type) {
        case "privatekey":
            return `{privatekey}${encryptUseKey(data)}`;
        case "aes-128-gcm":
        case "aes-192-gcm":
        case "aes-256-gcm":
        case "aes-128-ccm":
        case "aes-192-ccm":
        case "aes-256-ccm":
            return `{${type}}${encryptAes(type as any, data)}`;
        default:
            throw new Error(`Not found type ${type}`);
    }
}

export function decryptPassword(value: string) {
    if (
        typeof value !== "string" ||
        isEmpty(value) ||
        value.indexOf("{") !== 0
    ) {
        throw new Error("Not encrypt password");
    }
    if (!Constant.isUseEncrypt) {
        throw new Error("Not init environment");
    }
    const endIndex = value.indexOf("}");
    const type = value.substring(1, endIndex);
    const hash = value.substring(endIndex + 1);
    switch (type) {
        case "aes-128-gcm":
        case "aes-192-gcm":
        case "aes-256-gcm":
        case "aes-128-ccm":
        case "aes-192-ccm":
        case "aes-256-ccm":
            return decryptAes(type as any, hash);
        case "privatekey":
            return decryptUseKey(hash);
        default:
            throw new Error(`Not found type ${type}`);
    }
}

export async function decryptPWCli() {
    const encPw = (await questionReadline("Encrypt password: ", null, true)).trim();
    if (!isEmpty(encPw)) {
        const descPW = decryptPassword(encPw);
        /* tslint:disable:no-console */
        // eslint-disable-next-line no-console
        console.log("\nDecrypt password: %s", descPW);
    }
}
export async function encryptPWCli() {
    const type = await questionReadline(
        "- privatekey\n" +
            "- aes-128-gcm\n" +
            "- aes-192-gcm\n" +
            "- aes-256-gcm\n" +
            "- aes-128-ccm\n" +
            "- aes-192-ccm\n" +
            "- aes-256-ccm\n" +
            `Type encrypt(${Constant.DEFAULT_ALG}): `,
        Constant.DEFAULT_ALG,
    );
    const pw = (await questionReadline("Password: ", null, true)).trim();
    if (!isEmpty(pw)) {
        const descPW = encryptPassword(pw, type || undefined);
        /* tslint:disable:no-console */
        // eslint-disable-next-line no-console
        console.log("\nEncrypt password: %s", descPW);
    }
}
