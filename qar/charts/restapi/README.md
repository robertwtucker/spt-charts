# OnDemand REST API Server

![Version: 0.2.4](https://img.shields.io/badge/Version-0.2.4-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 10.5.0.5](https://img.shields.io/badge/AppVersion-10.5.0.5-informational?style=flat-square)

A Helm chart for Kubernetes

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| consumerName | string | `""` | Name of the REST consumer to create for the pool. Defaults to `admin` if blank. |
| ingress.annotations | object | `{}` | Provide any additional annotations which may be required. |
| ingress.enabled | bool | `false` | Enables Ingress, a Kubernetes API object that provides external access and load balancing. |
| ingress.hosts[0] | object | `{"host":""}` | Defines the host(s) for this Ingress. |
| ingress.tls | list | `[]` | Defines the TLS-enabled host(s) and options. |
| livenessProbe.failureThreshold | int | `5` | Number of consecutive negative tests before declaring failure |
| livenessProbe.initialDelaySeconds | int | `5` | Initial delay before probing liveness |
| livenessProbe.periodSeconds | int | `30` | Period in seconds between liveness checks |
| livenessProbe.successThreshold | int | `1` | Number of consecutive positive tests before counting it as a success |
| livenessProbe.timeoutSeconds | int | `1` | Timeout in seconds for liveness checks |
| podAnnotations | object | `{}` | Provides the ability to customize the deployment using Kubernetes annotations. |
| podSecurityContext.fsGroup | int | `1001` | ref: [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#volumes-and-file-systems](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#volumes-and-file-systems). |
| podSecurityContext.runAsUser | int | `1001` | ref: [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups). |
| poolName | string | `""` | Name of the REST connection pool to create. Defaults to `odpool` if blank. |
| readinessProbe.failureThreshold | int | `5` | Number of consecutive negative tests before declaring failure |
| readinessProbe.initialDelaySeconds | int | `10` | Initial delay before probing readiness |
| readinessProbe.periodSeconds | int | `30` | Period in seconds between readiness checks |
| readinessProbe.successThreshold | int | `1` | Number of consecutive positive tests before counting it as a success |
| readinessProbe.timeoutSeconds | int | `1` | Timeout in seconds for readiness checks |
| replicaCount | int | `1` | Defines the number of replicas to be created after deployment. |
| resources | object | `{}` |  |
| role | string | `"restapi"` | QAR component designation. |
| securityContext.allowPrivilegeEscalation | bool | `false` | ref: [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#privilege-escalation](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#privilege-escalation). |
| securityContext.capabilities | object | `{"drop":["all"]}` | The default (recommended) configuration prohibits all Linux capabilities. |
| securityContext.privileged | bool | `false` | ref: [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#privileged](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#privileged). |
| securityContext.runAsGroup | int | `1001` | ref: [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#capabilities](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#capabilities). |
| securityContext.runAsUser | int | `1001` | ref: [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups). |
| service.annotations | object | `{}` | Provide any additional annotations which may be required. |
| service.nodePorts.http | string | `""` | Node port for WAS |
| service.type | string | `"ClusterIP"` | Defines the value for the Kubernetes service object \[ClusterIP\|LoadBalancer\|NodePort\]. |
----------------------------------------------
