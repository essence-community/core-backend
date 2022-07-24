import Connection from "@ungate/plugininf/lib/db/Connection";
import * as fs from "fs";
import * as path from "path";
import { IJson } from "../Patcher.types";
import { DFormat } from './DFormat';
import { sqlDFormat, sqlAsset, sqlAData, sqlReport, sqlDSource, sqlSource, sqlReportFormat, sqlReportAsset, sqlReportQuery } from './SqlPostgres';
import { Asset } from './Asset';
import { AData } from './AData';
import { Report } from './Report';
import {
    closeFsWriteStream,
    createChangeXml,
    createWriteStream,
} from "../Utils";
import { DSource } from "./DSource";
import { Source } from "./Source";
import { ReportFormat } from "./ReportFormat";
import { ReportAsset } from "./ReportAsset";
import { ReportQuery } from "./ReportQuery";

export async function patchReport(dir: string, json: IJson, conn: Connection) {
    const include: string[] = [];
    const meta = path.join(dir, "report");
    if (!fs.existsSync(meta)) {
        fs.mkdirSync(meta);
    }
    if (json.data.cct_report && json.data.cct_report.length) {
        const cctReport = JSON.stringify(json.data.cct_report);
        // AData
        const adata = createWriteStream(meta, "AData");
        include.push("AData");
        await conn
            .executeStmt(
                sqlAData,
                {
                    cct_report: cctReport,
                },
                {},
                {
                    autoCommit: true,
                    resultSet: true,
                },
            )
            .then(
                (res) =>
                    new Promise<void>((resolve, reject) => {
                        res.stream.on("data", (row) => {
                            adata.write(new AData(row).toRow());
                        });
                        res.stream.on("error", (err) => reject(err));
                        res.stream.on("end", () => resolve());
                    }),
            );
        await closeFsWriteStream(adata);
        // D_Format
        const format = createWriteStream(meta, "DFormat");
        include.push("DFormat");
        await conn
            .executeStmt(
                sqlDFormat,
                {
                    cct_report: cctReport,
                },
                {},
                {
                    autoCommit: true,
                    resultSet: true,
                },
            )
            .then(
                (res) =>
                    new Promise<void>((resolve, reject) => {
                        res.stream.on("data", (row) => {
                            format.write(new DFormat(row).toRow());
                        });
                        res.stream.on("error", (err) => reject(err));
                        res.stream.on("end", () => resolve());
                    }),
            );
        await closeFsWriteStream(format);
        // D_Source
        const dSource = createWriteStream(meta, "DSource");
        include.push("DSource");
        await conn
            .executeStmt(
                sqlDSource,
                {
                    cct_report: cctReport,
                },
                {},
                {
                    autoCommit: true,
                    resultSet: true,
                },
            )
            .then(
                (res) =>
                    new Promise<void>((resolve, reject) => {
                        res.stream.on("data", (row) => {
                            dSource.write(new DSource(row).toRow());
                        });
                        res.stream.on("error", (err) => reject(err));
                        res.stream.on("end", () => resolve());
                    }),
            );
        await closeFsWriteStream(dSource);
        // D_Source
        const source = createWriteStream(meta, "Source");
        include.push("Source");
        await conn
            .executeStmt(
                sqlSource,
                {
                    cct_report: cctReport,
                },
                {},
                {
                    autoCommit: true,
                    resultSet: true,
                },
            )
            .then(
                (res) =>
                    new Promise<void>((resolve, reject) => {
                        res.stream.on("data", (row) => {
                            source.write(new Source(row).toRow());
                        });
                        res.stream.on("error", (err) => reject(err));
                        res.stream.on("end", () => resolve());
                    }),
            );
        await closeFsWriteStream(source);
        // Asset
        const asset = createWriteStream(meta, "Asset");
        include.push("Asset");
        await conn
            .executeStmt(
                sqlAsset,
                {
                    cct_report: cctReport,
                },
                {},
                {
                    autoCommit: true,
                    resultSet: true,
                },
            )
            .then(
                (res) =>
                    new Promise<void>((resolve, reject) => {
                        res.stream.on("data", (row) => {
                            asset.write(new Asset(row).toRow());
                        });
                        res.stream.on("error", (err) => reject(err));
                        res.stream.on("end", () => resolve());
                    }),
            );
        await closeFsWriteStream(asset);

         // Report
         const report = createWriteStream(meta, "Report");
         include.push("Report");
         await conn
             .executeStmt(
                 sqlReport,
                 {
                     cct_report: cctReport,
                 },
                 {},
                 {
                     autoCommit: true,
                     resultSet: true,
                 },
             )
             .then(
                 (res) =>
                     new Promise<void>((resolve, reject) => {
                         res.stream.on("data", (row) => {
                            report.write(new Report(row).toRow());
                         });
                         res.stream.on("error", (err) => reject(err));
                         res.stream.on("end", () => resolve());
                     }),
             );
         await closeFsWriteStream(report);
         // ReportFormat
         const reportFormat = createWriteStream(meta, "ReportFormat");
         include.push("ReportFormat");
         await conn
             .executeStmt(
                 sqlReportFormat,
                 {
                     cct_report: cctReport,
                 },
                 {},
                 {
                     autoCommit: true,
                     resultSet: true,
                 },
             )
             .then(
                 (res) =>
                     new Promise<void>((resolve, reject) => {
                         res.stream.on("data", (row) => {
                            reportFormat.write(new ReportFormat(row).toRow());
                         });
                         res.stream.on("error", (err) => reject(err));
                         res.stream.on("end", () => resolve());
                     }),
             );
         await closeFsWriteStream(reportFormat);
         // ReportAsset
         const reportAsset = createWriteStream(meta, "ReportAsset");
         include.push("ReportAsset");
         await conn
             .executeStmt(
                 sqlReportAsset,
                 {
                     cct_report: cctReport,
                 },
                 {},
                 {
                     autoCommit: true,
                     resultSet: true,
                 },
             )
             .then(
                 (res) =>
                     new Promise<void>((resolve, reject) => {
                         res.stream.on("data", (row) => {
                            reportAsset.write(new ReportAsset(row).toRow());
                         });
                         res.stream.on("error", (err) => reject(err));
                         res.stream.on("end", () => resolve());
                     }),
             );
         await closeFsWriteStream(reportAsset);
         // ReportQuery
         const reportQuery = createWriteStream(meta, "ReportQuery");
         include.push("ReportQuery");
         await conn
             .executeStmt(
                 sqlReportQuery,
                 {
                     cct_report: cctReport,
                 },
                 {},
                 {
                     autoCommit: true,
                     resultSet: true,
                 },
             )
             .then(
                 (res) =>
                     new Promise<void>((resolve, reject) => {
                         res.stream.on("data", (row) => {
                            reportQuery.write(new ReportQuery(row).toRow());
                         });
                         res.stream.on("error", (err) => reject(err));
                         res.stream.on("end", () => resolve());
                     }),
             );
         await closeFsWriteStream(reportQuery);
    }
    return createChangeXml(
        path.join(meta, "report.xml"),
        include.map(
            (str) =>
                `        <include file="${str}.sql" relativeToChangelogFile="true" />\n`,
        ),
    );
}
