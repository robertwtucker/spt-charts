# scaler

![Version: 1.5.1](https://img.shields.io/badge/Version-1.5.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 15.4](https://img.shields.io/badge/AppVersion-15.4-informational?style=flat-square)

Inspire Scaler

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| image.name | string | `""` | Defines the URL address of the Scaler image stored in a Docker image repository. |
| image.tag | string | `""` | Defines a specific version of the Scaler image to be deployed. |
| image.ips.name | string | `""` | Defines the URL address leading to the IPS image stored in a Docker image repository. |
| image.ips.tag | string | `""` | Defines a specific version of the IPS image to be deployed. |
| image.sen.name | string | `""` | Defines the URL address leading to the SEN image stored in a Docker image repository. |
| image.sen.tag | string | `""` | Defines a specific version of the SEN image to be deployed. |
| image.pullPolicy | string | `"IfNotPresent"` | Defines the Scaler image pull policy. [IfNotPresent/Always] |
| volumes | list | `[]` | Defines an array of volumes to be mounted to the Scaler pod. -- For example, you may need to mount a Container Storage Interface (CSI) volume to pass Secrets to Kubernetes from an external secret management system (e.g. AWS Secrets Manager). |
| activateVolumes | object | `{"enabled":false,"volumes":[{"name":"my-csi-storage"}]}` | Creates an Init Container that will mount the given volumes to the application pod. It also instructs the CSI driver to create Kubernetes Secrets from Secrets stored in external storage (e.g. AWS Secrets Manager). It uses the 'SecretProviderClass' definition to manage the Secret synchronization. |
| activateVolumes.enabled | bool | `false` | Defines whether or not to create the Init Container. |
| activateVolumes.volumes | list | `[{"name":"my-csi-storage"}]` | Defines an array of volumes to be mounted. |
| db.host | string | `""` | Defines the hostname of the server that runs the database. |
| db.port | string | `""` | Defines the port of the server that runs the database. |
| db.user | string | `""` | Defines (in plain text) the username of the database user. -- Use the 'userSource' variable instead if you wish to define the username using a Secret. |
| db.userSource | object | `{"secretKey":"","secretName":"","useSecret":false}` | Available since the 15.0 GA version of Scaler. -- Uses a Secret to define the username of the database user. |
| db.pass | string | `""` | Defines (in plain text) the password of the database user. -- Use the 'passSource' variable instead if you wish to define the password using a Secret. |
| db.passSource | object | `{"secretKey":"","secretName":"","useSecret":false}` | Available since the 15.0 GA version of Scaler. -- Uses a Secret to define the password of the database user. |
| db.name | string | `""` | Defines the name of an existing database that will be used. |
| db.type | string | `""` | Defines the type of your database. [MsSql/Oracle/MySql/PostgreSql] |
| db.connectionString | string | `""` | Defines (in plain text) a custom connection string to connect to the database. -- Do not include the user credentials in the connection string. Use 'db.pass' and 'db.user' instead. -- Use the 'connectionStringSource' variable instead if you wish to define the connection string using a Secret. |
| db.connectionStringSource | object | `{"secretKey":"","secretName":"","useSecret":false}` | Available since the 15.0 GA version of Scaler. -- Uses a Secret to define a custom connection string to connect to the database. |
| db.oracleConnectionType | string | `"SID"` | Defines the Oracle database connection type. [SID/ServiceName] |
| db.mssqlConnectionType | string | `"PORT"` | Defines the MSSQL database connection type. -- Depending on the used type, configure the related settings: db.port or db.mssqlInstanceName. [PORT/INSTANCE_NAME] |
| db.mssqlInstanceName | string | `""` | Defines the instance name of the server that runs the MSSQL database. |
| replicaCount | int | `1` | Defines the number of Scaler images (i.e. nodes) to be deployed at launch. |
| shutdownTimeout | int | `30` | Defines how long (in seconds) Scaler should wait before shutting down after stopping the system service. -- The allocated time allows Scaler to finish any unfinished jobs while not accepting new ones. |
| statefulScaling | object | `{"enabled":true}` | Since the 15.0 version, the following feature enables you to scale the Scaler cluster up and down just from the Kubernetes deployment. -- Enabling this features creates the following Kubernetes entities in order to authorize Scaler requests to Kubernetes: Role (with minimal required rights), RoleBinding and ServiceAccount. -- Note that RBAC must be enabled in your Kubernetes cluster. |
| statefulScaling.enabled | bool | `true` | Outsources the handling of Scaler's 'Expected Number of Nodes' setting to the Kubernetes deployment. |
| existingServiceAccount | string | `""` | If cluster scaling (or cluster autoscaling) is enabled, a custom service account can be used instead of the one automatically created by Scaler. -- Also, you may need to create a service account when passing Secrets to Kubernetes from an external secret management system. In such a case, the service account must have the permissions to access the external system (e.g. AWS Secrets Manager). |
| autoscaling.enabled | bool | `false` | Enables the autoscaling feature. Both the cluster and stateless architecture solutions are supported. |
| autoscaling.minReplicas | int | `1` | Defines the lower limit for the number of Inspire Scaler nodes that can be set by the autoscaling configuration. |
| autoscaling.maxReplicas | int | `10` | Defines the upper limit for the number of Inspire Scaler nodes that can be set by the autoscaling configuration. |
| autoscaling.targetCPUUtilizationPercentage | int | `60` | Kubernetes calculates average utilization this way: ((pod cpu usage)/(scaler.request + ips.request). -- CPU requests and CPU limits must be configured using the same values. Scenario 1: IPS.requests 1CPU, Scaler.requests 1CPU:  If IPS reaches 100% of its utilization capacity but Scaler is under no load, the average percentage is 50% -> not scaling. Scenario 2: IPS.requests 2CPU, Scaler.requests 1CPU:  If IPS reaches 100% of its utilization capacity but Scaler is under no load, the average percentage is 66% -> scaling. Scanerio 3: IPS.requests 1CPU, Scaler.request 1CPU, Scaler.limit 3CPU  If Scaler reaches 100% of its utilization capacity, the average percentage is 150%. -- If not specified, at least one custom metric must be created. |
| autoscaling.metrics | list | `[]` | The following is a list of all the custom metrics that are passed to the 'HorizontalPodAutoscaler' object. |
| addJvmArguments | string | `""` | Defines additional JVM arguments. -- For example, you can adjust Scaler's allocated Java heap memory (using the -Xmx2048m property) whose value should be lower than the value of resources.limits.memory. |
| cluster.backupCount | string | `nil` | Since the 15.0 version, the following feature enables the configuration of the backup count. Learn about that feature in the 'Backup Count' section of Scaler User Manual. By default if you do not specify a value, the most suitable value is automatically determined. -- Note the feature has no effect on stateless architecture. |
| sharedStorage.storageClass | string | `""` | Defines the name of the storage class that you have prepared as a prerequisite. -- Optional if an existing claim is used or the installation type is set to Stateless. |
| sharedStorage.size | string | `"8Gi"` | Defines the size (in gigabytes) the storage will be created with. |
| sharedStorage.existingClaim | string | `""` | Defines the name of an existing persistent volume claim. Unnecessary if the installation type is set to Stateless. |
| additionalStorage.enabled | bool | `false` | Enables/disables the additional disk space. |
| additionalStorage.mountPath | string | `"/opt/scalerAdditionalStorage"` | Defines the path to where the additional disk space will be mounted to in the container. |
| additionalStorage.storageClass | string | `""` | Defines the name of the storage class that you have prepared as a prerequisite. -- Optional if an existing claim is used. |
| additionalStorage.size | string | `"8Gi"` | Defines the size (in gigabytes) the storage will be created with. |
| additionalStorage.existingClaim | string | `""` | Defines the name of an existing persistent volume claim. |
| icmApiAuthenticationGroup | string | `"RestApiUser"` | Defines the ICM user group whose members are allowed to send API requests to Scaler. |
| installationType | string | `""` | Defines the type of Scaler architecture to be installed. [Stateless/Cluster] |
| customEncryption | object | `{"enabled":false,"keys":[{"id":1,"key":"","keySource":{"secretKey":"","secretName":"","useSecret":false}}]}` | Configures Scaler to use a custom encryption key to encrypt the passwords maintained by Scaler using an array of key-value pairs. Kubernetes converts each defined key into a secret. -- Use number 1 for the value of the first key's id. When switching keys, always increase the number used for the key id relative to the previous key. The id must be higher for each new encryption key. Otherwise, the encryption fails. -- For more information, see the 'Custom Password Encryption Keys' section of the Deployment Configuration Guide. |
| customEncryption.keys[0].keySource | object | `{"secretKey":"","secretName":"","useSecret":false}` | All encryption keys must come from the same secret. The secret must only contain encryption keys because all keys are mounted into the pod. If the secret contained any other keys (e.g. a database password), it would also be used as an encryption key. |
| useLibExtSidecar | bool | `false` | Defines whether you wish to import the 'lib-ext' folder with external libraries (e.g. the MySQL database driver) into Scaler. -- Build a docker image containing the 'lib-ext' folder you wish to import. -- The container starts as an init sidecar container and its script copies libraries to '/opt/Quadient/Inspire-Scaler/lib-ext'. |
| libExtSidecar.image.name | string | `""` | Defines the URL address of the 'lib-ext' sidecar image stored in a Docker image repository. |
| libExtSidecar.image.tag | string | `""` | Defines a specific version of the 'lib-ext' sidecar image to be deployed. |
| libExtSidecar.image.pullPolicy | string | `"IfNotPresent"` | Defines the 'lib-ext' sidecar image pull policy. [IfNotPresent/Always] |
| icmTrustedDomains | string | `nil` | Configures Scaler to encrypt the communication between Scaler and ICM using a custom certificate. -- ICM must be configured to use a custom certificate as well. To enable trusted domains for IPS, you must update the 'ips.configfileContent' Helm variable by including the <ICMClientVerifyDomain/> element. -- For more information, see the 'ICM Trusted Domains' section of Inspire Scaler User Manual. -- |
| ips.threadcount | int | `4` | Defines the number of processing threads to assign to Scaler's IPS. |
| ips.addParams | string | `"-allowdatarecording"` | Defines optional IPS commands for running as an application. -- For example, the -allowdatarecording command is necessary for Scaler's data recording feature. |
| ips.configFileContent | string | `""` | Defines a configuration to be created in the inspireproductionserver.config file. -- For example: <AllowedDirectories>/opt/localStorage;/opt/scalerSharedFolder;icm://</AllowedDirectories><ForbidLocalWebRequests>1</ForbidLocalWebRequests> |
| ips.resources.requests.cpu | int | `2` | Defines the CPU requests for Scaler's IPS. -- See CPU requests for Scaler to learn about the purpose of the setting. |
| ips.resources.requests.memory | string | `"3Gi"` | Memory requests for Scaler's IPS. -- See memory requests for Scaler to learn about the purpose of the setting. |
| ips.resources.limits.cpu | int | `2` | Defines the CPU limits for Scaler's IPS. -- See CPU limits for Scaler to learn about the purpose of the setting. |
| ips.resources.limits.memory | string | `"3Gi"` | Defines the memory limits for Scaler's IPS. -- See memory limits for Scaler to learn about the purpose of the setting. |
| ips.livenessProbe | object | `{"failureThreshold":10,"initialDelaySeconds":10,"periodSeconds":10,"successThreshold":1,"timeoutSeconds":2}` |  Learn about the probe's configuration settings at https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#configure-probes. |
| ips.livenessProbe.initialDelaySeconds | int | `10` | Defines the delay before the IPS container liveness probe is initiated. |
| ips.livenessProbe.periodSeconds | int | `10` | Defines how often to perform the IPS container probe. |
| ips.livenessProbe.timeoutSeconds | int | `2` | Defines when the IPS container probe times out. |
| ips.livenessProbe.failureThreshold | int | `10` | Defines the minimum consecutive failures for the IPS container probe to be considered failed after having succeeded. |
| ips.livenessProbe.successThreshold | int | `1` | Defines the minimum consecutive successes for the IPS container probe to be considered successful after having failed. |
| ips.readinessProbe | object | `{"failureThreshold":10,"initialDelaySeconds":10,"periodSeconds":10,"successThreshold":1,"timeoutSeconds":2}` |  Learn about the probe's configuration settings at https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#configure-probes. |
| ips.readinessProbe.initialDelaySeconds | int | `10` | Defines the delay before the IPS container readiness probe is initiated. |
| ips.readinessProbe.periodSeconds | int | `10` | Defines how often to perform the IPS container probe. |
| ips.readinessProbe.timeoutSeconds | int | `2` | Defines when the IPS container probe times out. |
| ips.readinessProbe.failureThreshold | int | `10` | Defines the minimum consecutive failures for the IPS container probe to be considered failed after having succeeded. |
| ips.readinessProbe.successThreshold | int | `1` | Defines the minimum consecutive successes for the IPS container probe to be considered successful after having failed |
| ips.customEnvs | object | `{}` | Allows you to specify custom environment variables for the IPS container. |
| sen | object | `{"addJvmArguments":"","customEnvs":{},"db":{"connectionString":"","connectionStringSource":{"secretKey":"","secretName":"","useSecret":false},"pass":"","passSource":{"secretKey":"","secretName":"","useSecret":false},"user":"","userSource":{"secretKey":"","secretName":"","useSecret":false}},"icmTrustedDomain":null,"livenessProbe":{"failureThreshold":5,"periodSeconds":5,"successThreshold":1,"timeoutSeconds":5},"maxParallelBatchCount":4,"readinessProbe":{"failureThreshold":10,"initialDelaySeconds":10,"periodSeconds":10,"successThreshold":1,"timeoutSeconds":2},"resources":{"limits":{"cpu":2,"memory":"3Gi"},"requests":{"cpu":2,"memory":"3Gi"}},"retentionPeriodInDays":30,"startupProbe":{"failureThreshold":60,"periodSeconds":5,"successThreshold":1,"timeoutSeconds":5}}` | Available since the 15.0 version (except for the 15.2 version) of Scaler. |
| sen.resources.requests.cpu | int | `2` | Defines the CPU requests for Scenario Engine. -- See CPU requests for Scaler to learn about the purpose of the setting. |
| sen.resources.requests.memory | string | `"3Gi"` | Memory requests for Scenario Engine. -- See memory requests for Scaler to learn about the purpose of the setting. |
| sen.resources.limits.cpu | int | `2` | Defines the CPU limits for Scenario Engine. -- See CPU limits for Scaler to learn about the purpose of the setting. |
| sen.resources.limits.memory | string | `"3Gi"` | Defines the memory limits for Scenario Engine. -- See memory limits for Scaler to learn about the purpose of the setting. |
| sen.customEnvs | object | `{}` | Allows you to specify custom environment variables for the Scenario Engine container. |
| sen.icmTrustedDomain | string | `nil` | Configures Scenario Engine to encrypt the communication between Scenario Engine and ICM using a custom certificate. -- ICM must be configured to use a custom certificate as well. -- For more information, see the 'ICM Trusted Domains' section of Inspire Scaler User Manual. |
| sen.db.connectionString | string | `""` | Defines (in plain text) a custom connection string to connect to the database. -- Do not include the user credentials in the connection string. Use 'db.pass' and 'db.user' instead. |
| sen.db.connectionStringSource | object | `{"secretKey":"","secretName":"","useSecret":false}` | Uses a Secret to define a custom connection string to connect to the database. |
| sen.db.user | string | `""` | Defines (in plain text) the username of the database user. -- Use the 'userSource' variable instead if you wish to define the username using a Secret. |
| sen.db.userSource | object | `{"secretKey":"","secretName":"","useSecret":false}` | Uses a Secret to define the username of the database user. |
| sen.db.pass | string | `""` | Defines (in plain text) the password of the database user. -- Use the 'passSource' variable instead if you wish to define the password using a Secret. |
| sen.db.passSource | object | `{"secretKey":"","secretName":"","useSecret":false}` | Uses a Secret to define the password of the database user. |
| sen.addJvmArguments | string | `""` | Defines additional JVM arguments. -- For example, you can adjust SEN's allocated Java heap memory (using the -Xmx2048m property) whose value should be lower than the value of resources.limits.memory. -- You can also use this variable to define the SEN properties listed in the 'SEN Properties' section of the Scaler User Manual. -- An example value: "-Dsen.retentionTime='06:50'" |
| sen.startupProbe.periodSeconds | int | `5` | Defines how often to perform the Scenario Engine container probe. |
| sen.startupProbe.timeoutSeconds | int | `5` | Defines when the Scenario Engine container probe times out. |
| sen.startupProbe.failureThreshold | int | `60` | Defines the minimum consecutive failures for the Scenario Engine container probe to be considered failed after having succeeded. |
| sen.startupProbe.successThreshold | int | `1` | Defines the minimum consecutive successes for the Scenario Engine container probe to be considered successful after having failed. |
| sen.livenessProbe.periodSeconds | int | `5` | Defines how often to perform the Scenario Engine container probe. |
| sen.livenessProbe.timeoutSeconds | int | `5` | Defines when the Scenario Engine container probe times out. |
| sen.livenessProbe.failureThreshold | int | `5` | Defines the minimum consecutive failures for the Scenario Engine container probe to be considered failed after having succeeded. |
| sen.livenessProbe.successThreshold | int | `1` | Defines the minimum consecutive successes for the Scenario Engine container probe to be considered successful after having failed. |
| sen.readinessProbe | object | `{"failureThreshold":10,"initialDelaySeconds":10,"periodSeconds":10,"successThreshold":1,"timeoutSeconds":2}` |  Learn about the probe's configuration settings at https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#configure-probes. |
| sen.readinessProbe.initialDelaySeconds | int | `10` | Defines the delay before the Scenario Engine container readiness probe is initiated. |
| sen.readinessProbe.periodSeconds | int | `10` | Defines how often to perform the Scenario Engine container probe. |
| sen.readinessProbe.timeoutSeconds | int | `2` | Defines when the Scenario Engine container probe times out. |
| sen.readinessProbe.failureThreshold | int | `10` | Defines the minimum consecutive failures for the Scenario Engine container probe to be considered failed after having succeeded. |
| sen.readinessProbe.successThreshold | int | `1` | Defines the minimum consecutive successes for the Scenario Engine container probe to be considered successful after having failed |
| role | string | `"scaler"` | Internal parameter |
| livenessProbe | object | `{"failureThreshold":5,"initialDelaySeconds":120,"periodSeconds":5,"successThreshold":1,"timeoutSeconds":5}` |  Learn about the probe's configuration settings at https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#configure-probes. |
| livenessProbe.initialDelaySeconds | int | `120` | Defines the delay before the Scaler container liveness probe is initiated. |
| livenessProbe.periodSeconds | int | `5` | Defines how often to perform the Scaler container probe. |
| livenessProbe.timeoutSeconds | int | `5` | Defines when the Scaler container probe times out. |
| livenessProbe.failureThreshold | int | `5` | Defines the minimum consecutive failures for the Scaler container probe to be considered failed after having succeeded. |
| livenessProbe.successThreshold | int | `1` | Defines the minimum consecutive successes for the Scaler container probe to be considered successful after having failed. |
| readinessProbe | object | `{"failureThreshold":3,"initialDelaySeconds":30,"periodSeconds":10,"successThreshold":1,"timeoutSeconds":5}` |  Learn about the probe's configuration settings at https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#configure-probes. |
| readinessProbe.initialDelaySeconds | int | `30` | Defines the delay before the Scaler container readiness probe is initiated. |
| readinessProbe.periodSeconds | int | `10` | Defines how often to perform the Scaler container probe. |
| readinessProbe.timeoutSeconds | int | `5` | Defines when the Scaler container probe times out. |
| readinessProbe.failureThreshold | int | `3` | Defines the minimum consecutive failures for the Scaler container probe to be considered failed after having succeeded. |
| readinessProbe.successThreshold | int | `1` | Defines the minimum consecutive successes for the Scaler container probe to be considered successful after having failed |
| podSecurityContext.runAsUser | int | `1001` | Learn about this setting at https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups. |
| podSecurityContext.fsGroup | int | `1001` | Learn about this setting at https://kubernetes.io/docs/concepts/policy/pod-security-policy/#volumes-and-file-systems. |
| podSecurityContext.runAsNonRoot | bool | `true` | Learn about this setting at https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups. |
| securityContext.readOnlyRootFilesystem | bool | `true` | Learn about this setting at https://kubernetes.io/docs/concepts/policy/pod-security-policy/#volumes-and-file-systems. |
| securityContext.privileged | bool | `false` | Learn about this setting at https://kubernetes.io/docs/concepts/policy/pod-security-policy/#privileged. |
| securityContext.allowPrivilegeEscalation | bool | `false` | Learn about this setting at https://kubernetes.io/docs/concepts/policy/pod-security-policy/#privilege-escalation. |
| securityContext.runAsUser | int | `1001` | Learn about this setting at https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups. |
| securityContext.runAsGroup | int | `1001` | Learn about this setting at https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups. |
| securityContext.capabilities | object | `{"drop":["all"]}` | Learn about this setting at https://kubernetes.io/docs/concepts/policy/pod-security-policy/#capabilities. -- The default (recommended) configuration prohibits all Linux capabilities. |
| resources.requests.cpu | int | `2` | Specifies the number of CPUs that a container requests within its Kubernetes pod. Kubernetes uses CPU requests to find a machine that best fits the container. -- It defines a minimum number of CPUs that the container may consume. If there is no contention for CPU, it may use as many CPUs as is available on the machine. -- If there is CPU contention on the machine, CPU requests provide a relative weight across all containers on the system for how much CPU time the container may use. |
| resources.requests.memory | string | `"3Gi"` | Specifies the amount of memory required for a container to run. Even though each container is able to consume as much memory on the machine as possible, this parameter improves placement of pods in the cluster. Kubernetes then takes available memory into account prior to binding your pod to a machine. |
| resources.limits.cpu | int | `2` | Defines the number of CPUs that a Scaler container is limited to use within its Kubernetes pod. CPU limits are used to control the maximum number of CPUs that the container may use independent of contention on the machine. If a container attempts to use more than the specified limit, the system will throttle the container. -- This allows your container to have a consistent level of service independent of the number of pods on the machine. |
| resources.limits.memory | string | `"3Gi"` | Defines the amount of memory a Scaler container is limited to use. If the container exceeds the specified memory limit, it will be terminated and potentially restarted depending on the container restart policy. |
| metricsAPI.enabled | bool | `true` | Since the 15.0 version, the following feature enables/disables Scaler's Metrics API endpoint. It is useful as a resource for monitoring tools which can be used to scale an Inspire Scaler cluster based on custom metrics. -- When performing an initial installation, this feature is applicable to both cluster and stateless architecture. However, when upgrading Scaler to new versions, the value can only be changed for stateless architecture. In cluster, you can enable/disable the endpoint using the 'Metrics API' check box in Scaler's Administration. |
| customEnvs | object | `{}` | Allows you to specify custom environment variables for the Scaler container. |
| service.annotations | object | `{}` | Provide any additional annotations which may be required. |
| service.type | string | `"ClusterIP"` | Defines the value for the service Kubernetes object. -- It is recommended to keep the default value because it makes Scaler accessible only from within the Kubernetes cluster. -- The LoadBalancer value makes Scaler accessible from the Internet. This should only be used for testing purposes. [ClusterIP/LoadBalancer] |
| ingress.enabled | bool | `false` | Enables Ingress, a Kubernetes API object that provides load balancing. |
| ingress.host | string | `nil` | Defines the Ingress host. |
| ingress.tls.enabled | bool | `true` | Enables HTTPS for Scaler. It is set to 'true' by default for security reasons. |
| ingress.tls.secretName | string | `nil` | The functionality of the 'secretName' parameter differs based on how you intend to provide a Kubernetes secret that stores the required certificate: -- 1) If you create a Kubernetes TLS secret that stores the required certificate manually by yourself, enter the name of the secret in the 'secretName' parameter. --    To learn about Kubernetes TLS secrets, see Kubernetes documentation at https://kubernetes.io/docs/concepts/configuration/secret/#tls-secrets. -- 2) If you intend to use the 'clusterIssuer' parameter to provide the required certificate, use the 'secretName' parameter to define a custom name for a secret that will be created by the cluster issuer. |
| ingress.tls.clusterIssuer | string | `nil` | Allows you to defines the name of a cluster-issuer to be used for creating the certificate secret. -- For more information about cluster issuer setup, see one of the following documentations based on which platform you use to deploy Inspire: -- AKS (Application Gateway Kubernetes Ingress): https://azure.github.io/application-gateway-kubernetes-ingress/how-tos/lets-encrypt/#certificate-issuance-with-letsencryptorg -- EKS (NGINX Ingress): https://cert-manager.io/docs/tutorials/acme/ingress/ |
| deployment.annotations | object | `{}` | Provides the ability to customize Scaler's deployment using Kubernetes annotations. |
