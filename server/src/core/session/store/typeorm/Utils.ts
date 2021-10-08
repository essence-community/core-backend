import {
    Document,
    FilterQuery,
    QueryOperators,
} from "@ungate/plugininf/lib/db/local/ILocalDB";
import {
    Brackets,
    Equal,
    In,
    IsNull,
    MoreThan,
    Not,
    ObjectLiteral,
    MoreThanOrEqual,
    LessThan,
    LessThanOrEqual,
    ILike,
} from "typeorm";
import { LogicalOperators } from "@ungate/plugininf/lib/db/local/ILocalDB";

const QueryOperatorsStr = [
    "$in",
    "$nin",
    "$ne",
    "$gt",
    "$lt",
    "$gte",
    "$lte",
    "$exists",
    "$regex",
    "$size",
    "$elemMatch",
];
const LogicalOperatorsStr = ["$not", "$or", "$and"];
const AllOperastors = [...QueryOperatorsStr, LogicalOperatorsStr];
export function addFilter<T, F>(
    value: FilterQuery<Document<T>>,
    key: string,
    parentKey?: string,
): Brackets {
    if (LogicalOperatorsStr.includes(key)) {
        switch (key as keyof LogicalOperators<T>) {
            case "$and":
                return {
                    whereFactory: (qb) => {
                        value.forEach((val) => {
                            qb.andWhere(addFilter(val, parentKey));
                        });
                    },
                };
            case "$or":
                return {
                    whereFactory: (qb) => {
                        value.forEach((val) => {
                            qb.orWhere(addFilter(val, parentKey));
                        });
                    },
                };
            case "$not":
                return {
                    whereFactory: (qb) => {
                        qb.where({
                            [key]: Not(addFilter(value, parentKey)),
                        });
                    },
                };
        }
    } else if (QueryOperatorsStr.includes(key)) {
        switch (key as keyof QueryOperators<T>) {
            case "$exists":
                return {
                    whereFactory: (qb) => {
                        if (typeof value === "object") {
                            Object.entries(value).forEach(
                                ([keyVal, valObject]) => {
                                    if (AllOperastors.includes(keyVal)) {
                                        qb.andWhere(
                                            addFilter(valObject, keyVal, key),
                                        );
                                    } else {
                                        qb.andWhere(
                                            addFilter(valObject, key, keyVal),
                                        );
                                    }
                                },
                            );
                        } else {
                            qb.where({
                                [parentKey]: Not(IsNull()),
                            });
                        }
                    },
                };
            case "$in":
                return {
                    whereFactory: (qb) => {
                        qb.where(
                            Object.entries(
                                value.reduce((res, val) => {
                                    if (parentKey) {
                                        res[parentKey].push(val);
                                    } else {
                                        Object.entries(val).forEach(
                                            ([keyVal, valObject]) => {
                                                if (res[keyVal]) {
                                                    res[keyVal].push(valObject);
                                                } else {
                                                    res[keyVal] = [valObject];
                                                }
                                            },
                                        );
                                    }
                                    return res;
                                }, {} as Record<string, any[]>),
                            ).reduce(
                                (res, [keyVal, valObject]) => ({
                                    ...res,
                                    [keyVal]: In(valObject as any[]),
                                }),
                                {} as ObjectLiteral,
                            ),
                        );
                    },
                };
            case "$nin":
                return {
                    whereFactory: (qb) => {
                        qb.where(
                            Object.entries(
                                value.reduce((res, val) => {
                                    if (parentKey) {
                                        res[parentKey].push(val);
                                    } else {
                                        Object.entries(val).forEach(
                                            ([keyVal, valObject]) => {
                                                if (res[keyVal]) {
                                                    res[keyVal].push(valObject);
                                                } else {
                                                    res[keyVal] = [valObject];
                                                }
                                            },
                                        );
                                    }
                                    return res;
                                }, {} as Record<string, any[]>),
                            ).reduce(
                                (res, [keyVal, valObject]) => ({
                                    ...res,
                                    [keyVal]: Not(In(valObject as any[])),
                                }),
                                {} as ObjectLiteral,
                            ),
                        );
                    },
                };
            case "$ne":
                return {
                    whereFactory: (qb) => {
                        if (typeof value === "object") {
                            Object.entries(value).forEach(
                                ([keyVal, valObject]) => {
                                    if (AllOperastors.includes(keyVal)) {
                                        qb.andWhere(
                                            addFilter(valObject, keyVal, key),
                                        );
                                    } else {
                                        qb.andWhere(
                                            addFilter(valObject, key, keyVal),
                                        );
                                    }
                                },
                            );
                        } else {
                            qb.where({
                                [parentKey]: Not(Equal(value)),
                            });
                        }
                    },
                };
            case "$gt":
                return {
                    whereFactory: (qb) => {
                        if (typeof value === "object") {
                            Object.entries(value).forEach(
                                ([keyVal, valObject]) => {
                                    if (AllOperastors.includes(keyVal)) {
                                        qb.andWhere(
                                            addFilter(valObject, keyVal, key),
                                        );
                                    } else {
                                        qb.andWhere(
                                            addFilter(valObject, key, keyVal),
                                        );
                                    }
                                },
                            );
                        } else {
                            qb.where({
                                [parentKey]: MoreThan(value),
                            });
                        }
                    },
                };
            case "$gte":
                return {
                    whereFactory: (qb) => {
                        if (typeof value === "object") {
                            Object.entries(value).forEach(
                                ([keyVal, valObject]) => {
                                    if (AllOperastors.includes(keyVal)) {
                                        qb.andWhere(
                                            addFilter(valObject, keyVal, key),
                                        );
                                    } else {
                                        qb.andWhere(
                                            addFilter(valObject, key, keyVal),
                                        );
                                    }
                                },
                            );
                        } else {
                            qb.where({
                                [parentKey]: MoreThanOrEqual(value),
                            });
                        }
                    },
                };
            case "$lt":
                return {
                    whereFactory: (qb) => {
                        if (typeof value === "object") {
                            Object.entries(value).forEach(
                                ([keyVal, valObject]) => {
                                    if (AllOperastors.includes(keyVal)) {
                                        qb.andWhere(
                                            addFilter(valObject, keyVal, key),
                                        );
                                    } else {
                                        qb.andWhere(
                                            addFilter(valObject, key, keyVal),
                                        );
                                    }
                                },
                            );
                        } else {
                            qb.where({
                                [parentKey]: LessThan(value),
                            });
                        }
                    },
                };
            case "$lte":
                return {
                    whereFactory: (qb) => {
                        if (typeof value === "object") {
                            Object.entries(value).forEach(
                                ([keyVal, valObject]) => {
                                    if (AllOperastors.includes(keyVal)) {
                                        qb.andWhere(
                                            addFilter(valObject, keyVal, key),
                                        );
                                    } else {
                                        qb.andWhere(
                                            addFilter(valObject, key, keyVal),
                                        );
                                    }
                                },
                            );
                        } else {
                            qb.where({
                                [parentKey]: LessThanOrEqual(value),
                            });
                        }
                    },
                };
            case "$regex":
                return {
                    whereFactory: (qb) => {
                        if (typeof value === "object") {
                            Object.entries(value).forEach(
                                ([keyVal, valObject]) => {
                                    if (AllOperastors.includes(keyVal)) {
                                        qb.andWhere(
                                            addFilter(valObject, keyVal, key),
                                        );
                                    } else {
                                        qb.andWhere(
                                            addFilter(valObject, key, keyVal),
                                        );
                                    }
                                },
                            );
                        } else {
                            qb.where({
                                [parentKey]: ILike(value),
                            });
                        }
                    },
                };
        }
    } else {
        return {
            whereFactory: (qb) => {
                if (typeof value === "object") {
                    Object.entries(value).forEach(([keyVal, valObject]) => {
                        if (AllOperastors.includes(keyVal)) {
                            qb.andWhere(addFilter(valObject, keyVal, key));
                        } else {
                            qb.andWhere(addFilter(valObject, keyVal));
                        }
                    });
                } else {
                    qb.where({
                        [parentKey]: Equal(value),
                    });
                }
            },
        };
    }
}
