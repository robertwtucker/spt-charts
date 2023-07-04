# Quadient Archive and Retrieval (QAR)

![Version: 0.2.5](https://img.shields.io/badge/Version-0.2.5-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 10.5.0.5](https://img.shields.io/badge/AppVersion-10.5.0.5-informational?style=flat-square)

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

## Chart Dependencies

| Repository                         | Name                                                                         | Version |
| ---------------------------------- | ---------------------------------------------------------------------------- | ------- |
| oci://registry-1.docker.io/bitnamicharts | [bitnami/common](https://github.com/bitnami/charts/tree/main/bitnami/common)                      | 2.x.x |
| oci://registry.sptcloud.com/charts       | [spt-charts/oracledb](https://github.com/robertwtucker/spt-charts/tree/master/oracledb) | 0.2.x |

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

### OnDemand parameters

| Name                                       | Description                                                                                                                              | Value                         |
| ------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------- |
| `image.registry`                           | OnDemand image container registry                                                                                                        | `""`                          |
| `image.repository`                         | OnDemand image repository                                                                                                                | `qar/ondemand`                |
| `image.tag`                                | OnDemand image tag                                                                                                                       | `10.5.0.5-oracle-ubi-8.8-854` |
| `image.digest`                             | OnDemand image digest in the format `sha256:aa....` (overrides `image.tag`)                                                              | `""`                          |
| `image.pullPolicy`                         | OnDemand image pull policy                                                                                                               | `IfNotPresent`                |
| `image.pullSecrets`                        | Specify container registry Secrets as an array                                                                                           | `[]`                          |
| `architecture`                             | OnDemand server architecture (`standalone` or `replicated`)                                                                              | `standalone`                  |
| `useStatefulSet`                           | Set to `true` to use a StatefulSet instead of a Deployment (only applicable when `architecture` == `standalone`)                         | `true`                        |
| `odInstanceName`                           | Name used in the header line of the `ars.ini` file to identify the OnDemand instance                                                     | `ARCHIVE`                     |
| `serverInstanceName`                       | Name of the OnDemand database (lower-cased prior to database creation)                                                                   | `ARCHIVE`                     |
| `storageManager`                           | Determines whether the server is linked to a cache-only or archive storage manager                                                       | `NO_TSM`                      |
| `trace.enabled`                            | Enables the OnDemand system trace facility                                                                                               | `false`                       |
| `auth.username`                            | Defines (in plain text) the name of the OnDemand admin user                                                                              | `""`                          |
| `auth.usernameSource.useSecret`            | Use a Secret to define the OnDemand admin user                                                                                           | `false`                       |
| `auth.usernameSource.secretName`           | The name of the Secret containing the user name                                                                                          | `""`                          |
| `auth.usernameSource.secretKey`            | The key of the Secret containing the user name                                                                                           | `""`                          |
| `auth.password`                            | Defines (in plain text) the password of the OnDemand admin user                                                                          | `""`                          |
| `auth.passwordSource.useSecret`            | Use a Secret to define the OnDemand admin user's password                                                                                | `false`                       |
| `auth.passwordSource.secretName`           | The name of the Secret containing the password                                                                                           | `""`                          |
| `auth.passwordSource.secretKey`            | The key of the Secret containing the password                                                                                            | `""`                          |
| `db.engine`                                | Specifies the DBMS used by the Library Server                                                                                            | `ORACLE`                      |
| `db.tnsServiceName`                        | Defines the Oracle TNS service name for the OnDemand database                                                                            | `archive`                     |
| `db.numSubServers`                         | Determines the number of processes that OnDemand starts on the library server to handle connections to the database                      | `10`                          |
| `db.auth.username`                         | Defines (in plain text) the name of the admin user to be created in the database(s)                                                      | `""`                          |
| `db.auth.usernameSource.useSecret`         | Use a Secret to define the database admin user                                                                                           | `false`                       |
| `db.auth.usernameSource.secretName`        | The name of the Secret containing the user name                                                                                          | `""`                          |
| `db.auth.usernameSource.secretKey`         | The key of the Secret containing the user name                                                                                           | `""`                          |
| `db.auth.password`                         | Defines (in plain text) the database admin user's password                                                                               | `""`                          |
| `db.auth.passwordSource.useSecret`         | Use a Secret to define the database admin user's password                                                                                | `false`                       |
| `db.auth.passwordSource.secretName`        | The name of the Secret containing the password                                                                                           | `""`                          |
| `db.auth.passwordSource.secretKey`         | The key of the Secret containing the password                                                                                            | `""`                          |
| `zookeeper.enabled`                        | Use Zookeeper to manage locking between multiple active OnDemand server instances                                                        | `false`                       |
| `zookeeper.servers`                        | List of Zookeeper servers to use                                                                                                         | `[]`                          |
| `zookeeper.auth.username`                  | Defines (in plain text) the name of the Zookeeper user                                                                                   | `""`                          |
| `zookeeper.auth.usernameSource.useSecret`  | Use a Secret to define the Zookeeper user                                                                                                | `false`                       |
| `zookeeper.auth.usernameSource.secretName` | The name of the Secret containing the user name                                                                                          | `""`                          |
| `zookeeper.auth.usernameSource.secretKey`  | The key of the Secret containing the user name                                                                                           | `""`                          |
| `zookeeper.auth.password`                  | Defines (in plain text) the Zookeeper user's password                                                                                    | `""`                          |
| `zookeeper.auth.passwordSource.useSecret`  | Use a Secret to define the Zookeeper user's password                                                                                     | `false`                       |
| `zookeeper.auth.passwordSource.secretName` | The name of the Secret containing the password                                                                                           | `""`                          |
| `zookeeper.auth.passwordSource.secretKey`  | The key of the Secret containing the password                                                                                            | `""`                          |
| `performInitialSetup`                      | Create a batch job to perform initial setup processing (experimental)                                                                    | `false`                       |
| `annotations`                              | Annotations to be added to the OnDemand statefulset (evaluated as a template)                                                            | `{}`                          |
| `labels`                                   | Additional labels to be added to the OnDemand statefulset (evaluated as a template)                                                      | `{}`                          |
| `replicaCount`                             | Defines the number of OnDemand nodes to be created (only when `architecture` == `replicated`)                                            | `2`                           |
| `updateStrategy.type`                      | Update strategy for the OnDemand Statefulset (applied to Deployment when `architecture` == `standalone` and `useStatefulSet` == `false`) | `RollingUpdate`               |
| `terminationGracePeriodSeconds`            | OnDemand termination grace period                                                                                                        | `""`                          |
| `existingServiceAccount`                   | Name of an existing service account to use (if blank, one will be created by default)                                                    | `""`                          |
| `podLabels`                                | OnDemand pod labels                                                                                                                      | `{}`                          |
| `podAnnotations`                           | OnDemand pod annotations                                                                                                                 | `{}`                          |
| `podSecurityContext.enabled`               | Enable the OnDemand pod SecurityContext                                                                                                  | `true`                        |
| `podSecurityContext.fsGroup`               | Group ID for the volumes of the OnDemand pod(s)                                                                                          | `1001`                        |
| `containerSecurityContext.enabled`         | Enable the OnDemand container SecurityContext                                                                                            | `true`                        |
| `containerSecurityContext.runAsUser`       | User ID for container(s) in the OnDemand pod(s)                                                                                          | `1001`                        |
| `resources.limits`                         | The resources limits for OnDemand containers                                                                                             | `{}`                          |
| `resources.requests`                       | The requested resources for OnDemand containers                                                                                          | `{}`                          |
| `containerPorts.ondemand`                  | OnDemand container port                                                                                                                  | `1445`                        |
| `livenessProbe.enabled`                    | Enable the OnDemand pod livenessProbe                                                                                                    | `true`                        |
| `livenessProbe.initialDelaySeconds`        | Initial delay before the probe is initiated                                                                                              | `2`                           |
| `livenessProbe.periodSeconds`              | Period between probes                                                                                                                    | `30`                          |
| `livenessProbe.timeoutSeconds`             | Time after which the probe times out                                                                                                     | `1`                           |
| `livenessProbe.successThreshold`           | Number of successful probes before the container is considered available                                                                 | `1`                           |
| `livenessProbe.failureThreshold`           | Number of failed probes before the container is deemed unavailable                                                                       | `3`                           |
| `readinessProbe.enabled`                   | Enable the OnDemand pod readinessProbe                                                                                                   | `true`                        |
| `readinessProbe.initialDelaySeconds`       | Initial delay before the probe is initiated                                                                                              | `2`                           |
| `readinessProbe.periodSeconds`             | Period between probes                                                                                                                    | `30`                          |
| `readinessProbe.timeoutSeconds`            | Time after which the probe times out                                                                                                     | `1`                           |
| `readinessProbe.successThreshold`          | Number of successful probes before the container is considered ready                                                                     | `1`                           |
| `readinessProbe.failureThreshold`          | Number of failed probes before the container is deemed unavailable                                                                       | `3`                           |

### Traffic exposure parameters

| Name                              | Description                                                                                        | Value                    |
| --------------------------------- | -------------------------------------------------------------------------------------------------- | ------------------------ |
| `service.type`                    | Type of Service object                                                                             | `ClusterIP`              |
| `service.portName`                | Name of the service port                                                                           | `ondemand`               |
| `service.ports.ondemand`          | OnDemand service port                                                                              | `1445`                   |
| `service.nodePorts.ondemand`      | NodePort for the OnDemand service                                                                  | `""`                     |
| `service.annotations`             | Provide any additional service annotations which may be required                                   | `{}`                     |
| `service.headless.annotations`    | Annotations for the headless service                                                               | `{}`                     |
| `ingress.enabled`                 | Enables an Ingress (provides external access and load balancing)                                   | `false`                  |
| `ingress.annotations`             | Provide any additional annotations which may be required for the Ingress (evaluated as a template) | `{}`                     |
| `ingress.hosts`                   | Defines the host(s) for this Ingress                                                               | `[]`                     |
| `ingress.paths.ondemand.path`     | Path to be matched against incoming OnDemand requests (must start with a slash)                    | `/*`                     |
| `ingress.paths.ondemand.pathType` | Path matching interpretation style                                                                 | `ImplementationSpecific` |
| `ingress.tls.enabled`             | Enable TLS configuration settings                                                                  | `false`                  |
| `ingress.tls.hosts`               | List of network host names contained in the TLS certificate                                        | `[]`                     |
| `ingress.tls.secretName`          | Secret used to terminate TLS traffic                                                               | `""`                     |

### Persistence parameters

| Name                                          | Description                                                                        | Value               |
| --------------------------------------------- | ---------------------------------------------------------------------------------- | ------------------- |
| `persistence.enabled`                         | Enable Oracle data persistence using a PVC                                         | `true`              |
| `persistence.existingClaim`                   | Name of an existing PVC to use (only when `architecture` == `standalone`)          | `""`                |
| `persistence.resourcePolicy`                  | Set to `keep` to avoid removing PVCs during a Helm delete operation                | `""`                |
| `persistence.mountPath`                       | The path the volume will be mounted at                                             | `/opt/qar/data`     |
| `persistence.storageClass`                    | PVC Storage Class for OnDemand data volume                                         | `""`                |
| `persistence.accessModes`                     | Persistent Volume Access Mode for the OnDemand data volume                         | `["ReadWriteOnce"]` |
| `persistence.size`                            | PVC Storage Request for the OnDemand data volume                                   | `8Gi`               |
| `persistence.annotations`                     | Additional annotations, as required                                                | `{}`                |
| `persistence.volumeClaimTemplates.selector`   | A label query over volumes to consider for binding (e.g. when using local volumes) | `[]`                |
| `persistence.volumeClaimTemplates.requests`   | Custom PVC requests attributes                                                     | `{}`                |
| `persistence.volumeClaimTemplates.dataSource` | Add a DataSource to the VolumeClaimTemplate                                        | `{}`                |

### ARSLOAD (batch load) parameters

| Name                                         | Description                                                                       | Value      |
| -------------------------------------------- | --------------------------------------------------------------------------------- | ---------- |
| `arsload.enabled`                            | Deploy one or more ARSLOAD (batch load) servers                                   | `false`    |
| `arsload.auth.username`                      | Defines (in plain text) the name of the ARSLOAD user                              | `""`       |
| `arsload.auth.usernameSource.useSecret`      | Use a Secret to define the ARSLOAD user                                           | `false`    |
| `arsload.auth.usernameSource.secretName`     | The name of the Secret containing the user name                                   | `""`       |
| `arsload.auth.usernameSource.secretKey`      | The key of the Secret containing the user name                                    | `""`       |
| `arsload.auth.password`                      | Defines (in plain text) the ARSLOAD user's password                               | `""`       |
| `arsload.auth.passwordSource.useSecret`      | Use a Secret to define the ARSLOAD user's password                                | `false`    |
| `arsload.auth.passwordSource.secretName`     | The name of the Secret containing the password                                    | `""`       |
| `arsload.auth.passwordSource.secretKey`      | The key of the Secret containing the password                                     | `""`       |
| `arsload.timeInterval`                       | Time interval in seconds to sleep                                                 | `300`      |
| `arsload.instances`                          | List of arsload deployment instances (one replica per input volume).              | `[]`       |
| `arsload.annotations`                        | Annotations to be added to the ARSLOAD deployment (evaluated as a template)       | `{}`       |
| `arsload.labels`                             | Additional labels to be added to the ARSLOAD deployment (evaluated as a template) | `{}`       |
| `arsload.updateStrategy.type`                | Update strategy for the ARSLOAD deployment                                        | `Recreate` |
| `arsload.terminationGracePeriodSeconds`      | ARSLOAD termination grace period                                                  | `""`       |
| `arsload.podLabels`                          | ARSLOAD pod labels                                                                | `{}`       |
| `arsload.podAnnotations`                     | ARSLOAD pod annotations                                                           | `{}`       |
| `arsload.podSecurityContext.enabled`         | Enable the ARSLOAD pod SecurityContext                                            | `true`     |
| `arsload.podSecurityContext.fsGroup`         | Group ID for the volumes of the ARSLOAD pod(s)                                    | `1001`     |
| `arsload.containerSecurityContext.enabled`   | Enable the ARSLOAD container SecurityContext                                      | `true`     |
| `arsload.containerSecurityContext.runAsUser` | User ID for container(s) in the ARSLOAD pod(s)                                    | `1001`     |
| `arsload.resources.limits`                   | The resources limits for ARSLOAD containers                                       | `{}`       |
| `arsload.resources.requests`                 | The requested resources for ARSLOAD containers                                    | `{}`       |
| `arsload.livenessProbe.enabled`              | Enable the ARSLOAD pod livenessProbe                                              | `true`     |
| `arsload.livenessProbe.initialDelaySeconds`  | Initial delay before the probe is initiated                                       | `5`        |
| `arsload.livenessProbe.periodSeconds`        | Period between probes                                                             | `30`       |
| `arsload.livenessProbe.timeoutSeconds`       | Time after which the probe times out                                              | `1`        |
| `arsload.livenessProbe.successThreshold`     | Number of successful probes before the container is considered available          | `1`        |
| `arsload.livenessProbe.failureThreshold`     | Number of failed probes before the container is deemed unavailable                | `5`        |
| `arsload.readinessProbe.enabled`             | Enable the ARSLOAD pod readinessProbe                                             | `true`     |
| `arsload.readinessProbe.initialDelaySeconds` | Initial delay before the probe is initiated                                       | `10`       |
| `arsload.readinessProbe.periodSeconds`       | Period between probes                                                             | `30`       |
| `arsload.readinessProbe.timeoutSeconds`      | Time after which the probe times out                                              | `1`        |
| `arsload.readinessProbe.successThreshold`    | Number of successful probes before the container is considered ready              | `1`        |
| `arsload.readinessProbe.failureThreshold`    | Number of failed probes before the container is deemed unavailable                | `5`        |

### OnDemand REST API parameters

| Name                                              | Description                                                                                        | Value                       |
| ------------------------------------------------- | -------------------------------------------------------------------------------------------------- | --------------------------- |
| `restapi.enabled`                                 | Deploy an OnDemand REST API server                                                                 | `false`                     |
| `restapi.image.registry`                          | OnDemand REST API image container registry                                                         | `""`                        |
| `restapi.image.repository`                        | OnDemand REST API image repository                                                                 | `qar/ondemand-restapi`      |
| `restapi.image.tag`                               | OnDemand REST API image tag                                                                        | `10.5.0.5-liberty-23.0.0.5` |
| `restapi.image.digest`                            | OnDemand REST API image digest in the format `sha256:aa....` (overrides `image.tag`)               | `""`                        |
| `restapi.image.pullPolicy`                        | OnDemand REST API image pull policy                                                                | `IfNotPresent`              |
| `restapi.image.pullSecrets`                       | Specify container registry Secrets as an array                                                     | `[]`                        |
| `restapi.auth.username`                           | Defines (in plain text) the name of the REST API user                                              | `""`                        |
| `restapi.auth.usernameSource.useSecret`           | Use a Secret to define the REST API user                                                           | `false`                     |
| `restapi.auth.usernameSource.secretName`          | The name of the Secret containing the user name                                                    | `""`                        |
| `restapi.auth.usernameSource.secretKey`           | The key of the Secret containing the user name                                                     | `""`                        |
| `restapi.auth.password`                           | Defines (in plain text) the REST API user's password                                               | `""`                        |
| `restapi.auth.passwordSource.useSecret`           | Use a Secret to define the REST API user's password                                                | `false`                     |
| `restapi.auth.passwordSource.secretName`          | The name of the Secret containing the password                                                     | `""`                        |
| `restapi.auth.passwordSource.secretKey`           | The key of the Secret containing the password                                                      | `""`                        |
| `restapi.poolName`                                | REST API connection pool to create                                                                 | `""`                        |
| `restapi.consumerName`                            | REST API consumer to create for the pool                                                           | `""`                        |
| `restapi.annotations`                             | Annotations to be added to the REST API deployment (evaluated as a template)                       | `{}`                        |
| `restapi.labels`                                  | Additional labels to be added to the REST API deployment (evaluated as a template)                 | `{}`                        |
| `restapi.replicaCount`                            | Number of REST API nodes to be created                                                             | `1`                         |
| `restapi.updateStrategy`                          | Update strategy for the REST API deployment                                                        | `{}`                        |
| `restapi.terminationGracePeriodSeconds`           | REST API termination grace period                                                                  | `""`                        |
| `restapi.podLabels`                               | REST API pod labels                                                                                | `{}`                        |
| `restapi.podAnnotations`                          | REST API pod annotations                                                                           | `{}`                        |
| `restapi.podSecurityContext.enabled`              | Enable the REST API pod SecurityContext                                                            | `true`                      |
| `restapi.podSecurityContext.fsGroup`              | Group ID for the volumes of the REST API pod(s)                                                    | `1001`                      |
| `restapi.generateConfigSecurityContext.enabled`   | Enable the REST API initContainer SecurityContext                                                  | `true`                      |
| `restapi.generateConfigSecurityContext.runAsUser` | User ID for initContainer in the REST API pod(s)                                                   | `0`                         |
| `restapi.containerSecurityContext.enabled`        | Enable the REST API container SecurityContext                                                      | `true`                      |
| `restapi.containerSecurityContext.runAsUser`      | User ID for container(s) in the REST API pod(s)                                                    | `1001`                      |
| `restapi.resources.limits`                        | The resources limits for REST API containers                                                       | `{}`                        |
| `restapi.resources.requests`                      | The requested resources for REST API containers                                                    | `{}`                        |
| `restapi.livenessProbe.enabled`                   | Enable the REST API pod livenessProbe                                                              | `true`                      |
| `restapi.livenessProbe.initialDelaySeconds`       | Initial delay before the probe is initiated                                                        | `5`                         |
| `restapi.livenessProbe.periodSeconds`             | Period between probes                                                                              | `30`                        |
| `restapi.livenessProbe.timeoutSeconds`            | Time after which the probe times out                                                               | `1`                         |
| `restapi.livenessProbe.successThreshold`          | Number of successful probes before the container is considered available                           | `1`                         |
| `restapi.livenessProbe.failureThreshold`          | Number of failed probes before the container is deemed unavailable                                 | `5`                         |
| `restapi.readinessProbe.enabled`                  | Enable the REST API pod readinessProbe                                                             | `true`                      |
| `restapi.readinessProbe.initialDelaySeconds`      | Initial delay before the probe is initiated                                                        | `10`                        |
| `restapi.readinessProbe.periodSeconds`            | Period between probes                                                                              | `30`                        |
| `restapi.readinessProbe.timeoutSeconds`           | Time after which the probe times out                                                               | `1`                         |
| `restapi.readinessProbe.successThreshold`         | Number of successful probes before the container is considered ready                               | `1`                         |
| `restapi.readinessProbe.failureThreshold`         | Number of failed probes before the container is deemed unavailable                                 | `5`                         |
| `restapi.containerPorts.http`                     | REST API container port                                                                            | `9080`                      |
| `restapi.service.type`                            | Type of Service object                                                                             | `ClusterIP`                 |
| `restapi.service.portName`                        | Name of the service port                                                                           | `http`                      |
| `restapi.service.ports.http`                      | REST API service port                                                                              | `9080`                      |
| `restapi.service.nodePorts.http`                  | NodePort for the REST API service                                                                  | `""`                        |
| `restapi.service.annotations`                     | Provide any additional service annotations which may be required                                   | `{}`                        |
| `restapi.ingress.enabled`                         | Enables an Ingress (provides external access and load balancing)                                   | `false`                     |
| `restapi.ingress.annotations`                     | Provide any additional annotations which may be required for the Ingress (evaluated as a template) | `{}`                        |
| `restapi.ingress.hosts`                           | Defines the host(s) for this Ingress                                                               | `[]`                        |
| `restapi.ingress.paths.restapi.path`              | Path to be matched against incoming REST API requests (must start with a slash)                    | `/*`                        |
| `restapi.ingress.paths.restapi.pathType`          | Path matching interpretation style                                                                 | `ImplementationSpecific`    |
| `restapi.ingress.tls.enabled`                     | Enable TLS configuration settings                                                                  | `false`                     |
| `restapi.ingress.tls.hosts`                       | List of network host names contained in the TLS certificate                                        | `[]`                        |
| `restapi.ingress.tls.secretName`                  | Secret used to terminate TLS traffic                                                               | `""`                        |

### Full-Text Search (FTS) parameters

| Name                                     | Description                                                                     | Value                  |
| ---------------------------------------- | ------------------------------------------------------------------------------- | ---------------------- |
| `fts.enabled`                            | Deploy an FTS server                                                            | `false`                |
| `fts.image.registry`                     | OnDemand FTS image container registry                                           | `""`                   |
| `fts.image.repository`                   | OnDemand FTS image repository                                                   | `qar/ondemand-fts`     |
| `fts.image.tag`                          | OnDemand FTS image tag                                                          | `10.5.0.5-ubi-8.8-854` |
| `fts.image.digest`                       | OnDemand FTS image digest in the format `sha256:aa....` (overrides `image.tag`) | `""`                   |
| `fts.image.pullPolicy`                   | OnDemand FTS image pull policy                                                  | `IfNotPresent`         |
| `fts.image.pullSecrets`                  | Specify container registry Secrets as an array                                  | `[]`                   |
| `fts.exportPollDelay`                    | Full-text index export process polling/sleep interval (in seconds)              | `180`                  |
| `fts.annotations`                        | Annotations to be added to the FTS deployment (evaluated as a template)         | `{}`                   |
| `fts.labels`                             | Additional labels to be added to the FTS deployment (evaluated as a template)   | `{}`                   |
| `fts.replicaCount`                       | Number of FTS nodes to be created                                               | `1`                    |
| `fts.updateStrategy`                     | Update strategy for the FTS deployment                                          | `{}`                   |
| `fts.terminationGracePeriodSeconds`      | FTS termination grace period                                                    | `""`                   |
| `fts.podLabels`                          | FTS pod labels                                                                  | `{}`                   |
| `fts.podAnnotations`                     | FTS pod annotations                                                             | `{}`                   |
| `fts.podSecurityContext.enabled`         | Enable the FTS pod SecurityContext                                              | `true`                 |
| `fts.podSecurityContext.fsGroup`         | Group ID for the volumes of the Fts pod(s)                                      | `1001`                 |
| `fts.containerSecurityContext.enabled`   | Enable the FTS container SecurityContext                                        | `true`                 |
| `fts.containerSecurityContext.runAsUser` | User ID for container(s) in the FTS pod(s)                                      | `1001`                 |
| `fts.resources.limits`                   | The resources limits for FTS containers                                         | `{}`                   |
| `fts.resources.requests`                 | The requested resources for FTS containers                                      | `{}`                   |
| `fts.livenessProbe.enabled`              | Enable the FTS pod livenessProbe                                                | `true`                 |
| `fts.livenessProbe.initialDelaySeconds`  | Initial delay before the probe is initiated                                     | `5`                    |
| `fts.livenessProbe.periodSeconds`        | Period between probes                                                           | `30`                   |
| `fts.livenessProbe.timeoutSeconds`       | Time after which the probe times out                                            | `1`                    |
| `fts.livenessProbe.successThreshold`     | Number of successful probes before the container is considered available        | `1`                    |
| `fts.livenessProbe.failureThreshold`     | Number of failed probes before the container is deemed unavailable              | `5`                    |
| `fts.readinessProbe.enabled`             | Enable the FTS pod readinessProbe                                               | `true`                 |
| `fts.readinessProbe.initialDelaySeconds` | Initial delay before the probe is initiated                                     | `10`                   |
| `fts.readinessProbe.periodSeconds`       | Period between probes                                                           | `30`                   |
| `fts.readinessProbe.timeoutSeconds`      | Time after which the probe times out                                            | `1`                    |
| `fts.readinessProbe.successThreshold`    | Number of successful probes before the container is considered ready            | `1`                    |
| `fts.readinessProbe.failureThreshold`    | Number of failed probes before the container is deemed unavailable              | `5`                    |
| `fts.containerPorts.fts`                 | FTS container port                                                              | `9081`                 |
| `fts.service.type`                       | Type of Service object                                                          | `ClusterIP`            |
| `fts.service.portName`                   | Name of the service port                                                        | `fts`                  |
| `fts.service.ports.fts`                  | FTS service port                                                                | `9081`                 |
| `fts.service.nodePorts.fts`              | NodePort for the FTS service                                                    | `""`                   |
| `fts.service.annotations`                | Provide any additional service annotations which may be required                | `{}`                   |

### Content Navigator parameters (*Not Implemented Yet*)

| Name                | Description                       | Value   |
| ------------------- | --------------------------------- | ------- |
| `navigator.enabled` | Deploy a Content Navigator server | `false` |

### k8s-wait-for parameters

| Name                    | Description                    | Value                             |
| ----------------------- | ------------------------------ | --------------------------------- |
| `wait.image.name`       | k8s-wait-for image name        | `ghcr.io/groundnuty/k8s-wait-for` |
| `wait.image.tag`        | k8s-wait-for image tag         | `no-root-v2.0`                    |
| `wait.image.pullPolicy` | k8s-wait-for image pull policy | `IfNotPresent`                    |

## License

Copyright (c) 2023 Quadient Group AG and distributed under the MIT License. See `LICENSE` for more information.

## Acknowledgements

- [Helm](https://helm.sh)
- [Bitnami](https://bitnami.com/)
- [IBM](https://www.ibm.com/docs/en/cmofm/10.5.0)
- [k8s-wait-for](https://github.com/groundnuty/k8s-wait-for)
