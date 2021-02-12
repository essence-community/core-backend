import { isEmpty } from "@ungate/plugininf/lib/util/Util";

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
            (Array.isArray(current) || typeof current !== "object")
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
