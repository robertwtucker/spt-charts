# Inspire Scaler

![Version: 0.2.0](https://img.shields.io/badge/Version-0.2.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 15.2](https://img.shields.io/badge/AppVersion-15.2-informational?style=flat-square)

## TL;DR

```console
$ helm install test-release ./inspire/scaler
```

## Introduction

This [Helm](https://helm.sh) chart bootstraps a deployment of [Quadient](https://quadient.com)'s Inspire Scaler, cloud-enabled orchestration application for the Inspire platform.

## Prerequisites

- Kubernetes 1.21+
- Helm 3.1+
- A supported database platform
- Inspire Scaler R15.0-GA

## Installing the Chart

To install the chart with the release name `dev-release`:

```console
$ cd charts
$ helm install dev-release ./inspire/scaler
```

These commands deploy Scaler on the [Kubernetes](https://kubernetes.io) cluster in the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `dev-release` deployment:

```console
$ helm uninstall dev-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Affinity for pod assignment ref: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity NOTE: podAffinityPreset, podAntiAffinityPreset, and nodeAffinityPreset will be ignored when set |
| autoscaling.enabled | bool | `false` | Enable auto-scaling for Scaler |
| autoscaling.maxReplicas | int | `100` | Maximum number of replicas that can be deployed |
| autoscaling.minReplicas | int | `1` | Minimum number of replicas to deploy |
| autoscaling.targetCPUUtilizationPercentage | int | `80` | Target CPU utilization (percent) for each replica |
| containerPort | int | `30600` | Scaler container port |
| db.connStringAdd | string | `""` | Additional Scaler database connection string parameters |
| db.host | string | `""` | Scaler database host |
| db.name | string | `"scaler"` | Scaler database name |
| db.password | string | `""` | Scaler database password |
| db.port | int | `5432` | Scaler database port |
| db.type | string | `"PostgreSQL"` | Scaler database type Must be one of: `MicrosoftSQL` (default), `SQLAzure`, `MySQL`, `PostgreSQL`, `DB2`, `Oracle` |
| db.user | string | `""` | Scaler database user |
| existingConfigMap | string | `""` | Name of a pre-existing configmap to use (one will be created by default) |
| existingSecret | string | `""` | Name of a pre-existing secret to use (one will be created by default) |
| fullnameOverride | string | `""` | Fully override the name used for chart objects |
| icm.host | string | `""` | ICM host |
| icm.password | string | `""` | ICM password |
| icm.port | int | `30353` | ICM port |
| icm.user | string | `""` | ICM username |
| icmApiAuthenticationGroup | string | `"RestApiUser"` | Group to use for Scaler API authentication |
| image.pullPolicy | string | `"IfNotPresent"` | Scaler image pull policy |
| image.registry | string | `"registry.sptcloud.com"` | Scaler image registry |
| image.repository | string | `"inspire/scaler"` | Scaler image repository |
| image.tag | string | `"15.2.412.0-HF"` | Override tag specified by `appVersion` in the chart file |
| imagePullSecrets | list | `[]` | List of image repository pull secrets Secrets must be manually created in the namespace. ref: https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/ Example: imagePullSecrets:   - myRegistryKeySecretName |
| ingress.annotations | object | `{}` | Additional annotations for the Ingress resource. To enable certificate autogeneration, place cert-manager annotations here. For a full list of possible ingress annotations, please see ref: https://github.com/kubernetes/ingress-nginx/blob/master/docs/user-guide/nginx-configuration/annotations.md Use this parameter to set the required annotations for cert-manager, see ref: https://cert-manager.io/docs/usage/ingress/#supported-annotations e.g: annotations:   kubernetes.io/ingress.class: nginx   cert-manager.io/cluster-issuer: cluster-issuer-name |
| ingress.apiVersion | string | `""` | Force Ingress API version (automatically detected if not set) |
| ingress.enabled | bool | `false` | Enable ingress record generation for Hello |
| ingress.hostname | string | `"scaler.local"` | Default host for the ingress record |
| ingress.path | string | `"/"` | Default path for the ingress record NOTE: You may need to set this to '/*' in order to use this with ALB ingress controllers |
| ingress.pathType | string | `"ImplementationSpecific"` | Ingress path type |
| ingress.tls | bool | `false` | Enable TLS configuration for the host defined at `ingress.hostname` parameter TLS certificates will be retrieved from a TLS secret with name: `{{- printf "%s-tls" .Values.ingress.hostname }}` |
| ips.containerPort | int | `30354` | IPS container port |
| ips.image.pullPolicy | string | `"IfNotPresent"` | IPS image pull policy |
| ips.image.registry | string | `"registry.sptcloud.com"` | IPS image registry |
| ips.image.repository | string | `"inspire/ips"` | IPS image repository |
| ips.image.tag | string | `"15.2.231.0-HF"` | Override tag specified by `appVersion` in the chart file |
| ips.livenessProbe.failureThreshold | int | `10` | Number of consecutive negative tests before declaring failure |
| ips.livenessProbe.initialDelaySeconds | int | `10` | Initial delay before probing liveness |
| ips.livenessProbe.periodSeconds | int | `10` | Period in seconds between liveness checks |
| ips.livenessProbe.successThreshold | int | `1` | Number of consecutive positive tests before counting it as a success |
| ips.livenessProbe.timeoutSeconds | int | `2` | Timeout in seconds for liveness checks |
| ips.readinessProbe.failureThreshold | int | `10` | Number of consecutive negative tests before declaring failure |
| ips.readinessProbe.initialDelaySeconds | int | `10` | Initial delay before probing readiness |
| ips.readinessProbe.periodSeconds | int | `10` | Period in seconds between readiness checks |
| ips.readinessProbe.successThreshold | int | `1` | Number of consecutive positive tests before counting it as a success |
| ips.readinessProbe.timeoutSeconds | int | `2` | Timeout in seconds for readiness checks |
| ips.resources.limits | object | `{}` | Resource limits for the IPS container |
| ips.resources.requests | object | `{"cpu":"100m","memory":"512Mi"}` | Requested resources for the IPS container |
| ips.threadCount | int | `4` | Threads per IPS instance |
| license.mode | string | `"CL"` | Licensing mode |
| license.server | string | `""` | Primary license server |
| license.server2 | string | `""` | Backup license server |
| livenessProbe.failureThreshold | int | `5` | Number of consecutive negative tests before declaring failure |
| livenessProbe.initialDelaySeconds | int | `90` | Initial delay before probing liveness |
| livenessProbe.periodSeconds | int | `5` | Period in seconds between liveness checks |
| livenessProbe.successThreshold | int | `1` | Number of consecutive positive tests before counting it as a success |
| livenessProbe.timeoutSeconds | int | `5` | Timeout in seconds for liveness checks |
| nameOverride | string | `""` | Partially override the name used for chart objects |
| nodeSelector | object | `{}` |  |
| persistence.accessModes | list | `["ReadWriteOnce"]` | [array] Persistent Volume access modes |
| persistence.enabled | bool | `true` | Enable persistence using Persistent Volume Claims |
| persistence.existingClaim | string | `""` | The name of an existing PVC to use for persistence |
| persistence.size | string | `"5Gi"` | Persistent Volume size |
| persistence.storageClass | string | `""` | Persistent Volume storage class If defined, storageClassName: <storageClass> If set to "-", storageClassName: "", which disables dynamic provisioning If undefined (the default) or set to null, no storageClassName spec is set, choosing the default provisioner |
| podAnnotations | object | `{}` | Annotations for Scaler pods |
| podSecurityContext | object | `{}` |  |
| readinessProbe.failureThreshold | int | `3` | Number of consecutive negative tests before declaring failure |
| readinessProbe.initialDelaySeconds | int | `30` | Initial delay before probing readiness |
| readinessProbe.periodSeconds | int | `10` | Period in seconds between readiness checks |
| readinessProbe.successThreshold | int | `1` | Number of consecutive positive tests before counting it as a success |
| readinessProbe.timeoutSeconds | int | `5` | Timeout in seconds for readiness checks |
| replicaCount | int | `1` |  |
| resources.limits | object | `{}` | Resource limits for the Scaler container |
| resources.requests | object | `{"cpu":"500m","memory":"2Gi"}` | Requested resources for the Scaler container |
| restartPolicy | string | `"Always"` | Restart policy |
| securityContext | object | `{}` |  |
| service.nodePort | string | `""` | Nodeport to expose (`service.type` must be NodePort or LoadBalancer) |
| service.port | int | `30600` | Scaler server port |
| service.type | string | `"ClusterIP"` | Type of service to create |
| serviceAccount.annotations | object | `{}` | Annotations to use with the service account |
| serviceAccount.create | bool | `false` | Enable service account creation (will use `default` if false) |
| serviceAccount.name | string | `""` | Force the name used for the service account |
| terminationGracePeriodSeconds | int | `35` | Termination grace period (seconds) |
| tolerations | list | `[]` | Tolerations for pod assignment ref: https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/ |
| useSsl | bool | `false` | Enable use of SSL/TLS |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```console
$ helm install my-release \
  --set databaseUser=admin,databasePassword=s3cr3t inspire/scaler
```

The above command sets the Scaler database username and password to `admin` and `s3cr3t`, respectively.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```console
$ helm install my-release -f values.yaml inspire/scaler
```

> **Tip**: You can use the default `values.yaml` file and just delete the unchanged items.

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)
