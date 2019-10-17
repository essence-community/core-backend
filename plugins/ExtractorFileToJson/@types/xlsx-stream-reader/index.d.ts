declare module "xlsx-stream-reader" {
    interface IOptionXlsxStreamReader {
        // throw additional exceptions, if false - then pass empty string in that places
        verbose?: boolean;
        // should cells with combined formats be formatted or not
        formatting?: boolean;
        // whether or not to trim text and comment nodes
        saxTrim?: boolean;
    }
    interface IValues {
        forEach: (value: any, colId: number) => void;
    }
    interface IRow {
        attributes: {
            r: number;
        };
        values: any[];
        formulas: any[];
    }
    interface IWorksheet {
        skip(): void;
        abort(): void;
        name: string;
        id: number;
        rowCount: number;
        process(): void;
        getColumnName(index: number): string;
        getColumnNumber(name: string): number;
        on(event: "error" | "end", listener: (...args: any[]) => void): void;
        on(event: "row", listener: (row: IRow) => void): void;
    }
    class XlsxStreamReader {
        constructor(config?: IOptionXlsxStreamReader);
        on(
            event: "error" | "end" | "sharedStrings" | "styles",
            listener: (...args: any[]) => void,
        ): void;
        on(event: "worksheet", listener: (worksheet: IWorksheet) => void): void;
    }
    export = XlsxStreamReader;
}
