# OnDemand Library Server

![Version: 0.2.2](https://img.shields.io/badge/Version-0.2.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 10.5.0.5](https://img.shields.io/badge/AppVersion-10.5.0.5-informational?style=flat-square)

A Helm chart for Kubernetes

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| autoscaling.enabled | bool | `false` | Enables the autoscaling feature. |
| autoscaling.maxReplicas | int | `3` | Defines the upper limit for the number of CMOD nodes that can be set by the autoscaling configuration. |
| autoscaling.minReplicas | int | `1` | Defines the lower limit for the number of CMOD nodes that can be set by the autoscaling configuration. |
| autoscaling.targetCPUUtilizationPercentage | int | `80` | Sets the Pod CPU usage target. |
| ingress.annotations | object | `{}` | Provide any additional annotations which may be required. |
| ingress.enabled | bool | `false` | Enables Ingress, a Kubernetes API object that provides external access and load balancing. |
| ingress.hosts[0] | object | `{"host":""}` | Defines the host(s) for this Ingress. |
| ingress.tls | list | `[]` | Defines the TLS-enabled host(s) and options. |
| livenessProbe.failureThreshold | int | `3` | Number of consecutive negative tests before declaring failure |
| livenessProbe.initialDelaySeconds | int | `2` | Initial delay before probing liveness |
| livenessProbe.periodSeconds | int | `30` | Period in seconds between liveness checks |
| livenessProbe.successThreshold | int | `1` | Number of consecutive positive tests before counting it as a success |
| livenessProbe.timeoutSeconds | int | `1` | Timeout in seconds for liveness checks |
| performInitialSetup | bool | `false` | Defines whether to create a batch job to perform initial setup processing. |
| persistence.accessModes | list | `["ReadWriteOnce"]` | PVC Access Mode for the CMOD data volume. |
| persistence.annotations | object | `{}` | Additional annotations, as required. |
| persistence.enabled | bool | `true` | Enable CMOD Library server data persistence using a PVC. |
| persistence.existingClaim | string | `""` | Name of an existing PVC to use. |
| persistence.labels | object | `{}` | Additional labels, as required. |
| persistence.mountPath | string | `"/opt/qar/data"` | The path the volume will be mounted at. |
| persistence.size | string | `"8Gi"` | PVC Storage Request for the CMOD data volume. |
| persistence.storageClass | string | `""` | If defined, storageClassName: \<storageClass\>. If set to "-", storageClassName: "", which disables dynamic provisioning. If undefined (the default) or set to null, no storageClassName spec is set, choosing the default provisioner. (gp2 on AWS, standard on GKE, AWS & OpenStack) |
| podAnnotations | object | `{}` | Provides the ability to customize the deployment using Kubernetes annotations. |
| podSecurityContext.fsGroup | int | `1001` | ref: [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#volumes-and-file-systems](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#volumes-and-file-systems). |
| podSecurityContext.runAsUser | int | `1001` | ref: [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups). |
| readinessProbe.failureThreshold | int | `3` | Number of consecutive negative tests before declaring failure |
| readinessProbe.initialDelaySeconds | int | `2` | Initial delay before probing readiness |
| readinessProbe.periodSeconds | int | `30` | Period in seconds between readiness checks |
| readinessProbe.successThreshold | int | `1` | Number of consecutive positive tests before counting it as a success |
| readinessProbe.timeoutSeconds | int | `1` | Timeout in seconds for readiness checks |
| replicaCount | int | `1` | Defines the number of replicas to be created after deployment. |
| resources | object | `{}` |  |
| role | string | `"ondemand"` | QAR component designation. |
| securityContext.allowPrivilegeEscalation | bool | `false` | ref: [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#privilege-escalation](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#privilege-escalation). |
| securityContext.capabilities | object | `{"drop":["all"]}` | The default (recommended) configuration prohibits all Linux capabilities. |
| securityContext.privileged | bool | `false` | ref: [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#privileged](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#privilege). |
| securityContext.runAsGroup | int | `1001` | ref: [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#capabilities](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#capabilities). |
| securityContext.runAsUser | int | `1001` | ref: [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups). |
| service.annotations | object | `{}` | Provide any additional annotations which may be required. |
| service.nodePorts.ondemand | string | `""` | Node port for CMOD |
| service.type | string | `"ClusterIP"` | Defines the value for the Kubernetes service object \[ClusterIP\|LoadBalancer\|NodePort\]. |
----------------------------------------------
