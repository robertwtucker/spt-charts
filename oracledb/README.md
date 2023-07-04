# Oracle Database Helm Chart

![Version: 0.2.0](https://img.shields.io/badge/Version-0.2.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 21.3.0-ee](https://img.shields.io/badge/AppVersion-21.3.0--ee-informational?style=flat-square)

This Helm chart was originally adapted for use with the charts for
deploying Quadient's Archive and Retrieval.

## Prerequisites

To deploy this chart, you will need:

- An Oracle Container Registry account created through the Oracle Single Sign-On
  portal.
- Acknowledge terms of use for the Oracle Database Docker image on the Oracle
  Container Registry.

### Oracle Container Registry

You will need an Oracle Container Registry account created through the Oracle
Single Sign-On portal [https://profile.oracle.com/myprofile/account/create-account.jspx](https://profile.oracle.com/myprofile/account/create-account.jspx).

Log in with your Oracle account credentials or create a new account, and agree
to the terms of use for the images you need to use:

### Oracle Database Docker Image

If you intend on deploying the database within a kubernetes cluster you must
agree to the terms of the Oracle database Docker image:

- At [https://container-registry.oracle.com](https://container-registry.oracle.com),
  search for 'database'.
- Click **Enterprise**.
- Click to accept the License terms and condition on the right.
- Fill in your information (if you haven't already).
- Accept the License.

Note that the deployment in cluster is for testing purpose only and not for production.

### Create a docker-registry Secret

The chart needs to pull the image from the Oracle Container Registry, and for doing
so requires the credentials to be stored in a docker-registry secret.

```bash
kubectl create secret docker-registry image-secret -n ${namespace} --docker-server=container-registry.oracle.com --docker-username='${email}' --docker-password='${password}' --docker-email='${email}'
```

## Parameters

### Global parameters

| Name                       | Description                                                                                                          | Value |
| -------------------------- | -------------------------------------------------------------------------------------------------------------------- | ----- |
| `global.imageRegistry`     | Global container image registry                                                                                      | `""`  |
| `global.imagePullSecrets`  | Global registry Secrets as an array                                                                                  | `[]`  |
| `global.storageClass`      | Global StorageClass for Persistent Volume(s)                                                                         | `""`  |
| `global.namespaceOverride` | Override the namespace for resources deployed by the chart (can itself be overridden by the local namespaceOverride) | `""`  |

### Common parameters

| Name                | Description                                                                         | Value |
| ------------------- | ----------------------------------------------------------------------------------- | ----- |
| `nameOverride`      | String to partially override the fullname template (will maintain the release name) | `""`  |
| `fullnameOverride`  | String to fully override the fullname template                                      | `""`  |
| `namespaceOverride` | String to fully override the namespace                                              | `""`  |
| `commonLabels`      | Add labels to all the deployed resources (evaluated as a template)                  | `{}`  |
| `commonAnnotations` | Common annotations to add to all resources (evaluated as a template)                | `{}`  |

### Oracle Database parameters

| Name                             | Description                                                                                                                          | Value                           |
| -------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------- |
| `image.registry`                 | Oracle Database image container registry                                                                                             | `container-registry.oracle.com` |
| `image.repository`               | Oracle Database image repository                                                                                                     | `database/express`              |
| `image.tag`                      | Oracle Database image tag                                                                                                            | `21.3.0-xe`                     |
| `image.digest`                   | Oracle Database image digest in the format `sha256:aa....` (overrides `image.tag`)                                                   | `""`                            |
| `image.pullPolicy`               | Oracle Database image pull policy                                                                                                    | `IfNotPresent`                  |
| `image.pullSecrets`              | Specify container registry Secrets as an array                                                                                       | `[]`                            |
| `architecture`                   | Oracle Database server architecture (`standalone` or `replicated`)                                                                   | `standalone`                    |
| `useStatefulSet`                 | Set to `true` to use a StatefulSet instead of a Deployment (only applicable when `architecture` == `standalone`)                     | `false`                         |
| `sid`                            | The Oracle Database SID that should be used (EE/SE default: `ORCLCDB`, XE preset: `XE`)                                              | `""`                            |
| `pdb`                            | The Oracle Database PDB name that should be used (EE/SE default: `ORCLPDB1`, XE preset: `XEPDB1`)                                    | `""`                            |
| `characterSet`                   | The character set to use when creating the database (default: `AL32UTF8`)                                                            | `""`                            |
| `username`                       | The username is always `SYS` unless using an Autonomous Database (change to `ADMIN`)                                                 | `SYS`                           |
| `password`                       | Defines (in plain text) the password of the SYS database user                                                                        | `""`                            |
| `passwordSource.useSecret`       | Use a Secret to define the password of the SYS database user                                                                         | `false`                         |
| `passwordSource.secretName`      | The name of the Secret containing the password                                                                                       | `""`                            |
| `passwordSource.secretKey`       | The key of the Secret containing the password                                                                                        | `""`                            |
| `shmVolume.enabled`              | Enable emptyDir volume for /dev/shm in Oracle Database pod(s)                                                                        | `false`                         |
| `shmVolume.sizeLimit`            | Set to enable a size limit on the shm tmpfs                                                                                          | `""`                            |
| `setupScripts.existingConfigMap` | Name of an existing ConfigMap containing the script(s) to initialize the server (a non-empty value overrides `setupScripts.content`) | `""`                            |
| `setupScripts.content`           | Script content to use for initial setup                                                                                              | `""`                            |

### Oracle Database StatefulSet parameters

| Name                                    | Description                                                                                                                                     | Value           |
| --------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------- | --------------- |
| `annotations`                           | Annotations to be added to the Oracle Database StatefulSet (evaluated as a template)                                                            | `{}`            |
| `labels`                                | Additional labels to be added to the Oracle Database StatefulSet (evaluated as a template)                                                      | `{}`            |
| `replicaCount`                          | Defines the number of Oracle Database nodes to be created after deployment (only when `architecture` == `replicated`)                           | `2`             |
| `updateStrategy.type`                   | Update strategy for the Oracle Database Statefulset (applied to Deployment when `architecture` == `standalone` and `useStatefulSet` == `false`) | `RollingUpdate` |
| `terminationGracePeriodSeconds`         | Oracle Database termination grace period                                                                                                        | `""`            |
| `existingServiceAccount`                | Name of an existing service account to use (if blank, one will be created by default)                                                           | `""`            |
| `podLabels`                             | Oracle Database pod labels                                                                                                                      | `{}`            |
| `podAnnotations`                        | Oracle Database pod annotations                                                                                                                 | `{}`            |
| `podSecurityContext.enabled`            | Enable the Oracle Database pod SecurityContext                                                                                                  | `true`          |
| `podSecurityContext.fsGroup`            | Group ID for the volumes of the Oracle Database pod(s)                                                                                          | `54321`         |
| `containerSecurityContext.enabled`      | Enable the Oracle Database container SecurityContext                                                                                            | `true`          |
| `containerSecurityContext.runAsUser`    | User ID for container(s) in the Oracle Database pod(s)                                                                                          | `54321`         |
| `containerSecurityContext.runAsNonRoot` | Prohibit the container from running under the root context (UID 0)                                                                              | `true`          |
| `resources.limits`                      | The resources limits for Oracle Database containers                                                                                             | `{}`            |
| `resources.requests`                    | The requested resources for Oracle Database containers                                                                                          | `{}`            |
| `containerPorts.oracledb`               | Oracle Database container port                                                                                                                  | `1521`          |
| `containerPorts.emexpress`              | EM Express container port                                                                                                                       | `5500`          |
| `livenessProbe.enabled`                 | Enable the Oracle Database pod livenessProbe                                                                                                    | `true`          |
| `livenessProbe.initialDelaySeconds`     | Initial delay before the probe is initiated                                                                                                     | `90`            |
| `livenessProbe.periodSeconds`           | Period between probes                                                                                                                           | `10`            |
| `livenessProbe.timeoutSeconds`          | Time after which the probe times out                                                                                                            | `5`             |
| `livenessProbe.successThreshold`        | Number of successful probes before the container is considered available                                                                        | `1`             |
| `livenessProbe.failureThreshold`        | Number of failed probes before the container is deemed unavailable                                                                              | `5`             |
| `readinessProbe.enabled`                | Enable the Oracle Database pod readinessProbe                                                                                                   | `true`          |
| `readinessProbe.initialDelaySeconds`    | Initial delay before the probe is initiated                                                                                                     | `40`            |
| `readinessProbe.periodSeconds`          | Period between probes                                                                                                                           | `20`            |
| `readinessProbe.timeoutSeconds`         | Time after which the probe times out                                                                                                            | `10`            |
| `readinessProbe.successThreshold`       | Number of successful probes before the container is considered ready                                                                            | `1`             |
| `readinessProbe.failureThreshold`       | Number of failed probes before the container is deemed unavailable                                                                              | `5`             |

### Traffic exposure parameters

| Name                               | Description                                                                                        | Value                    |
| ---------------------------------- | -------------------------------------------------------------------------------------------------- | ------------------------ |
| `service.type`                     | Defines the value for the Service object (ClusterIP/LoadBalancer/NodePort)                         | `ClusterIP`              |
| `service.ports.oracledb`           | Oracle Database service port                                                                       | `1521`                   |
| `service.ports.emexpress`          | EM Express service port                                                                            | `5500`                   |
| `service.nodePorts.oracledb`       | NodePort for the Oracle Database service                                                           | `""`                     |
| `service.nodePorts.emexpress`      | NodePort for the EM Express NodePort service                                                       | `""`                     |
| `service.annotations`              | Provide any additional service annotations which may be required                                   | `{}`                     |
| `service.headless.annotations`     | Annotations for the headless service                                                               | `{}`                     |
| `ingress.enabled`                  | Enables an Ingress (provides external access and load balancing)                                   | `false`                  |
| `ingress.annotations`              | Provide any additional annotations which may be required for the Ingress (evaluated as a template) | `nil`                    |
| `ingress.hosts`                    | Defines the host(s) for this Ingress                                                               | `[]`                     |
| `ingress.paths.oracledb.path`      | Path to be matched against incoming Oracle Database requests (must start with a slash)             | `/db/*`                  |
| `ingress.paths.oracledb.pathType`  | Path matching interpretation style                                                                 | `ImplementationSpecific` |
| `ingress.paths.emexpress.path`     | Path to be matched against incoming EM Express requests (must start with a slash)                  | `/em/*`                  |
| `ingress.paths.emexpress.pathType` | Path matching interpretation style                                                                 | `ImplementationSpecific` |
| `ingress.tls.enabled`              | Enable TLS configuration settings                                                                  | `false`                  |
| `ingress.tls.hosts`                | List of network host names contained in the TLS certificate                                        | `[]`                     |
| `ingress.tls.secretName`           | Secret used to terminate TLS traffic                                                               | `""`                     |

### Persistence parameters

| Name                                          | Description                                                                        | Value                 |
| --------------------------------------------- | ---------------------------------------------------------------------------------- | --------------------- |
| `persistence.enabled`                         | Enable Oracle data persistence using a PVC                                         | `true`                |
| `persistence.existingClaim`                   | Name of an existing PVC to use (only when `architecture` == `standalone`)          | `""`                  |
| `persistence.resourcePolicy`                  | Set to `keep` to avoid removing PVCs during a Helm delete operation                | `""`                  |
| `persistence.mountPath`                       | The path the volume will be mounted at                                             | `/opt/oracle/oradata` |
| `persistence.storageClass`                    | PVC Storage Class for Oracle data volume                                           | `""`                  |
| `persistence.accessModes`                     | Persistent Volume Access Mode for the Oracle data volume                           | `["ReadWriteOnce"]`   |
| `persistence.size`                            | PVC Storage Request for the Oracle data volume                                     | `8Gi`                 |
| `persistence.annotations`                     | Additional annotations, as required                                                | `{}`                  |
| `persistence.volumeClaimTemplates.selector`   | A label query over volumes to consider for binding (e.g. when using local volumes) | `[]`                  |
| `persistence.volumeClaimTemplates.requests`   | Custom PVC requests attributes                                                     | `{}`                  |
| `persistence.volumeClaimTemplates.dataSource` | Add a DataSource to the VolumeClaimTemplate                                        | `{}`                  |

## License

This Helm chart is adapted from chart published in
[Oracle's SOA Suite Github repository](https://github.com/oracle/helm-charts/tree/main/soa-suite/charts/oracledb).
As such, the original UPL v1.0 license is included.
