# Inspire ICM

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 15.0.644.0-GA](https://img.shields.io/badge/AppVersion-15.0.644.0--GA-informational?style=flat-square)

## TL;DR

```console
$ helm install test-release ./inspire/icm
```

## Introduction

This [Helm](https://helm.sh) chart bootstraps a deployment of [Quadient](https://quadient.com)'s Inspire Content Mangager (ICM), an application that manages workflows, native files and resources by saving their version history to a database.

## Prerequisites

- Kubernetes 1.21+
- Helm 3.1+
- A supported database platform
- Inspire Designer (ICM) R15.0-GA

## Installing the Chart

To install the chart with the release name `dev-release`:

```console
$ cd charts
$ helm install dev-release ./inspire/icm
```

These commands deploy ICM on the [Kubernetes](https://kubernetes.io) cluster in the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `dev-release` deployment:

```console
$ helm uninstall dev-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalParams | string | `"-enablehttpconnections"` | Additional parameters for the ICM command |
| affinity | object | `{}` | Affinity for pod assignment ref: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity NOTE: podAffinityPreset, podAntiAffinityPreset, and nodeAffinityPreset will be ignored when set |
| autoscaling.enabled | bool | `false` | Enable auto-scaling for ICM |
| autoscaling.maxReplicas | int | `100` | Maximum number of replicas that can be deployed |
| autoscaling.minReplicas | int | `1` | Minimum number of replicas to deploy |
| autoscaling.targetCPUUtilizationPercentage | int | `80` | Target CPU utilization (percent) for each replica |
| containerPorts.http | int | `8080` | External ICM http port |
| containerPorts.icm | int | `30353` | ICM service port |
| fullnameOverride | string | `""` | Fully override the name used for chart objects |
| icmDatabaseConnStringAdd | string | `""` | Additional ICM database connection string parameters |
| icmDatabaseHost | string | `"postgresql"` | ICM database host |
| icmDatabaseName | string | `"icm"` | ICM database name |
| icmDatabasePassword | string | `""` | ICM database password |
| icmDatabasePort | string | `"5432"` | ICM database port |
| icmDatabaseType | string | `"PostgreSQL"` | ICM database type Must be one of: `MicrosoftSQL` (default), `SQLAzure`, `MySQL`, `PostgreSQL`, `DB2`, `Oracle` |
| icmDatabaseUser | string | `""` | ICM database user |
| image.pullPolicy | string | `"IfNotPresent"` | ICM image pull policy |
| image.pullSecrets | list | `[]` | ICM image pull secrets |
| image.registry | string | `"registry.sptcloud.com"` | ICM image registry |
| image.repository | string | `"inspire/icm"` | ICM image repository |
| image.tag | string | `"15.0.644.0-GA-postgresql"` | Override tag specified by `appVersion` in the chart file |
| ingress.annotations | object | `{}` | Additional annotations for the Ingress resource. To enable certificate autogeneration, place cert-manager annotations here. For a full list of possible ingress annotations, please see ref: https://github.com/kubernetes/ingress-nginx/blob/master/docs/user-guide/nginx-configuration/annotations.md Use this parameter to set the required annotations for cert-manager, see ref: https://cert-manager.io/docs/usage/ingress/#supported-annotations e.g: annotations:   kubernetes.io/ingress.class: nginx   cert-manager.io/cluster-issuer: cluster-issuer-name |
| ingress.apiVersion | string | `""` | Force Ingress API version (automatically detected if not set) |
| ingress.enabled | bool | `false` | Enable ingress record generation for Hello |
| ingress.hostname | string | `"icm.local"` | Default host for the ingress record |
| ingress.path | string | `"/"` | Default path for the ingress record NOTE: You may need to set this to '/*' in order to use this with ALB ingress controllers |
| ingress.pathType | string | `"ImplementationSpecific"` | Ingress path type |
| ingress.tls | bool | `false` | Enable TLS configuration for the host defined at `ingress.hostname` parameter TLS certificates will be retrieved from a TLS secret with name: `{{- printf "%s-tls" .Values.ingress.hostname }}` |
| inspireLicense | string | `"CL"` |  |
| inspireLicenseServer | string | `""` | Inspire license server |
| livenessProbe.initialDelaySeconds | int | `5` | Initial delay before probing liveness |
| livenessProbe.periodSeconds | int | `10` | Period in seconds between liveness checks |
| livenessProbe.timeoutSeconds | int | `2` | Timeout in seconds for liveness checks |
| nameOverride | string | `""` | Partially override the name used for chart objects |
| nodeSelector | object | `{}` | Node labels for pod assignment |
| podAnnotations | object | `{}` | Annotations for ICM pods |
| podSecurityContext | object | `{}` | Configure ICM pod security context ref: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-pod |
| readinessProbe.initialDelaySeconds | int | `5` | Initial delay before probing readiness |
| readinessProbe.periodSeconds | int | `10` | Period in seconds between readiness checks |
| readinessProbe.timeoutSeconds | int | `2` | Timeout in seconds for readiness checks |
| replicaCount | int | `1` | Number of ICM containers to deploy |
| resources.limits | object | `{}` | Resource limits for the ICM container |
| resources.requests | object | `{"cpu":"100m","memory":"512Mi"}` | Requested resources for the ICM container |
| securityContext | object | `{}` | Configure security context (main ICM container only) ref: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-container |
| service.http | int | `8080` | HTTP(s) access port for ICM |
| service.icm | int | `30353` | ICM server port |
| service.nodePorts | object | `{"http":"","icm":""}` | Nodeports to expose (NodePort or LoadBalancer) |
| service.type | string | `"ClusterIP"` | Type of service to create |
| serviceAccount.annotations | object | `{}` | Annotations to use with the service account |
| serviceAccount.create | bool | `false` | Enable service account creation (will use `default` if false) |
| serviceAccount.name | string | `""` | Force the name used for the service account |
| tolerations | list | `[]` | Tolerations for pod assignment ref: https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/ |
| useExistingConfigMap | string | `""` | Name of a pre-existing configmap to use (one will be created by default) |
| useExistingSecret | string | `""` | Name of a pre-existing secret to use (one will be created by default) |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```console
$ helm install my-release \
  --set icmDatabaseUser=admin,icmDatabasePassword=s3cr3t inspire/icm
```

The above command sets the ICM database username and password to `admin` and `s3cr3t`, respectively.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```console
$ helm install my-release -f values.yaml inspire/icm
```

> **Tip**: You can use the default `values.yaml` file and just delete the unchanged items.

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)