declare module "jsrsasign" {
    export class X509 {
        readCertPEM(text: string): void;
        getSerialNumberHex(): string;
    }
}
