/**
 * Удаляем атрибуты которые null
 * @param key
 * @param value
 * @returns {*}
 * @private
 */
export function replaceNull(key: string, value: any) {
    if (value === null) {
        return undefined;
    }
    return value;
}

export const FIND_SYMBOL = new RegExp("[/#=&?]+", "g");