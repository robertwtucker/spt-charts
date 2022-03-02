# Document Host

![Version: 0.1.10](https://img.shields.io/badge/Version-0.1.10-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.3.3](https://img.shields.io/badge/AppVersion-0.3.3-informational?style=flat-square)

## TL;DR

```console
$ helm install test-release ./docuhost
```

## Introduction

This [Helm](https://helm.sh) chart installs the Document Host (Docuhost) service used for temporarily hosting demo documents for retrieval using a generated link.

## Prerequisites

- Kubernetes 1.21+
- Helm 3.1+

## Installing the Chart

To install the chart with the release name `dev-release`:

```console
$ cd charts
$ helm install dev-release ./docuhost
```

These commands deploy Docuhost on the [Kubernetes](https://kubernetes.io) cluster in the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

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
| app.url | string | `"http://localhost/v1/documents"` | Fully-qualified URL to the documents resource (gets prepend to document ID) |
| autoscaling.enabled | bool | `false` | Enable auto-scaling for DocuHost |
| autoscaling.maxReplicas | int | `100` | Maximum number of replicas that can be deployed |
| autoscaling.minReplicas | int | `1` | Minimum number of replicas to deploy |
| autoscaling.targetCPUUtilizationPercentage | int | `80` | Target CPU utilization (percent) for each replica |
| containerPort | int | `8080` | DocuHost container port |
| db.host | string | `"localhost"` | Database host |
| db.name | string | `"docuhost"` | Database name |
| db.password | string | `""` | Database password |
| db.port | int | `27017` | Database port |
| db.prefix | string | `"mongodb"` | Database prefix (identifies standard connection format for URI creation) |
| db.timeout | int | `10` | Database connection timeout (seconds) |
| db.username | string | `""` | Database user |
| existingConfigMap | string | `""` | Name of a pre-existing configmap to use (one will be created by default) |
| existingSecret | string | `""` | Name of a pre-existing secret to use (one will be created by default) |
| fullnameOverride | string | `""` | Fully override the name used for chart objects |
| image.pullPolicy | string | `"IfNotPresent"` | DocuHost image pull policy |
| image.repository | string | `"registry.sptcloud.com/spt/docuhost"` | DocuHost image repository |
| image.tag | string | `"0.3.3-916bdea"` | Override tag specified by `appVersion` in the chart file |
| imagePullSecrets | list | `[]` | List of image repository pull secrets Secrets must be manually created in the namespace. ref: https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/ Example: imagePullSecrets:   - name: myRegistryKeySecretName |
| ingress.annotations | object | `{}` | Additional annotations for the Ingress resource. To enable certificate autogeneration, place cert-manager annotations here. For a full list of possible ingress annotations, please see ref: https://github.com/kubernetes/ingress-nginx/blob/master/docs/user-guide/nginx-configuration/annotations.md Use this parameter to set the required annotations for cert-manager, see ref: https://cert-manager.io/docs/usage/ingress/#supported-annotations e.g: annotations:   kubernetes.io/ingress.class: nginx   cert-manager.io/cluster-issuer: cluster-issuer-name |
| ingress.apiVersion | string | `""` | Force Ingress API version (automatically detected if not set) |
| ingress.enabled | bool | `false` | Enable ingress record generation for Hello |
| ingress.hostname | string | `"docuhost.local"` | Default host for the ingress record |
| ingress.path | string | `"/"` | Default path for the ingress record NOTE: You may need to set this to '/*' in order to use this with ALB ingress controllers |
| ingress.pathType | string | `"ImplementationSpecific"` | Ingress path type |
| ingress.tls | bool | `false` | Enable TLS configuration for the host defined at `ingress.hostname` parameter TLS certificates will be retrieved from a TLS secret with name: `{{- printf "%s-tls" .Values.ingress.hostname }}` |
| livenessProbe.failureThreshold | int | `3` | Number of consecutive negative tests before declaring failure |
| livenessProbe.initialDelaySeconds | int | `2` | Initial delay before probing liveness |
| livenessProbe.periodSeconds | int | `10` | Period in seconds between liveness checks |
| livenessProbe.successThreshold | int | `1` | Number of consecutive positive tests before counting it as a success |
| livenessProbe.timeoutSeconds | int | `1` | Timeout in seconds for liveness checks |
| log.debug | bool | `false` | Use debug log settings |
| log.format | string | `"text"` | Log output format [text|json] |
| nameOverride | string | `""` | Partially override the name used for chart objects |
| nodeSelector | object | `{}` | Node labels for pod assignment |
| podAnnotations | object | `{}` | Annotations for DocuHost pods |
| podSecurityContext | object | `{"fsGroup":11000,"runAsNonRoot":true,"runAsUser":11000}` | Configure DocuHost pod security context ref: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-pod |
| podSecurityContext.fsGroup | int | `11000` | ref: https://kubernetes.io/docs/concepts/policy/pod-security-policy/#volumes-and-file-systems. |
| podSecurityContext.runAsNonRoot | bool | `true` | ref: https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups. |
| podSecurityContext.runAsUser | int | `11000` | ref: https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups. |
| readinessProbe.failureThreshold | int | `3` | Number of consecutive negative tests before declaring failure |
| readinessProbe.initialDelaySeconds | int | `2` | Initial delay before probing readiness |
| readinessProbe.periodSeconds | int | `30` | Period in seconds between readiness checks |
| readinessProbe.successThreshold | int | `1` | Number of consecutive positive tests before counting it as a success |
| readinessProbe.timeoutSeconds | int | `1` | Timeout in seconds for readiness checks |
| replicaCount | int | `1` | Number of DocuHost containers to deploy |
| resources.limits | object | `{}` | Resource limits for the DocuHost container |
| resources.requests | object | `{"cpu":"100m","memory":"256Mi"}` | Requested resources for the DocuHost container |
| securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["all"]},"privileged":false,"runAsUser":11000}` | Configure security context ref: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-container |
| securityContext.allowPrivilegeEscalation | bool | `false` | ref: https://kubernetes.io/docs/concepts/policy/pod-security-policy/#privilege-escalation. |
| securityContext.capabilities | object | `{"drop":["all"]}` | The default (recommended) configuration prohibits all Linux capabilities. |
| securityContext.privileged | bool | `false` | ref: https://kubernetes.io/docs/concepts/policy/pod-security-policy/#privileged. |
| securityContext.runAsUser | int | `11000` | ref: https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups. |
| server.port | int | `8080` | Port to listen on (must match containerPort) |
| server.timeout | int | `20` | Time (in seconds) to wait before initiating shutdown or terminating read/write ops |
| service.nodeport | string | `""` | Nodeport to expose (type must be NodePort or LoadBalancer) |
| service.port | int | `8080` | DocuHost server port |
| service.type | string | `"ClusterIP"` | Type of service to create |
| serviceAccount.annotations | object | `{}` | Annotations to use with the service account |
| serviceAccount.create | bool | `false` | Enable service account creation (will use `default` if false) |
| serviceAccount.name | string | `""` | Force the name used for the service account |
| shortlink.apikey | string | `""` | API Key to use for authorization |
| shortlink.domain | string | `"tiny.one"` | Domain name to use for short links |
| tolerations | list | `[]` | Tolerations for pod assignment ref: https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/ |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```console
$ helm install my-release \
  --set db.user=admin,db.password=s3cr3t docuhost
```

The above command sets the Docuhost database username and password to `admin` and `s3cr3t`, respectively.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```console
$ helm install my-release -f values.yaml docuhost
```

> **Tip**: You can use the default `values.yaml` file and just delete the unchanged items.

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.7.0](https://github.com/norwoodj/helm-docs/releases/v1.7.0)
