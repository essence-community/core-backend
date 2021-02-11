import { IOPAEval, IOPARenderParams } from "./OPARender.types";
import { spawn } from "child_process";
import * as path from "path";
import { IRufusLogger } from "rufus";
import * as crypto from "crypto";
import * as http from "http";
import { IFile } from "@ungate/plugininf/lib/IContext";

const createLocal = (params: IOPARenderParams, log: IRufusLogger) => {
    const opa = spawn(path.resolve(params.fvPath), [
        "run",
        "-s",
        `-a 127.0.0.1:${params.localPort || "8181"}`,
    ]);
    opa.stdout.on("data", (data) => {
        log.debug(data);
    });
    opa.stderr.on("data", (data) => {
        log.error(data);
    });
    opa.stdout.on("close", () => {
        createLocal(params, log);
    });
};
export class HTTPOPARender implements IOPAEval {
    params: IOPARenderParams;
    log: IRufusLogger;
    url: string;
    constructor(params: IOPARenderParams, log: IRufusLogger) {
        this.params = params;
        this.log = log;
        this.url = params.fvUrl;
        if (params.fkType === "local_http") {
            createLocal(params, log);
            this.url = `http://127.0.0.1:${params.localPort || "8181"}`;
        }
    }

    async eval(
        query: string[] | IFile[],
        dataFile: string[] | IFile[],
        input: Record<string, any> | Record<string, any>[],
        queryId: string = crypto
            .createHash("md5")
            .update(JSON.stringify(query))
            .digest("hex"),
    ) {
        const isExist = this.params.flCachePolitics
            ? await new Promise((resolve, reject) => {
                  http.get(`${this.url}/v1/policies/${queryId}`, (res) => {
                      const { statusCode } = res;
                      const contentType = res.headers["content-type"];

                      let error;
                      if (statusCode !== 200) {
                          error = new Error(
                              "Request Failed.\n" +
                                  `Status Code: ${statusCode}`,
                          );
                      } else if (!/^application\/json/.test(contentType)) {
                          error = new Error(
                              "Invalid content-type.\n" +
                                  `Expected application/json but received ${contentType}`,
                          );
                      }
                      if (error) {
                          this.log.error(error.message);
                          // Consume response data to free up memory
                          res.resume();
                          reject(error);
                          return;
                      }

                      res.setEncoding("utf8");
                      let rawData = "";
                      res.on("data", (chunk) => {
                          rawData += chunk;
                      });
                      res.on("end", () => {
                          try {
                              const parsedData = JSON.parse(rawData);
                              if (parsedData.code === "resource_not_found") {
                                  resolve(false);
                              } else {
                                  resolve(true);
                              }
                          } catch (e) {
                              reject(e);
                          }
                      });
                  });
              })
            : false;
        if (!isExist) {
            await new Promise((resolve, reject) => {
                const req = http.request(
                    `${this.url}/v1/policies/${queryId}`,
                    {
                        method: "PUT",
                        headers: {
                            "content-type": "text/plain",
                        },
                    },
                    (res) => {
                        const { statusCode } = res;

                        let error;
                        if (statusCode !== 200) {
                            error = new Error(
                                "Request Failed.\n" +
                                    `Status Code: ${statusCode}`,
                            );
                        }
                        if (error) {
                            this.log.error(error.message);
                            // Consume response data to free up memory
                            res.resume();
                            reject(error);
                            return;
                        }
                        res.resume();
                        return resolve(true);
                    },
                );
                req.end(query);
            });
        }
        return await new Promise((resolve, reject) => {
            const req = http.request(
                `${this.url}/v1/data/${queryId}`,
                {
                    method: "POST",
                    headers: {
                        "content-type": "application/json",
                    },
                },
                (res) => {
                    const { statusCode } = res;
                    const contentType = res.headers["content-type"];

                    let error;
                    if (statusCode !== 200) {
                        error = new Error(
                            "Request Failed.\n" + `Status Code: ${statusCode}`,
                        );
                    } else if (!/^application\/json/.test(contentType)) {
                        error = new Error(
                            "Invalid content-type.\n" +
                                `Expected application/json but received ${contentType}`,
                        );
                    }
                    if (error) {
                        this.log.error(error.message);
                        // Consume response data to free up memory
                        res.resume();
                        reject(error);
                        return;
                    }

                    res.setEncoding("utf8");
                    let rawData = "";
                    res.on("data", (chunk) => {
                        rawData += chunk;
                    });
                    res.on("end", () => {
                        try {
                            const parsedData = JSON.parse(rawData);
                            resolve(parsedData.result);
                        } catch (e) {
                            reject(e);
                        }
                    });
                },
            );
            req.end(JSON.stringify({ input }));
        });
    }
}
