# ARSLOAD Server

![Version: 0.2.2](https://img.shields.io/badge/Version-0.2.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 10.5.0.5](https://img.shields.io/badge/AppVersion-10.5.0.5-informational?style=flat-square)

A Helm chart for Kubernetes

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| instances | string | `nil` | List of arsload deployment instances (one replica per input volume). |
| livenessProbe.failureThreshold | int | `5` | Number of consecutive negative tests before declaring failure |
| livenessProbe.initialDelaySeconds | int | `5` | Initial delay before probing liveness |
| livenessProbe.periodSeconds | int | `30` | Period in seconds between liveness checks |
| livenessProbe.successThreshold | int | `1` | Number of consecutive positive tests before counting it as a success |
| livenessProbe.timeoutSeconds | int | `1` | Timeout in seconds for liveness checks |
| podAnnotations | object | `{}` | Provides the ability to customize the deployment using Kubernetes annotations. |
| podSecurityContext.fsGroup | int | `1001` | ref: [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#volumes-and-file-systems](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#volumes-and-file-systems). |
| podSecurityContext.runAsUser | int | `1001` | ref: [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups). |
| readinessProbe.failureThreshold | int | `5` | Number of consecutive negative tests before declaring failure |
| readinessProbe.initialDelaySeconds | int | `10` | Initial delay before probing readiness |
| readinessProbe.periodSeconds | int | `30` | Period in seconds between readiness checks |
| readinessProbe.successThreshold | int | `1` | Number of consecutive positive tests before counting it as a success |
| readinessProbe.timeoutSeconds | int | `1` | Timeout in seconds for readiness checks |
| resources | object | `{}` |  |
| role | string | `"arsload"` | QAR component designation. |
| securityContext.allowPrivilegeEscalation | bool | `false` | ref: [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#privilege-escalation](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#privilege-escalation). |
| securityContext.capabilities | object | `{"drop":["all"]}` | The default (recommended) configuration prohibits all Linux capabilities. |
| securityContext.privileged | bool | `false` | ref: [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#privileged](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#privileged). |
| securityContext.runAsGroup | int | `1001` | ref: [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#capabilities](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#capabilities). |
| securityContext.runAsUser | int | `1001` | ref: [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups). |
| timeInterval | int | `600` | Time interval in seconds to sleep (the `arsload` command itself defaults to 600) |
----------------------------------------------
