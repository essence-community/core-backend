import { ListMeta, ObjectMeta, Time } from "../meta/v1";
import { ObjectReference } from "../core/v1";
import { JobSpec } from "./v1";
/**
 * CronJob represents the configuration of a single cron job.
 */
export interface CronJob {
    /**
     * APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
     */
    apiVersion?: "batch/v1beta1";
    /**
     * Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
     */
    kind?: "CronJob";
    /**
     * Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
     */
    metadata?: ObjectMeta;
    /**
     * Specification of the desired behavior of a cron job, including the schedule. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
     */
    spec?: CronJobSpec;
    /**
     * Current status of a cron job. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
     */
    status?: CronJobStatus;
}
/**
 * CronJobList is a collection of cron jobs.
 */
export interface CronJobList {
    /**
     * APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
     */
    apiVersion?: "batch/v1beta1";
    /**
     * items is the list of CronJobs.
     */
    items: Array<CronJob>;
    /**
     * Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
     */
    kind?: "CronJobList";
    /**
     * Standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
     */
    metadata?: ListMeta;
}
/**
 * CronJobSpec describes how the job execution will look like and when it will actually run.
 */
export interface CronJobSpec {
    /**
     * Specifies how to treat concurrent executions of a Job. Valid values are: - "Allow" (default): allows CronJobs to run concurrently; - "Forbid": forbids concurrent runs, skipping next run if previous run hasn't finished yet; - "Replace": cancels currently running job and replaces it with a new one
     */
    concurrencyPolicy?: string;
    /**
     * The number of failed finished jobs to retain. This is a pointer to distinguish between explicit zero and not specified. Defaults to 1.
     */
    failedJobsHistoryLimit?: number;
    /**
     * Specifies the job that will be created when executing a CronJob.
     */
    jobTemplate: JobTemplateSpec;
    /**
     * The schedule in Cron format, see https://en.wikipedia.org/wiki/Cron.
     */
    schedule: string;
    /**
     * Optional deadline in seconds for starting the job if it misses scheduled time for any reason.  Missed jobs executions will be counted as failed ones.
     */
    startingDeadlineSeconds?: number;
    /**
     * The number of successful finished jobs to retain. This is a pointer to distinguish between explicit zero and not specified. Defaults to 3.
     */
    successfulJobsHistoryLimit?: number;
    /**
     * This flag tells the controller to suspend subsequent executions, it does not apply to already started executions.  Defaults to false.
     */
    suspend?: boolean;
}
/**
 * CronJobStatus represents the current state of a cron job.
 */
export interface CronJobStatus {
    /**
     * A list of pointers to currently running jobs.
     */
    active?: Array<ObjectReference>;
    /**
     * Information when was the last time the job was successfully scheduled.
     */
    lastScheduleTime?: Time;
    /**
     * Information when was the last time the job successfully completed.
     */
    lastSuccessfulTime?: Time;
}
/**
 * JobTemplateSpec describes the data a Job should have when created from a template
 */
export interface JobTemplateSpec {
    /**
     * Standard object's metadata of the jobs created from this template. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
     */
    metadata?: ObjectMeta;
    /**
     * Specification of the desired behavior of the job. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
     */
    spec?: JobSpec;
}
