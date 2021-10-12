import { ListMeta, ObjectMeta, Time } from "../meta/v1";
/**
 * Describes a certificate signing request
 */
export interface CertificateSigningRequest {
    /**
     * APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
     */
    apiVersion?: "certificates.k8s.io/v1beta1";
    /**
     * Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
     */
    kind?: "CertificateSigningRequest";
    metadata?: ObjectMeta;
    /**
     * The certificate request itself and any additional information.
     */
    spec?: CertificateSigningRequestSpec;
    /**
     * Derived information about the request.
     */
    status?: CertificateSigningRequestStatus;
}
export interface CertificateSigningRequestCondition {
    /**
     * lastTransitionTime is the time the condition last transitioned from one status to another. If unset, when a new condition type is added or an existing condition's status is changed, the server defaults this to the current time.
     */
    lastTransitionTime?: Time;
    /**
     * timestamp for the last update to this condition
     */
    lastUpdateTime?: Time;
    /**
     * human readable message with details about the request state
     */
    message?: string;
    /**
     * brief reason for the request state
     */
    reason?: string;
    /**
     * Status of the condition, one of True, False, Unknown. Approved, Denied, and Failed conditions may not be "False" or "Unknown". Defaults to "True". If unset, should be treated as "True".
     */
    status?: string;
    /**
     * type of the condition. Known conditions include "Approved", "Denied", and "Failed".
     */
    type: string;
}
export interface CertificateSigningRequestList {
    /**
     * APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
     */
    apiVersion?: "certificates.k8s.io/v1beta1";
    items: Array<CertificateSigningRequest>;
    /**
     * Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
     */
    kind?: "CertificateSigningRequestList";
    metadata?: ListMeta;
}
/**
 * This information is immutable after the request is created. Only the Request and Usages fields can be set on creation, other fields are derived by Kubernetes and cannot be modified by users.
 */
export interface CertificateSigningRequestSpec {
    /**
     * Extra information about the requesting user. See user.Info interface for details.
     */
    extra?: {
        [name: string]: Array<string>;
    };
    /**
     * Group information about the requesting user. See user.Info interface for details.
     */
    groups?: Array<string>;
    /**
     * Base64-encoded PKCS#10 CSR data
     */
    request: string;
    /**
     * Requested signer for the request. It is a qualified name in the form: `scope-hostname.io/name`. If empty, it will be defaulted:
     *  1. If it's a kubelet client certificate, it is assigned
     *     "kubernetes.io/kube-apiserver-client-kubelet".
     *  2. If it's a kubelet serving certificate, it is assigned
     *     "kubernetes.io/kubelet-serving".
     *  3. Otherwise, it is assigned "kubernetes.io/legacy-unknown".
     * Distribution of trust for signers happens out of band. You can select on this field using `spec.signerName`.
     */
    signerName?: string;
    /**
     * UID information about the requesting user. See user.Info interface for details.
     */
    uid?: string;
    /**
     * allowedUsages specifies a set of usage contexts the key will be valid for. See: https://tools.ietf.org/html/rfc5280#section-4.2.1.3
     *      https://tools.ietf.org/html/rfc5280#section-4.2.1.12
     * Valid values are:
     *  "signing",
     *  "digital signature",
     *  "content commitment",
     *  "key encipherment",
     *  "key agreement",
     *  "data encipherment",
     *  "cert sign",
     *  "crl sign",
     *  "encipher only",
     *  "decipher only",
     *  "any",
     *  "server auth",
     *  "client auth",
     *  "code signing",
     *  "email protection",
     *  "s/mime",
     *  "ipsec end system",
     *  "ipsec tunnel",
     *  "ipsec user",
     *  "timestamping",
     *  "ocsp signing",
     *  "microsoft sgc",
     *  "netscape sgc"
     */
    usages?: Array<string>;
    /**
     * Information about the requesting user. See user.Info interface for details.
     */
    username?: string;
}
export interface CertificateSigningRequestStatus {
    /**
     * If request was approved, the controller will place the issued certificate here.
     */
    certificate?: string;
    /**
     * Conditions applied to the request, such as approval or denial.
     */
    conditions?: Array<CertificateSigningRequestCondition>;
}
