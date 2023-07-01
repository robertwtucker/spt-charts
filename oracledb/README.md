# Oracle Database Helm Chart

![Version: 0.1.2](https://img.shields.io/badge/Version-0.1.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 21.3.0-ee](https://img.shields.io/badge/AppVersion-21.3.0--ee-informational?style=flat-square)

This Helm chart was orginally adapted for use with the charts for
deploying Quadient's Archive and Retrieval.

## Disclaimer

This chart is for demo purpose only. It stores data in the container itself
which will be lost if the pod is re-assigned or deleted.

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

You may provision the database supporting the Oracle SOA suite domain schemas
separately, and point the chart to it by providing the database url. The database
must be accessible from the Kubernetes cluster. This is the recommended way to
deploy this chart.

If you intend on deploying the database within the kubernetes cluster (optional;
not for production), you must agree to the terms of the Oracle database Docker image:

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

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| applicationName | string | `""` | Application name to use (prefix) for chart components. |
| characterSet | string | `""` | The character set to use when creating the database (default: AL32UTF8) |
| existingServiceAccount | string | `""` | Enter the name of an existing service account to use. Otherwise, one will be created by default. |
| image.name | string | `"container-registry.oracle.com/database/express"` | Defines the URL address of the Oracle database image stored in a Docker image repository. |
| image.pullPolicy | string | `"IfNotPresent"` | Defines the Oracle database image pull policy. \[IfNotPresent\|Always\]. |
| image.tag | string | `""` | Overrides the image tag. Defaults to the chart's appVersion. |
| imagePullSecrets | list | `[]` | List of image repository pull secrets Secrets must be manually created in the namespace. ref: [https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/) Example: imagePullSecrets:   - name: myRegistryKeySecretName |
| ingress.annotations | object | `{}` | Provide any additional annotations which may be required. |
| ingress.enabled | bool | `false` | Enables Ingress, a Kubernetes API object that provides external access and load balancing. |
| ingress.hosts | list | `[{"host":""}]` | Defines the host(s) for this Ingress. |
| ingress.tls | list | `[]` | Defines the TLS-enabled host(s) and options. |
| livenessProbe.failureThreshold | int | `5` | Defines the minimum consecutive failures for the Oracle database container probe to be considered failed after having succeeded. |
| livenessProbe.initialDelaySeconds | int | `90` | Defines the delay before the Oracle database container liveness probe is initiated. |
| livenessProbe.periodSeconds | int | `10` | Defines how often to perform the Oracle database container probe. |
| livenessProbe.successThreshold | int | `1` | Defines the minimum consecutive successes for the Oracle database container probe to be considered successful after having failed. |
| livenessProbe.timeoutSeconds | int | `5` | Defines when the Oracle database container probe times out. |
| password | string | `""` | Defines (in plain text) the password of the SYS database user. Use the 'passwordSource' variable instead to define the password using a Secret. |
| passwordSource | object | `{"secretKey":"","secretName":"","useSecret":false}` | Use a Secret to define the password of the SYS database user. |
| pdb | string | `""` | The Oracle database PDB name that should be used (EE/SE default: ORCLPDB1, XE preset: XEPDB1). |
| persistence.accessModes | list | `["ReadWriteOnce"]` | PVC Access Mode for the Oracle data volume. |
| persistence.annotations | object | `{}` | Additional annotations, as required. |
| persistence.enabled | bool | `true` | Enable Oracle data persistence using a PVC. |
| persistence.existingClaim | string | `""` | Name of an existing PVC to use. |
| persistence.labels | object | `{}` | Additional labels, as required. |
| persistence.mountPath | string | `"/opt/oracle/oradata"` | The path the volume will be mounted at. |
| persistence.size | string | `"8Gi"` | PVC Storage Request for the Oracle data volume. |
| persistence.storageClass | string | `""` | If defined, storageClassName: \<storageClass\> If set to "-", storageClassName: "", which disables dynamic provisioning. If undefined (the default) or set to null, no storageClassName spec is set, choosing the default provisioner. (gp2 on AWS, standard on GKE, AWS & OpenStack) |
| podAnnotations | object | `{}` | Provides the ability to customize the deployment using Kubernetes annotations. |
| podSecurityContext.fsGroup | int | `54321` | Learn about this setting at [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#volumes-and-file-systems](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#volumes-and-file-systems). |
| podSecurityContext.runAsNonRoot | bool | `true` | Learn about this setting at [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups). |
| podSecurityContext.runAsUser | int | `54321` | Learn about this setting at [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups). |
| readinessProbe.failureThreshold | int | `5` | Defines the minimum consecutive failures for the Oracle database container probe to be considered failed after having succeeded. |
| readinessProbe.initialDelaySeconds | int | `40` | Defines the delay before the Oracle database container readiness probe is initiated. |
| readinessProbe.periodSeconds | int | `20` | Defines how often to perform the Oracle database container probe. |
| readinessProbe.successThreshold | int | `1` | Defines the minimum consecutive successes for the Oracle database container probe to be considered successful after having failed |
| readinessProbe.timeoutSeconds | int | `10` | Defines when the Oracle database container probe times out. |
| replicaCount | int | `1` | Defines the number of Oracle database nodes to be deployed at launch. |
| resources | object | `{}` |  |
| role | string | `"oracledb"` | Component designation. |
| securityContext.allowPrivilegeEscalation | bool | `false` | Learn about this setting at [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#privilege-escalation](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#privilege-escalation). |
| securityContext.capabilities | object | `{"drop":["all"]}` | The default (recommended) configuration prohibits all Linux capabilities. |
| securityContext.privileged | bool | `false` | Learn about this setting at [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#privileged](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#privileged). |
| securityContext.readOnlyRootFilesystem | bool | `false` | Learn about this setting at [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#volumes-and-file-systems](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#volumes-and-file-systems). |
| securityContext.runAsGroup | int | `54321` | Learn about this setting at [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups}(https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups). |
| securityContext.runAsUser | int | `54321` | Learn about this setting at [https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups). |
| service.annotations | object | `{}` | Provide any additional annotations which may be required. |
| service.nodePorts.emexpress | string | `""` | Node port for EM Express |
| service.nodePorts.oracledb | string | `""` | Node port for the Oracle database |
| service.type | string | `"ClusterIP"` | Defines the value for the Kubernetes service object \[ClusterIP\|LoadBalancer\]. |
| setupConfigMap | string | `""` | Name of an existing ConfigMap containing the script(s) to use for initial database setup. A non-empty value overrides any values in  `setupScriptContent`. |
| setupScriptContent | string | `""` | Script(s) to use for initial setup. |
| shmVolume.enabled | bool | `false` | Enable emptyDir volume for /dev/shm for Oracle pod(s) |
| shmVolume.sizeLimit | string | `""` | Set this to enable a size limit on the shm tmpfs. Note: the size of the tmpfs counts against container's memory limit e.g: sizeLimit: 1Gi |
| sid | string | `""` | The Oracle database SID that should be used (EE/SE default: ORCLCDB, XE preset: XE). |
| username | string | `"SYS"` | The username is always SYS unless using an Autonomous Database (change to `ADMIN`) |

## License

This Helm chart is adapted from chart published in
[Oracle's SOA Suite Github repository](https://github.com/oracle/helm-charts/tree/main/soa-suite/charts/oracledb).
As such, the original UPL v1.0 license is included.
