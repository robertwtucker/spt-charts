# Quadient Archive and Retrieval (QAR)

![Version: 0.2.4](https://img.shields.io/badge/Version-0.2.4-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 10.5.0.5](https://img.shields.io/badge/AppVersion-10.5.0.5-informational?style=flat-square)

## TL;DR

```bash
helm install test-release ./qar
```

## Introduction

This [Helm](https://helm.sh) chart installs the Quadient Archive & Retrieval (QAR) component services.

## Prerequisites

- Kubernetes 1.23+
- Helm 3.1+

## Installing the Chart

To install the chart with the release name `dev-release`:

```bash
cd charts
helm install dev-release ./qar
```

These commands deploy QAR in the [Kubernetes](https://kubernetes.io) cluster using the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `dev-release` deployment:

```bash
helm uninstall dev-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| oci://registry.sptcloud.com/charts | [oracledb](https://github.com/robertwtucker/spt-charts/tree/master/oracledb) | 0.1.1 |

## Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.applicationName | string | `"qar"` | Defines a unique name of an application within a Kubernetes namespace. |
| global.arsload.enabled | bool | `false` | Defines whether to deploy an ARSLOAD server. |
| global.arsload.image.name | string | `"registry.sptcloud.com/qar/ondemand"` | Defines the URL address of the ARSLOAD server image stored in a container repository. |
| global.arsload.image.pullPolicy | string | `"IfNotPresent"` | QAR REST API image pull policy \[Always\|IfNotPresent\]. |
| global.arsload.image.tag | string | `"10.5.0.5-oracle-ubi-8.8-854"` | Overrides tag specified by the `appVersion` in the chart file. |
| global.arsload.passwordOverride | string | `""` | Defines (in plain text) the password of the CMOD ARSLOAD user (for batch-loading documents). If left undefined, the deployment will generate a random alphanumeric password. Use the 'passwordOverrideSource' variable to define the username using a Secret. |
| global.arsload.passwordOverrideSource | object | `{"secretKey":"","secretName":"","useSecret":false}` | Uses a Secret to define the password of the CMOD ARSLOAD user (for batch-loading documents). |
| global.arsload.userOverride | string | `""` | Defines (in plain text) the name of the CMOD ARSLOAD user (for batch-loading documents). If left undefined, the default user `admin` is used. Use the `userOverrideSource' variable to define the username using a Secret. |
| global.arsload.userOverrideSource | object | `{"secretKey":"","secretName":"","useSecret":false}` | Uses a Secret to define the CMOD ARSLOAD user (for batch-loading documents). |
| global.existingServiceAccount | string | `""` | Enter the name of an existing service account to use. Otherwise, one will be created by default. |
| global.fts.enabled | bool | `false` | Defines whether to enable Full-Text Search. |
| global.fts.image.name | string | `"registry.sptcloud.com/qar/ondemand-fts"` | Defines the URL address of the FTS server image stored in a container repository. |
| global.fts.image.pullPolicy | string | `"IfNotPresent"` | FTS image pull policy \[Always\|IfNotPresent\]. |
| global.fts.image.tag | string | `"10.5.0.5-ubi-8.8-854"` | Overrides tag specified by the `appVersion` in the chart file. |
| global.fts.portOverride | string | `nil` | Defines the port to run the FTS server on. If left undefined, the default port 8191 is used. |
| global.imagePullSecrets | list | `[]` | List of image repository pull secrets. Secrets must be manually created in the namespace. ref: [https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/) Example: imagePullSecrets:   - name: myRegistryKeySecretName |
| global.navigator.enabled | bool | `false` | Defines whether to deploy a Content Navigator server. [Not Implemented Yet] |
| global.navigator.portOverride | string | `nil` | Defines the port to run the HTTP listener on. If left undefined, the default port 9080 is used. [Not Implemented Yet] |
| global.ondemand.db.engine | string | `"ORACLE"` | Specifies the DBMS used by the Library Server \[DB2\|ORACLE\]. |
| global.ondemand.db.numSubServers | int | `10` | Determines the number of processes that CMOD starts on the library server to handle connections to the database. Specify a value that supports the peak number of concurrent database connections library server needs to handle. |
| global.ondemand.db.passwordOverride | string | `""` | Defines (in plain text) the password of the administrative user to be created in the Oracle database(s). If left undefined, the deployment will generate a random alphanumeric password. Use the 'passwordOverrideSource' variable to define the password using a Secret. |
| global.ondemand.db.passwordOverrideSource | object | `{"secretKey":"","secretName":"","useSecret":false}` | Uses a Secret to define the password of the administrative user to be created in the Oracle database(s). |
| global.ondemand.db.tnsServiceName | string | `""` | Defines the Oracle TNS service name for the CMOD database. If left undefined, the lower-cased `serverInstanceName` value is used. |
| global.ondemand.db.userOverride | string | `""` | Defines (in plain text) the name of the administrative user to be created in the oracled database(s). If left undefined, the default user `archive` is created. Use the `userOverrideSource' variable to define the username using a Secret. |
| global.ondemand.db.userOverrideSource | object | `{"secretKey":"","secretName":"","useSecret":false}` | Uses a Secret to define the administrative user to be created in the Oracle database(s). |
| global.ondemand.image.name | string | `"registry.sptcloud.com/qar/ondemand"` | Defines the URL address of the QAR server image stored in a container repository. |
| global.ondemand.image.pullPolicy | string | `"IfNotPresent"` | QAR image pull policy \[Always\|IfNotPresent\]. |
| global.ondemand.image.tag | string | `"10.5.0.5-oracle-ubi-8.8-854"` | Overrides tag specified by the `appVersion` in the chart file. |
| global.ondemand.odInstanceName | string | `"ARCHIVE"` | Used in the header line of the `ars.ini` file to identify the name of the CMOD instance. |
| global.ondemand.passwordOverride | string | `""` | Defines (in plain text) the password of the CMOD admin user. If left undefined, the deployment will generate a random alphanumeric password. Use the 'passwordOverrideSource' variable to define the password using a Secret. |
| global.ondemand.passwordOverrideSource | object | `{"secretKey":"","secretName":"","useSecret":false}` | Uses a Secret to define the password of the CMOD user. |
| global.ondemand.portOverride | string | `nil` | Defines the port to run the ARS listener on. If left undefined, the default port 1445 is used. |
| global.ondemand.serverInstanceName | string | `"ARCHIVE"` | Identifies the name of the CMOD database (will be lower-cased for database creation). If not provided, the name `archive` will be used. |
| global.ondemand.storageManager | string | `"NO_TSM"` | Determines whether the server program is linked to a cache-only storage manager or an archive storage manager. Required on library servers. \[TSM\|NO_TSM\|CACHE_ONLY\] |
| global.ondemand.trace.enabled | bool | `false` | Enables the system trace facility |
| global.ondemand.userOverride | string | `""` | Defines (in plain text) the name of the CMOD admin user. If left undefined, the default user `admin` is created. Use the `userOverrideSource' variable to define the username using a Secret. |
| global.ondemand.userOverrideSource | object | `{"secretKey":"","secretName":"","useSecret":false}` | Uses a Secret to define the CMOD admin user. |
| global.oracledb.emExpress.portOverride | string | `nil` | Defines the port to run the EM Express app on. If left undefined, the default port 5500 is used. |
| global.oracledb.passwordOverride | string | `""` | Defines (in plain text) the password to be created for the Oracle database's SYS user. If left undefined, the deployment will generate a random alphanumeric password. Use the 'passwordOverrideSource' variable to define the password using a Secret. |
| global.oracledb.passwordOverrideSource | object | `{"secretKey":"","secretName":"","useSecret":false}` | Uses a Secret to define the password of the CMOD user to be created in the Oracle database(s). |
| global.oracledb.tnsListener.portOverride | string | `nil` | Defines the port to run the TNS listener on. If left undefined, the default port 1521 is used. |
| global.restapi.enabled | bool | `false` | Defines whether to deploy a REST API server. |
| global.restapi.image.name | string | `"registry.sptcloud.com/qar/ondemand-restapi"` | Defines the URL address of the REST API server image stored in a container repository. |
| global.restapi.image.pullPolicy | string | `"IfNotPresent"` | QAR REST API image pull policy \[Always\|IfNotPresent\]. |
| global.restapi.image.tag | string | `"10.5.0.5-liberty-23.0.0.5"` | Overrides tag specified by the `appVersion` in the chart file. |
| global.restapi.passwordOverride | string | `""` | Defines (in plain text) the password of the CMOD user to use when generating the REST configuration (OD access pool). If left undefined, the deployment will generate a random alphanumeric password. Use the 'passwordOverrideSource' variable to define the username using a Secret. |
| global.restapi.passwordOverrideSource | object | `{"secretKey":"","secretName":"","useSecret":false}` | Uses a Secret to define the password of the CMOD user used when generating the REST configuration. |
| global.restapi.portOverride | string | `nil` | Defines the port to run the HTTP listener on. If left undefined, the default port 9080 is used. |
| global.restapi.userOverride | string | `""` | Defines (in plain text) the name of the CMOD user to use when generating the REST configuration (OD access pool). If left undefined, the default user `admin` is used. Use the `userOverrideSource' variable to define the username using a Secret. |
| global.restapi.userOverrideSource | object | `{"secretKey":"","secretName":"","useSecret":false}` | Uses a Secret to define the CMOD user used when generating the REST configuration. |
| global.wait.image.name | string | `"ghcr.io/groundnuty/k8s-wait-for"` | Defines the name of the k8s-wait-for image stored in a container repository. |
| global.wait.image.tag | string | `"no-root-v2.0"` | Specifies the version tag to use. |
| global.zookeeper.enabled | bool | `false` | Defines whether to deploy a Zookeeper instance. |
| global.zookeeper.portOverride | string | `nil` | Defines the port to run the Zookeeper listener on. If left undefined, the default port 1445 is used. |
| ondemand.autoscaling.enabled | bool | `false` | Enables the autoscaling feature. |
| ondemand.autoscaling.maxReplicas | int | `3` | Defines the upper limit for the number of CMOD nodes that can be set by the autoscaling configuration. |
| ondemand.autoscaling.minReplicas | int | `1` | Defines the lower limit for the number of CMOD nodes that can be set by the autoscaling configuration. |
| ondemand.autoscaling.targetCPUUtilizationPercentage | int | `80` | Sets the Pod CPU usage target. |
| ondemand.ingress.annotations | object | `{}` | Provide any additional annotations which may be required. |
| ondemand.ingress.enabled | bool | `false` | Enables Ingress, a Kubernetes API object that provides external access and load balancing. |
| ondemand.ingress.hosts[0] | object | `{"host":""}` | Defines the host(s) for this Ingress. |
| ondemand.ingress.tls | list | `[]` | Defines the TLS-enabled host(s) and options. |
| ondemand.livenessProbe.failureThreshold | int | `3` | Number of consecutive negative tests before declaring failure |
| ondemand.livenessProbe.initialDelaySeconds | int | `2` | Initial delay before probing liveness |
| ondemand.livenessProbe.periodSeconds | int | `30` | Period in seconds between liveness checks |
| ondemand.livenessProbe.successThreshold | int | `1` | Number of consecutive positive tests before counting it as a success |
| ondemand.livenessProbe.timeoutSeconds | int | `1` | Timeout in seconds for liveness checks |
| ondemand.performInitialSetup | bool | `false` | Defines whether to create a batch job to perform initial setup processing. |
| ondemand.persistence.accessModes | list | `["ReadWriteOnce"]` | PVC Access Mode for the CMOD data volume. |
| ondemand.persistence.annotations | object | `{}` | Additional annotations, as required. |
| ondemand.persistence.enabled | bool | `true` | Enable CMOD Library server data persistence using a PVC. |
| ondemand.persistence.existingClaim | string | `""` | Name of an existing PVC to use. |
| ondemand.persistence.labels | object | `{}` | Additional labels, as required. |
| ondemand.persistence.mountPath | string | `"/opt/qar/data"` | The path the volume will be mounted at. |
| ondemand.persistence.size | string | `"8Gi"` | PVC Storage Request for the CMOD data volume. |
| ondemand.persistence.storageClass | string | `""` | If defined, storageClassName: \<storageClass\>. If set to "-", storageClassName: "", which disables dynamic provisioning. If undefined (the default) or set to null, no storageClassName spec is set, choosing the default provisioner. (gp2 on AWS, standard on GKE, AWS & OpenStack) |
| ondemand.podAnnotations | object | `{}` | Provides the ability to customize the deployment using Kubernetes annotations. |
| ondemand.podSecurityContext.fsGroup | int | `1001` | ref: [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#volumes-and-file-systems](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#volumes-and-file-systems). |
| ondemand.podSecurityContext.runAsUser | int | `1001` | ref: [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups). |
| ondemand.readinessProbe.failureThreshold | int | `3` | Number of consecutive negative tests before declaring failure |
| ondemand.readinessProbe.initialDelaySeconds | int | `2` | Initial delay before probing readiness |
| ondemand.readinessProbe.periodSeconds | int | `30` | Period in seconds between readiness checks |
| ondemand.readinessProbe.successThreshold | int | `1` | Number of consecutive positive tests before counting it as a success |
| ondemand.readinessProbe.timeoutSeconds | int | `1` | Timeout in seconds for readiness checks |
| ondemand.replicaCount | int | `1` | Defines the number of replicas to be created after deployment. |
| ondemand.resources | object | `{}` |  |
| ondemand.role | string | `"ondemand"` | QAR component designation. |
| ondemand.securityContext.allowPrivilegeEscalation | bool | `false` | ref: [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#privilege-escalation](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#privilege-escalation). |
| ondemand.securityContext.capabilities | object | `{"drop":["all"]}` | The default (recommended) configuration prohibits all Linux capabilities. |
| ondemand.securityContext.privileged | bool | `false` | ref: [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#privileged](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#privilege). |
| ondemand.securityContext.runAsGroup | int | `1001` | ref: [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#capabilities](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#capabilities). |
| ondemand.securityContext.runAsUser | int | `1001` | ref: [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups). |
| ondemand.service.annotations | object | `{}` | Provide any additional annotations which may be required. |
| ondemand.service.nodePorts.ondemand | string | `""` | Node port for CMOD |
| ondemand.service.type | string | `"ClusterIP"` | Defines the value for the Kubernetes service object \[ClusterIP\|LoadBalancer\|NodePort\]. |
| oracledb.characterSet | string | `""` | The character set to use when creating the database (default: AL32UTF8) |
| oracledb.existingServiceAccount | string | `""` | Enter the name of an existing service account to use. Otherwise, one will be created by default. |
| oracledb.image.name | string | `"container-registry.oracle.com/database/express"` | Defines the URL address of the Oracle database image stored in a Docker image repository. |
| oracledb.image.pullPolicy | string | `"IfNotPresent"` | Defines the Oracle database image pull policy. \[IfNotPresent/Always\]. |
| oracledb.image.tag | string | `""` | Overrides the image tag. Defaults to the chart's appVersion. |
| oracledb.ingress.annotations | object | `{}` | Provide any additional annotations which may be required. |
| oracledb.ingress.enabled | bool | `false` | Enables Ingress, a Kubernetes API object that provides external access and load balancing. |
| oracledb.ingress.hosts\[0\].host | string | `""` | Defines the host(s) for this Ingress. |
| oracledb.ingress.tls | list | `\[\]` | Defines the TLS-enabled host(s) and options. |
| oracledb.livenessProbe.failureThreshold | int | `5` | Defines the minimum consecutive failures for the Oracle database container probe to be considered failed after having succeeded. |
| oracledb.livenessProbe.initialDelaySeconds | int | `90` | Defines the delay before the Oracle database container liveness probe is initiated. |
| oracledb.livenessProbe.periodSeconds | int | `10` | Defines how often to perform the Oracle database container probe. |
| oracledb.livenessProbe.successThreshold | int | `1` | Defines the minimum consecutive successes for the Oracle database container probe to be considered successful after having failed. |
| oracledb.livenessProbe.timeoutSeconds | int | `5` | Defines when the Oracle database container probe times out. |
| oracledb.password | string | `""` | Defines (in plain text) the password of the SYS database user. Use the 'passwordSource' variable instead to define the password using a Secret. |
| oracledb.passwordSource | object | `{"secretKey":"","secretName":"","useSecret":false}` | Use a Secret to define the password of the SYS database user. |
| oracledb.pdb | string | `""` | The Oracle database PDB name that should be used (EE/SE default: ORCLPDB1, XE preset: XEPDB1). |
| oracledb.persistence.accessModes | list | `\[ReadWriteOnce\]` | PVC Access Mode for the Oracle data volume. |
| oracledb.persistence.annotations | object | `{}` | Additional annotations, as required. |
| oracledb.persistence.enabled | bool | `true` | Enable Oracle data persistence using a PVC. |
| oracledb.persistence.existingClaim | string | `""` | Name of an existing PVC to use. |
| oracledb.persistence.labels | object | `{}` | Additional labels, as required. |
| oracledb.persistence.mountPath | string | `"/opt/oracle/oradata"` | The path the volume will be mounted at. |
| oracledb.persistence.size | string | `"8Gi"` | PVC Storage Request for the Oracle data volume. |
| oracledb.persistence.storageClass | string | `""` | If defined, storageClassName: \<storageClass\> If set to "-", storageClassName: "", which disables dynamic provisioning. If undefined (the default) or set to null, no storageClassName spec is set, choosing the default provisioner. (gp2 on AWS, standard on GKE, AWS & OpenStack) |
| oracledb.podAnnotations | object | `{}` | Provides the ability to customize the deployment using Kubernetes annotations. |
| oracledb.podSecurityContext.fsGroup | int | `54321` | Learn about this setting at [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#volumes-and-file-systems](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#volumes-and-file-systems). |
| oracledb.podSecurityContext.runAsNonRoot | bool | `true` | Learn about this setting at [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups). |
| oracledb.podSecurityContext.runAsUser | int | `54321` | Learn about this setting at [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups). |
| oracledb.readinessProbe.failureThreshold | int | `5` | Defines the minimum consecutive failures for the Oracle database container probe to be considered failed after having succeeded. |
| oracledb.readinessProbe.initialDelaySeconds | int | `40` | Defines the delay before the Oracle database container readiness probe is initiated. |
| oracledb.readinessProbe.periodSeconds | int | `20` | Defines how often to perform the Oracle database container probe. |
| oracledb.readinessProbe.successThreshold | int | `1` | Defines the minimum consecutive successes for the Oracle database container probe to be considered successful after having failed. |
| oracledb.readinessProbe.timeoutSeconds | int | `10` | Defines when the Oracle database container probe times out. |
| oracledb.replicaCount | int | `1` | Defines the number of Oracle database nodes to be deployed at launch. |
| oracledb.resources | object | `{}` | Provide resource request and limitation parameters, as required. |
| oracledb.role | string | `"oracledb"` | QAR component designation. |
| oracledb.securityContext.allowPrivilegeEscalation | bool | `false` | Learn about this setting at [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#privilege-escalation](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#privilege-escalation). |
| oracledb.securityContext.capabilities | object | `{"drop":\["all"\]}` | The default (recommended) configuration prohibits all Linux capabilities. |
| oracledb.securityContext.privileged | bool | `false` | Learn about this setting at [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#privileged](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#privileged). |
| oracledb.securityContext.readOnlyRootFilesystem | bool | `false` | Learn about this setting at [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#volumes-and-file-systems](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#volumes-and-file-systems). |
| oracledb.securityContext.runAsGroup | int | `54321` | Learn about this setting at [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups). |
| oracledb.securityContext.runAsUser | int | `54321` | Learn about this setting at [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups). |
| oracledb.service.annotations | object | `{}` | Provide any additional annotations which may be required. |
| oracledb.service.nodePorts.emexpress | string | `""` | Node port for EM Express. |
| oracledb.service.nodePorts.oracledb | string | `""` | Node port for the Oracle database. |
| oracledb.service.type | string | `"ClusterIP"` | Defines the value for the Kubernetes service object \[ClusterIP/LoadBalancer\]. |
| oracledb.shmVolume.enabled | bool | `false` | Enable emptyDir volume for /dev/shm for Oracle pod(s) |
| oracledb.shmVolume.sizeLimit | string | `""` | Set this to enable a size limit on the shm tmpfs. Note: the size of the tmpfs counts against container's memory limit e.g: sizeLimit: 1Gi |
| oracledb.sid | string | `""` | The Oracle database SID that should be used (EE/SE default: ORCLCDB, XE preset: XE). |
| oracledb.username | string | `"SYS"` | The username is always SYS unless using an Autonomous Database (change to `ADMIN`) |
| restapi.consumerName | string | `""` | Name of the REST consumer to create for the pool. Defaults to `admin` if blank. |
| restapi.ingress.annotations | object | `{}` | Provide any additional annotations which may be required. |
| restapi.ingress.enabled | bool | `false` | Enables Ingress, a Kubernetes API object that provides external access and load balancing. |
| restapi.ingress.hosts[0] | object | `{"host":""}` | Defines the host(s) for this Ingress. |
| restapi.ingress.tls | list | `[]` | Defines the TLS-enabled host(s) and options. |
| restapi.livenessProbe.failureThreshold | int | `5` | Number of consecutive negative tests before declaring failure |
| restapi.livenessProbe.initialDelaySeconds | int | `5` | Initial delay before probing liveness |
| restapi.livenessProbe.periodSeconds | int | `30` | Period in seconds between liveness checks |
| restapi.livenessProbe.successThreshold | int | `1` | Number of consecutive positive tests before counting it as a success |
| restapi.livenessProbe.timeoutSeconds | int | `1` | Timeout in seconds for liveness checks |
| restapi.podAnnotations | object | `{}` | Provides the ability to customize the deployment using Kubernetes annotations. |
| restapi.podSecurityContext.fsGroup | int | `1001` | ref: [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#volumes-and-file-systems](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#volumes-and-file-systems). |
| restapi.podSecurityContext.runAsUser | int | `1001` | ref: [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups). |
| restapi.poolName | string | `""` | Name of the REST connection pool to create. Defaults to `odpool` if blank. |
| restapi.readinessProbe.failureThreshold | int | `5` | Number of consecutive negative tests before declaring failure |
| restapi.readinessProbe.initialDelaySeconds | int | `10` | Initial delay before probing readiness |
| restapi.readinessProbe.periodSeconds | int | `30` | Period in seconds between readiness checks |
| restapi.readinessProbe.successThreshold | int | `1` | Number of consecutive positive tests before counting it as a success |
| restapi.readinessProbe.timeoutSeconds | int | `1` | Timeout in seconds for readiness checks |
| restapi.replicaCount | int | `1` | Defines the number of replicas to be created after deployment. |
| restapi.resources | object | `{}` |  |
| restapi.role | string | `"restapi"` | QAR component designation. |
| restapi.securityContext.allowPrivilegeEscalation | bool | `false` | ref: [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#privilege-escalation](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#privilege-escalation). |
| restapi.securityContext.capabilities | object | `{"drop":["all"]}` | The default (recommended) configuration prohibits all Linux capabilities. |
| restapi.securityContext.privileged | bool | `false` | ref: [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#privileged](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#privileged). |
| restapi.securityContext.runAsGroup | int | `1001` | ref: [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#capabilities](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#capabilities). |
| restapi.securityContext.runAsUser | int | `1001` | ref: [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups). |
| restapi.service.annotations | object | `{}` | Provide any additional annotations which may be required. |
| restapi.service.nodePorts.http | string | `""` | Node port for WAS |
| restapi.service.type | string | `"ClusterIP"` | Defines the value for the Kubernetes service object \[ClusterIP\|LoadBalancer\|NodePort\]. |
| arsload.instances | string | `nil` | List of arsload deployment instances (one replica per input volume). |
| arsload.livenessProbe.failureThreshold | int | `5` | Number of consecutive negative tests before declaring failure |
| arsload.livenessProbe.initialDelaySeconds | int | `5` | Initial delay before probing liveness |
| arsload.livenessProbe.periodSeconds | int | `30` | Period in seconds between liveness checks |
| arsload.livenessProbe.successThreshold | int | `1` | Number of consecutive positive tests before counting it as a success |
| arsload.livenessProbe.timeoutSeconds | int | `1` | Timeout in seconds for liveness checks |
| arsload.podAnnotations | object | `{}` | Provides the ability to customize the deployment using Kubernetes annotations. |
| arsload.podSecurityContext.fsGroup | int | `1001` | ref: [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#volumes-and-file-systems](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#volumes-and-file-systems). |
| arsload.podSecurityContext.runAsUser | int | `1001` | ref: [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups). |
| arsload.readinessProbe.failureThreshold | int | `5` | Number of consecutive negative tests before declaring failure |
| arsload.readinessProbe.initialDelaySeconds | int | `10` | Initial delay before probing readiness |
| arsload.readinessProbe.periodSeconds | int | `30` | Period in seconds between readiness checks |
| arsload.readinessProbe.successThreshold | int | `1` | Number of consecutive positive tests before counting it as a success |
| arsload.readinessProbe.timeoutSeconds | int | `1` | Timeout in seconds for readiness checks |
| arsload.resources | object | `{}` |  |
| arsload.role | string | `"arsload"` | QAR component designation. |
| arsload.securityContext.allowPrivilegeEscalation | bool | `false` | ref: [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#privilege-escalation](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#privilege-escalation). |
| arsload.securityContext.capabilities | object | `{"drop":["all"]}` | The default (recommended) configuration prohibits all Linux capabilities. |
| arsload.securityContext.privileged | bool | `false` | ref: [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#privileged](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#privileged). |
| arsload.securityContext.runAsGroup | int | `1001` | ref: [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#capabilities](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#capabilities). |
| arsload.securityContext.runAsUser | int | `1001` | ref: [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups). |
| arsload.timeInterval | int | `600` | Time interval in seconds to sleep (the `arsload` command itself defaults to 600) |
| fts.exportPollDelay | int | `180` | Full-text index export process polling/sleep interval (in seconds) |
| fts.livenessProbe.failureThreshold | int | `5` | Number of consecutive negative tests before declaring failure |
| fts.livenessProbe.initialDelaySeconds | int | `5` | Initial delay before probing liveness |
| fts.livenessProbe.periodSeconds | int | `30` | Period in seconds between liveness checks |
| fts.livenessProbe.successThreshold | int | `1` | Number of consecutive positive tests before counting it as a success |
| fts.livenessProbe.timeoutSeconds | int | `1` | Timeout in seconds for liveness checks |
| fts.podAnnotations | object | `{}` | Provides the ability to customize the deployment using Kubernetes annotations. |
| fts.podSecurityContext.fsGroup | int | `1001` | ref: [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#volumes-and-file-systems](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#volumes-and-file-systems). |
| fts.podSecurityContext.runAsUser | int | `1001` | ref: [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups). |
| fts.readinessProbe.failureThreshold | int | `5` | Number of consecutive negative tests before declaring failure |
| fts.readinessProbe.initialDelaySeconds | int | `10` | Initial delay before probing readiness |
| fts.readinessProbe.periodSeconds | int | `30` | Period in seconds between readiness checks |
| fts.readinessProbe.successThreshold | int | `1` | Number of consecutive positive tests before counting it as a success |
| fts.readinessProbe.timeoutSeconds | int | `1` | Timeout in seconds for readiness checks |
| fts.replicaCount | int | `1` | Defines the number of replicas to be created after deployment. |
| fts.resources | object | `{}` |  |
| fts.role | string | `"fts"` | QAR component designation. |
| fts.securityContext.allowPrivilegeEscalation | bool | `false` | ref: [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#privilege-escalation](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#privilege-escalation). |
| fts.securityContext.capabilities | object | `{"drop":["all"]}` | The default (recommended) configuration prohibits all Linux capabilities. |
| fts.securityContext.privileged | bool | `false` | ref: [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#privileged](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#privileged). |
| fts.securityContext.runAsGroup | int | `1001` | ref: [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#capabilities](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#capabilities). |
| fts.securityContext.runAsUser | int | `1001` | ref: [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups). |
| fts.service.annotations | object | `{}` | Provide any additional annotations which may be required. |
| fts.service.nodePorts.http | string | `""` | Node port for WAS |
| fts.service.type | string | `"ClusterIP"` | Defines the value for the Kubernetes service object \[ClusterIP\|LoadBalancer\|NodePort\]. |
----------------------------------------------
