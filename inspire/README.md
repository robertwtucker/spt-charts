# inspire

![Version: 1.5.1](https://img.shields.io/badge/Version-1.5.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 15.4](https://img.shields.io/badge/AppVersion-15.4-informational?style=flat-square)

Inspire

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.imagePullSecrets | list | `[]` | Defines an array of names of secrets, containing the connection settings to Docker image repositories. |
| global.applicationName | string | `"inspire"` | Defines a unique name of an application within a Kubernetes namespace. |
| global.scaler.enabled | bool | `true` | Defines whether to deploy Scaler or not. |
| global.scaler.userOverride | string | `nil` | Defines (in plain text) the username of a Scaler user to be created in ICM. -- If left undefined, the default user called scaler is created. -- The username value is not treated as a Secret. |
| global.scaler.passOverride | string | `nil` | Defines (in plain text) the password of a Scaler user to be created in ICM. -- If left undefined, Scaler's deployment will provide you with a random alphanumeric password. -- Use the 'passOverrideSource' variable instead if you wish to define the password using a Secret. |
| global.scaler.passOverrideSource | object | `{"secretKey":"","secretName":"","useSecret":false}` | Uses a Secret to define the password of a Scaler user to be created in ICM. |
| global.scaler.portOverride | string | `nil` | Defines the port to run Scaler on. -- If left undefined, the default port 30600 is used. |
| global.interactive.enabled | bool | `true` | Defines whether to deploy Interactive or not. |
| global.interactive.userOverride | string | `nil` | Defines the username of an Interactive system user to be created in ICM. -- If left undefined, the default user called system is created. -- The username value is not treated as a Secret. |
| global.interactive.passOverride | string | `nil` | Defines the password of an Interactive system user to be created in ICM. -- If left undefined, Interactive's deployment will provide you with a random alphanumeric password. -- Use the 'passOverrideSource' variable instead if you wish to define the password using a Secret. |
| global.interactive.passOverrideSource | object | `{"secretKey":"","secretName":"","useSecret":false}` | Uses a Secret to define the password of an Interactive system user to be created in ICM. |
| global.interactive.portOverride | string | `nil` | Defines the port to run Interactive on. -- If left undefined, the default port 30701 is used. |
| global.icm.adminPassOverride | string | `nil` | Defines the password of the ICM admin user. -- If left undefined, ICM's deployment will provide you with a random alphanumeric password. -- Use the 'adminPassOverrideSource' variable instead if you wish to define the password using a Secret. |
| global.icm.adminPassOverrideSource | object | `{"secretKey":"","secretName":"","useSecret":false}` | Uses a Secret to define the password of the ICM admin user. |
| global.icm.portOverride | string | `nil` | Defines the port to run ICM on. -- If left undefined, the default port 30353 is used. |
| global.license.method | string | `"CL"` | Defines the type of your license (cloud licensing or net licensing). [CL/LS] |
| global.license.server | string | `""` | Defines the URL address of your licensing server (Quadient Cloud server or Inspire License Manager server). -- Use the 'serverSource' variable instead if you wish to define the URL address using a Secret. |
| global.license.serverSource | object | `{"secretKey":"","secretName":"","useSecret":false}` | Uses a Secret to define the URL address of your licensing server. |
| global.license.server2 | string | `""` | Defines the URL address of your backup licensing server (Quadient Cloud server or Inspire License Manager server). -- Use the 'server2Source' variable instead if you wish to define URL address using a Secret. |
| global.license.server2Source | object | `{"secretKey":"","secretName":"","useSecret":false}` | Uses a Secret to define the URL address of your backup licensing server. |
| global.dataRecording.prepareEnvironment | bool | `false` | Since the R15.0 GA version, this defines whether or not you want to prepare the Inspire Flex components for the use of the Data Recording feature. The value of this setting must be set to 'true' for the Data recording feature to work in Kubernetes. |
| global.dataRecording.prepareConfigurationVariables | bool | `false` | You must use the following option when deploying the following Scaler versions to enable the preparation of the Data Recording configuration variables: - 15.0 versions earlier than SP2 - 15.X FMAP versions earlier than 15.4 FMAP -- Without this feature enabled, the Data Recording feature will not be able to function. |
| global.sen | object | `{"enabled":false,"passOverride":"","passOverrideSource":{"secretKey":"","secretName":"","useSecret":false},"userOverride":""}` | Available since the 15.0 version (except for the 15.2 version) of Scaler. |
| global.sen.enabled | bool | `false` | Defines whether to deploy Scenario Engine or not. |
| global.sen.userOverride | string | `""` | Defines (in plain text) the username of a Scenario Engine user to be created in ICM. -- If left undefined, the default user called 'sen' is created. -- The username value is not treated as a Secret. |
| global.sen.passOverride | string | `""` | Defines (in plain text) the password of a Scenario Engine user to be created in ICM. -- If left undefined, Scaler's deployment will provide you with a random alphanumeric password. -- Use the 'passOverrideSource' variable instead if you wish to define the password using a Secret. |
| global.sen.passOverrideSource | object | `{"secretKey":"","secretName":"","useSecret":false}` | Uses a Secret to define the password of a Scenario Engine user to be created in ICM. |

