# Document Host

![Version badge](https://img.shields.io/badge/dynamic/yaml?url=https%3A%2F%2Fraw.githubusercontent.com%2Frobertwtucker%2Fspt-charts%2Fmaster%2Fdocuhost%2FChart.yaml&query=%24.version&label=Version)
![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)
![AppVersion badge](https://img.shields.io/badge/dynamic/yaml?url=https%3A%2F%2Fraw.githubusercontent.com%2Frobertwtucker%2Fspt-charts%2Fmaster%2Fdocuhost%2FChart.yaml&query=%24.appVersion&label=AppVersion&link=https%3A%2F%2Fgithub.com%2Frobertwtucker%2Fdocument-host)

## TL;DR

```console
helm install test-release ./docuhost
```

## Introduction

This [Helm](https://helm.sh) chart installs the Document Host (Docuhost)
service used for temporarily hosting demo documents for retrieval using a
generated link.

## Prerequisites

- Kubernetes 1.21+
- Helm 3.1+

## Installing the Chart

To install the chart with the release name `dev-release`:

```console
cd charts
helm install dev-release ./docuhost
```

These commands deploy Docuhost on the [Kubernetes](https://kubernetes.io)
cluster in the default configuration. The [Parameters](#parameters) section
lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `dev-release` deployment:

```console
helm uninstall dev-release
```

The command removes all the Kubernetes components associated with the chart and
deletes the release.

## Parameters

### Document Host (DocuHost) parameters

| Name                   | Description                                                                             | Value                                |
| ---------------------- | --------------------------------------------------------------------------------------- | ------------------------------------ |
| `image.repository`     | DocuHost image repository                                                               | `registry.sptcloud.com/spt/docuhost` |
| `image.tag`            | DocuHost image tag                                                                      | `""`                                 |
| `image.pullPolicy`     | DocuHost image pull policy                                                              | `IfNotPresent`                       |
| `imagePullSecrets`     | Specify container registry Secrets as an array                                          | `[]`                                 |
| `app.env`              | Environment in which the application is running (usually `development` or `production`) | `development`                        |
| `app.url`              | Fully-qualified URL to the `documents` resource (gets prepend to document ID)           | `http://localhost/api/v2/documents`  |
| `auth.secret`          | Secret used to encode the JWT and encrypt things in transit                             | `""`                                 |
| `auth.trustHost`       | When set, tells Auth.js to trust the `X-Forwarded-Host` header from a reverse proxy     | `false`                              |
| `auth.auth0.audience`  | Audience for scope assigned to token                                                    | `urn:docuhost`                       |
| `auth.auth0.id`        | Auth0 Client ID for this application                                                    | `""`                                 |
| `auth.auth0.secret`    | Auth0 Client Secret for this application                                                | `""`                                 |
| `auth.auth0.issuer`    | Domain associated with the Auth0 account                                                | `""`                                 |
| `db.username`          | Database user's name                                                                    | `docuhost`                           |
| `db.password`          | Database user's password                                                                | `""`                                 |
| `db.protocol`          | Database protocol (usually `mongodb` or `mongodb+srv`)                                  | `mongodb`                            |
| `db.host`              | Database host name                                                                      | `localhost`                          |
| `db.port`              | Database port (can be left empty to use mongodb's default of `27017`)                   | `""`                                 |
| `db.name`              | Database name                                                                           | `documents`                          |
| `shortlink.apiKey`     | API Key to use for authorization                                                        | `""`                                 |
| `shortlink.domain`     | Domain name to use for short links                                                      | `tinyurl.com`                        |
| `shortlink.serviceUrl` | URL to use for short link service                                                       | `https://api.tinyurl.com`            |
| `nameOverride`         | Partially override the name used for chart objects                                      | `""`                                 |
| `fullnameOverride`     | Fully override the name used for chart objects                                          | `""`                                 |
| `existingConfigMap`    | Name of a pre-existing configmap to use (if blank, one will be created by default)      | `""`                                 |
| `existingSecret`       | Name of a pre-existing secret to use (if blank, one will be created by default)         | `""`                                 |

### DocuHost deployment parameters

| Name                                            | Description                                                                     | Value   |
| ----------------------------------------------- | ------------------------------------------------------------------------------- | ------- |
| `replicaCount`                                  | Number of DocuHost containers to deploy                                         | `1`     |
| `serviceAccount.create`                         | Enable service account creation (otherwise, the `default` account will be used) | `false` |
| `serviceAccount.annotations`                    | Annotations to use with the service account                                     | `{}`    |
| `serviceAccount.name`                           | Specify the name used for the service account                                   | `""`    |
| `podAnnotations`                                | Annotations for DocuHost pods                                                   | `{}`    |
| `podSecurityContext.fsGroup`                    | Group ID for the volumes of the DocuHost pod(s)                                 | `1001`  |
| `securityContext.runAsUser`                     | User ID for container(s) in the Docuhost pod(s)                                 | `1001`  |
| `resources.limits`                              | The resources limits for DocuHost containers                                    | `{}`    |
| `resources.requests`                            | The requested resources for DocuHost containers                                 | `{}`    |
| `nodeSelector`                                  | Node labels for pod assignment                                                  | `{}`    |
| `tolerations`                                   | Tolerations for pod assignment                                                  | `[]`    |
| `affinity`                                      | Affinity for pod assignment                                                     | `{}`    |
| `containerPort`                                 | DocuHost container port                                                         | `3000`  |
| `livenessProbe.initialDelaySeconds`             | Initial delay before the probe is initiated                                     | `2`     |
| `livenessProbe.periodSeconds`                   | Period between probes                                                           | `10`    |
| `livenessProbe.timeoutSeconds`                  | Time after which the probe times out                                            | `1`     |
| `livenessProbe.failureThreshold`                | Number of failed probes before the container is deemed unavailable              | `3`     |
| `livenessProbe.successThreshold`                | Number of successful probes before the container is considered available        | `1`     |
| `readinessProbe.initialDelaySeconds`            | Initial delay before the probe is initiated                                     | `2`     |
| `readinessProbe.periodSeconds`                  | Period between probes                                                           | `30`    |
| `readinessProbe.timeoutSeconds`                 | Time after which the probe times out                                            | `1`     |
| `readinessProbe.failureThreshold`               | Number of failed probes before the container is deemed unavailable              | `3`     |
| `readinessProbe.successThreshold`               | Number of successful probes before the container is considered ready            | `1`     |
| `autoscaling.enabled`                           | Enable auto-scaling for DocuHost                                                | `false` |
| `autoscaling.minReplicas`                       | Minimum number of replicas to deploy                                            | `1`     |
| `autoscaling.maxReplicas`                       | Maximum number of replicas that can be deployed                                 | `100`   |
| `autoscaling.targetCPUUtilizationPercentage`    | Target CPU utilization (percent) for each replica                               | `80`    |
| `autoscaling.targetMemoryUtilizationPercentage` | Target memory utilization (percent) for each replica                            | `80`    |

### Traffic exposure parameters

| Name                  | Description                                                                       | Value                    |
| --------------------- | --------------------------------------------------------------------------------- | ------------------------ |
| `service.type`        | Type of service to create                                                         | `ClusterIP`              |
| `service.port`        | DocuHost server port                                                              | `3000`                   |
| `service.nodeport`    | Nodeport to expose (type must be NodePort or LoadBalancer)                        | `""`                     |
| `ingress.enabled`     | Enable ingress record generation for Hello                                        | `false`                  |
| `ingress.pathType`    | Ingress path type                                                                 | `ImplementationSpecific` |
| `ingress.apiVersion`  | Force Ingress API version (automatically detected if not set)                     | `""`                     |
| `ingress.hostname`    | Default host for the ingress record                                               | `docuhost.local`         |
| `ingress.path`        | Default path for the ingress record                                               | `/`                      |
| `ingress.annotations` | Default/additional annotations for the ingress record                             | `{}`                     |
| `ingress.tls`         | Enable TLS configuration for the host defined by the `ingress.hostname` parameter | `false`                  |

### k8s-wait-for parameters

| Name                    | Description                    | Value                             |
| ----------------------- | ------------------------------ | --------------------------------- |
| `wait.image.name`       | k8s-wait-for image name        | `ghcr.io/groundnuty/k8s-wait-for` |
| `wait.image.tag`        | k8s-wait-for image tag         | `no-root-v2.0`                    |
| `wait.image.pullPolicy` | k8s-wait-for image pull policy | `IfNotPresent`                    |

## License

Copyright (c) 2022 Quadient Group AG and distributed under the MIT License. See `LICENSE` for more information.

## Acknowledgements

- [Helm](https://helm.sh)
- [Bitnami](https://bitnami.com/)
