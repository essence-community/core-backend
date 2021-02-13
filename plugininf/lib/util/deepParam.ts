import { isEmpty } from "./Util";

export function deepParam(
    path: string | string[],
    params: Record<string, any>,
) {
    if (isEmpty(params) || isEmpty(path)) {
        return null;
    }
    const paths: any[] = Array.isArray(path) ? path : path.split(".");
    let current: any = params;

    for (const [idx, val] of paths.entries()) {
        if (
            typeof current === "string" &&
            (current.trim().charAt(0) === "[" ||
                current.trim().charAt(0) === "{")
        ) {
            current = JSON.parse(current);
        }
        if (!Array.isArray(current) && typeof current !== "object") {
            return null;
        }
        if (
            val === "*" &&
            (current[val] === undefined || current[val] === null)
        ) {
            return Array.isArray(current)
                ? current.map((obj) => deepParam(paths.slice(idx + 1), obj))
                : Object.entries(current).map(([key, obj]) =>
                      deepParam(paths.slice(idx + 1), obj),
                  );
        }

        if (current[val] === undefined || current[val] === null) {
            return current[val];
        }

        current = current[val];
    }

    return current;
}

export const deepChange = (
    obj: Record<string, any>,
    path: string,
    value: any,
): boolean => {
    if (isEmpty(path) || isEmpty(obj)) {
        return false;
    }
    const paths: any[] = path.split(".");
    const last = paths.pop();
    let current: any = obj;

    if (
        !Array.isArray(current[paths[0]]) &&
        typeof current[paths[0]] !== "object"
    ) {
        current[paths[0]] = /[0-9]+/.test(paths[0]) ? [] : {};
    }
    for (const val of paths) {
        current = current[val];
        if (!Array.isArray(current) && typeof current !== "object") {
            current[val] = /[0-9]+/.test(val) ? [] : {};
            current = current[val];
        }
    }
    current[last] = value;

    return true;
};
