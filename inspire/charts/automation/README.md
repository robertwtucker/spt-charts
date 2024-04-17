# automation

![Version: 2.3.0](https://img.shields.io/badge/Version-2.3.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 16.4](https://img.shields.io/badge/AppVersion-16.4-informational?style=flat-square)

Inspire Automation

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| image.name | string | `""` | Defines the URL address of the Automation image stored in a Docker image repository. |
| image.tag | string | `""` | Defines a specific version of the Automation image to be deployed. |
| image.pullPolicy | string | `"IfNotPresent"` | Defines the Automation image pull policy. [IfNotPresent/Always] |
| volumes | list | `[]` | Defines an array of volumes to be mounted to the Automation pod. For example, you may need to mount a Container Storage Interface (CSI) volume to pass Secrets to Kubernetes from an external secret management system (e.g. AWS Secrets Manager). |
| activateVolumes | object | `{"enabled":false,"volumes":[{"name":"my-csi-storage"}]}` | Creates an Init Container that will mount the given volumes to the application pod. It also instructs the CSI driver to create Kubernetes Secrets from Secrets stored in external storage (e.g. AWS Secrets Manager). It uses the 'SecretProviderClass' definition to manage the Secret synchronization. |
| activateVolumes.enabled | bool | `false` | Defines whether or not to create the Init Container. |
| activateVolumes.volumes | list | `[{"name":"my-csi-storage"}]` | Defines an array of volumes to be mounted. |
| iaServerName | string | `"automation"` | Specifies the server custom name. |
| maxJavaHeap | string | `"4096M"` | Specifies the maximum amount of Inspire Automation´s heap memory. |
| actionLogRetentionPeriod | int | `2419200` | Specifies (in seconds) the retention time for user action logs. Every 500th time a log is recorded, old logs are deleted. |
| log4paRetentionPeriod | int | `2419200` | Specifies (in seconds) the retention time for log4pa logs. Every 500th time a log is recorded, old logs are deleted. |
| deltaTimeAfterCompletion | int | `1800` | Specifies (in seconds) the default time to keep successfully completed jobs. |
| retentionPeriodAfterError | int | `3600` | Specifies (in seconds) the default time to keep completed jobs with errors. |
| logAsJson | bool | `true` | Available since the 16.0 SP1 version (except for the 16.2 version) of Automation. Specifies if the Inspire Automation server should output logs to console in JSON format. |
| customLoggerConfigContent | string | `""` | Available since the 16.0 SP1 version (except for the 16.2 version) of Automation. Specifies custom logger configuration for the Inspire Automation server to use. |
| db.host | string | `""` | Defines the hostname of the server that runs the database. |
| db.port | string | `""` | Defines the port of the server that runs the database. |
| db.user | string | `""` | Defines (in plain text) the username of the database user. Use the 'userSource' variable instead if you wish to define the username using a Secret. |
| db.userSource | object | `{"secretKey":"","secretName":"","useSecret":false}` | Uses a Secret to define the username of the database user. |
| db.pass | string | `""` | Defines (in plain text) the password of the database user. Use the 'passSource' variable instead if you wish to define the password using a Secret. |
| db.passSource | object | `{"secretKey":"","secretName":"","useSecret":false}` | Uses a Secret to define the password of the database user. |
| db.driverClass | string | `""` | Specifies the driver class name for the database connection. |
| db.driver | string | `""` | Specifies the path to JDBC driver. |
| db.name | string | `""` | Defines the name of an existing database that will be used. |
| db.type | string | `""` | Defines the type of your database. [Oracle Thin/MySQL/MSSQL/PostgreSQL] |
| db.connectionURL | string | `""` | Specifies a custom database connection string. Do not include the user credentials in the connection string. |
| securityStorageType | string | `"icm"` | Specifies the method of assigning user security to the deployed Inspire Automation server. The only possible value is "icm". |
| securityIcmAdministratorGroup | string | `""` | Specifies the name of the ICM group to be used for the administrator role in Inspire Automation. |
| shutdownTimeout | int | `90` | Defines how long (in seconds) Kubernetes should wait before shutting down the pod. |
| existingServiceAccount | string | `""` | A custom service account that runs the Automation pod. Also, you may need to create a service account when passing Secrets to Kubernetes from an external secret management system. In such a case, the service account must have the permissions to access the external system (e.g. AWS Secrets Manager). |
| role | string | `"automation"` | Internal parameter |
| workingDirectory.storageClass | string | `""` | Defines the name of the storage class that you have prepared as a prerequisite. Optional if an existing claim is used. |
| workingDirectory.size | string | `"15Gi"` | Defines the size (in gigabytes) the storage will be created with. |
| workingDirectory.existingClaim | string | `""` | Defines the name of an existing persistent volume claim. |
| ips.enabled | bool | `true` | Defines whether or not to create Ips pod |
| ips.ipsCount | int | `1` | Defines the number of IPS images (i.e. nodes) to be deployed at launch. |
| ips.image.name | string | `""` | Defines the URL address of the IPS image stored in a Docker image repository. |
| ips.image.tag | string | `""` | Defines a specific version of the IPS image to be deployed. |
| ips.image.pullPolicy | string | `"IfNotPresent"` | Defines the IPS image pull policy. [IfNotPresent/Always] |
| ips.threadcount | int | `4` | Defines the number of processing threads to assign to Automation's IPS. |
| ips.customEnvs | object | `{}` | Allows you to specify custom environment variables for the IPS container. |
| ips.addParams | string | `""` | Defines optional IPS commands for running as an application. |
| ips.configFileContent | string | `""` | Defines a configuration to be created in the inspireproductionserver.config file. For example: <AllowedDirectories>/opt/localStorage;/opt/sharedFolder;icm://</AllowedDirectories><ForbidLocalWebRequests>1</ForbidLocalWebRequests> |
| ips.role | string | `"ips"` | Internal parameter |
| ips.automationPodAffinity | bool | `true` | Schedule an IPS pod on the same node as Automation pod for better performance. |
| ips.resources.requests.cpu | int | `2` | Specifies the number of CPUs that a container requests within its Kubernetes pod. Kubernetes uses CPU requests to find a machine that best fits the container. It defines a minimum number of CPUs that the container may consume. If there is no contention for CPU, it may use as many CPUs as is available on the machine. If there is CPU contention on the machine, CPU requests provide a relative weight across all containers on the system for how much CPU time the container may use. |
| ips.resources.requests.memory | string | `"3Gi"` | Specifies the amount of memory required for a container to run. Even though each container is able to consume as much memory on the machine as possible, this parameter improves placement of pods in the cluster. Kubernetes then takes available memory into account prior to binding your pod to a machine. |
| ips.resources.limits.cpu | int | `2` | Defines the number of CPUs that an IPS container is limited to use within its Kubernetes pod. CPU limits are used to control the maximum number of CPUs that the container may use independent of contention on the machine. If a container attempts to use more than the specified limit, the system will throttle the container. This allows your container to have a consistent level of service independent of the number of pods on the machine. |
| ips.resources.limits.memory | string | `"3Gi"` | Defines the amount of memory an IPS container is limited to use. If the container exceeds the specified memory limit, it will be terminated and potentially restarted depending on the container restart policy. |
| ips.podSecurityContext.runAsUser | int | `1001` | Learn about this setting at https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-pod. |
| ips.podSecurityContext.fsGroup | int | `1001` | Learn about this setting at https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-pod. |
| ips.podSecurityContext.runAsNonRoot | bool | `true` | Learn about this setting at https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-pod. |
| ips.podSecurityContext.seccompProfile | object | `{"type":"RuntimeDefault"}` | Learn about this setting at https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-seccomp-profile-for-a-container. |
| ips.securityContext.readOnlyRootFilesystem | bool | `true` | Learn about this setting at https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-container. |
| ips.securityContext.privileged | bool | `false` | Learn about this setting at https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-container. |
| ips.securityContext.allowPrivilegeEscalation | bool | `false` | Learn about this setting at https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-container. |
| ips.securityContext.runAsUser | int | `1001` | Learn about this setting at https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-container. |
| ips.securityContext.runAsGroup | int | `1001` | Learn about this setting at https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-container. |
| ips.securityContext.capabilities | object | `{"drop":["ALL"]}` | Learn about this setting at https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-capabilities-for-a-container. The default (recommended) configuration prohibits all Linux capabilities. |
| ips.livenessProbe | object | `{"failureThreshold":5,"initialDelaySeconds":120,"periodSeconds":5,"successThreshold":1,"timeoutSeconds":5}` | Learn about liveness probes at https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/. Learn about the probe's configuration settings at https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#configure-probes. |
| ips.livenessProbe.initialDelaySeconds | int | `120` | Defines the delay before the IPS container liveness probe is initiated. |
| ips.livenessProbe.periodSeconds | int | `5` | Defines how often to perform the IPS container probe. |
| ips.livenessProbe.timeoutSeconds | int | `5` | Defines when the IPS container probe times out. |
| ips.livenessProbe.failureThreshold | int | `5` | Defines the minimum consecutive failures for the  container probe to be considered failed after having succeeded. |
| ips.livenessProbe.successThreshold | int | `1` | Defines the minimum consecutive successes for the IPS container probe to be considered successful after having failed. |
| ips.readinessProbe | object | `{"failureThreshold":3,"initialDelaySeconds":30,"periodSeconds":10,"successThreshold":1,"timeoutSeconds":5}` | Learn about readiness probes at https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/. Learn about the probe's configuration settings at https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#configure-probes. |
| ips.readinessProbe.initialDelaySeconds | int | `30` | Defines the delay before the IPS container readiness probe is initiated. |
| ips.readinessProbe.periodSeconds | int | `10` | Defines how often to perform the IPS container probe. |
| ips.readinessProbe.timeoutSeconds | int | `5` | Defines when the IPS container probe times out. |
| ips.readinessProbe.failureThreshold | int | `3` | Defines the minimum consecutive failures for the IPS container probe to be considered failed after having succeeded. |
| ips.readinessProbe.successThreshold | int | `1` | Defines the minimum consecutive successes for the IPS container probe to be considered successful after having failed |
| ips.service.annotations | object | `{}` | Provide any additional annotations which may be required. |
| ips.statefulset.annotations | object | `{}` | Provides the ability to customize IPS's deployment using Kubernetes annotations. |
| ips.podLabels | object | `{}` | Additional labels for IPS pods |
| podSecurityContext.runAsUser | int | `1001` | Learn about this setting at https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-pod. |
| podSecurityContext.fsGroup | int | `1001` | Learn about this setting at https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-pod. |
| podSecurityContext.runAsNonRoot | bool | `true` | Learn about this setting at https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-pod. |
| podSecurityContext.seccompProfile | object | `{"type":"RuntimeDefault"}` | Learn about this setting at https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-seccomp-profile-for-a-container. |
| securityContext.readOnlyRootFilesystem | bool | `true` | Learn about this setting at https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-container. |
| securityContext.privileged | bool | `false` | Learn about this setting at https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-container. |
| securityContext.allowPrivilegeEscalation | bool | `false` | Learn about this setting at https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-container. |
| securityContext.runAsUser | int | `1001` | Learn about this setting at https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-container. |
| securityContext.runAsGroup | int | `1001` | Learn about this setting at https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-container. |
| securityContext.capabilities | object | `{"drop":["ALL"]}` | Learn about this setting at https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-capabilities-for-a-container. The default (recommended) configuration prohibits all Linux capabilities. |
| livenessProbe | object | `{"failureThreshold":5,"initialDelaySeconds":120,"periodSeconds":5,"successThreshold":1,"timeoutSeconds":5}` | Learn about liveness probes at https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/. Learn about the probe's configuration settings at https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#configure-probes. |
| livenessProbe.initialDelaySeconds | int | `120` | Defines the delay before the Automation container liveness probe is initiated. |
| livenessProbe.periodSeconds | int | `5` | Defines how often to perform the Automation container probe. |
| livenessProbe.timeoutSeconds | int | `5` | Defines when the Automation container probe times out. |
| livenessProbe.failureThreshold | int | `5` | Defines the minimum consecutive failures for the  container probe to be considered failed after having succeeded. |
| livenessProbe.successThreshold | int | `1` | Defines the minimum consecutive successes for the Automation container probe to be considered successful after having failed. |
| readinessProbe | object | `{"failureThreshold":3,"initialDelaySeconds":30,"periodSeconds":10,"successThreshold":1,"timeoutSeconds":5}` | Learn about readiness probes at https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/. Learn about the probe's configuration settings at https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#configure-probes. |
| readinessProbe.initialDelaySeconds | int | `30` | Defines the delay before the Automation container readiness probe is initiated. |
| readinessProbe.periodSeconds | int | `10` | Defines how often to perform the Automation container probe. |
| readinessProbe.timeoutSeconds | int | `5` | Defines when the Automation container probe times out. |
| readinessProbe.failureThreshold | int | `3` | Defines the minimum consecutive failures for the Automation container probe to be considered failed after having succeeded. |
| readinessProbe.successThreshold | int | `1` | Defines the minimum consecutive successes for the Automation container probe to be considered successful after having failed |
| customEnvs | object | `{}` | Allows you to specify custom environment variables for the Automation container. |
| resources.requests.cpu | int | `2` | Specifies the number of CPUs that a container requests within its Kubernetes pod. Kubernetes uses CPU requests to find a machine that best fits the container. It defines a minimum number of CPUs that the container may consume. If there is no contention for CPU, it may use as many CPUs as is available on the machine. If there is CPU contention on the machine, CPU requests provide a relative weight across all containers on the system for how much CPU time the container may use. |
| resources.requests.memory | string | `"3Gi"` | Specifies the amount of memory required for a container to run. Even though each container is able to consume as much memory on the machine as possible, this parameter improves placement of pods in the cluster. Kubernetes then takes available memory into account prior to binding your pod to a machine. |
| resources.limits.cpu | int | `2` | Defines the number of CPUs that an Automation container is limited to use within its Kubernetes pod. CPU limits are used to control the maximum number of CPUs that the container may use independent of contention on the machine. If a container attempts to use more than the specified limit, the system will throttle the container. This allows your container to have a consistent level of service independent of the number of pods on the machine. |
| resources.limits.memory | string | `"3Gi"` | Defines the amount of memory an Automation container is limited to use. If the container exceeds the specified memory limit, it will be terminated and potentially restarted depending on the container restart policy. |
| service.annotations | object | `{}` | Provide any additional annotations which may be required. |
| service.type | string | `"ClusterIP"` | Defines the value for the service Kubernetes object. It is recommended to keep the default value because it makes Automation accessible only from within the Kubernetes cluster. The LoadBalancer value makes Automation accessible from the Internet. This should only be used for testing purposes. [ClusterIP/LoadBalancer] |
| deployment.annotations | object | `{}` | Provides the ability to customize Automation's deployment using Kubernetes annotations. |
| podLabels | object | `{}` | Additional labels for Automation pods |

