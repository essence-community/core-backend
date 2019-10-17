import { isEmpty } from "@ungate/plugininf/lib/util/Util";

const ENGLISH_ALPHABET_LENGTH = 26;
const NUM_AND_ENGLISH_ALPHABET_LENGTH = 36;
/**
 * Реальный номер колоноки Excel
 * @param columnNumber
 */
export const getColumnNumber = (columnName: string) => {
    let i = columnName.search(/\d/);
    let colNum = 0;
    columnName.replace(/\D/g, (letter: string) => {
        // Считаем реальный номер колонки Пример у колонки A номер 1 B номер 2
        colNum +=
            (parseInt(letter, NUM_AND_ENGLISH_ALPHABET_LENGTH) - 9) *
            Math.pow(ENGLISH_ALPHABET_LENGTH, --i);
        return "";
    });

    return colNum;
};
/**
 * Наименование колонок по принципу Excel
 * @param columnNumber
 */
export const getColumnName = (columnNumber: string | number) => {
    if (isEmpty(columnNumber)) {
        return "";
    }

    let columnName = "";
    let dividend =
        typeof columnNumber === "string"
            ? parseInt(columnNumber as string, 10)
            : (columnNumber as number);
    let modulo = 0;
    while (dividend > 0) {
        modulo = (dividend - 1) % ENGLISH_ALPHABET_LENGTH;
        columnName = String.fromCharCode(65 + modulo).toString() + columnName;
        dividend = Math.floor((dividend - modulo) / ENGLISH_ALPHABET_LENGTH);
    }
    return columnName;
};
